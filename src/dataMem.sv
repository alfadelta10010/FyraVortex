/*
module dataMem #(parameter SIZE = 11)(addr, dataW, dataR, memR, clk, memW);
  output logic [31:0] dataR;
  input bit clk;
  input logic [31:0] dataW;
  input logic [SIZE-1 :0] addr;
  input logic memR;
  input logic [1:0] memW;
  logic [7:0] datafile1 [0:5];
  logic [7:0] datafile2 [0:5];
  logic [7:0] datafile3 [0:5];
  logic [7:0] datafile4 [0:5];
  
  initial begin
    int i;
    for(i = 0; i < (2**SIZE); i++)
    begin
      datafile1[i] = 8'b0;
      datafile2[i] = 8'b0;
      datafile3[i] = 8'b0;
      datafile4[i] = 8'b0;
    end
  end
  
  always @(posedge clk) 
    begin 
      if(memR == 1) 
        begin
          dataR[7:0] <= datafile1[addr[8:3]];          
          dataR[15:8] <= datafile2[addr[8:3]];
          dataR[23:16] <= datafile3[addr[8:3]];
          dataR[31:24] <= datafile4[addr[8:3]];
        end
      if(memW == 2'b01)
        datafile1[addr] = dataW[31:24];
      if(wrType[2] == 1'b1)
        datafile[addr+2] = dataW[23:16];
      if(wrType[1] == 1'b1)
        datafile[addr+1] = dataW[15:8];
      if(wrType[0] == 1'b1)
        
    end
endmodule
 */

module dataMem #(parameter SIZE = 11) (clk, memW, addr, dataW, wrType, dataR);
    input logic clk;
    input logic memW;
    input logic [SIZE-1:0] addr;
    input logic [31:0] dataW;
    input logic [3:0] wrType;
    output logic [31:0] dataR;
    logic [31:0] mem [(2**SIZE)-1:0];
    logic [31:0] write_data_masked;

    // Generate the write data mask based on byte enable
    assign write_data_masked = { 
        (wrType[3] ? dataW[31:24] : mem[addr][31:24]),
        (wrType[2] ? dataW[23:16] : mem[addr][23:16]),
        (wrType[1] ? dataW[15:8]  : mem[addr][15:8]),
        (wrType[0] ? dataW[7:0]   : mem[addr][7:0])
    };
    always_ff @(posedge clk) begin
        if (memW) begin
            mem[addr] <= write_data_masked;
        end
    end
    assign dataR = mem[addr];
endmodule

