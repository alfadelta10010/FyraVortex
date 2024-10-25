module IF(pcRst, clk, branchSel, branchVal, pcP, pcN, instOut, pcEn);
  input logic pcRst, clk, branchSel, pcEn;
  input logic [31:0] branchVal;
  output logic [31:0] pcP, pcN, instOut;
  logic [31:0] pcIn;
  
  adder #(32) pcAdder (.a(32'd4), .b(pcP), .s(pcN)); 
  instMem #(8) instructionMemory (.instAddr(pcP), .instOut(instOut));
  mux21 #(32) branchMux (.a(pcN), .b(branchVal), .s(branchSel), .y(pcIn));
  regs #(32) programCounter (.clk(clk), .rst(pcRst), .in(pcIn), .out(pcP), .en(pcEn));
endmodule
