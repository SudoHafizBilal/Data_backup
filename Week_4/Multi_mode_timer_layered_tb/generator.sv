import transaction_pkg::*; 
class generator;

	int repeat_count,count;
	mailbox gen2drv;
	mailbox gen2scb;
	
	function new(mailbox gen2drv, mailbox gen2scb, int repeat_count);
		this.repeat_count = repeat_count;
		this.gen2drv = gen2drv;
		this.gen2scb = gen2scb;
	endfunction
	
	task run();
		transaction trans;
		$display("Mode description");
		$display("Mode = 0 (Do nothing) count (0 to 1)");
		$display("Mode = 1 (One shot)   count (2 to 9)");
		$display("Mode = 2 (Periodic)   count (10 to 25)");
		$display("Mode = 3 (PWM_signal) count (25 to onward)");
		$display(" ");
		repeat(repeat_count) begin

			trans = new();
			trans.prescalar = 3;
			trans.compare_val = 2;

			if(count < 5) begin 
				trans.mode        = 0;
				trans.reload_val  = 2;
			end
			else if(count < 10) begin 
				trans.mode        = 1;
				trans.reload_val  = 5;
			end
			else if(count <= 25) begin 
				trans.mode        = 2;
				trans.reload_val  = 4;
			end
			else begin
				trans.mode        = 3;
				trans.reload_val  = 5;
			end
			count++;
			
			$display("[Generator]");
			trans.display_generated_inputs();
			// for driver
			gen2drv.put(trans);
			// for scoreboard
			gen2scb.put(trans);
		end
		
	endtask
	
endclass