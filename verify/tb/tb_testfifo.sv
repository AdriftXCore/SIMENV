`timescale 1ns/1ns

`include "top_define.vh" 

module tb_testfifo;

parameter CYCLE = 20;


logic                   clk      ;
logic                   rst      ;
logic                   wr_en    ;
logic                   rd_en    ;
logic [`WIDTH_DEF-1:0]  din      ;
logic [`WIDTH_DEF-1:0]  dout     ;
logic                   prog_full;

initial clk = 0;
always #(CYCLE/2) clk = ~clk;

initial begin
    rst = 0;
    #1
    rst = 1;
    #(10 * CYCLE)
    rst = 0;
end

testfifo#(
    .WIDTH        ( `WIDTH_DEF ),
    .DEPTH        ( `DEPTH_DEF )
)u_testfifo(
    .clk        (  clk      ),
    .rst        (  rst      ),
    .wr_en      (  wr_en    ),
    .din        (  din      ),
    .rd_en      (  rd_en    ),
    .dout       (  dout     ),
    .prog_full  (  prog_full)
);

initial begin
    #1
    wr_en = 0;
    din   = 0;
    #(15 * CYCLE)
    repeat(24)begin
        wr_en = 1;
        din   = {$random} % ((2**32) - 1);
        #(CYCLE)
        wr_en = 0;
        din   = 0;
    end
    #(10 * CYCLE)
    wr_en = 0;
    din   = 0;
    $stop;
end

initial begin
    #1
    rd_en = 0;
    #(16 * CYCLE)
    forever begin
        if(prog_full == 1)
            rd_en = 1;
        else
            rd_en = 0;
        #(CYCLE);
    end
end

initial
begin
    $fsdbDumpfile("tb.fsdb");
    $fsdbDumpvars(0);
end


endmodule

