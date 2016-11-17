module test_Shifter;
	reg [15:0] x;
	reg [3:0] shift;
	reg leftOrRight;
	wire [15:0] result;
	
	integer i;

	//Shifter16_LR shift0(result, shift, leftOrRight, x); // 16bit LR Shifter
	Rotator16_LR rotate0(result, shift, leftOrRight, x); // 16bit LR Rotator
	
	initial begin
		// shift & rotate right
		for (i = 1; i < 16; i = i + 1) begin
			#100
			shift = i;
			leftOrRight = 1'b0;
			//x = 16'hf0f0;
			x = 16'h00ff;
		end
		
		#500
		
		// shift & rotate left
		for (i = 1; i < 16; i = i + 1) begin
			#100
			shift = i;
			leftOrRight = 1'b1;
			//x = 16'hf0f0;
			x = 16'h00ff;
		end
	end
endmodule 