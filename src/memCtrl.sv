/*
memctrl┌──────────────────────────────┐
 ─────►|        mem_controller        │
 [2:0] │   ┌──────────────────────┐   │
       │   │                      │   │
 addrIn│   │                      │   │dataRO
 ──────►   │addrOut         dataRI│   ├──────►
 [31:0]│   ├──────►         ──────►   │[31:0]
       │   │[11:0]          [31:0]│   │ 
       │   │                      │   │
 dataWI│   │dataWO                │   │
 ──────►   ├──────►               │   │
 [31:0]│   │[31:0]                │   │
       └───┘                      └───┘
*/

module memCtrl#(parameter SIZE = 12) (
    input logic [2:0] mem_ctrl,
    input logic [31:0] addrIn,
    input logic [31:0] dataRI,
    input logic [31:0] dataWI,
    output logic [31:0] dataRO,
    output logic [31:0] dataWO,
    output logic [SIZE-1:0] addrOut
);
    /*
    Uncomment if unified memory
    assign addrOut = addrIn[SIZE-1:0] + MemOffset;
    */
    assign addrOut = addrIn[SIZE-1:0];

    // Default assignment to prevent latches
    always_comb begin
        dataRO = 32'b0; // default value for dataRO
        dataWO = 32'b0; // default value for dataWO

        case(mem_ctrl)
            3'b000: dataRO = {{24{dataRI[7]}}, dataRI[7:0]};   // LB
            3'b001: dataRO = {{16{dataRI[15]}}, dataRI[15:0]}; // LH
            3'b010: dataRO = dataRI;                           // LW
            3'b011: dataRO = {24'b0, dataRI[7:0]};             // LBU
            3'b100: dataRO = {16'b0, dataRI[15:0]};            // LHU
            3'b101: dataWO = {24'b0, dataWI[7:0]};             // SB
            3'b110: dataWO = {16'b0, dataWI[15:0]};            // SH
            3'b111: dataWO = dataWI;                           // SW
            default: begin
                dataWO = 32'b0;
                dataRO = 32'b0;
            end
        endcase
    end
endmodule

