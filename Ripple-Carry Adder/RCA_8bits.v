module RCA_8bits(cout, sum, x, y, cin);
	input [7:0] x, y;
	input cin;
	output [7:0] sum;
	output cout;
	wire [6:0] c;
	
	FullAdder FA0(c[0], sum[0], x[0], y[0], cin);
	FullAdder FA1(c[1], sum[1], x[1], y[1], c[0]);
	FullAdder FA2(c[2], sum[2], x[2], y[2], c[1]);
	FullAdder FA3(c[3], sum[3], x[3], y[3], c[2]);
	FullAdder FA4(c[4], sum[4], x[4], y[4], c[3]);
	FullAdder FA5(c[5], sum[5], x[5], y[5], c[4]);
	FullAdder FA6(c[6], sum[6], x[6], y[6], c[5]);
	FullAdder FA7(cout, sum[7], x[7], y[7], c[6]);
endmodule 