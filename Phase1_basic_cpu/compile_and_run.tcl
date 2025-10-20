# ModelSim compilation and simulation script
vlib work
vmap work work

# Compile all source files
vlog ./src/IR.v
vlog ./src/PC.v
vlog ./src/AC.v
vlog ./src/ALU.v
vlog ./src/DataPath.v
vlog ./src/Controller.v
vlog ./src/CPU.v
vlog ./testbench/CPU_tb.v

# Simulate
vsim work.CPU_tb

# Run simulation
run -all

# Display results
echo "Simulation completed. Check outputs/output.txt for results."