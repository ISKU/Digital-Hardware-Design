module test_KSA;
	reg [15:0] x, y; // input x, y
	reg c0; // carry in
	wire [15:0] sum; // output sum
	wire c16; // carry out
	reg [16:0] check; // KoggeStoneAdder로 구한 값이 맞는지 확인
	
	integer i, j, k;
	integer num_correct; // 값이 맞을 경우 증가
	integer num_wrong; // 값이 틀릴 경우 증가

	KoggeStoneAdder ksa(c16, sum, x, y, c0); // Kogge Stone Adder

	initial begin
		num_correct = 0; num_wrong = 0;
		
		for (i = 0; i < 65536; i = i + 1000) begin
			x = i; // X값은 0에서 ~ 65535까지 1000씩 증가한다.
			for (j = 0; j < 65536; j = j + 1000) begin
				y = j; // Y값 0에서 ~ 65535까지 1000씩 증가한다.
				for (k = 0; k < 2; k = k + 1) begin
					c0 = k; // carry in 0 또는 1
					check = x + y + c0; // Kogge Stone Adder로 계산한 값이 실제 계산 값과 일치하는지 확인
										
					#10 
					if ({c16, sum} == check) // Kogge Stone Adder로 계산한 값이 맞으면
						num_correct = num_correct + 1; // num_correct 증가
					else
						num_wrong = num_wrong + 1;
						
					$display($time, ": %d + %d + %d = %d (%d)", x, y, c0, {c16, sum}, check);
					// Kogge Stone Adder로 계산한 결과와 실제 계산 값을 출력하여 제대로 계산되었는지 확인
				end
			end
		end
		
		$display("num_correct = %d, num_wrong = %d", num_correct, num_wrong);
		// 맞은 개수, 틀린 개수 출력
	end
endmodule 