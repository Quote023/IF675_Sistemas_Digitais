module calculadora(
	input ativo,
	input clk,
	input [4:0] tecla_atual,
	output reg[6:0] A,
	output reg[6:0] B,
	output reg[7:0] resultado);

	parameter NUM_A = 0, NUM_B = 1;
	parameter OP_SUM = 0, OP_SUB = 1, OP_MUL = 2;

	reg num_selec = NUM_A;
	reg[1:0] operacao = OP_SUM;

	always @ (posedge clk) begin
		if(ativo) begin
			case (tecla_atual)
				TECLAS.T_HASH: num_selec <= NUM_A; 
				TECLAS.T_ASTE: num_selec <= NUM_B;
				TECLAS.T_A: operacao <= OP_SUM;
				TECLAS.T_B: operacao <= OP_SUB;
				TECLAS.T_C: operacao <= OP_MUL;
				default: if (tecla_atual < 10) begin
					if (num_selec == NUM_A) A <= tecla_atual;
					else B <= tecla_atual;
				 end
			endcase
		end 
		//else begin 
		//	A <= ativo;
		//	B <= 10;
		//end
	end

	  always @ (posedge clk) begin
		 case (operacao) 
			OP_SUM: resultado <= (A + B);
			OP_SUB: resultado <= (A - B);
			OP_MUL: resultado <= (A * B);
		 endcase
	  end
endmodule