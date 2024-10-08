module tb_mux21(a_tb, b_tb, s_tb, y_tb);
  logic [31:0] a_tb;
  logic [31:0] b_tb;
  logic s_tb;
  logic [31:0] y_tb;
  
  mux21 #(32) dut (.a(a_tb), .b(b_tb), .s(s_tb), .y(y_tb));
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_mux21);
    a_tb = 32'habcdef12;
    b_tb = 32'h12345678;
    s_tb = 1'b0;
    #1 s_tb = 1'b1; 
    #1 s_tb = 1'b0;
    #1 $finish;
  end
endmodule