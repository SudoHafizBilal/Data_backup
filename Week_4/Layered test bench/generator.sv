class generator;

	int repeat_count;
	mailbox gen2drv;
	mailbox gen2scb;
	
	function new(mailbox gen2drv, mailbox gen2scb, int repeat_count);
		this.repeat_count = repeat_count;
		this.gen2drv = gen2drv;
		this.gen2scb = gen2scb;
	endfunction
	
	task run();
		transaction trans, trans1;
		int i=1;
		
		repeat(repeat_count) begin
			trans = new(1*i,2*i, 0);
			trans.display("[Generator]");
			gen2drv.put(trans);
			trans1 = new trans;
			gen2scb.put(trans1);
			i++;
		end
		
	endtask
	
endclass