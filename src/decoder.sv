/*
        ┌─────┐
        │     │rd[4:0]    
        │  D  ├──────────►
        │     │rs1[4:0]   
        │  E  ├──────────►
        │     │rs2[4:0]   
instIn  │  C  ├──────────►
────────►     │
[31:0]  │  O  │
        │     │
        │  D  │
        │     │
        │  E  │
        │     │
        │  R  │   Opcode  
        │     ├──────────►
        └┬──┬─┘   [6:0]   
         │  │
         ▼  ▼
        F3  F7
*/

module decoder(instIn, opcode, rd, rs1, rs2, fn3, fn7);
  input logic [31:0] instIn;
  output logic [4:0] rd;
  output logic [4:0] rs1;
  output logic [4:0] rs2;
  output logic [6:0] opcode;
  output logic [2:0] fn3;
  output logic [6:0] fn7;
  always_comb
    begin
      opcode = instIn[6:0];
      {rd, rs1, rs2, fn3, fn7} = 'b0;
      case(opcode)
        7'b0110111: //LUI
          begin
            rd = instIn[11:7];
          end
        7'b0010111: //JAL
          begin
            rd = instIn[11:7];
          end
        7'b0010111: //AUIPC
          begin
            rd = instIn[11:7];
          end
        7'b1100111: //JALR
          begin
            rd = instIn[11:7];
            rs1 = instIn[19:15];
            fn3 = instIn[14:12];
          end
        7'b1100011: //B-type
          begin
            rs1 = instIn[19:15];
            rs2 = instIn[24:20];
            fn3 = instIn[14:12];
          end
        7'b0000011: //IL-type
          begin 
            rs1 = instIn[19:15];
            rs2 = instIn[24:20];
            rd = instIn[11:7];
            fn3 = instIn[14:12];
          end
        7'b0100011: //S-type
          begin
            rs1 = instIn[19:15];
            rs2 = instIn[24:20];
            fn3 = instIn[14:12];
          end
        7'b0010011: //IR-type
          begin
            rs1 = instIn[19:15];
            rd = instIn[11:7];
            fn3 = instIn[14:12];
            if(fn3 == 3'b101)
              fn7 = instIn[31:25];
            else
              fn7 = 7'b0;
          end
        7'b0110011: //R-type
          begin
            rs1 = instIn[19:15];
            rs2 = instIn[24:20];
            rd = instIn[11:7];
            fn3 = instIn[14:12];
            fn7 = instIn[31:25];
          end
        default:
          begin
            rs1 = 5'b0;
            rs2 = 5'b0;
            rd = 5'b0;
            fn3 = 3'b0;
            fn7 = 7'b0;
          end
      endcase
    end
endmodule
