import transaction_pkg::*; 
class scoreboard;
	mailbox mon2scb, gen2scb;
	int repeat_count;
	
	function new(mailbox gen2scb, mailbox mon2scb, int repeat_count);
		this.mon2scb = mon2scb;
		this.gen2scb = gen2scb;
		this.repeat_count = repeat_count;
	endfunction
	
	task run();
		transaction exp, act;
		int ncount = 0, nsuccess =0, nfails = 0;
				
		while(ncount<repeat_count) begin
			$display("[SCOREBOARD]");
			gen2scb.get(exp);
			exp.display_generated_inputs();
			mon2scb.get(act);
			exp.current_count = act.current_count;

			// Compute expected result 
			if(exp.mode == 0) begin
				exp.timeout = 1;
				exp.pwm_out = 0;
			end
			else if(exp.mode == 1 || exp.mode == 2) begin
				exp.pwm_out = 0;
				if(exp.current_count == 0) begin 
					exp.timeout = 1;
				end
				else begin 
					exp.timeout = 0;
				end
			end
			else if(exp.mode == 3) begin
				exp.pwm_out = 0;
				exp.timeout = 0;
				if(exp.current_count == 0) begin
					exp.timeout = 1;
				end
				if (exp.current_count <= exp.compare_val) begin 
					exp.pwm_out = 1;
				end			
			end
			else begin
				exp.timeout = 0;
				exp.pwm_out = 0;
			end

			$display("Expected Inputs Outputs");
			exp.display();
			$display("Actual Inputs Outputs from monitor");
			act.display();
			
				if(act.timeout == exp.timeout && act.pwm_out == exp.pwm_out && act.current_count == exp.current_count) begin
					$display("This %0dth test is passed ", ncount);
					$display("");
					nsuccess++;
				end
				else begin
					$display("############################");
					$display("#### TEST FAILED ALARAM ####");
					$display("############################");
          			$display("This %0dth test is failed ", ncount);
					$display("");
					nfails++;
				end
			ncount++;
		end
		$display("######################-----Final Result-----####################");
		$display(" ");
		$display("Total Success = %0d, Total Failures = %0d", nsuccess, nfails);
		$display(" ");
		$display("######################-----The End-----####################");
		$display(" ");
		$display(" ");
	endtask
	
endclass