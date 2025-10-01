interface alu_intf(input logic clk);
  logic [7:0] a, b;
  logic [2:0] op_sel;
  logic [7:0] out;
  logic zero, carry, overflow;
  logic valid;

  modport drv (output a, b, op_sel, valid,input clk);
  
  modport mon (input a, b, op_sel, out, zero, carry, overflow, valid, clk);
endinterface
