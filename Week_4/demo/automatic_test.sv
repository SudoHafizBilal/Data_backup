`include "environment.sv"

import transaction_pkg::*;

program automatic_test(timer_if tb_if);

  environment env;

  initial begin
    env = new(5, tb_if, tb_if); // run 5 transactions
    env.run();
    $finish;
  end

endprogram
