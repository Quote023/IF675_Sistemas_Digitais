`include "contador_intern.v"
`include "contar_10.v"

// clk = 1000mhz
module contador(
  input clk,   
  output reg[3:0] decs,
  output reg[9:0] segs
);

  wire clkDiv10;
  contar_10(clk,clkDiv10);
  contador_intern(clkDiv10,0,0,decs,segs);
endmodule