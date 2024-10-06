//https://edaplayground.com/x/AxsV
module tb_branchCtrl();
  logic [2:0] b_control_tb;
  logic [31:0] r1_tb;
  logic [31:0] r2_tb;
  logic [0:0] branch_sel_tb;
  
  branchCtrl dut (.b_control(b_control_tb), .r1(r1_tb), .r2(r2_tb), .branch_sel(branch_sel_tb));
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_branch_control);
    #1 r1_tb = 32'hF0000000;
    r2_tb = 32'hF0000000;
    b_control_tb = 3'b011;
    #1 b_control_tb = 3'b001;
    #1 b_control_tb = 3'b010;
    #1 r2_tb = 32'hF0000001;
    #1 b_control_tb = 3'b000;
    #1 b_control_tb = 3'b111;
    #1 b_control_tb = 3'b100;
    #1 r2_tb = 32'hFFFFFFFF;
    #1 b_control_tb = 3'b101;
    #1 $finish;
  end
endmodule
