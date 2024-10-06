module tb_IF();
  logic pcRst, clk, pcEn, branchSel_tb;
  logic [31:0] branchVal_tb, pcP_tb, pcN_tb, instOut_tb;
  
  IF dut(.clk(clk_tb), 
         .pcRst(pcRst_tb), 
         .branchSel(branchSel_tb), 
         .branchVal(branchVal_tb), 
         .pcP(pcP_tb),
         .pcN(pcN_tb), 
         .instOut(instOut_tb),
         .pcEn(pcEn_tb),
        );
  
  always
    begin
      clk_tb = 0;
      #1;
      clk_tb = 1;
      #1;
    end
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(0, tb_IF);
      pcRst_tb <= 1;
      branchSel_tb <= 0;
      branchVal_tb <= 0;
      #1 pcRst_tb <= 0;
      #30;
      #1 branchSel_tb <= 1;
      #1 branchVal_tb <= 40;
    end
endmodule
