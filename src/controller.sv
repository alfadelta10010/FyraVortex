module controller (
  input logic [2:0] f3,
  input logic [6:0] f7,
  input logic [6:0] opcode,
  output logic regWR,
  output logic memWR,
  output logic [1:0] wbCtrl,
  output logic [2:0] branchCtrl,
  output logic [2:0] memCtrl,
  output logic aluS1,
  output logic aluS2,
  output logic doBranch,
  output logic doJump,
  output logic [3:0] aluOp
);

  // Register Write Control
  assign regWR = (opcode == 7'b0110011) || (opcode == 7'b0010011) ||
                 (opcode == 7'b0000011) || (opcode == 7'b0110111) ||
                 (opcode == 7'b0010111) || (opcode == 7'b1101111) ||
                 (opcode == 7'b1100111);

  // Memory Write Control
  assign memWR = (opcode == 7'b0100011);

  // Writeback Control
  assign wbCtrl = (opcode == 7'b0110011 || opcode == 7'b0010011 || opcode == 7'b0110111 || opcode == 7'b0010111) ? 2'b00 :
                  (opcode == 7'b0000011) ? 2'b01 :
                  (opcode == 7'b1101111 || opcode == 7'b1100111) ? 2'b10 :
                  2'b11;

  // ALU Source 1
  assign aluS1 = (opcode == 7'b1100011 || opcode == 7'b0010111 || opcode == 7'b1101111);

  // ALU Source 2
  assign aluS2 = (opcode == 7'b0110011);

  // Branch Control
  assign branchCtrl = (opcode == 7'b1100011) ? f3 : 3'b011;

  // Memory Control
  assign memCtrl = (opcode == 7'b0000011) ? 
                   ((f3 == 3'b000) ? 3'b000 :
                   (f3 == 3'b001) ? 3'b001 :
                   (f3 == 3'b010) ? 3'b010 :
                   (f3 == 3'b100) ? 3'b011 :
                   (f3 == 3'b101) ? 3'b100 : 3'b000) :  // LBU and LHU
                   (opcode == 7'b0100011) ? 
                   ((f3 == 3'b000) ? 3'b101 :
                   (f3 == 3'b001) ? 3'b110 :
                   (f3 == 3'b010) ? 3'b111 : 3'b000) : 3'b000;

  // ALU Operation
  assign aluOp = (opcode == 7'b0110011) ? 
                 ((f3 == 3'b000 && f7[5]) || (f3 == 3'b101 && f7[5]) ? {1'b1, f3} : 
                 {1'b0, f3}) :
                 (opcode == 7'b0010011) ? 
                 ((f3 == 3'b101 && f7[5]) ? {1'b1, f3} : 
                 {1'b0, f3}) :
                 (opcode == 7'b1100011) ? 4'b0000 : 4'b1001;

  // Jump and Branch Control
  assign doJump = (opcode == 7'b1101111 || opcode == 7'b1100111) ? 1'b1 : 1'b0;
  assign doBranch = (opcode == 7'b1100011);

endmodule
