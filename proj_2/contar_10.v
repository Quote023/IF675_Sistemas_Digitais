module contar_10(input clk, output reg out);
  reg [3:0] cont = 0;
  always @ (posedge clk) begin
    if(cont >= 10) begin
      out <= 1;
      cont <= 0;
    end
    else
      cont <= cont + 1;
  end
endmodule
