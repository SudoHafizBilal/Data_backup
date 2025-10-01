`include "environment.sv"

program automatic_test(MMT_intf MMT_if);

	initial begin
		environment env;
		env = new(MMT_if, 50);
		env.run();
		$stop;
	end

endprogram