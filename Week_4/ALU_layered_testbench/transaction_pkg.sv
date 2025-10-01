package transaction_pkg;

class transaction;

	static int count;	// static variable
	int id;				// nonstatic variable
	
	// Inputs to DUT
	rand bit [7:0] a;
	rand bit [7:0] b;
	rand bit [2:0] op_sel;
	
	// Outputs from DUT
	bit [7:0] out;
	bit zero, carry, overflow;
	
	function new(bit [7:0] a=0, bit[7:0] b=0, bit[2:0] op_sel=0);
	//, bit [7:0] out, bit zero, bit carry, bit overflow);
	
		// Inputs & Outputs
		this.a = a;
		this.b = b;
		this.op_sel = op_sel;
		//this.out = out;
		//this.zero = zero;
		//this.carry = carry;
		//this.overflow = overflow;
		
		id = count;
		count = count+1;
	endfunction
	
	function display_generated_inputs();
		$display("---------------------------------------------------------");
		$display("count=%d, ID=%d, a=%d, b=%d, op_sel=%d", count, id, a, b, op_sel);
		$display("---------------------------------------------------------");
	endfunction
	
	function display();
		$display("----------------------------------------------------------------------------------------");
		$display("count=%d, ID=%d, a=%d, b=%d, op_sel=%d, out=%d, zero=%d, carry=%d, overflow=%d", count, id, a, b, op_sel, out, zero, carry, overflow);
		$display("----------------------------------------------------------------------------------------");
	endfunction
	
endclass
endpackage
