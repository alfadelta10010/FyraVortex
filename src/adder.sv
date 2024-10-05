`timescale 1ns / 1ps
module adder #(parameter N = 32)(a, b, s, cin, cout);
  input logic [N-1:0] a;
  input logic [N-1:0] b;
  output logic [N-1:0] s;
  input logic cin;
  output logic cout;
  assign {cout, s} = a + b + cin;
endmodule
