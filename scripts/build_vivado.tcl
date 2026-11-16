# ==============================================================================
# Vivado Batch Build Script (Non-Project Mode)
# Target: Digilent Basys 3 (xc7a35tcpg236-1)
# ==============================================================================

set outputDir ./build_output
file mkdir $outputDir

# 1. Read VHDL Source Files
read_vhdl ../src/TIMEBASE.vhd
read_vhdl ../src/COUNTERS.vhd
read_vhdl ../src/CONTROL_UNIT.vhd
read_vhdl ../src/TOP_LEVEL.vhd

# 2. Read Physical Constraints
read_xdc ../constrs/basys3_master.xdc

# 3. Synthesize Design
synth_design -top TOP_LEVEL -part xc7a35tcpg236-1
write_checkpoint -force $outputDir/post_synth.dcp
report_utilization -file $outputDir/post_synth_util.rpt

# 4. Implementation (Opt, Place, Route)
opt_design
place_design
report_io -file $outputDir/io_placed.rpt
report_utilization -file $outputDir/utilization_placed.rpt
write_checkpoint -force $outputDir/post_place.dcp

route_design
write_checkpoint -force $outputDir/post_route.dcp
report_timing_summary -file $outputDir/timing_summary_routed.rpt

# 5. Generate Bitstream
write_bitstream -force $outputDir/TOP_LEVEL.bit
puts "Build completed successfully! Bitstream saved to $outputDir/TOP_LEVEL.bit"
