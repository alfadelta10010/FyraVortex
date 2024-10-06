module ID(clk, pc_p, inst_out,wr_en, wr_addr, wr_data, rs1_val, rs2_val, imm, rs1, rs2, rd, opcode, reg_wr, mem_rd, mem_wr, wb_ctrl, alu_op, alu_s1, alu_s2, branch_ctrl, mem_ctrl, do_branch, jump_ctrl);
	input  logic clk;
	input  logic [31:0] pc_p, inst_out;
	input  logic wr_en;
   	input  logic [4:0]  wr_addr;
  	input  logic [31:0] wr_data;
	output logic [31:0] rs1_val, rs2_val, imm;
	output logic [4:0]  rs1, rs2, rd;
	output logic [5:0]  opcode;
	output logic reg_wr;
	output logic mem_rd, mem_wr;
	output logic [1:0] wb_ctrl;
	output logic [2:0] branch_ctrl;
	output logic [2:0] mem_ctrl;
	output logic alu_s1, alu_s2;
	output logic [3:0] alu_op;
	output logic jump_ctrl;	
	output logic do_branch;
	logic [2:0] fn3;
   	logic [6:0] fn7;
	
	decoder       decode (.instIn(inst_out), .opcode(opcode), .rd(rd), .rs1(rs1), .rs2(rs2), .fn3(fn3), .fn7(fn7));
	controller    control_unit (.f3(fn3), .f7(fn7), .opcode(opcode), .reg_wr(reg_wr), .mem_rd(mem_rd), .mem_wr(mem_wr), .wb_ctrl(wb_ctrl), .alu_op(alu_op), .alu_s1(alu_s1), .alu_s2(alu_s2), .branch_ctrl(branch_ctrl), .mem_ctrl(mem_ctrl), .do_branch(do_branch), .jump_ctrl(jump_ctrl));
	RegFile #(32) register (.clk(clk), .wr_en(wr_en), .rd_addr1(rs1), .rd_addr2(rs2), .wr_addr(wr_addr), .wr_data(wr_data), .rd_data1(rs1_val), .rd_data2(rs2_val));
	signExt       Immediate_Extender (.opcode(opcode), .instIn(pc_p), .immOut(imm));
	
endmodule
