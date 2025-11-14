VVP_OUTPUT = frog_sim.vvp
VCD_OUTPUT = frog_chip.vcd

all:
	iverilog -o $(VVP_OUTPUT) frog.v frog_tb.v
	vvp $(VVP_OUTPUT)
.PHONY: all

clean:
	rm $(VVP_OUTPUT) $(VCD_OUTPUT)
.PHONY: clean
