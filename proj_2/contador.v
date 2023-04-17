
// clk = 1000mhz
module contador(
  input ativo,
  input clk,
  input tecla_atual,
  output wire decs,
  output wire segs
);

  assign reset = ativo && tecla_atual == TECLAS.T_A;
  assign parar = ativo && tecla_atual == TECLAS.T_D;
  
  wire clkDiv10;
  contar_10(clk,clkDiv10);
  contador_intern(clkDiv10,reset,parar,decs,segs);
endmodule