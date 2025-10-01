class driver;

	mailbox gen2driv;
	int repeat_count;
	virtual ra_intf.drv rinf;
	
	function new (mailbox gen2driv, int repeat_count, virtual ra_intf.drv rinf);
		this.gen2driv = gen2driv;
		this.repeat_count = repeat_count;
		this.rinf = rinf;
	endfunction
	
	task run();
		transaction trans;
		
		repeat(repeat_count) begin
			gen2driv.get(trans);
			trans.display(" [DRIVER]");
			reset sequence();
			drive_signals(trans.a, trans.b);
		end
		
	endtask
	
	task drive_signals (input logic [3:0] a, b);
	
		@(posedge rinf.clk); 
		rinf.a <= a; 
		rinf.b <= b; 
		rinf.valid <= 1;
		
		@(posedge rinf.clk); 
		rinf.valid <= 0;
		
		@(posedge rinf.clk);
	
	endtask
endclass