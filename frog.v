
`timescale 1ns/1ps

module frog_chip #(
	parameter N=8
)(
	input wire clk,
	input wire rst_n,
	
	input wire enable,
	input wire load,
	
	input wire [N-1:0] program,
	input wire [N-1:0] seed,

	output wire out
);

	reg [N-1:0] lfsr;
	reg [N-1:0] taps;
	
	wire feedback;
	assign feedback = ^(lfsr & taps); // XOR all together with tapped flags
	
	assign out = lfsr[0]; // out is LSB
	
	always @(posedge clk) begin
	
		if (!rst_n) begin
			lfsr <= {N{1'b0}};
            taps <= {N{1'b0}};
		end
	
		else if (load) begin
			taps <= program;
			lfsr <= seed;
		end
	
		else if (enable) begin
			lfsr <= {feedback, lfsr[N-1:1]};
		end
	
	end

endmodule