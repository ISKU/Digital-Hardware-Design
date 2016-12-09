module CPU (clk, nRESET);
	input clk;
	input nRESET;
	
	reg [15:0] pc;
	reg [3:0] cc;
	wire [15:0] instr;
	wire unary;
	wire imm;
	wire [3:0] aluop;
	wire setcc;
	wire [2:0] rD, rA, rB;
	wire [4:0] immB;
	wire wben;
	wire [15:0] valA, valB, svalA, svalB, valE;
	wire [3:0] NZCV;

	/* PC Register */
	always (posedge clk or negedge nRESET)
		if (!nRESET) 
			pc <= 16'b0;
		else 
			pc <= pc + 2;

	/* Instruction Memory */
	memory imem (clk, `READ, pc, instr);

	/* Instruction Decoder */
	decoder idec (instr, unary, imm, aluop, setcc, rD, rA, rB, immB, wben);
	
	/* Register File */
	reg_file ireg_file (clk, nRESET, wben, rD, valE, rA, rB, valA, valB);

	/* ALU */
	assign svalA = unary ? 16'b0 : valA;
	assign svalB = imm ? {11{immB[4]}, immB}/*sign ext*/ : valB;
	alu ialu (svalA, svalB, NZCV, valE);

	/* Condition code Register */
	always (posedge clk or negedge nRESET)
		if (nRESET) 
			cc <= 4'b0;
		else if(setcc) 
			cc <= NZCV;
endmodule 