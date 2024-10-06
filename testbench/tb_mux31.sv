module tb_mux31();
  logic [31:0] a_tb; b_tb, c_tb;
  logic [1:0] s_tb;
  logic [31:0] y_tb;
  
  mux31 dut (.a(a_tb), .b(b_tb), .c(c_tb), .s(s_tb), .y(y_tb));
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_mux31);
    a_tb = 32'habcdef12;
    b_tb = 32'h12345678;
    c_tb = 32'hbabeface;
    #1 s_tb = 2'b00;
    #1 s_tb = 2'b01;
    #1 s_tb = 2'b10;
    #1 s_tb = 2'b11;
    #1 $finish;
  end
endmodule