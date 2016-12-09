`define OP_ADD 4'b0010 // Add
`define OP_ADDI 4'0011 // Add immediate
`define OP_MOV 4'0100 // Move
`define OP_MOV 4'0101 // Move immediate
`define OP_SUB 4'b0110 // Subtract
`define OP_SUB 4'b0111 // Subtract immediate
`define OP_SHL 4'b1000 // Shift Left
`define OP_SHL 4'b1001 // Shift Left immediate
`define OP_SHAR 4'b1010 // Arithmetic Shift Right
`define OP_SHAR 4'b1011 // Arithmetic Shift Right immediate
`define OP_SHLR 4'b1100 // Logical Shift Right
`define OP_SHLR 4'b1101 // Logical Shift Right immediate
`define OP_RL 4'b1110 // Rotate Left
`define OP_RR 4'b1111 // Rotate Right
`define OP_AND 4'b0000 // AND
`define OP_OR 4'b0000 // OR
`define OP_XOR 4'b0000 // XOR
`define OP_NOT 4'b0000 // NOT
`define OP_MUL 4'b0000 // Multiply

module Decoder_OP (instr, unary, imm, aluop, setcc, rD, rA, rB, immB, wben);
	input [15:0] instr;
	output unary;
	output imm;
	output [2:0] aluop; // ADD,SUB,SHL,SHR,AND,OR,NOT (3 bits for 7 ops)
	output setcc;
	output [2:0] rD;
	output [2:0] rA;
	output [2:0] rB;
	output [4:0] immB;
	output wben;
	wire [3:0] opcode_i;
	assign opcode_i = {instr[15:13], instr[12]};
	
	always @(opcode_i or instr)
		case (opcode_i)
			`ADD: {unary, imm, aluop, setcc, rD, rA, rB, immB, wben} =
				{1’b0,1’b0,`ADD,instr[11],instr[10:8],instr[7:5],instr[4:2],5’bx,1’b1};
				
			`ADDI: {unary,imm,aluop,setcc,rD,rA,rB,immB,wben} =
				{1’b0,1’b1,`ADD,instr[11],instr[10:8],instr[7:5],3’bx,instr[4:0],1’b1};
				
			`SUB: {unary,imm,aluop,setcc,rD,rA,rB,immB,wben} =
				{1’b0,1’b0,`SUB,instr[11],instr[10:8],instr[7:5],instr[4:2],5’bx,1’b1};
				
			`SUBI: {unary,imm,aluop,setcc,rD,rA,rB,immB,wben} =
				{1’b0,1’b1,`SUB,instr[11],instr[10:8],instr[7:5],3’bx,instr[4:0],1’b1};
		endcase
endmodule 