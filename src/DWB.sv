module DWB(clk, wbCtrl, memW, memCtrl, pcN, aluOut, dataIn, wbOut);
  input logic clk;
  input logic [1:0] wbCtrl;
  input logic memW;
  input logic [2:0] memCtrl;
  input logic [31:0] pcN;
  inout logic [31:0] aluOut;
  input logic [31:0] dataIn;
  output logic [31:0] wbOut;
  
  logic [11:0] addrOut;
  logic [31:0] dataR, dataW, dataOut;
  logic [3:0] wrType;
  
  memCtrlr #(12) memoryController (.memCtrl(memCtrl), .addrIn(aluOut), .dataRI(dataR), .dataWI(dataIn), 
                                  .dataRO(dataOut), .dataWO(dataW), .addrOut(addrOut), .wrType(wrType)
                                 );
  dataMem #(12) dataMemory (.addr(addrOut), .dataW(dataW), .dataR(dataR), .wrType(wrType), .clk(clk), .memW(memW));
  mux31 #(32) writebackMUX (.a(pcN), .b(aluOut), .c(dataOut), .y(wbOut), .s(wbCtrl)
                           );
endmodule
