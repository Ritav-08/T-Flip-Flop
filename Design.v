`timescale 1ns / 1ps

module Tff(
   input T_i, 
   input clk_i, 
   input rst_i, 
   output reg Q_o, 
   output Qbar_o
);

assign Qbar_o = ~Q_o;

always@(posedge clk_i)
   if(rst_i)
      Q_o <= 1'b0;
   else if(T_i)
      Q_o <= ~Q_o;

endmodule
