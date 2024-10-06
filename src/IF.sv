module IF(pcRst, clk, branchSel, branchVal, pcP, pcN, instOut, pcEn);
  input logic pc_rst, clk, branch_sel, pcEn;
  input logic [31:0] branchVal;
  output logic [31:0] pcP, pcN, instOut;
  logic [31:0] pcIn;
  
  adder #(32) pcAdder (.a(32'd4), .b(pcP), .s(pcN)); 
  instMem #(32, 32, 512) instructionMemory (.inst_addr(pcP), .inst(instOut));
  mux21 #(32) branchMux (.a(pcN), .b(branchVal), .s(branchSel), .y(pcIn));
  regs #(32) programCounter (.clk(clk), .rst(pcRst), .in(pcIn), .out(pcP), .en(pcEn));
endmodule
