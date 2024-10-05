module MEM_WB(clk, wb_ctrl, mem_rd, mem_wr, mem_ctrl, reg_wr, pc_out, alu_out, mem_data, rd, wb_out, rd_out, reg_wr_out);
	input logic clk;
	input logic  [1:0] wb_ctrl;
	input logic  mem_rd, mem_wr;
	input logic  [2:0] mem_ctrl;
	input logic  reg_wr;
	input logic  [31:0] pc_out;
	inout logic  [31:0] alu_out;
	input logic  [31:0] mem_data;
	input logic  [4:0]  rd;
	output logic [31:0] wb_out;
	output logic [4:0] rd_out;
	output logic reg_wr_out;
	
	logic [31:0] mem_out, ctrl_out, out, mem_data_in;
	logic [11:0] addr_out;
	
	
	
	assign reg_wr_out = reg_wr;
	assign rd_out = rd;
	memCtrl #(12) Memory_Controller(.dataRI(mem_out), .dataRO(out), .addrIn(alu_out), .addrOut(addr_out), .dataWI(mem_data), .dataWO(mem_data_in), .mem_ctrl(mem_ctrl));
	dataMem #(12) Data_Memory(.addr(addr_out), .dataW(mem_data_in), .dataR(mem_out), .memR(mem_rd), .memW(mem_wr), .clk(clk));
	mux31   #(32) Write_Back_MUX(.a(pc_out), .b(alu_out), .c(out), .s(wb_ctrl), .y(wb_out));
	
endmodule
