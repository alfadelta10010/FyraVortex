module IF(pc_rst, clk, branch_sel, branch_val, pc_p, pc_n, inst_out, pc_en);
  input logic pc_rst, clk, branch_sel, pc_en;
  input logic [31:0] branch_val;
  output logic [31:0] pc_p, pc_n, inst_out;
  logic [31:0] pc_in;
  adder #(32) pc_adder (.a(32'd4), .b(pc_p), .s(pc_n)); 
  instMem #(32, 32, 512) inst_mem (.inst_addr(pc_p), .inst(inst_out));
  mux21 #(32) branch_mux(.a(pc_n), .b(branch_val), .s(branch_sel), .y(pc_in));
  regs #(32) pc(.clk(clk), .rst(pc_rst), .in(pc_in), .out(pc_p), .en(pc_en));
endmodule
