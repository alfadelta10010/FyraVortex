module regFile #(parameter DATA_WIDTH = 32) (clk, wr_en, rs1, rs2, rd, r1, r2, dIn);
  input logic clk, wr_en;
  input logic [4:0] rs1, rs2, rd;
  input logic [DATA_WIDTH-1:0] dIn;
  output logic [DATA_WIDTH-1:0] r1, r2;
  logic [DATA_WIDTH-1:0] reg_file [0:31];
  integer i;
  initial begin
    for (i = 0; i < 32; i = i + 1) 
      begin
        reg_file[i] = 0;
      end
  end
  
  // register file write logic (synchronous)
  always @(posedge clk) 
    begin
      if (wr_en) 
        reg_file[rd] <= dIn;
    end
  // MAJOR ISSUE, r0 GETS OVERWRITTEN
  
  // register file read logic (combinational)
  assign r1 = (rs1 != 0 ) ? reg_file[rs1] : 0;
  assign r2 = (rs2 != 0 ) ? reg_file[rs2] : 0;
endmodule
