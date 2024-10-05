module tb_adder();
  logic [31:0] a_tb;
  logic [31:0] b_tb;
  logic [31:0] s_tb;
  logic cin_tb;
  logic cout_tb;
  
  adder #(32) dut (.a(a_tb), .b(b_tb), .cin(cin_tb), .s(s_tb), .cout(cout_tb));
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_adder);
    a_tb = 32'h00000000;
    b_tb = 32'h00000004;
    cin_tb = 0;
    #1 a_tb = 32'h00000004;
    b_tb = 32'h00000004;
    cin_tb = 0;
    #2 a_tb = 32'h00000004;
    b_tb = 32'h0000F004;
    cin_tb = 1;
    #3 a_tb = 32'hFFFFFFFE;
    b_tb = 32'h00000001;
    cin_tb = 1;
  end
endmodule
    