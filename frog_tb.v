`timescale 1ns/1ps

module frog_chip_tb;

	parameter N = 8;
	parameter CLK_PERIOD = 10;
	
	reg clk;
	reg rst_n;
	reg load;
    reg [N-1:0] program;
    reg [N-1:0] seed;
    reg enable;
    wire out;
    
    frog_chip #(.N(N)) uut (
    	.clk(clk),
        .rst_n(rst_n),
        .load(load),
        .program(program),
        .seed(seed),
        .enable(enable),
        .out(out)
    )
    
    initial begin // Clock gen
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end
    
    initial begin
    	// Initialize
        rst_n = 0;
        load = 0;
        enable = 0;
        tap_prog = 0;
        init_seq = 0;
        
        // Release reset
        #(CLK_PERIOD*2);
        rst_n = 1;
        #(CLK_PERIOD);
        
        tap_prog = 8'b10111000;
        init_seq = 8'b10101010;
        load = 1;
        #(CLK_PERIOD);
        load = 0;
        enable = 1;
        
        // Run for 260 cycles (should repeat at 255 for maximal LFSR)
        repeat(260) begin
            #(CLK_PERIOD);
        end
    end

endmodule