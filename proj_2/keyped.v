//Do PDF Monitor Verificar linhas e colunas para saber o botão pessionadas -----
/*
A -> 10
B -> 11
C -> 12
D -> 13
* -> 14 (X)
# -> 15 (Y)
*/
module keypad(
	input clk,
	output reg [3:0] colunas,
	input [3:0] linhas,
	output reg [4:0] number,
	output reg pressed,	
	input wire button, //para debounce
   output reg debounced_button //para debounce
);

//--------------- KEYPAD- VERIFICA COLUNAS --------------------

reg [31:0] counter = 0;
parameter cycle = 5000000;
reg [1:0] state = 0;

always @(posedge clk) begin
	if (button == debounced_button) begin
        count <= count + 1;  // Se o botão está no mesmo estado que a última contagem, continue a contagem
   
			if(counter < cycle) begin
				if(~pressed) counter <= counter + 1;
				else	counter <= 0;
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
	 else begin
        // Se o botão mudou de estado, zere a contagem
        count <= 0;
    end
	  // Se a contagem atingir um valor máximo, atualize o valor debounced_button
    if (count >= 5000000) begin
        debounced_button <= button;
    end
end
//--------------- KEYPAD- VERIFICA LINHAS --------------------
always @ (posedge clk) begin
	
	if(~&linhas) begin
		pressed <= 1;
		
		if (~colunas[0]) begin
				  if (~linhas[0]) number <= 4'd1;
			else if (~linhas[1]) number <= 4'd4;
			else if (~linhas[2]) number <= 4'd7;
			else if (~linhas[3]) number <= 4'd14;
		end else
		if (~colunas[1]) begin
				  if (~linhas[0]) number <= 4'd2;
			else if (~linhas[1]) number <= 4'd5;
			else if (~linhas[2]) number <= 4'd8;
			else if (~linhas[3]) number <= 4'd0;
		end else
		if (~colunas[2]) begin
				  if (~linhas[0]) number <= 4'd3;
			else if (~linhas[1]) number <= 4'd6;
			else if (~linhas[2]) number <= 4'd9;
			else if (~linhas[3]) number <= 4'd15;
		end else
		if (~colunas[3]) begin
				  if (~linhas[0]) number <= 4'd10;
			else if (~linhas[1]) number <= 4'd11;
			else if (~linhas[2]) number <= 4'd12;
			else if (~linhas[3]) number <= 4'd13;
		end
	end
	else begin 
		pressed <= 0;
		number <= 5'd16;
	end
end
endmodule 