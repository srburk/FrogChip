`timescale 1ns/1ps

module frog_chip_tb;

	parameter N = 8;
	parameter CLK_PERIOD = 10;
	parameter [N-1:0] PROGRAM_SEQ = 8'b10111000;
	parameter [N-1:0] SEED_SEQ = 8'b10101010;
	
	reg clk;
	reg rst_n;
	reg load;
    reg program;
    reg seed;
    reg enable;
    wire out;
    
    integer i;
    
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
        
        load = 1;
        for (i = 0; i < N; i++) begin
			program = PROGRAM_SEQ[i];
			seed = SEED_SEQ[i];
			#(CLK_PERIOD);
		end
		
        load = 0;
        enable = 1;
        
        #(CLK_PERIOD*260);
        $finish;
    end
    
    initial begin
    	$dumpfile("frog_chip.vcd");
    	$dumpvars(0, frog_chip_tb);
	end

endmodule