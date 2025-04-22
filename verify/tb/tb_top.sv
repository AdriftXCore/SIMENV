`timescale 1ns/1ns

module tb_top;

`include "top_define.vh"

// `define DAT_W 32

// output declaration of module dff
reg   [`DAT_W -1:0] D;
logic [`DAT_W -1:0] Q;
logic               clk;

dff u_dff(
    .clk 	(clk  ),
    .d   	(D    ),
    .q   	(q    )
);

parameter CYCLE = 20;
initial clk = 0;
always #(CYCLE/2) clk = ~clk;

initial begin
    D = 'd0;
    repeat(10 ) @(posedge clk) #1;
    D = 'd1;
    repeat(10 ) @(posedge clk) #1;
    D = 'd2;

    repeat(100) @(posedge clk) #1;
    $finish;
end

initial begin
    $dumpfile("tb_top.vcd");
    $dumpvars(0,tb_top);
end

endmodule