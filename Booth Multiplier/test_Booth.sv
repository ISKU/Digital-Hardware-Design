module test_Booth;
	reg [15:0] x, y; // input x, y (16bit)
	wire [31:0] result; // output x*y (32bit)
	reg [31:0] check; // Booth Multiplier로 구한 값이 맞는지 확인
	
	integer i, j;
	integer num_correct; // 값이 맞을 경우 증가
	integer num_wrong; // 값이 틀릴 경우 증가

	BoothMultiplier booth(result, x, y); // 16bit Modified Booth Multiplier

	initial begin
		num_correct = 0; num_wrong = 0;
		
		for (i = 0; i < 65536; i = i + 1000) begin
			x = i; // X값은 0에서 ~ 65535까지 1000씩 증가한다.
			for (j = 0; j < 65536; j = j + 1000) begin
				y = j; // Y값 0에서 ~ 65535까지 1000씩 증가한다.

				check = x * y; 
				// Booth Multiplier로 계산한 값이 실제 계산 값과 일치하는지 확인 하기 위해 계산
										
				#30 
				if (result == check) // Kogge Stone Adder로 계산한 값이 맞으면
					num_correct = num_correct + 1; // num_correct 증가
				else
					num_wrong = num_wrong + 1;
						
				$display($time, ": %d * %d = %d (%d)", x, y, result, check);
				// Booth Multiplier로 계산한 결과와 실제 계산 값을 출력하여 제대로 계산되었는지 확인
			end
		end
		
		$display("num_correct = %d, num_wrong = %d", num_correct, num_wrong);
		// 맞은 개수, 틀린 개수 출력
	end
endmodule 