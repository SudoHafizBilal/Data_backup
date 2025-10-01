import transaction_pkg::*;

class driver;
  mailbox gen2drv;
  virtual timer_if.drv dif;

  function new(mailbox gen2drv, virtual timer_if.drv dif);
    this.gen2drv = gen2drv;
    this.dif     = dif;
  endfunction

  task run();
    transaction tr;
    forever begin
      gen2drv.get(tr);
      // Apply to interface
      dif.mode        <= tr.mode;
      dif.prescaler   <= tr.prescaler;
      dif.reload_val  <= tr.reload_val;
      dif.compare_val <= tr.compare_val;
      dif.start       <= tr.start;
      tr.display("DRV");
      @(posedge dif.clk); // give time to propagate
    end
  endtask
endclass
