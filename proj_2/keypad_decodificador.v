module keypad_decodificador(
	input clk,
	input wire [3:0] linhas,
	key
);

output reg [4:0] key = TECLAS.T_NULL;
reg [3:0] colunas;

//--------------- KEYPAD- VERIFICA COLUNAS --------------------
reg [22:0] counter = 0; //max 3388608
parameter cycle = 5000000;
reg [1:0] state = 0;

// A cada ciclo de (+/- 10/ms) troca qual coluna fica com nível lógico 0
// Essa troca rápida permite identificar qual coluna tá sendo pressionada
always @(posedge clk) begin   
	if(counter < cycle) begin
		if(key == TECLAS.T_NULL) counter <= 0; // Se a tecla apertada for solta => zera a contagem
		else counter <= counter + 1;
	end
	else begin 
		counter <= 0;
		state <= state + 1;
	end
	case(state)
		0: colunas <= 4'b0111;
		1: colunas <= 4'b1011;
		2: colunas <= 4'b1101;
		3: colunas <= 4'b1110;	
	endcase
end
//--------------- KEYPAD- VERIFICA LINHAS --------------------
always @ (posedge clk) begin
	if(~&linhas) begin 
		if (~colunas[0]) begin
			if 		(~linhas[0]) 	number <= TECLAS.T_1;
			else if (~linhas[1]) 	number <= TECLAS.T_4;
			else if (~linhas[2]) 	number <= TECLAS.T_7;
			else if (~linhas[3]) 	number <= TECLAS.T_ASTE;
		end else if (~colunas[1]) begin
			if 		(~linhas[0]) 	number <= TECLAS.T_2;
			else if (~linhas[1]) 	number <= TECLAS.T_5;
			else if (~linhas[2]) 	number <= TECLAS.T_8;
			else if (~linhas[3]) 	number <= TECLAS.T_0;
		end else if (~colunas[2]) begin
			if 		(~linhas[0]) 	number <= TECLAS.T_3;
			else if (~linhas[1]) 	number <= TECLAS.T_6;
			else if (~linhas[2]) 	number <= TECLAS.T_9;
			else if (~linhas[3]) 	number <= TECLAS.T_HASH;
		end else if (~colunas[3]) begin
			if 		(~linhas[0])	number <= TECLAS.T_A;
			else if (~linhas[1]) 	number <= TECLAS.T_B;
			else if (~linhas[2]) 	number <= TECLAS.T_C;
			else if (~linhas[3]) 	number <= TECLAS.T_D;
		end
	end
	else begin 
		key <= TECLAS.T_NULL;
	end
end
endmodule 
