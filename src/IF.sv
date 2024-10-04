module IF(pc_rst, clk, branch_sel, branch_val, pc_p, pc_n, inst_out, pc_en);
	input logic pc_rst, clk, branch_sel, pc_en;
	input logic [31:0] branch_val;
	output logic [31:0] pc_p, pc_n, inst_out;
	logic dump;
	logic [31:0] pc_in;
	adder pc_adder #(32) (.a(32'd4), .b(pc_p), .cin(1'b0), .s(pc_n), .cout(dump)); 
	instMem inst_mem #(32, 32, 512) (.inst_addr(pc_p), .inst(inst_out));
	mux21 branch_mux #(32) (.a(pc_n), .b(branch_val), .s(branch_sel), .y(pc_in));
	regs pc #(32) (.clk(clk), .rst(pc_rst), .in(pc_in), .out(pc_p), .en(pc_en));
endmodule