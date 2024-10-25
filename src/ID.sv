module ID(clk, pcP, pcN, instIn, regWRIn, rdIn, DIn, r1, r2, imm, rs1Out, rs2Out, rdOut, opcode, regWR, memRD, wbCtrl, aluOp, aluS1, aluS2, branchCtrl, memCtrl, doBranch, doJump);
  input logic [31:0] pcP, pcN, instIn;
  input logic clk;
  input logic regWRIn;
  input logic [4:0] rdIn;
  input logic [31:0] DIn;
  output logic [31:0] r1, r2, imm;
  output logic [4:0] rs1Out, rs2Out, rdOut;
  output logic [6:0] opcode;
  output logic regWR, memRD, aluS1, aluS2, doJump, doBranch;
  output logic [1:0] wbCtrl;
  output logic [2:0] branchCtrl;
  output logic [2:0] memCtrl;
  output logic [3:0] aluOp;
  logic [2:0] fn3;
  logic [6:0] fn7;
  
  decoder decoderUnit (.instIn(instIn), .opcode(opcode), .rd(rdOut), 
                       .rs1(rs1Out), .rs2(rs2Out), .fn3(fn3), .fn7(fn7)
                      );
  controller controlUnit (.f3(f3), .f7(f7), .opcode(opcode), .regWR(regWR), 
                          .memRD(memRD), .wbCtrl(wbCtrl), .aluOp(aluOp), 
                          .aluS1(aluS1), .aluS2(aluS2), .branchCtrl(branchCtrl), 
                          .memCtrl(memCtrl), .doJump(doJump), .doBranch(doBranch)
                         );
  regFile #(32) registerFile (.clk(clk), .wrEn(regWRIn), .rs1(rs1Out), .rs2(rs2Out), .rd(rdIn), .r1(r1), .r2(r2), .dIn(DIn));
  signExt signExtender (.opcode(opcode), .instIn(instIn), .immOut(imm));
endmodule
