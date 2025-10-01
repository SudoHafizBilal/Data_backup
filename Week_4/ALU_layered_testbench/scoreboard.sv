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
		$display(" ");
		$display("[SCOREBOARD]");		
		while(ncount<repeat_count) begin
			gen2scb.get(exp);
			$display("Get expected values from generator");
			exp.display();
			$display(" ");
			mon2scb.get(act);
			$display("Get actual values from monitor");
			act.display();
			$display(" ");
			
			$display("Computes expected result");
			case(exp.op_sel)
				3'b000: exp.out = exp.a + exp.b;
				3'b001: exp.out = exp.a - exp.b;
				3'b010: exp.out = exp.a & exp.b;
				3'b011: exp.out = exp.a | exp.b;
				3'b100: exp.out = exp.a ^ exp.b;
				3'b101: exp.out = ~exp.a;
				3'b110: exp.out = exp.a << 1;
				3'b111: exp.out = exp.a >> 1;
			endcase
			$display("Compares expected vs actual result");
			if (exp.out === act.out && exp.zero === act.zero) 	 begin
					$display("This test is passed");
					nsuccess++;
				end
			else begin
				nfails++;
				$display("[SCOREBOARD] MISMATCH for ID=%0d: EXP out=%0d zero=%d, ACT out=%0d zero=%d",
                  exp.id, exp.out, exp.zero, act.out, act.zero);
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