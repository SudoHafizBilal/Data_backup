package transaction_pkg;

  class transaction;
    // Inputs
    rand bit [1:0]   mode;
    rand bit [15:0]  prescaler;
    rand bit [31:0]  reload_val;
    rand bit [31:0]  compare_val;
    rand bit         start;

    // Outputs
    bit              timeout;
    bit              pwm_out;
    bit [31:0]       current_count;

    // Constraint example (to avoid silly values)
    constraint c_valid {
      prescaler inside {[1:1000]};   // reasonable prescaler
      reload_val > 0;
      compare_val < reload_val;
    }

    function void display(string tag="");
      $display("[%s] mode=%0d prescaler=%0d reload=%0d compare=%0d start=%0b | timeout=%0b pwm_out=%0b count=%0d",
               tag, mode, prescaler, reload_val, compare_val, start,
               timeout, pwm_out, current_count);
    endfunction
  endclass

endpackage
