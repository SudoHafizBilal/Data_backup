import transaction_pkg::*; 
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
		
		repeat(repeat_count) begin
		
			$display(" ");
			$display(" ");
			$display(" ");
			// Generated random inputs
			trans = new($urandom_range(0,255),$urandom_range(0,255), $urandom_range(0,7));
			$display("[Generator]");
			trans.display_generated_inputs();
			
			// for driver
			$display("[Same inputs send to driver]");
			gen2drv.put(trans);
			trans.display_generated_inputs();
			
			// for scoreboard
			trans1 = new trans;
			$display("[Same inputs send to scoreboard]");
			gen2scb.put(trans1);
			trans1.display_generated_inputs();
		end
		
	endtask
	
endclass