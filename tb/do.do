# ==============================================================================
# ModelSim Compilation & Simulation Macro
# ==============================================================================
vlib work
vcom -93 ../src/TIMEBASE.vhd
vcom -93 ../src/COUNTERS.vhd
vcom -93 ../src/CONTROL_UNIT.vhd
vcom -93 ../src/TOP_LEVEL.vhd
vcom -93 TB_TOP_LEVEL.vhd

vsim -voptargs=+acc=lprn work.TB_TOP_LEVEL

# Waveform Signals
add wave -divider "System Clock & Reset"
add wave -hex /TB_TOP_LEVEL/TB_CLK
add wave -hex /TB_TOP_LEVEL/TB_RESET

add wave -divider "Internal Control Signals"
add wave -hex /TB_TOP_LEVEL/DUT/ENABLE
add wave -hex /TB_TOP_LEVEL/DUT/SEL
add wave -hex /TB_TOP_LEVEL/DUT/NEXT_STAGE
add wave -hex /TB_TOP_LEVEL/DUT/U2/STATE

add wave -divider "Traffic Light Outputs (TPL[4:0])"
add wave -bin /TB_TOP_LEVEL/TB_TPL
add wave -divider "Pedestrians [4:3]"
add wave -color Red /TB_TOP_LEVEL/DUT/TPL(4)
add wave -color Green /TB_TOP_LEVEL/DUT/TPL(3)
add wave -divider "Vehicles [2:0]"
add wave -color Red /TB_TOP_LEVEL/DUT/TPL(2)
add wave -color Yellow /TB_TOP_LEVEL/DUT/TPL(1)
add wave -color Green /TB_TOP_LEVEL/DUT/TPL(0)

# Run full simulation to observe multiple complete cycles
run 3000 ns
wave zoomfull
