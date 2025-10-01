import transaction_pkg::*; 
class monitor;

	mailbox mon2scb;
	int repeat_count;
	virtual alu_intf.mon rinf;
	
	function new (mailbox mon2scb, int repeat_count, virtual alu_intf.mon rinf);
		this.mon2scb = mon2scb;
		this.repeat_count = repeat_count;
		this.rinf = rinf;
	endfunction
	int n = 1;
	task run();
		
		transaction trans;
		int ncount = 0;
		$display(" ");
		$display("Enter Monitor's run task");
		while (ncount<repeat_count) begin
			$display("Wait M clk posedge");
			@(posedge rinf.clk);
			$display("clk no %d",n);
			n++;
			$display("check if D_valid is 1");
			if(rinf.valid) begin
				$display(" [Monitor]");
				trans = new(rinf.a, rinf.b, rinf.op_sel);
				trans.out = rinf.out;
				trans.zero = rinf.zero;
				trans.carry = rinf.carry;
				trans.overflow = rinf.overflow;
				mon2scb.put(trans);
				trans.display();
				ncount++;
				$display(" ");
				$display(" ");
			end
		end
		
	endtask
endclass