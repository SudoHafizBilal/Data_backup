module axi4_lite_slave (
    //Axi signals
    input  logic        clk,
    input  logic        rst_n,
    axi4_lite_if.slave  axi_if,

    // UART physical interface
    output logic        uart_tx,
    input  logic        uart_rx,
    
    // Status outputs for monitoring
    output logic [3:0]  tx_fifo_count,
    output logic [3:0]  rx_fifo_count
);

    //Uart Transmitter signals
	logic  		 uart_write_en;
	logic [7:0]  uart_write_data;

    //Uart Receiver signals
    logic 		 uart_read_en;
    logic [7:0]  uart_read_data;
    logic uart_rx_data_valid;
    logic uart_rx_frame_error;
	
    // UART Transmitter Instance
    uart_tx_top uart_tx_inst (
        .clk(clk),
        .rst(rst_n),
        .wr_en(uart_write_en),
        .wr_data(uart_write_data),
        .tx(uart_tx),
        .count(tx_fifo_count)
    );
    
    // UART Receiver Instance
    uart_rx_top uart_rx_inst (
        .clk(clk),
        .rst(rst_n),
        .rxd(uart_rx),
        .rx_data(uart_read_data),
        .write(uart_rx_data_valid),
        .rd_en(uart_read_en),
        .frame_error(uart_rx_frame_error),
        .parity_bit() 
    );
	
    // TX control
    assign uart_write_en = (write_state == W_DATA) && axi_if.wvalid && 
                          addr_valid_write && (write_addr_index == 4'd0); // Write to register 0
    assign uart_write_data = axi_if.wdata[7:0];

    // RX control - read from register 4 triggers FIFO read
    assign uart_read_data = (read_state == R_ADDR) && addr_valid_read && (read_addr_index == 4'd4);
    
    // Register bank - 16 x 32-bit registers
    logic [31:0] register_bank [0:15];
    
    // Address decode
    logic [3:0] write_addr_index, read_addr_index;
    logic       addr_valid_write, addr_valid_read;
    
    // State machines for read and write channels
    typedef enum logic [1:0] {
        W_IDLE, W_ADDR, W_DATA, W_RESP
    } write_state_t;
    
    typedef enum logic [1:0] {
        R_IDLE, R_ADDR, R_DATA
    } read_state_t;
    
    write_state_t write_state;
    read_state_t  read_state;
    




    // TODO: Implement write channel state machine
    // Consider: Outstanding transaction handling
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            write_state       <= W_IDLE;
            axi_if.awready    <= 1'b0;
            axi_if.wready     <= 1'b0;
            axi_if.bvalid     <= 1'b0;
            axi_if.bresp      <= 2'b00;
			write_addr_index  <= 4'b0;
			addr_valid_write  <= 1'b0; 
			uart_write_data   <= 8'b0;
			uart_write_en  	  <= 1'b0;
        end 
		else begin
			case (write_state)
				W_IDLE: begin
                    axi_if.wready  <= 0;
                    axi_if.bvalid  <= 0;
                    if (axi_if.awvalid) begin
                        write_state <= W_ADDR;
						axi_if.awready    <= 1; // ready to accept address
                    end
					else begin
					write_state <= W_IDLE;
					end
				end
				
				W_ADDR: begin
                    write_addr_index  <= axi_if.awaddr[5:2]; // word-aligned
                    addr_valid_write  <= (axi_if.awaddr[5:2] < 16);
					axi_if.wready     <= 1; // wait for write data
					write_state       <= W_DATA;
                end
				W_DATA: begin
					axi_if.awready    <= 0;
					if (axi_if.wvalid) begin
                        if (addr_valid_write) begin
                            for (int i = 0; i < 4; i++) begin
                                if (axi_if.wstrb[i]) begin
                                    register_bank[write_addr_index][i*8 +: 8] 
                                        <= axi_if.wdata[i*8 +: 8];
								end
                            end
						end        
						
						uart_write_data <= register_bank[write_addr_index][1:0];
						uart_write_en  	<= 1'b1;
						axi_if.wready   <= 0;
						axi_if.bvalid   <= 1;
                        write_state     <= W_RESP;
                    end
					else begin
						write_state     <= W_DATA;
					end
				end
				
				
				W_RESP: begin
					uart_write_data   <= 8'b0;
					uart_write_en  	  <= 1'b0;
					
                    if (axi_if.bready && addr_valid_write) begin
						axi_if.bresp    <= 2'b00; // OKAY
                    end
					else begin
						axi_if.bresp    <= 2'b10; // SLVERR
					end
					write_state     <= W_IDLE;
                end
				
				default: begin
					write_state <= W_IDLE;
				end
			
			endcase
		end
	end
    
	// TODO: Implement read channel state machine  
    // Consider: Read data pipeline timing
	
	always_ff @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			read_state       <= R_IDLE;
            axi_if.arready   <= 0;
            axi_if.rvalid    <= 0;
            axi_if.rdata     <= 0;
            axi_if.rresp     <= 2'b00;
			read_addr_index  <= 4'b0;
			addr_valid_read  <= 1'b0;
		end
		else begin
			case (read_state) 
				R_IDLE: begin
                    
                    if (axi_if.arvalid) begin
						axi_if.arready <= 1; // ready for read address
                        read_addr_index <= (axi_if.araddr[5:2]);
                        addr_valid_read <= (axi_if.araddr[5:2] < 16);
                        read_state      <= R_ADDR;
                    end
                end
				
				R_ADDR: begin
                    axi_if.arready   <= 0;
                    if (addr_valid_read) begin
                        axi_if.rdata <= register_bank[read_addr_index];
                        axi_if.rvalid <= 1;
						axi_if.rresp <= 2'b00; // OKAY
                    end else begin
                        axi_if.rdata <= 32'hDEADBEEF; // invalid addr marker
                        axi_if.rresp <= 2'b10; // SLVERR
                    end
                    read_state <= R_DATA;
                end
				
				R_DATA: begin
                    if (axi_if.rready) begin
                        axi_if.rvalid <= 0;
                        read_state    <= R_IDLE;
                    end
                end
				
				default: begin
					read_state <= R_IDLE;
				end
			endcase
		end
	end
    



    // TODO: Implement address decode logic
    // Consider: What constitutes a valid address?
    
    // TODO: Implement register bank
    // Consider: Which registers are read-only vs read-write?

    //Register Map Description
    //Register bank[0] Transmitter status
    //Register bank[0] map -----> [         Unused           |fifo full|fifo empty|fifo count]
    //Register bank[0] map -----> [--------------------------|    -    |     -    |   ----   ]
    //Register bank[1] Transmitter Data

    //Register bank[3] Receiver status
    //Register bank[3] map -----> [         Unused          |frame error|fifo full|fifo empty|fifo count]
    //Register bank[3] map -----> [-------------------------|     -     |    -    |     -    |   ----   ]
    //Register bank[4] Receiver Data

    //Register bank [0] & [3] are read only register
    
always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        register_bank[0] <= 32'h0; 
        register_bank[3] <= 32'h0; 
        register_bank[4] <= 32'h0; 
        rx_fifo_count <= 4'h0;
    end else begin
        // Read only registers
        // TX Status
        register_bank[0][3:0]   <= tx_fifo_count;            
        register_bank[0][4]     <= (tx_fifo_count == 4'd0);  
        register_bank[0][5]     <= (tx_fifo_count == 4'd15);  
        register_bank[0][31:6]  <= 26'h0;                    
        
        // RX Status 
        register_bank[3][3:0]   <= rx_fifo_count;            
        register_bank[3][4]     <= (rx_fifo_count == 4'd0);  
        register_bank[3][5]     <= (rx_fifo_count == 4'd15); 
        register_bank[3][6]     <= uart_rx_frame_error;      
        register_bank[3][31:7]  <= 25'h0;                    
        
		// Update RX FIFO count safely
        
        //check full fifo
		if (uart_rx_data_valid && (rx_fifo_count < 15)) begin
			rx_fifo_count <= rx_fifo_count + 1; 
		end 

        //check empty fifo
		if (uart_rx_rd_en  && (rx_fifo_count > 0)) begin
			rx_fifo_count <= rx_fifo_count - 1; 
		end
        
        // Receiver Data register
        if (uart_rx_data_valid) begin
            register_bank[4][7:0]   <= uart_read_data;
            register_bank[4][31:8]  <= 24'h0;
        end
    end
end

endmodule

