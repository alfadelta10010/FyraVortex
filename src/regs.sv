module regs #(parameter N = 32) (clk, rst, in, out, en);
  input bit clk;
  input bit rst;
  input bit en;
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
