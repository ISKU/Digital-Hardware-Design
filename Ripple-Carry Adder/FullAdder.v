module FullAdder(cout, sum, a, b, cin);
	input a, b, cin;
	output cout, sum;
	
	assign {cout, sum} = a + b + cin;
endmodule 