import transaction_pkg::*; 
class driver;

	mailbox gen2drv;
	int repeat_count;
	virtual MMT_intf.drv MMT_if;
	
	function new (mailbox gen2drv, int repeat_count, virtual MMT_intf.drv MMT_if);
		this.gen2drv = gen2drv;
		this.repeat_count = repeat_count;
		this.MMT_if = MMT_if;
	endfunction
	
	task run();
		
		transaction trans;
		$display(" ");
		$display("#############-------Now execution will start-------###############");
		$display(" ");
		repeat(repeat_count) begin
			gen2drv.get(trans);
			$display("[DRIVER]");
			trans.display_generated_inputs();
			drive_signals(trans);
			@(posedge MMT_if.clk); 
		end
		
	endtask
	
	task drive_signals (transaction t);
		@(posedge MMT_if.clk); 
		MMT_if.mode <= t.mode; 
		MMT_if.prescalar <= t.prescalar; 
		MMT_if.reload_val <= t.reload_val;
		MMT_if.compare_val <= t.compare_val;
		MMT_if.valid <= 1;
		@(posedge MMT_if.clk); 
		MMT_if.valid <= 0;
		
	
	endtask
endclass