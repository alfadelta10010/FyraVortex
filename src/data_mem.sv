// data_mem - data memory for single-cycle RISC-V CPU
module data_mem #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 32, MEM_SIZE = 64) (clk, wr_en, wr_addr, wr_data,rd_data_mem);
  input clk, wr_en;
  input [ADDR_WIDTH-1:0] wr_addr, wr_data;
  output [DATA_WIDTH-1:0] rd_data_mem;
  logic [DATA_WIDTH-1:0] data_ram [0:MEM_SIZE-1];  // array of 64 32-bit words or data
  assign rd_data_mem = data_ram[wr_addr[DATA_WIDTH-1:2] % 64];  // combinational read logic, word-aligned memory access

// synchronous write logic
  always @(posedge clk) begin
    if (wr_en) 
      data_ram[wr_addr[DATA_WIDTH-1:2] % 64] <= wr_data;
  end
endmodule
