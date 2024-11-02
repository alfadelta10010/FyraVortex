module IE (doBranch, doJump, aluS1, aluS2, bCtrl, r1, r2, imm, pcP, aluOp, bSel, aluOut);
  input logic doBranch, doJump, aluS1, aluS2;
  input logic [2:0] bCtrl;
  input logic [31:0] r1, r2, imm, pcP;
  input logic [3:0] aluOp;
  output logic [0:0] bSel;
  output logic [31:0] aluOut;
  logic [31:0] aluY1, aluY2;
  logic branchYes, branchOut;
  
  alu ALU(.d1(aluY1), .d2(aluY2), .result(aluOut), .control(aluOp));
  branchCtrl branchController (.bCtrl(bCtrl), .r1(r1), .r2(r2), .bSel(branchYes));
  mux21 #(32) aluSrc1 (.a(r1), .b(pcP), .s(aluS1), .y(aluY1));
  mux21 #(32) aluSrc2 (.a(imm), .b(r2), .s(aluS2), .y(aluY2));
  or2 #(32) branchJumpGate (.a(doJump), .b(branchYes), .y(bSel));
  and2 #(32) branchValidate (.a(branchOut), .b(doBranch), .y(branchYes));
  
endmodule