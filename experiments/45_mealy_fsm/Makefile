SV_SRCS := src/design.sv
    TB := tb/tb.sv

SIM ?= iverilog
VVP ?= vvp
GHDL ?= ghdl

.PHONY: test sim vhdl clean

test: sim
	@if command -v $(GHDL) >/dev/null 2>&1; then $(MAKE) vhdl; else echo "ghdl not found; skipping VHDL syntax run"; fi

sim:
	@mkdir -p build
	$(SIM) -g2012 -o build/tb.vvp $(SV_SRCS) $(TB)
	$(VVP) build/tb.vvp

vhdl:
	@mkdir -p build/vhdl
	$(GHDL) -a --workdir=build/vhdl src/*.vhd

clean:
	rm -rf build

