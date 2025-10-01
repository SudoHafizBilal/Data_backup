class monitor;

	mailbox mon2scb;
	int repeat_count;
	virtual ra_intf.mon rinf;
	
	function new (mailbox mon2scb, int repeat_count, virtual ra intf.mon rinf);
		this.mon2scb = mon2scb;
		this.repeat_count = repeat_count;
		this.rinf = rinf;
	endfunction
	
	task run();
		transaction trans;
		int ncount = 0;
		
		while (ncount<repeat_count) begin
			@(posedge rinf.clk);
			
			if(!rinf.reset && rinf.valid) begin
				@(posedge rinf.clk);
				trans = new(rinf.a, rinf.b, rinf.c);
				mon2scb.put(trans);
				trans.display(" [Monitor]");
				ncount++;
			end
		end
		
	endtask
endclass