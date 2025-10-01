interface MMT_intf(input logic clk);

logic valid;
// Inputs 
logic        rst_n;
logic        start;
logic [1:0]  mode;
logic [15:0] prescalar;
logic [31:0] reload_val;
logic [31:0] compare_val;
	
// Outputs 
logic [31:0] current_count;
logic timeout, pwm_out;

  modport drv (output start, mode, prescalar, reload_val, valid, compare_val, input rst_n, clk);
  modport mon (input start, mode, prescalar, reload_val, compare_val, valid, current_count, timeout, pwm_out, rst_n, clk);
endinterface
