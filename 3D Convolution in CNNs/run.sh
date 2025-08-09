#!/bin/bash

read -p "Enter stride value (1 or 2): " stride

# Validate input
if [[ ! "$stride" =~ ^[12]$ ]]; then
    echo "Error: Stride must be 1 or 2"
    exit 1
fi

# Step 1: Data Generation
echo "Step 1/3: Generating input data..."
cd MATLAB/
matlab -batch "data_gen" || { echo "Data generation failed"; exit 1; }
cd ..

# Step 2: Verilog Simulation
echo "Step 2/3: Running Verilog simulation with stride=$stride..."
cd HDL/
iverilog -Ptb_top.stride=$stride -o conv *.v || { echo "Verilog compilation failed"; exit 1; }
vvp conv || { echo "Verilog simulation failed"; exit 1; }
cd ..

# Step 3: Verification
echo "Step 3/3: Running verification..."
cd MATLAB/
matlab -batch "Eval($stride)" || { echo "Verification failed"; exit 1; }
cd ..

echo "All steps completed successfully with stride=$stride!"
