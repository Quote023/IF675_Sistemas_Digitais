module cronometro_calculadora(clk,key,decs,segs,X,Y,resultado,modo_atual,

dis_centena,
is_dezena,
dis_unidade,
dis_decimal,

dis_dezena_In1,
dis_unidadeIn1,
dis_dezena_In2,
dis_unidade_In2

);
	input clk; //clock 1000hz
	input [4:0] key; //input do keypad

	output wire [3:0] decs; //decimos de segundos do cronometro
	output wire [9:0] segs; // segundos do cronometro;
	
	output [0:6] dis_centena; //cetena display
	output [0:6] dis_dezena; //dezena display
	output [0:6] dis_unidade;	//unidade display
	
	output [0:6] dis_dezena_In1; //dezena display In1
	output [0:6] dis_unidadeIn1; //unidade display In1
	output [0:6] dis_dezena_In2; //dezena display In2
	output [0:6] dis_unidade_In2; //unidade display In2
	
	//display para cronometro
	reg [3:0] unidade = 0;
	reg [2:0] dezena = 0;
	reg [2:0] centena = 0;
	reg [2:0] decimal=0;
	
	//modulo calculadora
	reg[3:0] dezenaIn1;
	reg[3:0] unidadeIn1;
	reg[3:0] dezenaIn2;
	reg[3:0] unidadeIn2;
	
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
    .resultado(resultado),
	 .sinal(sinal));
	 
	//display para cronometro
	
	decimal <= decs;
   unidade <= segs % 10;
   dezena <= segs / 10 % 10;
   centena <= segs / 100 % 10;
			
	display(centena, dis_centena); 
	display(dezena, dis_dezena);
	display(unidade, dis_unidade);
	display(decimal, dis_decimal);
	
	//modulo calculadora
	
	dezenaIn1 <= A / 10;
	unidadeIn1 <= A % 10;
	dezenaIn2 <= B / 10;
	unidadeIn2 <= B % 10;
		
	display(dezenaIn1, dis_dezena_In1);
	display(unidadeIn1, dis_unidadeIn1);	
	
	display(dezenaIn2, dis_dezena_In2);
	display(unidadein2, dis_unidade_In2);
	
endmodule 