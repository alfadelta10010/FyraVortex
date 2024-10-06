module tb_regs();
  logic clk_tb;
  logic rst_tb;
  logic en_tb;
  logic [31:0] in_tb;
  logic [31:0] out_tb;
  
  regs #(32) dut (.clk(clk_tb), .rst(rst_tb), .in(in_tb), .out(out_tb), .en(en_tb));
  always
    begin
      clk_tb = 0;
      #1;
      clk_tb = 1;
      #1;
    end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_regs);
    en_tb = 0;
    rst_tb = 1;
    #2 rst_tb = 0;
    #2 inp_tb = 32'hBABEFACE;
    #2 en_tb = 1;
    inp_tb = 32'hDEADBEEF;
    #2 $finish;
  end
endmodule
