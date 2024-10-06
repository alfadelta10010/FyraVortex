module tb_ALU();
  logic [31:0] d1_tb;
  logic [31:0] d2_tb;
  logic [31:0] result_tb;
  logic [3:0] control_tb;
  
  ALU dut (.d1(d1_tb), .d2(d2_tb), .result(result_tb), .control(control_tb));
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_ALU);
    d1_tb = 32'hF31474A1;
    d2_tb = 32'hA214673C;
    control_tb = 4'bX;
    #10 control_tb = 4'b0000;
    #10 control_tb = 4'b0001;
    #10 control_tb = 4'b0010;
    #10 control_tb = 4'b0011;
    #10 control_tb = 4'b0100;
    #10 control_tb = 4'b0101;
    #10 control_tb = 4'b0110;
    #10 control_tb = 4'b0111;
    #10 control_tb = 4'b1000;
    #10 control_tb = 4'b1001;
    #10 control_tb = 4'b1010;
    #10 control_tb = 4'b1011;
    #10 control_tb = 4'b1100;
    #10 control_tb = 4'b1101;
    #10 control_tb = 4'b1110;
    #10 control_tb = 4'b1111;
    #10 $finish;
  end
endmodule