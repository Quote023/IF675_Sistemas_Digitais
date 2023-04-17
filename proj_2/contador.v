
// clk = 1000mhz
module contador(
  input ativo,
  input clk,
  input [4:0] tecla_atual,
  output wire [3:0] decs,
  output wire [9:0] segs
);

  assign reset = ativo && tecla_atual == TECLAS.T_A;
  assign parar = ativo && tecla_atual == TECLAS.T_D;
  
  wire clkDiv10;
  contar_10(clk,clkDiv10);
  contador_intern(clkDiv10,0,0,decs,segs);
endmodule