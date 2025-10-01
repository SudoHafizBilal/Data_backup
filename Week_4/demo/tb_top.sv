`include "timer_if.sv"

`timescale 1ns/1ps
import transaction_pkg::*;

module tb_top;

  logic clk, rst_n;
  timer_if tb_if(clk);

  // DUT
  Multi_Mode_Timer dut(
    .clk(tb_if.clk),
    .rst_n(tb_if.rst_n),
    .mode(tb_if.mode),
    .prescaler(tb_if.prescaler),
    .reload_val(tb_if.reload_val),
    .compare_val(tb_if.compare_val),
    .start(tb_if.start),
    .timeout(tb_if.timeout),
    .pwm_out(tb_if.pwm_out),
    .current_count(tb_if.current_count)
  );

  // Clock
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 100 MHz
  end

  // Reset
  initial begin
    rst_n = 0;
    #20 rst_n = 1;
  end

  // Connect rst_n into interface
  assign tb_if.rst_n = rst_n;

  // Run program
  automatic_test test(tb_if);

endmodule
