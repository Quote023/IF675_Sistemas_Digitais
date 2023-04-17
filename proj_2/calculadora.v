module calculadora(
  input ativo,
  input tecla_atual,
  input clk,
  output reg[6:0] A,
  output reg[6:0] B,
  output [7:0] resultado);

  parameter NUM_A = 0, NUM_B = 1;
  parameter OP_SUM = 0, OP_SUB = 1, OP_MUL = 2;

  reg num_selec = NUM_A;
  reg[1:0] operacao;

  always @ (posedge clk) begin
    if(ativo) begin
      case (tecla_atual)
        TECLAS.HASH: num_selec <= NUM_A; 
        TECLAS.ASTE: num_selec <= NUM_B;
        TECLAS.T_A=12: operacao <= OP_SUM;
		    TECLAS.T_B=13: operacao <= OP_SUB;
		    TECLAS.T_C=14: operacao <= OP_MUL;
        default: if (tecla_atual < 10) begin
            if (num_selec == NUM_A) A <= tecla_atual;
            else B <= tecla_atual;
          end
      endcase
    end
  end

  always @ (posedge clk) begin
    case (operacao) 
      OP_SUM: resultado <= (A + B);
      OP_SUB: resultado <= (A - B);
      OP_MUL: resultado <= (A * B);
    endcase
  end
endmodule