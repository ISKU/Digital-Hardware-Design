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

module ALU (result, cc, valA, valB, aluop, sub);
	input [15:0] valA; // input A
	input [15:0] valB; // input B
	input [3:0] aluop; // ALU Operation code (12개)
	input sub; // 빼기 옵션
	
	output [3:0] cc; // N, Z, C, V
	output [15:0] result; // output
	
	wire [15:0] and16b, or16b, not16b, xor16b; // and, or, not, xor
	wire [15:0] shift_out, arithmetic_out, rotate_out; // shift, rotate
	wire [15:0] add_out, mul_out, svalB; // add, sub, multiply 
	
	wire [15:0] result;
	wire shift_co, add_co, mul_co; // shift, add, multiply carry overflow
	wire shift_LR, rotate_LR; // shift, rotate 왼쪽 오른쪽 선택
	wire N, Z, C, V; // N, Z, C, V
	
	// AND, OR, NOT, XOR
	assign and16b = valA & valB; // valA and valB
	assign or16b = valA | valB; // valA or valB
	assign not16b = ~valB; // not valB
	assign xor16b = valA ^ valB; // valA xor valB
	
	// Left Shifter Or Logical Shift Right
	assign shift_LR = 
		(shift_LR == `OP_SHL) ? 1'b1 : // shift left
		(shift_LR == `OP_SHLR) ? 1'b0 : 1'bx; // logical shift right
	Shifter16_LR myShifter(shift_out, valB, shift_LR, valA); // valA를 valB 만큼 Shift
	
	// Arithmetic Shift Right 
	Shifter16_LR myArithmeticShift(arithmetic_out, valB, valA); // valA를 valB만큼 Arithmetic Shift
	
	// Rotator
	assign rotate_LR = 
		(rotate_LR == `OP_RL) ? 1'b1 : // rotate left
		(rotate_LR == `OP_RR) ? 1'b0 : 1'bx; // rotate right
	Rotator16_LR myRotator(rotate_out, valB, rotate_LR, valA); // valA를 valB만큼 Rotate
	
	// 덧셈 or 뺄셈
	assign svalB = sub ? ~valB : valB; // 뺄셈일 경우 1의 보수를 취한다
	KoggeStoneAdder myAdder(add_co, add_out, valA, svalB, sub); // KoggeStoneAdder를 통한 덧셈 또는 뺄셈(1(sub)의 더하여 2의보수)

	// 곱셈
	BoothMultiplier myMultiplier(mul_co, mul_out, valA, valB);
	
	// 각각의 OPCODE에 대한 결과값 
	assign result =
		(aluop == `OP_ADD) ? add_out :
		(aluop == `OP_SUB) ? add_out :
		(aluop == `OP_SHL) ? shift_out :
		(aluop == `OP_SHAR) ? arithmetic_out :
		(aluop == `OP_SHLR) ? shift_out :
		(aluop == `OP_RL) ? rotate_out :
		(aluop == `OP_RR) ? rotate_out :
		(aluop == `OP_AND) ? and16b :
		(aluop == `OP_OR) ? or16b :
		(aluop == `OP_XOR) ? xor16b :
		(aluop == `OP_NOT) ? not16b :
		(aluop == `OP_MUL) ? mul_out : 16'bx;
	
	assign N = result[15]; // 최상위 비트로부터 부호 확인
	assign Z = ~|result; // Zero 확인
	assign C = 
		(aluop == `OP_ADD) ? add_co : // Add
		(aluop == `OP_MUL) ? mul_co : // Multiply
		1'b0;
	assign V = 
		(aluop == `OP_SHL) ? 1'b1 : // shift left
		(aluop == `OP_ADD) ? // Add
			(~valA[15] & ~svalB[15] & add_out[15]) | /* (-) + (-) = (+) */ 
			(valA[15] & svalB[15] & ~add_out[15]) : /* (+) + (+) = (-) */
		(aluop == `OP_MUL) ? mul_co : // Multiply
		1'b0;
	
	assign cc = {N, Z, C, V};
	
endmodule 