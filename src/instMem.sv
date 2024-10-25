module instMem #(parameter XLEN = 8) (instAddr, instOut);
  input logic [31:0] instAddr;
  logic [XLEN - 1 : 0] addr;
  output logic [31:0] instOut;  
  reg [7:0] mem [0: (2**XLEN)-1];
  
  initial begin
    $readmemh("program.data", mem, 0, (2**XLEN) -1);
  end
  
  always @(*)
    begin
      addr = instAddr[XLEN-1:0]; 
      instOut = {mem [addr+3], mem [addr+2], mem [addr+1], mem [addr]};
    end
endmodule

