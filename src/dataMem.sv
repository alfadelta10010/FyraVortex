module dataMem #(parameter SIZE = 12)(addr, dataW, dataR, memR, clk, wrType);
  output logic [31:0] dataR;
  input bit clk;
  input logic [31:0] dataW;
  input logic [SIZE-1 :0] addr;
  input logic memR;
  input logic [3:0] wrType;
  logic [7:0] datafile [0 : (2**SIZE) - 1];
  
  initial begin
    int i;
    for(i = 0; i < (2**SIZE); i++)
    begin
      datafile[i] = 8'b0;
    end
  end
  
  always @(posedge clk) 
    begin 
      if(memR == 1) 
        begin
          dataR[7:0] <= datafile[addr];
          dataR[15:8] <= datafile[addr+1];
          dataR[23:16] <= datafile[addr+2];
          dataR[31:24] <= datafile[addr+3];
        end
      else
        dataR <= 32'bX;
    end
  always_comb
    begin
      if(wrType[3] == 1'b1)
        datafile[addr+3] = dataW[31:24];
      if(wrType[2] == 1'b1)
        datafile[addr+2] = dataW[23:16];
      if(wrType[1] == 1'b1)
        datafile[addr+1] = dataW[15:8];
      if(wrType[0] == 1'b1)
        datafile[addr] = dataW[7:0];
    end
endmodule
