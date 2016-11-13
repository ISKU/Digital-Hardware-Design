module BoothMultiplier(z, x, y);
	input [15:0] x;
	input [15:0] y;
	output [31:0] z;
	
	wire [2:0] sel1;
	wire [2:0] sel2;
	wire [2:0] sel3;
	wire [2:0] sel4;
	wire [2:0] sel5;
	wire [2:0] sel6;
	wire [2:0] sel7;
	wire [2:0] sel8;
	
	wire sign1;
	wire sign2;
	wire sign3;
	wire sign4;
	wire sign5;
	wire sign6;
	wire sign7;
	wire sign8;
	
	wire [18:0] partial1;
	wire [17:0] partial2;
	wire [17:0] partial3;
	wire [17:0] partial4;
	wire [17:0] partial5;
	wire [17:0] partial6;
	wire [17:0] partial7;
	wire [16:0] partial8;
	
	
	wire [19:0] sum1;
	wire [19:0] sum2;
	wire [19:0] sum3;
	wire [19:0] sum4;
	wire [19:0] sum5;
	wire [19:0] sum6;
	wire [18:0] sum7;
	
	wire [19:0]carry1;
	wire [19:0]carry2;
	wire [19:0]carry3;
	wire [19:0]carry4;
	wire [19:0]carry5;
	wire [19:0]carry6;
	wire [18:0]carry7;	
	wire cout;
	
	BoothEncoder booth1(sel1, {y[1:0], 1'b0});
	BoothEncoder booth2(sel2, y[3:1]);
	BoothEncoder booth3(sel3, y[5:3]);
	BoothEncoder booth4(sel4, y[7:5]);
	BoothEncoder booth5(sel5, y[9:7]);
	BoothEncoder booth6(sel6, y[11:9]);
	BoothEncoder booth7(sel7, y[13:11]);
	BoothEncoder booth8(sel8, y[15:13]);
	
	PartialProduct level_1(partial1, sign1, sel1, x);
	PartialProduct level_2(partial2, sign2, sel2, x);
	PartialProduct level_3(partial3, sign3, sel3, x);
	PartialProduct level_4(partial4, sign4, sel4, x);
	PartialProduct level_5(partial5, sign5, sel5, x);
	PartialProduct level_6(partial6, sign6, sel6, x);
	PartialProduct level_7(partial7, sign7, sel7, x);
	PartialProduct level_8(partial8, sign8, sel8, x);
	
	// Carry Save Adders
	CSA20 csa0(
		carry1,
		sum1,
		({3'b0, ~partial1[16], partial1[16], partial1[16:2]}),
		({2'b0, 1'b1, ~partial2[16], partial2[15:0]}),
		({1'b1, ~partial3[16], partial3[15:0], 2'b0})
	);
	
	CSA20 csa1(
		carry2,
		sum2,
		{2'b0, sum1[19:2]},
		{1'b0, carry1[19:2], sign3},
		{1'b1, ~partial4[16], partial4[15:0], 2'b0}
	);
	
	CSA20 csa2(
		carry3,
		sum3,
		{2'b0, sum2[19:2]},
		{1'b0, carry2[19:2], sign4},
		{1'b1, ~partial5[16], partial5[15:0], 2'b0}
	);
	
	CSA20 csa3(
		carry4,
		sum4,
		{2'b0, sum3[19:2]},
		{1'b0, carry3[19:2], sign5},
		{1'b1, ~partial6[16], partial6[15:0], 2'b0}
	);
	
	CSA20 csa4(
		carry5,
		sum5,
		{2'b0, sum4[19:2]},
		{1'b0, carry4[19:2], sign6},
		{1'b1, ~partial7[16], partial7[15:0], 2'b0}
	);
	
	CSA20 csa5(
		carry6,
		sum6,
		{2'b0, sum5[19:2]},
		{1'b0, carry5[19:2], sign7},
		{1'b1, ~partial8[16], partial8[15:0], 2'b0}
	);
	
	CSA19_HA csa6(
		carry7,
		sum7,
		{1'b0, sum6[19:2]},
		{carry6[19:2], sign8}
	);

	RCA32 cpa0(
		cout,
		z,
		{1'b0, sum7[18:2], sum6[1:0], sum5[1:0], sum4[1:0], sum3[1:0], sum2[1:0], sum1[1:0], partial1[1:0]},
		{carry7[18:2], carry6[1:0], carry5[1:0], carry4[1:0], carry3[1:0], carry2[1:0], carry1[1:0], sign2, 1'b0, sign1},
		1'b0
	);
endmodule 