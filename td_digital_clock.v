// =======================================================================
// COMPANY NAME : CODTECH IT SOLUTIONS 
// INTERN NAME : KAKARLAMUDI DIVYA 
// INTERN ID : CITS99
// DOMAIN : VLSI DESIGN 
// BATCH DURATION : MAY-june 2026
// TASK TITLE : DIGITAL ClOCK CIRCUIT DESIGN ANd SIMULATION
// =======================================================================

`timescale 1ns / 1ps

module tb_digital_clock;

    // Testbench inputs declared as 'reg' to drive stimulus
    reg clk;
    reg rst;

    // Testbench outputs declared as 'wire' to monitor signals
    wire [5:0] sec;
    wire [5:0] min;
    wire [4:0] hrs;

    // Instantiate the Unit Under Test (UUT)
    digital_clock uut (
        .clk(clk),
        .rst(rst),
        .sec(sec),
        .min(min),
        .hrs(hrs)
    );

    // Clock Generator: Toggle clock every 5ns (Creates a 100MHz clock)
    always begin
        #5 clk = ~clk;
    end

    // Stimulus Block
    initial begin
        // Initialize inputs
        clk = 0;
        rst = 1; // Assert reset at startup

        // Hold reset condition for 20ns
        #20;
        rst = 0; // Deassert reset to let the clock run

        // Monitor signal changes automatically in the EDA log terminal
        $monitor("Time = %0t | %02d:%02d:%02d", $time, hrs, min, sec);

        // Run simulation for a long duration to observe increments
        #150000; 

        // Terminate simulation run
        $finish;
    end

    // Waveform Configuration Block for EDA Playground EPWave display
    initial begin
        $dumpfile("dump.vcd");         // Specifies the VCD waveform file name
        $dumpvars(1, tb_digital_clock); // Dumps top-level testbench variables
    end

endmodule
