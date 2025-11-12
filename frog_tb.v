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
    );
    
    initial begin // Clock gen
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end
    
    initial begin
    	// Initialize
        rst_n = 0;
        load = 0;
        enable = 0;
        program = 0;
        seed = 0;
        
        // Release reset
        #(CLK_PERIOD*2);
        rst_n = 1;
        #(CLK_PERIOD);
        
        program = 8'b10111000;
        seed = 8'b10101010;
        load = 1;
        #(CLK_PERIOD);
        load = 0;
        enable = 1;
        
        #(CLK_PERIOD*260);
    end

endmodule