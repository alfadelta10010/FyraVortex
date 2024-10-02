module forward(rs1, rs2, rd_mem, reg_write, forward_a, forward_b);
	input logic [4:0] rs1, rs2;
	input logic [4:0] rd_mem;
	input logic reg_write;
	output logic forward_a, forward_b;
	logic r1, r2;
	
	always_comb begin
		r1 = (rs1 == rd_mem) ?  1'b1: 1'b0;
		r2 = (rs2 == rd_mem) ?  1'b1: 1'b0;
		forward_a = (reg_write & r1) ? 1'b1: 1'b0;
		forward_b = (reg_write & r2) ? 1'b1: 1'b0;
	end
endmodule