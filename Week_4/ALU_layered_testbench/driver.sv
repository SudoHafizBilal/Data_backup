import transaction_pkg::*; 
class driver;

	mailbox gen2drv;
	int repeat_count;
	virtual alu_intf.drv rinf;
	
	function new (mailbox gen2drv, int repeat_count, virtual alu_intf.drv rinf);
		this.gen2drv = gen2drv;
		this.repeat_count = repeat_count;
		this.rinf = rinf;
	endfunction
	
	task run();
		transaction trans;
		$display(" ");
		$display(" ");
		$display("#############-------Now execution will start-------###############");
		$display(" ");
		$display(" ");
		$display(" Enter Drivers's run task");
		repeat(repeat_count) begin
			gen2drv.get(trans);
			$display(" ");
			$display("[DRIVER]");
			trans.display_generated_inputs();
			//reset sequence();
			drive_signals(trans);
			$display("These inputs send to DUT(ALU) from Driver");
			$display(" ");
		end
		
	endtask
	
	task drive_signals (transaction t);
		$display("Enter Driver's drive_signals task");
		$display("Wait D 1st clk posedge");
		@(posedge rinf.clk); 
		rinf.a <= t.a; 
		rinf.b <= t.b; 
		rinf.op_sel <= t.op_sel;
		rinf.valid <= 1;
		$display("D_valid is 1");
		$display("Wait D 2st clk posedge");
		@(posedge rinf.clk); 
		$display("D_valid is 0");
		rinf.valid <= 0;
		
	
	endtask
endclass