
// clk = 1000mhz
module contador(
  input clk,   
  output wire decs,
  output wire segs
);

  wire clkDiv10;
  contar_10(clk,clkDiv10);
  contador_intern(clkDiv10,0,0,decs,segs);
endmodule