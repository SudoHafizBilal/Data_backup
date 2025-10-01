`timescale 1ns/1ps

module tb_top;

	//Clock generator
	logic clk, rst_n, start;
	initial begin
		clk = 0;
		forever #5 clk = ~clk;
	end

	initial begin
		rst_n = 0;
		start = 0;
		repeat (2) @(posedge clk);
		rst_n = 1;
		start = 1;
	end

	// Interface
	MMT_intf MMT_if(clk);
	
	// Instantiate DUT
    Multi_Mode_Timer dut (
        .clk(MMT_if.clk),
        .rst_n(MMT_if.rst_n),
        .mode(MMT_if.mode),
        .prescalar(MMT_if.prescalar),
        .reload_val(MMT_if.reload_val),
        .compare_val(MMT_if.compare_val),
        .start(MMT_if.start),
        .timeout(MMT_if.timeout),
        .pwm_out(MMT_if.pwm_out),
        .current_count(MMT_if.current_count)
    );
	
	assign MMT_if.rst_n = rst_n;
	assign MMT_if.start = start;
	// Test instance
	automatic_test ta(MMT_if);

endmodule