`include "top_define.vh"

module dff(
    input  wire                  clk ,
    input  wire [`DAT_W -1:0]    d   ,
    output reg  [`DAT_W -1:0]    q 
);

always_ff @(posedge clk)begin
    q <= d;
end

endmodule
