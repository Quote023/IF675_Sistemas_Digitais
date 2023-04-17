module cronometro_calculadora(clk,key);
	input clk; //clock 1000hz
	input key; //input do keypad

	wire decs, segs; //decimos de segundos e segundos do cronometro;
	wire X,Y; //valores atuais da calcuadora
  wire resultado; //resultado calculadora

	reg modo_atual = MODOS.CRON;
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
    .ativo(tecla_atual,modo_atual == MODOS.CRON),
    .tecla_atual(tecla_atual),
    .clk(clk),
    .decs(decs),
    .segs(segs));
  
  calculadora(
    .ativo(modo_atual==MODOS.CALC),
    .tecla_atual(tecla_atual),
    .clk(clk),
    .A(X),
    .B(Y),
    .resultado(resultado));

  displays(modo_atual,decs,segs,resultado);
endmodule