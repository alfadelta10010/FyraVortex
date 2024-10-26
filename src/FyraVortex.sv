module FyraVortex(clk, reset, dataOut);

//IF Stage
input logic reset;
input logic clk;
logic pcEn;
logic [31:0] pcP, pcN, instOut;

//IF-ID
logic [31:0] pcP_IFID, pcN_IFID, instOut_IFID;

//ID Stage
logic regWRIn;
logic [4:0] rdIn;
logic [31:0] r1, r2, imm;
logic [4:0] rs1Out, rs2Out, rdOut;
logic [6:0] opcode;
logic regWR, aluS1, aluS2, doJump, doBranch, memW;
logic [1:0] wbCtrl;
logic [2:0] branchCtrl;
logic [2:0] memCtrl;
logic [3:0] aluOp;

//ID-IE
logic [31:0] r1_IDIE, r2_IDIE, imm_IDIE;
logic [4:0] rs1Out_IDIE, rs2Out_IDIE, rdOut_IDIE;
logic [6:0] opcode_IDIE;
logic regWR_IDIE, aluS1_IDIE, aluS2_IDIE, memW_IDIE, doJump_IDIE, doBranch_IDIE;
logic [1:0] wbCtrl_IDIE;
logic [2:0] branchCtrl_IDIE;
logic [2:0] memCtrl_IDIE;
logic [3:0] aluOp_IDIE;
logic [31:0] pcP_IDIE, pcN_IDIE;

//IE Stage
logic [0:0] bSel, forwardCtlA, forwardCtlB;
logic [31:0] aluOut, r1Forward, r2Forward;

//IE-DWB
logic bSel_IEDWB, regWR_IEDWB;
logic [4:0] rdOut_IEDWB;
logic [31:0] aluOut_IEDWB, r2_IEDWB, pcN_IEDWB;
logic [1:0] wbCtrl_IEDWB;
logic memW_IEDWB;
logic [2:0] memCtrl_IEDWB;


output logic [31:0] dataOut;

IF InstFetch (.pcRst(reset), .clk(clk), .branchSel(bSel), .branchVal(aluOut), .pcP(pcP), .pcN(pcN), .instOut(instOut), .pcEn(1'b1));

regs #(96) IF_ID (.clk(clk), .rst(reset), .in({pcP, pcN, instOut}), .out({pcP_IFID, pcN_IFID, instOut_IFID}), .en(1'b1));

ID InstDecode (.clk(clk), .pcP(pcP_IFID), .pcN(pcN_IFID), .instIn(instOut_IFID), .regWRIn(regWR_IEDWB), .rdIn(rdOut_IEDWB), .DIn(dataOut), .r1(r1), .r2(r2), .imm(imm), .rs1Out(rs1Out), .rs2Out(rs2Out), .rdOut(rdOut), .opcode(opcode),
                .regWR(regWR), .memW(memW), .wbCtrl(wbCtrl), .aluOp(aluOp), .aluS1(aluS1), .aluS2(aluS2), .branchCtrl(branchCtrl), .memCtrl(memCtrl), .doBranch(doBranch), .doJump(doJump));

regs #(199) ID_IE (.clk(clk), .rst(reset), .in({r1, r2, imm, rs1Out, rs2Out, rdOut, opcode, regWR, aluS1, aluS2, doJump, doBranch, wbCtrl, branchCtrl, memCtrl, aluOp, pcP_IFID, pcN_IFID, memW}), 
                  .out({r1_IDIE, r2_IDIE, imm_IDIE, rs1Out_IDIE, rs2Out_IDIE, rdOut_IDIE, opcode_IDIE, regWR_IDIE, aluS1_IDIE, aluS2_IDIE, doJump_IDIE, doBranch_IDIE, wbCtrl_IDIE, branchCtrl_IDIE, memCtrl_IDIE, aluOp_IDIE, pcP_IDIE, pcN_IDIE, memW_IDIE}), .en(1'b1));

mux21 #(32) forward1(.a(r1_IDIE), .b(aluOut_IEDWB), .s(forwardCtlA), .y(r1Forward));
mux21 #(32) forward2(.a(r2_IDIE), .b(aluOut_IEDWB), .s(forwardCtlB), .y(r2Forward));

forward FU (.rs1(r1_IDIE), .rs2(r2_IDIE), .rd_mem(rdOut_IEDWB), .reg_write(regWR_IEDWB), .forward_a(forwardCtlA), .forward_b(forwardCtlB));

IE InstExec(.doBranch(doBranch_IDIE), .doJump(doJump_IDIE), .aluS1(aluS1_IDIE), .aluS2(aluS2_IDIE), 
            .bCtrl(branchCtrl_IDIE), .r1(r1Forward), .r2(r2Forward), .imm(imm_IDIE), .pcP(pcP_IDIE),
            .aluOp(aluOp_IDIE), .bSel(bSel), .aluOut(aluOut)
           );

regs #(75) IE_DWB (.clk(clk), .rst(reset), .in({bSel, aluOut, wbCtrl_IDIE, memW_IDIE, memCtrl_IDIE, pcN_IDIE, r2_IDIE, rdOut_IDIE, regWR_IDIE}), .out({bSel_IEDWB, aluOut_IEDWB, wbCtrl_IEDWB, memW_IEDWB, memCtrl_IEDWB, pcN_IEDWB, r2_IEDWB, rdOut_IEDWB, regWR_IEDWB}), .en(1'b1));

DWB Data_WriteBack(.clk(clk), .wbCtrl(wbCtrl_IEDWB), .memW(memW_IEDWB), .memCtrl(memCtrl_IEDWB), .pcN(pcN_IEDWB), .aluOut(aluOut_IEDWB), .dataIn(r2_IEDWB), .wbOut(dataOut));

endmodule
