import transaction_pkg::*; 
class monitor;

	mailbox mon2scb;
	int repeat_count;
	virtual MMT_intf.mon MMT_if;
	
	function new (mailbox mon2scb, int repeat_count, virtual MMT_intf.mon MMT_if);

		this.mon2scb = mon2scb;
		this.repeat_count = repeat_count;
		this.MMT_if = MMT_if;
	endfunction
	
	task run();
		
		transaction trans;
		int ncount = 0;
		while (ncount<repeat_count) begin
			trans = new();
			@(posedge MMT_if.clk);
			if(MMT_if.valid) begin
				$display(" [Monitor]");
				//OUtputs values from DUT
				trans.mode          = MMT_if.mode;
      			trans.prescalar     = MMT_if.prescalar;
      			trans.reload_val    = MMT_if.reload_val;
      			trans.compare_val   = MMT_if.compare_val;
      			trans.start         = MMT_if.start;
      			trans.timeout       = MMT_if.timeout;
      			trans.pwm_out       = MMT_if.pwm_out;
      			trans.current_count = MMT_if.current_count;
				mon2scb.put(trans);
				trans.display();
				ncount++;
			end
		end
		
	endtask
endclass