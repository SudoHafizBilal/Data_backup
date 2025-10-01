class transaction;

	static int count;	// static variable
	int id;				// nonstatic variable
	rand bit [3:0] a;
	rand bit [3:0] b;
	bit [3:0] c;
	
	function new(bit [3:0] a, bit[3:0] b, bit[4:0] c);
		this.a = a;
		this.b = b;
		this.c = c;
		id = count;
		count = count+1;
	endfunction
	
	function display();
		$display("---------------------------");
		$display("count=%d, ID=%d, a = %d, b=%d, c=%d", count, id, a, b, c);
		$display("---------------------------");
	endfunction
	
endclass