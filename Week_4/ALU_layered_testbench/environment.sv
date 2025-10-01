`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

import transaction_pkg::*; 
class environment;

	mailbox gen2drv, mon2scb, gen2scb;
	generator gen;
	driver drv;
	monitor mon;
	scoreboard scb;
		
	function new(virtual alu_intf rinf, int repeat_count);
		this.gen2drv = new();
		this.mon2scb = new();
		this.gen2scb = new();
		
		this.gen = new(gen2drv, gen2scb, repeat_count);
		this.drv = new(gen2drv, repeat_count, rinf);
		this.mon = new (mon2scb, repeat_count, rinf);
		this.scb = new(gen2scb, mon2scb, repeat_count);
	endfunction
	
	task run();
		fork
			gen.run();
			drv.run();
			mon.run();
			scb.run();
		join
	endtask;
	
endclass