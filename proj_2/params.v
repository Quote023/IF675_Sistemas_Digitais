module TECLAS;
	parameter //5 bits
		T_0=0,
		T_1=1,
		T_2=2,
		T_3=3,
		T_4=4,
		T_5=5,
		T_6=6,
		T_7=7,
		T_8=8,
		T_9=9,
		T_HASH=15,
		T_ASTE=14,
		T_A=10,
		T_B=11,
		T_C=12,
		T_D=13,
		T_NULL=16;
endmodule

module MODOS; //1 bit
	parameter CRON = 0, CALC = 1;
endmodule