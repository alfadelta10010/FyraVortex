module regs #(parameter N = 32) (clk, rst, in, out, en);
  input logic clk;
  input logic rst;
  input logic en;
  input logic [N-1:0] in;
  output logic [N-1:0] out;
  always_ff @(posedge clk or posedge rst) 
    begin
      if (rst)
        out <= 0;
      else if (en) 
        out <= in;
      else
        out <= out;
    end
endmodule
