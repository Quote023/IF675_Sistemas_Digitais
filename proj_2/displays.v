module display(number, display);
	input [3:0] number;
	output reg [0:6] display; // display de 7 seg
	
	always @(*) begin //padrão
	
	case(number)
			1: display = 7'b1001111;
			2: display = 7'b0010010;
			3: display = 7'b0000110;
			4: display = 7'b1001100;
			5: display = 7'b0100100;
			6: display = 7'b0100000;
			7: display = 7'b0001111;
			8: display = 7'b0000000;
			9: display = 7'b0000100;
			0: display = 7'b0000001;
			default: display = 7'b1111111;
		endcase
	end
endmodule 