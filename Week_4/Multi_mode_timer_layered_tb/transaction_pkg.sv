package transaction_pkg;

class transaction;

	static int count;	
	int id;				
	
	// Inputs to DUT
	rand bit         start;
    rand bit [1:0]   mode;
    rand bit [15:0]  prescalar;
    rand bit [31:0]  reload_val;
    rand bit [31:0]  compare_val;
    
	// Outputs from DUT
	bit [31:0] current_count;
	bit timeout, pwm_out;

	function new();
	  start = 1;
      id = count;
      count++;
    endfunction
	
	function void display_generated_inputs();
		$display("------------------------------------------------------------------------------");
		$display("count=%0d, ID=%0d, start=%0d, mode=%0d, prescalar=%0d, reload_value=%0d, Compare_value=%0d", 
					count, id, start, mode, prescalar, reload_val, compare_val);
		$display("------------------------------------------------------------------------------");
	endfunction
	
	function void display();
		$display("------------------------------------------------------------------------------------------------------------------------");
		$display("count=%0d, ID=%0d, start=%0d, mode=%0d, prescalar=%0d, reload_value=%0d, Compare_value=%0d | current_count=%0d, timeout=%0d, pwm_out=%0d", 
					count, id, start, mode, prescalar, reload_val, compare_val, current_count, timeout, pwm_out);
		$display("------------------------------------------------------------------------------------------------------------------------");
	endfunction
	
endclass
endpackage
