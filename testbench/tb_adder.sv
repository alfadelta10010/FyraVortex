module tb_adder();
  logic [31:0] a_tb;
  logic [31:0] b_tb;
  logic [31:0] s_tb;
  
  adder #(32) dut (.a(a_tb), .b(b_tb), .s(s_tb));
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_adder);
    a_tb = 32'h00000000;
    b_tb = 32'h00000004;
    #1 a_tb = 32'h00000004;
    b_tb = 32'h00000004;
    #1 a_tb = 32'h00000004;
    b_tb = 32'h0000F004;
    #1 a_tb = 32'hFFFFFFFE;
    b_tb = 32'h00000002;
  end
endmodule
