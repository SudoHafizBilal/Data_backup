

module tb_top;

	//Clock generator
	bit clk;
	initial begin
		clk = 0;
		forever #5 clk = ~clk;
	end
	
	// Interface
	alu_intf rinf(clk);
	
	// DUT instance
	alu dut (
		.a(rinf.a),
		.b(rinf.b),
		.op_sel(rinf.op_sel),
		.out(rinf.out),
		.zero(rinf.zero),
		.carry(rinf.carry),
		.overflow(rinf.overflow)
	);
	
	// Test instance
	automatic_test ta(rinf);

endmodule