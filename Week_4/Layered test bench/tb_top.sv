`include "ra_intf.sv"

module tb_top;

	// Clock generator
	bit clk;
	initial begin
		clk = 0;
		forever #20 clk = ~clk;
	end
	
	ra_intf rinf(clk);
	radder ra(rinf);
	test ta(rinf);

endmodule