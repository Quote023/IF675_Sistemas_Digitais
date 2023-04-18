module keypad_decodificador(
	input clk,
	input wire [3:0] linhas,
	output reg [1:0] state = 0,
	output reg [4:0] key = TECLAS.T_NULL
);




//--------------- KEYPAD- VERIFICA COLUNAS --------------------
reg [22:0] counter = 0; //max 3388608
parameter cycle = 300;

// A cada ciclo de (+/- 10/ms) troca qual coluna fica com nível lógico 0
// Essa troca rápida permite identificar qual coluna tá sendo pressionada
always @(posedge clk) begin   
	if(counter < cycle) 
		if(key == TECLAS.T_NULL) counter <= 0; // Se a tecla apertada for solta => zera a contagem
		else counter <= counter + 1'd1;
	else begin 
		counter <= 0;
		state <= state + 1'd1;
	end
end
//--------------- KEYPAD- VERIFICA LINHAS --------------------
always @ (posedge clk) begin
	if(~&linhas)
		case(state)
			0: 
			if			(~linhas[0]) 	key <= TECLAS.T_1;
			else if 	(~linhas[1]) 	
				key <= TECLAS.T_4;
			else if 	(~linhas[2]) 	key <= TECLAS.T_7;
			else if 	(~linhas[3]) 	key <= TECLAS.T_ASTE;
			1:
			if 		(~linhas[0]) 	key <= TECLAS.T_2;
			else if 	(~linhas[1]) 	key <= TECLAS.T_5;
			else if 	(~linhas[2]) 	key <= TECLAS.T_8;
			else if 	(~linhas[3]) 	key <= TECLAS.T_0;
			2:
			if 		(~linhas[0]) 	key <= TECLAS.T_3;
			else if 	(~linhas[1]) 	key <= TECLAS.T_6;
			else if 	(~linhas[2]) 	key <= TECLAS.T_9;
			else if 	(~linhas[3]) 	key <= TECLAS.T_HASH;
			3:
			if 		(~linhas[0])	key <= TECLAS.T_A;
			else if 	(~linhas[1]) 	key <= TECLAS.T_B;
			else if 	(~linhas[2]) 	key <= TECLAS.T_C;
			else if 	(~linhas[3]) 	key <= TECLAS.T_D;
		endcase
	else 
		key <= TECLAS.T_NULL;
end
endmodule 
