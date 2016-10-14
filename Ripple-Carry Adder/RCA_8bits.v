module RCA_8bits(cout, sum, x, y, cin);
	input [7:0] x, y; // 8bit input
	input cin; // 0번재 FA의 들어오는 Carry의 초기값
	output [7:0] sum; // x+y 더한 결과
	output cout; // 마지막 FA의 Carry
	wire [6:0] c; // 각각의 FA의 Carry
	
	FullAdder FA0(c[0], sum[0], x[0], y[0], cin);
	FullAdder FA1(c[1], sum[1], x[1], y[1], c[0]);
	FullAdder FA2(c[2], sum[2], x[2], y[2], c[1]);
	FullAdder FA3(c[3], sum[3], x[3], y[3], c[2]);
	FullAdder FA4(c[4], sum[4], x[4], y[4], c[3]);
	FullAdder FA5(c[5], sum[5], x[5], y[5], c[4]);
	FullAdder FA6(c[6], sum[6], x[6], y[6], c[5]);
	FullAdder FA7(cout, sum[7], x[7], y[7], c[6]);
	// 1bit 더하기를 하는 FA 8개를 이어 붙여 8bit 덧셈을 할 수 있다.
	// cin은 0번째 FA의 들어오는 Carry이며, cout은 마지막 FA의 Carry이다.
	// 각 FA가 연산한 결과는 sum으로 저장되고, carry는 다음 FA로 넘겨준다.
endmodule 