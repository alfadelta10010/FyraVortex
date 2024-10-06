module tb_controller();
  logic [2:0] f3_tb;
  logic [6:0] f7_tb;
  logic [6:0] opcode_tb;
  logic regWR_tb;
  logic memRD_tb, memWR_tb;
  logic [1:0] wbCtrl_tb;
  logic [2:0] branchCtrl_tb;
  logic [2:0] memCtrl_tb;
  logic aluS1_tb, aluS2_tb, doBranch_tb, doJump_tb;
  logic [3:0] aluOp_tb;
  
  controller dut (.f3(f3_tb), 
                  .f7(f7_tb), 
                  .opcode(opcode_tb), 
                  .regWR(regWR_tb), 
                  .memRD(memRD_tb), 
                  .memWR(memWR_tb), 
                  .wbCtrl(wbCtrl_tb), 
                  .aluOp(aluOp_tb), 
                  .aluS1(aluS1_tb), 
                  .aluS2(aluS2_tb), 
                  .branchCtrl(branchCtrl_tb), 
                  .memCtrl(memCtrl_tb), 
                  .doJump(doJump_tb), 
                  .doBranch(doBranch_tb)
                 );
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_controller);
    f7_tb = 7'b0;
    opcode_tb = 7'b0;
    f3_tb = 3'b0;
    #1 opcode_tb = 7'b0110011; // R-type
    f3_tb = 3'b000;
    #1 f7_tb = 7'b0100000;
    #1 f3_tb = 3'b001;
    #1 f7_tb = 7'b0;
    #1 f3_tb = 3'b010;
    #1 f3_tb = 3'b011;
    #1 f3_tb = 3'b100;
    #1 f3_tb = 3'b101;
    #1 f7_tb = 7'b0100000;
    #1 f3_tb = 3'b110;
    #1 f7_tb = 7'b0;
    #1 f3_tb = 3'b111;
    #1 opcode_tb = 7'b0010011; // IR-Type
    f3_tb = 3'b000;
    #1 f3_tb = 3'b001;
    #1 f3_tb = 3'b010;
    #1 f3_tb = 3'b011;
    #1 f3_tb = 3'b100;
    #1 f3_tb = 3'b101;
    #1 f3_tb = 3'b110;
    #1 f3_tb = 3'b111;
    #1 opcode_tb = 7'b0000011; // IL-Type
    f3_tb = 3'b000;
    #1 f3_tb = 3'b001;
    #1 f3_tb = 3'b010;
    #1 f3_tb = 3'b011;
    #1 f3_tb = 3'b100;
    #1 f3_tb = 3'b101;
    #1 f3_tb = 3'b110;
    #1 f3_tb = 3'b111;
    #1 opcode_tb = 7'b0100011; // S-type
    f3_tb = 3'b000;
    #1 f3_tb = 3'b001;
    #1 f3_tb = 3'b010;
    #1 f3_tb = 3'b011;
    #1 f3_tb = 3'b100;
    #1 f3_tb = 3'b101;
    #1 f3_tb = 3'b110;
    #1 f3_tb = 3'b111;
    #1 opcode_tb = 7'b1100011; // B-type
    f3_tb = 3'b000;
    #1 f3_tb = 3'b001;
    #1 f3_tb = 3'b010;
    #1 f3_tb = 3'b011;
    #1 f3_tb = 3'b100;
    #1 f3_tb = 3'b101;
    #1 f3_tb = 3'b110;
    #1 f3_tb = 3'b111;
    #1 opcode_tb = 7'b0110111; // LUI
    f3_tb = 3'b000;
    #1 f3_tb = 3'b001;
    #1 f3_tb = 3'b010;
    #1 f3_tb = 3'b011;
    #1 f3_tb = 3'b100;
    #1 f3_tb = 3'b101;
    #1 f3_tb = 3'b110;
    #1 f3_tb = 3'b111;
    #1 opcode_tb = 7'b0010111; // AUPIC
    f3_tb = 3'b000;
    #1 f3_tb = 3'b001;
    #1 f3_tb = 3'b010;
    #1 f3_tb = 3'b011;
    #1 f3_tb = 3'b100;
    #1 f3_tb = 3'b101;
    #1 f3_tb = 3'b110;
    #1 f3_tb = 3'b111;
    #1 opcode_tb = 7'b1101111; // JAL
    f3_tb = 3'b000;
    #1 f3_tb = 3'b001;
    #1 f3_tb = 3'b010;
    #1 f3_tb = 3'b011;
    #1 f3_tb = 3'b100;
    #1 f3_tb = 3'b101;
    #1 f3_tb = 3'b110;
    #1 f3_tb = 3'b111;
    #1 opcode_tb = 7'b0010111; // JALR
    f3_tb = 3'b000;
    #1 f3_tb = 3'b001;
    #1 f3_tb = 3'b010;
    #1 f3_tb = 3'b011;
    #1 f3_tb = 3'b100;
    #1 f3_tb = 3'b101;
    #1 f3_tb = 3'b110;
    #1 f3_tb = 3'b111;
    #1 opcode_tb = 7'b0011111; // default case
  end
endmodule