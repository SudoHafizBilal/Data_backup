interface timer_if(input logic clk);

  logic        rst_n;
  logic [1:0]  mode;
  logic [15:0] prescaler;
  logic [31:0] reload_val;
  logic [31:0] compare_val;
  logic        start;
  logic        timeout;
  logic        pwm_out;
  logic [31:0] current_count;

  // Driver modport
  modport drv (
    output mode, prescaler, reload_val, compare_val, start,
    input  timeout, pwm_out, current_count, rst_n
  );

  // Monitor modport
  modport mon (
    input mode, prescaler, reload_val, compare_val, start,
          timeout, pwm_out, current_count, rst_n
  );

endinterface
