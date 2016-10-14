module test_RCA;
	reg [7:0] x;
	reg [7:0] y;
	reg cin;
	
	wire [7:0] sum;
	wire cout;
	
	RCA_8bits U0(cout, sum, x, y, cin);
	
	initial begin
		#100
		x = 8'b11110000;
		y = 8'b00001111;
		cin = 0;
		
		#100
		x = 8'b01010101;
		y = 8'b10101010;
		cin = 0;
		
		#100
		$finish;
	end
endmodule
