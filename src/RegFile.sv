module RegFile #(parameter DATA_WIDTH = 32) (
    input       clk,
    input       wr_en,
    input       [4:0] rd_addr1, rd_addr2, wr_addr,
    input       [DATA_WIDTH-1:0] wr_data,
    output      [DATA_WIDTH-1:0] rd_data1, rd_data2
);

logic [DATA_WIDTH-1:0] reg_file_arr [0:31];

integer i;
initial begin
    for (i = 0; i < 32; i = i + 1) begin
        reg_file_arr[i] = 0;
    end
end

// register file write logic (synchronous)
always @(posedge clk) begin
    if (wr_en) reg_file_arr[wr_addr] <= wr_data;
end

// register file read logic (combinational)
assign rd_data1 = ( rd_addr1 != 0 ) ? reg_file_arr[rd_addr1] : 0;
assign rd_data2 = ( rd_addr2 != 0 ) ? reg_file_arr[rd_addr2] : 0;

endmodule
