module testfifo #(
    parameter WIDTH = 8 ,
    parameter DEPTH = 16
)(
    input   logic               clk         ,   //system clock
    input   logic               rst         ,   //reset signal

    input   logic               wr_en       ,
    input   logic [WIDTH-1:0]   din         ,

    input   logic               rd_en       ,
    output  logic [WIDTH-1:0]   dout        ,

    output  logic               prog_full    
);

xpm_fifo_sync  #(
	.DOUT_RESET_VALUE   ("0"       ), 
	.FIFO_MEMORY_TYPE   ("block"   ),
	.FIFO_READ_LATENCY  (0         ),     
	.FIFO_WRITE_DEPTH   (DEPTH     ),   
	.FULL_RESET_VALUE   (0         ),      
	.PROG_EMPTY_THRESH  (10        ),    
	.PROG_FULL_THRESH   (11        ),     
	.RD_DATA_COUNT_WIDTH(1         ),   
	.READ_DATA_WIDTH    (WIDTH ),      
	.READ_MODE          ("fwft"    ),         
	.SIM_ASSERT_CHK     (0         ),        
	.USE_ADV_FEATURES   ("0002"    ), 
	.WAKEUP_TIME        (0         ),      
	.WRITE_DATA_WIDTH   (WIDTH ),     
	.WR_DATA_COUNT_WIDTH(1         )  
)
np_ppe_pb_cmd_trans(
	.dout         (dout  		    ),                   
	.empty        ( 	            ),                 
	.full         (                 ),                         
	.prog_full    (prog_full  	    ),         
	.din          (din		        ),                     
	.rd_en        (rd_en      	    ),                 
	.rst          (rst          	),                     
	.wr_clk       (clk          	),               
	.wr_en        (wr_en            )          
);

endmodule
