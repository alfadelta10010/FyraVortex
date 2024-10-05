`timescale 1ns / 1ps
module adder #(parameter N = 32)(a, b, s);
  input logic [N-1:0] a;
  input logic [N-1:0] b;
  output logic [N-1:0] s;
  assign s = a + b;
endmodule
