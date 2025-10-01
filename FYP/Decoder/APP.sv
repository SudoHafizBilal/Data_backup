module app_memory #(
    parameter Z = 52,
    parameter N_GROUPS = 52,     
    parameter Q = 6             
)(
    input  logic                 clk,
    input  logic                 rst,
    
    input  logic                 wr_en,
    input  logic [$clog2(N_GROUPS)-1:0] wr_addr,
    input  logic [Q-1:0]         wr_data [Z],

    input  logic [$clog2(N_GROUPS)-1:0] rd_addr,
    output logic [Q-1:0]         rd_data [Z]
);

    logic [Q-1:0] memory [N_GROUPS][Z];

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            for (int g = 0; g < N_GROUPS; g++)
                for (int i = 0; i < Z; i++)
                    memory[g][i] <= '0;
        end else if (wr_en) begin
            for (int i = 0; i < Z; i++)
                memory[wr_addr][i] <= wr_data[i];
        end
    end

    always_comb begin
        for (int i = 0; i < Z; i++)
            rd_data[i] = memory[rd_addr][i];
    end

endmodule