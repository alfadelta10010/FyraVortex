`timescale 1ns / 1ps
module and2 #(parameter N = 32)(a, b, y);
  input logic [N-1 : 0] a;
  input logic [N-1 : 0] b;
  output logic [N-1 : 0] y;
  assign y = a & b;
endmodule
