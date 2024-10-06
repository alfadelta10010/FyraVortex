module DWB(clk, wbCtrl, memRD, memWR, memCtrl, pcN, aluOut, dataIn, wbOut);
  input logic clk;
  input logic [1:0] wbCtrl;
  input logic memRD, memWR;
  input logic [2:0] memCtrl;
  input logic [31:0] pcN;
  inout logic [31:0] aluOut;
  input logic [31:0] dataIn;
  output logic [31:0] wbOut;
  
  logic [11:0] addrOut;
  logic [31:0] dataR, dataW, dataOut;
  
  memCtrlr #(12) memoryController (.memCtrl(memCtrl), .addrIn(aluOut), .dataRI(dataR), .dataWI(dataIn), 
                                  .dataRO(dataOut), .dataWO(dataW), .addrOut(addrOut)
                                 );
  dataMem #(12) dataMemory (.addr(addrOut), .dataW(dataW), .dataR(dataR), .memW(memWR), 
                            .memR(memRD), .clk(clk)
                           );
  mux31 #(32) writebackMUX (.a(pcN), .b(aluOut), .c(dataOut), .y(wbOut), .s(wbCtrl)
                           );
  
endmodule
