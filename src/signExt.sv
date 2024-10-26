/*
Instruction [31:0]
─────────┐
         │
Opcode┌──▼──┐[31:0]
──────► Ext ├──────►Immediate
 [6:0]└─────┘        Value
*/

module signExt(opcode, instIn, immOut);
  input logic [6:0] opcode;
  input logic [31:0] instIn;
  output logic [31:0] immOut;
  always_comb
    case(opcode)
      7'b0110111: begin // LUI 
        immOut[31:12] = instIn[31:12];
        immOut[11:0] = 12'b0;
      end
      7'b0010111: begin // AUIPC
        immOut[31:12] = instIn[31:12];
        immOut[11:0] = 12'b0;
      end
      7'b1101111: begin // JAL
        immOut = {{20{instIn[31]}}, instIn[19:12], instIn[13], instIn[30:21], 1'b0};
      end
      7'b1100111: begin // JALR
        immOut[11:0] = instIn[31:20];
        immOut[31:12] = {20{instIn[31]}};
      end
      7'b1100011: begin // Branches
        immOut = {{20{instIn[31]}}, instIn[7], instIn[30:25], instIn[11:8], 1'b0};
      end
      7'b0000011: begin // IL-Type
        immOut = {{20{instIn[31]}}, instIn[31:20]};
      end
      7'b0010011: begin // IR-Type
        immOut = (instIn[14:12] == (3'b001 || 3'b101)) ? {27'b0, instIn[24:20]} : {{20{instIn[31]}}, instIn[31:20]};
      end
      7'b0100011: begin
        immOut = {{20{instIn[31]}}, instIn[31:25], instIn[11:7]};
      end
      default:
        immOut = 32'b0;
    endcase
endmodule
