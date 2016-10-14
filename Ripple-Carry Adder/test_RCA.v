module test_RCA;
	reg [7:0] x; 
	reg [7:0] y; // 8bit input
	reg cin; // 초기값
	
	wire [7:0] sum; // 8bit output
	wire cout; // carry
	
	RCA_8bits U0(cout, sum, x, y, cin);
	// 8bit Ripple-Carry Adder
	
	initial begin
		#100
		x = 8'b11110000; 
		y = 8'b00001111;
		cin = 0;
		// 11110000과 00001111을 더한다.
		
		#100
		x = 8'b01010101;
		y = 8'b10101010;
		cin = 0;
		// 01010101과 10101010을 더한다.
		
		#100
		$finish;
	end
endmodule
