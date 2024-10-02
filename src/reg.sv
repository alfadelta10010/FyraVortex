module reg #(parameter N = 32) (clk, reset, in, out);
  input bit clk;
  input bit reset;
  input logic [N-1:0] in;
  output logic [N-1:0] out;
  always_ff @(posedge clk, posedge reset) 
    begin
      if (reset) 
        out <= 32'b0;
      else 
        out <= in;
  end
endmodule