module cronometro_calculadora(
  input clk, // clock 1000hz
  input wire [3:0] kpd_linhas, // estado das linhas do keypad
  output wire [3:0] decs, // decimos de segundos do cronometro
  output wire [9:0] segs,  // segundos do cronometro;
  output wire [6:0] X, // valores atuais da calcuadora
  output wire [6:0] Y, // valores atuais da calcuadora
  output wire [7:0] resultado, // resultado calculadora
);

	reg modo_atual = MODOS.CRON;
  reg display_enabled = 1;
	
  wire [4:0] tecla_atual;

	keypad_decodificador(
  .clk(clk),
	.linhas(kpd_linhas),
	.key(tecla_atual),
  );

	always @ (posedge clk) begin: TROCA_MODO
    case(modo_atual)
      MODOS.CRON: 
        if(tecla_atual == TECLAS.T_HASH || tecla_atual == TECLAS.T_ASTE)
          modo_atual <= MODOS.CALC;
        else display_enabled <= TECLAS.T_C;

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

  displays(modo_atual,decs,segs,X,Y,resultado);
endmodule