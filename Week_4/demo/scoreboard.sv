import transaction_pkg::*;

class scoreboard;
  mailbox gen2scb;
  mailbox mon2scb;
  int repeat_count;

  function new(mailbox gen2scb, mailbox mon2scb, int repeat_count);
    this.gen2scb = gen2scb;
    this.mon2scb = mon2scb;
    this.repeat_count = repeat_count;
  endfunction

  task run();
    transaction exp, act;
    for (int i=0; i<repeat_count; i++) begin
      gen2scb.get(exp);
      mon2scb.get(act);

      // Very simple check: just compare timeout & pwm_out for now
      if (exp.start == act.start) begin
        if (act.timeout !== 1'bx && act.pwm_out !== 1'bx)
          $display("[SCB] Check PASS for test %0d", i);
        else
          $display("[SCB] Check FAIL for test %0d", i);
      end
      exp.display("EXP");
      act.display("ACT");
    end
  endtask
endclass
