module HalfAdder(cout, sum, a, b);
	input a, b; // input
	output cout, sum; // carry, sum
	
	assign {cout, sum} = a + b; // a + b의 2bit 결과를 저장
endmodule 