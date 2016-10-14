module FullAdder(cout, sum, a, b, cin);
	input a, b, cin; // input, carry in 초기값
	output cout, sum; // carry, sum
	
	assign {cout, sum} = a + b + cin; // a + b의 2bit 결과, cin은 들어오는 carry이다.
endmodule 