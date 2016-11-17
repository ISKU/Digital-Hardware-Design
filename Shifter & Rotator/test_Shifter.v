module test_Shifter;
	reg [15:0] x; // 16bit 입력
	reg [3:0] shift; // 4bit shift & rotate 할 bit 개수 
	reg leftOrRight; // left 또는 right 결정
	wire [15:0] result; // 16bit 결과
	
	integer i;

	Shifter16_LR shift0(result, shift, leftOrRight, x); // 16bit LR Shifter
	//Rotator16_LR rotate0(result, shift, leftOrRight, x); // 16bit LR Rotator
	
	initial begin
		// shift & rotate right
		// 1~15bit shift 또는 rotate를 right 결과 모두 출력
		for (i = 1; i < 16; i = i + 1) begin
			#100
			shift = i;
			leftOrRight = 1'b0; // right set
			x = 16'hffff;
			//x = 16'h00ff;
		end
		
		#500
		
		// shift & rotate left
		// 1~15bit shift 또는 rotate를 left 모두 출력
		for (i = 1; i < 16; i = i + 1) begin
			#100
			shift = i;
			leftOrRight = 1'b1; // left set
			x = 16'hffff;
			//x = 16'h00ff;
		end
	end
endmodule 