// instr_mem - instruction memory for single-cycle RISC-V CPU
module inst_mem #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 32, MEM_SIZE = 512) (inst_addr, inst);
  input [ADDR_WIDTH-1:0] inst_addr;
  output [DATA_WIDTH-1:0] inst;
  // array of 64 32-bit words or instructions
  logic [DATA_WIDTH-1:0] inst_ram [0:MEM_SIZE-1];
  initial begin
    $readmemh("program_dump.hex", inst_ram);
  end
  
  // word-aligned memory access
  // combinational read logic
  assign inst = inst_ram[inst_addr[31:2]];
endmodule
