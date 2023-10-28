`timescale 1ns/1ns

module tb_testfifo;

parameter CYCLE = 20;


logic clk      ;
logic rst      ;
logic wr_en    = 0;
logic din      = 0;
logic rd_en    ;
logic dout     ;
logic prog_full;

initial clk = 0;
always #(CYCLE/2) clk = ~clk;

initial begin
    rst = 0;
    #1
    rst = 1;
    #(10 * CYCLE)
    rst = 0;

    #(100 * CYCLE)
    $stop;
end

testfifo#(
    .WIDTH        ( 8 ),
    .DEPTH        ( 16 )
)u_testfifo(
    .clk        (  clk      ),
    .rst        (  rst      ),
    .wr_en      (  wr_en    ),
    .din        (  din      ),
    .rd_en      (  rd_en    ),
    .dout       (  dout     ),
    .prog_full  (  prog_full)
);

initial
begin
    $fsdbDumpfile("tb.fsdb");
    $fsdbDumpvars(0);
end


endmodule



