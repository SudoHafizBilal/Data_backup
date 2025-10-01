`include "environment.sv"

program automatic_test(ra_intf rinf);

	initial begin
		environment env;
		env = new(rinf, 10);
		env.run();
		$stop;
	end

endprogram