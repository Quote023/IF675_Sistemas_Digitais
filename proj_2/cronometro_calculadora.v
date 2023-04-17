module cronometro_calculadora(clk,key,decs,segs,X,Y,resultado,modo_atual);
	input clk; //clock 1000hz
	input [4:0] key; //input do keypad

	output wire [3:0] decs; //decimos de segundos do cronometro
	output wire [9:0] segs; // segundos do cronometro;
	output wire [6:0] X,Y; //valores atuais da calcuadora
	output wire [7:0] resultado; //resultado calculadora

	output reg modo_atual = MODOS.CRON;
	reg[4:0] tecla_atual = TECLAS.T_NULL;

	always @ (posedge clk) begin: ATRIBUIR_TECLA
    tecla_atual <= key;
  end

	always @ (posedge clk) begin: TROCA_MODO
    case(modo_atual)
      MODOS.CRON: if(tecla_atual == TECLAS.T_HASH || tecla_atual == TECLAS.T_ASTE)
        modo_atual <= MODOS.CALC;
      MODOS.CALC: if (tecla_atual == TECLAS.T_D)
        modo_atual <= MODOS.CRON;
    endcase
	end

  contador(
    .ativo(modo_atual == MODOS.CRON),
    .tecla_atual(tecla_atual),
    .clk(clk),
    .decs(decs),
    .segs(segs));
  
  calculadora(
    .ativo(modo_atual == MODOS.CALC),
    .tecla_atual(tecla_atual),
    .clk(clk),
    .A(X),
    .B(Y),
    .resultado(resultado));

  displays(modo_atual,decs,segs,resultado);
endmodule