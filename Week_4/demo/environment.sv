`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

import transaction_pkg::*;

class environment;
  generator  gen;
  driver     drv;
  monitor    mon;
  scoreboard scb;

  mailbox gen2drv, gen2scb, mon2scb;
  int repeat_count;
  virtual timer_if.drv dif;
  virtual timer_if.mon mif;

  function new(int repeat_count,
               virtual timer_if.drv dif,
               virtual timer_if.mon mif);
    this.repeat_count = repeat_count;
    this.dif = dif;
    this.mif = mif;
    gen2drv = new();
    gen2scb = new();
    mon2scb = new();
    gen = new(gen2drv, gen2scb, repeat_count);
    drv = new(gen2drv, dif);
    mon = new(mon2scb, repeat_count, mif);
    scb = new(gen2scb, mon2scb, repeat_count);
  endfunction

  task run();
    fork
      gen.run();
      drv.run();
      mon.run();
      scb.run();
    join
  endtask
endclass
