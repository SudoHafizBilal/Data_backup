import transaction_pkg::*;

class generator;
  mailbox gen2drv;
  mailbox gen2scb;
  int repeat_count;

  function new(mailbox gen2drv, mailbox gen2scb, int repeat_count);
    this.gen2drv = gen2drv;
    this.gen2scb = gen2scb;
    this.repeat_count = repeat_count;
  endfunction

  task run();
    transaction tr;
    for (int i=0; i<repeat_count; i++) begin
      tr = new();
      assert(tr.randomize());
      gen2drv.put(tr);
      gen2scb.put(tr);
      tr.display("GEN");
    end
  endtask
endclass
