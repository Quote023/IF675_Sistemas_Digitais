module displays(modo,decs,segs,X,Y,resultado);
input   modo; // modo do display pode ser MODO.CRON ou MODO.CALC
input [3:0] decs; //decimos de segundos do cronometro
input [9:0] segs; // segundos do cronometro;
input [6:0] X,Y; //valores atuais da calcuadora
input [7:0] resultado; //resultado calculadora

endmodule