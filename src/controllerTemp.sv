module controllerTemp (
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

  // regWR signal
  assign regWR = (opcode == 7'b0110011) || (opcode == 7'b0010011) ||
                 (opcode == 7'b0000011) || (opcode == 7'b0110111) ||
                 (opcode == 7'b0010111) || (opcode == 7'b1101111) ||
                 (opcode == 7'b0010111);

  // memWR signal
  assign memWR = (opcode == 7'b0100011);

  // wbCtrl signal
  assign wbCtrl = (opcode == 7'b0110011 || opcode == 7'b0010011 || opcode == 7'b0110111 || opcode == 7'b0000011) ? 2'b01 :
                (opcode == 7'b1101111 || opcode == 7'b1100111) ? 2'b10 : 
                2'b11;

  // branchCtrl signal
  assign branchCtrl = (opcode == 7'b1100011) ? f3 : 3'b000;

  // aluS1 signal
  assign aluS1 = (opcode == 7'b0110011 || opcode == 7'b0010011 || 
                  opcode == 7'b0000011 || opcode == 7'b0100011 || 
                  opcode == 7'b0110111);

  // aluS2 signal
  assign aluS2 = (opcode == 7'b0110011);

  // doBranch signal
  assign doBranch = (opcode == 7'b1100011);

  // doJump signal
  assign doJump = (opcode == 7'b1101111 || opcode == 7'b0010111);

  // aluOp signal
  assign aluOp = (opcode == 7'b0110011 && f3 == 3'b000) ? ((f7[5] == 1'b1) ? 4'b1000 : 4'b0000) : // SUB/ADD
                 (opcode == 7'b0110011 && f3 == 3'b101) ? ((f7[5] == 1'b1) ? 4'b1101 : 4'b0101) : // SRA/SRL
                 (opcode == 7'b0010011 && f3 == 3'b101) ? ((f7[5] == 1'b1) ? 4'b1101 : 4'b0101) : // SRAI/SRLI
                 (opcode == 7'b0010011 || opcode == 7'b0110011) && (f3 == 3'b000 || f3 == 3'b001 || f3 == 3'b010 ||
                                                                      f3 == 3'b011 || f3 == 3'b100 || f3 == 3'b110 || 
                                                                      f3 == 3'b111) && (f7 == 7'b0) ? {1'b0, f3[2:0]} : // Other ALU operations
                 (opcode == 7'b0110111 || opcode == 7'b0010111 || opcode == 7'b1101111 || opcode == 7'b0010111) ? 4'b0000 :
                 4'b1001; // Default (Malformed instruction)

  // memCtrl signal
  assign memCtrl = (opcode == 7'b0000011) ? (
                      (f3 == 3'b000) ? 3'b000 : // LB
                      (f3 == 3'b001) ? 3'b001 : // LH
                      (f3 == 3'b010) ? 3'b010 : // LW
                      (f3 == 3'b100) ? 3'b011 : // LBU
                      (f3 == 3'b101) ? 3'b100 : // LHU
                      3'b000 // Default for malformed instructions
                    ) :
                    (opcode == 7'b0100011) ? (
                      (f3 == 3'b000) ? 3'b101 : // SB
                      (f3 == 3'b001) ? 3'b110 : // SH
                      (f3 == 3'b010) ? 3'b111 : // SW
                      3'b000 // Default for malformed instructions
                    ) :
                    3'b000;

endmodule
