module contador_intern (
  input clk,
  input reset,
  input pausa,
  output reg[3:0] decs,
  output reg[9:0] segs
);

always @ (posedge clk) begin  
  if (reset)  
    decs <= 0;  
  else if (pausa)
    decs <= decs;
  else begin
    decs <= decs + 1;
    if(decs + 1 == 10)
      segs = segs + 1;
  end
end  
endmodule  