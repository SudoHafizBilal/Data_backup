import transaction_pkg::*;

class monitor;
  mailbox mon2scb;
  int repeat_count;
  virtual timer_if.mon mif;

  function new(mailbox mon2scb, int repeat_count, virtual timer_if.mon mif);
    this.mon2scb = mon2scb;
    this.repeat_count = repeat_count;
    this.mif = mif;
  endfunction

  task run();
    transaction tr;
    int ncount = 0;
    while (ncount < repeat_count) begin
      @(posedge mif.clk);
      tr = new();
      tr.mode          = mif.mode;
      tr.prescaler     = mif.prescaler;
      tr.reload_val    = mif.reload_val;
      tr.compare_val   = mif.compare_val;
      tr.start         = mif.start;
      tr.timeout       = mif.timeout;
      tr.pwm_out       = mif.pwm_out;
      tr.current_count = mif.current_count;
      mon2scb.put(tr);
      tr.display("MON");
      ncount++;
    end
  endtask
endclass
