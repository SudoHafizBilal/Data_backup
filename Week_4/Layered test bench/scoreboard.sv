class scoreboard;
	mailbox mon2scb, gen2scb;
	int repeat_count;
	
	function new(mailbox gen2scb, mailbox mon2scb, int repeat_count);
		this.mon2scb = mon2scb;
		this.gen2scb = gen2scb;
		this.repeat_count = repeat_count;
	endfunction
	
	task run();
		transaction t_fromdrv, t_frommon;
		int ncount = 0, nsuccess =0, nfails = 0;
		
		while(ncount<repeat_count) begin
			gen2scb.get(t_fromdrv);
			mon2scb.get(t_frommon);
			
			if ((t_fromdrv.a+t_fromdrv.b)!=t_frommon.c) 
				nfails++;
			else 
				nsuccess++;
				
			ncount++;
		end
		
		$display("Total Success = %0d, Total Failures = %0d", nsuccess, nfails);
	endtask
	
endclass