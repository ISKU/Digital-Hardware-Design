`define OP_ADD 4'b0001 // Add
`define OP_SUB 4'b0010 // Subtract
`define OP_SHL 4'b0101 // Shift Left
`define OP_SHAR 4'b0110 // Arithmetic Shift Right 
`define OP_SHLR 4'b0111 // Logical Shift Right
`define OP_RL 4'b1000 // Rotate Left
`define OP_RR 4'b1001 // Rotate Right
`define OP_AND 4'b1011 // AND
`define OP_OR 4'b1100 // OR
`define OP_XOR 4'b1101 // XOR
`define OP_NOT 4'b1110 // NOT
`define OP_MUL 4'b1111 // Multiply

module test_ALU;
	reg [15:0] valA, valB;
	reg [3:0] aluop;
	reg sub;
	wire [3:0] cc;
	wire [15:0] result;

	ALU myALU(result, cc, valA, valB, aluop, sub);
	
	initial begin
		
		// Add , Subtract Test
		#200
		aluop = `OP_ADD;
		valA = 16'd10000;
		valB = 16'd15000; // 10000 + 15000
		sub = 0;
		#10 $display($time, ": %d + %d = %d (%d), NZCV: %b", valA, valB, result, valA + valB, cc);
		
		#200
		valA = 16'd32767;
		valB = 16'd1; // 32767 + 1 !! Overflow set
		#10 $display($time, ": %d + %d = %d (%d), NZCV: %b", valA, valB, result, valA + valB, cc);
		
		#200
		aluop = `OP_SUB;
		valA = 16'd15000;
		valB = 16'd5000; // 15000 - 5000
		sub = 1;
		#10 $display($time, ": %d - %d = %d (%d), NZCV: %b", valA, valB, result, valA - valB, cc);
		
		#200
		valA = 16'd20000;
		valB = 16'd40000; // 20000 - 40000 !! Negative set
		sub = 1;
		#10 $display($time, ": %d - %d = %d (%d), NZCV: %b", valA, valB, result, valA - valB, cc);
		
		#200
		valA = 16'd60000;
		valB = 16'd60000; // 60000 - 60000 !! Zero set
		#10 $display($time, ": %d - %d = %d (%d), NZCV: %b", valA, valB, result, valA - valB, cc);
		
		// Multiply Test
		#200
		aluop = `OP_MUL;
		valA = 16'd100;
		valB = 16'd200; // 100 * 200
		sub = 0;
		#10 $display($time, ": %d * %d = %d (%d), NZCV: %b", valA, valB, result, valA * valB, cc);
		
		#200
		valA = 16'd60000;
		valB = 16'd60000; // 60000 * 60000 !! Overflow, carry set
		#10 $display($time, ": %d * %d = %d (%d), NZCV: %b", valA, valB, result, valA * valB, cc);	
		
		#200
		valA = 16'd54321;
		valB = 16'd0; // 54321 * 0 !! zero set
		#10 $display($time, ": %d * %d = %d (%d), NZCV: %b", valA, valB, result, valA * valB, cc);
		
		// Shift Test
		#200
		aluop = `OP_SHL; // Shift Left !! Overflow set
		valA = 16'h00ff;
		valB = 16'd4; // 0000 0000 1111 1111 << 4 !! result = 0000 1111 1111 0000
		sub = 0;
		#10 $display($time, ": %b << %d = %b, NZCV: %b", valA, valB, result, cc);	
		
		#200
		aluop = `OP_SHAR; // Arithmetic Shift Right
		valA = 16'hff00;
		valB = 16'd4; // 1111 1111 0000 0000 >> 4 !! result = 1111 1111 1111 0000
		sub = 0;
		#10 $display($time, ": %b >> %d = %b, NZCV: %b", valA, valB, result, cc);	
		
		#200
		valA = 16'h0fff;
		valB = 16'd4; // 0000 1111 1111 1111 >> 4 !! result = 0000 0000 1111 1111
		#10 $display($time, ": %b >> %d = %b, NZCV: %b", valA, valB, result, cc);	
		
		#200
		aluop = `OP_SHLR; // Logical Shift Right
		valA = 16'hffff;
		valB = 16'd15; // 1111 1111 1111 111 >> 15 !! result = 0000 0000 0000 0001
		sub = 0;
		#10 $display($time, ": %b >> %d = %b, NZCV: %b", valA, valB, result, cc);	
		
		// Rotate Test
		#200
		aluop = `OP_RL; // Rotate Left
		valA = 16'hf0ff;
		valB = 16'd4; // 1111 0000 1111 1111 << 4 !! result = 0000 1111 1111 1111
		sub = 0;
		#10 $display($time, ": %b << %d = %b, NZCV: %b", valA, valB, result, cc);			
		
		#200
		aluop = `OP_RR; // Rotate right
		valA = 16'hf0ff;
		valB = 16'd4; // 1111 0000 1111 1111 >> 4 !! result = 1111 1111 0000 1111
		sub = 0;
		#10 $display($time, ": %b >> %d = %b, NZCV: %b", valA, valB, result, cc);		
		
		// Logical Gate Test
		#200
		aluop = `OP_AND; // AND
		valA = 16'hff00;
		valB = 16'h00ff; // 1111 1111 0000 0000 & 0000 0000 1111 1111 !! result zero set
		sub = 0;
		#10 $display($time, ": %b & %b = %b, NZCV: %b", valA, valB, result, cc);		
		
		#200
		aluop = `OP_OR; // OR
		valA = 16'hff00;
		valB = 16'h00ff; // 1111 1111 0000 0000 | 0000 0000 1111 1111 !! result 0xffff
		sub = 0;
		#10 $display($time, ": %b | %b = %b, NZCV: %b", valA, valB, result, cc);		
		
		#200
		aluop = `OP_XOR; // XOR
		valA = 16'haaaa;
		valB = 16'haa55; // 1010 1010 1010 1010 ^ 1010 1010 0101 0101 !! reuslt 0x00ff
		sub = 0;
		#10 $display($time, ": %b ^ %b = %b, NZCV: %b", valA, valB, result, cc);		
		
		#200
		aluop = `OP_NOT; // NOT
		valA = 16'bx; // don't care
		valB = 16'hff00; // A: don't care, B: 1111 111 0000 0000 !! result 0x00ff
		sub = 0;
		#10 $display($time, ": ~%b = %b, NZCV: %b", valB, result, cc);		
		
		#200
		$finish;
	end

endmodule 