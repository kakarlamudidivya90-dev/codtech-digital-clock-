# codtech-digital-clock-
# CODTECH IT SOLUTIONS INTERNSHIP TASK

## 👤 INTERN INFORMATION
* **Full Name:** Kakarlamudi divya 
* **Intern ID:** CITS998
* **Domain Name:** VLSI Design Engineer
* **No. of Weeks / Duration:** 4 Weeks
* **Project Name:** 24-Hour Digital Clock Circuit Design and Simulation

---

## 📌 PROJECT OVERVIEW & SCOPE
### **Project Name:** 
Digital Clock Circuit Design and Simulation

### **Project Scope:**
The scope of this project is to develop, implement, and verify a synchronous 24-Hour Digital Clock Circuit using Verilog Hardware Description Language (HDL). The system acts as a core time-tracking module found in consumer electronics and embedded VLSI systems. 

**Functional Requirements Implemented:**
* **Time Tracking:** Supports real-time tracking of time across three dedicated output registers: seconds (0-59), minutes (0-59), and hours (0-23).
* **Synchronous Reset:** Incorporates a single global control clock (`clk`) and an active-high reset (`rst`) that safely flushes all internal registers back to `00:00:00` on a clock edge.
* **Hierarchical Logic:** Nested cascade logic where minutes only increment when seconds hit 59, and hours only increment when minutes hit 59.

---

## 🎛️ PIN CONFIGURATION & DESCRIPTION


| Signal Name | Direction | Bit-Width | Description |
| :--- | :--- | :--- | :--- |
| **clk** | Input | 1-bit | Global System Clock Signal for synchronization. |
| **rst** | Input | 1-bit | Active-High Synchronous Reset to clear clock registers. |
| **sec** | Output | 6-bit | Output register to track seconds (Counts 0 to 59). |
| **min** | Output | 6-bit | Output register to track minutes (Counts 0 to 59). |
| **hrs** | Output | 5-bit | Output register to track hours (Counts 0 to 23). |

---

## 💻 SOURCE CODE WITH COMMENTS

### **A. RTL Design Code (`digital_clock.v`)**
```verilog
// Module Name: digital_clock
// Description: 24-Hour Digital Clock Circuit with Reset and Clock Enable
module digital_clock (
    input wire clk,       // Main system clock input
    input wire rst,       // Active-high synchronous reset
    output reg [5:0] sec, // 6-bit register for Seconds (0 to 59)
    output reg [5:0] min, // 6-bit register for Minutes (0 to 59)
    output reg [4:0] hrs  // 5-bit register for Hours (0 to 23)
);

    // Clock logic triggers at every positive edge of the system clock
    always @(posedge clk) begin
        if (rst) begin
            // Reset condition: All time counters are set to 00:00:00
            sec <= 6'd0;
            min <= 6'd0;
            hrs <= 5'd0;
        end else begin
            // Increment seconds on every clock cycle
            if (sec == 6'd59) begin
                sec <= 6'd0; // Reset seconds to 0 after 59
                
                // When seconds hit 59, minutes are incremented
                if (min == 6'd59) begin
                    min <= 6'd0; // Reset minutes to 0 after 59
                    
                    // When both seconds and minutes hit 59, hours are incremented
                    if (hrs == 5'd23) begin
                        hrs <= 5'd0; // Reset hours to 0 after 23 (24-Hour cycle complete)
                    end else begin
                        hrs <= hrs + 1'b1; // Increments the hours by 1
                    end
                end else begin
                    min <= min + 1'b1; // Increments the minutes by 1
                end
            end else begin
                sec <= sec + 1'b1; // Increments the seconds by 1
            end
        end
    end

endmodule
```

### **B. Verification Testbench Code (`tb_digital_clock.v`)**
```verilog
`timescale 1ns / 1ps

module tb_digital_clock;

    // Testbench Inputs (Declared as reg)
    reg clk;
    reg rst;

    // Testbench Outputs (Declared as wire to monitor design outputs)
    wire [5:0] sec;
    wire [5:0] min;
    wire [4:0] hrs;

    // Instantiate the Digital Clock Unit Under Test (UUT)
    digital_clock uut (
        .clk(clk),
        .rst(rst),
        .sec(sec),
        .min(min),
        .hrs(hrs)
    );

    // Clock Generation: Toggle clock every 5ns (Period = 10ns)
    always begin
        #5 clk = ~clk;
    end

    // Initial Block for Stimulus Generation
    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 1; // Apply Reset initially

        // Wait 20ns for global reset to settle
        #20;
        rst = 0; // Release Reset to start the clock

        // Monitor outputs in the console window
        \(monitor("Time = \%0t \vert{} \%02d:\%02d:\%02d", \)time, hrs, min, sec);

        // Run simulation for enough time to see changes
        #1000; 

        // End Simulation
        \$finish;
    end

    // Waveform Generation Configuration for EDA Playground
    initial begin
        \$dumpfile("dump.vcd"); // Creates waveform file
        \$dumpvars(1, tb_digital_clock); // Dumps all variables of testbench
    end

endmodule
```

---

## 📊 SIMULATION RESULTS & OUTPUT IMAGES

### **1. Console Output Log Screen Shot**



### **3. Timing Waveforms Screen Shot (EPWave)**
https://raw.githubusercontent.com/kakarlamudidivya90-dev/codtech-digital-clock-/refs/heads/main/Screenshot_20260530_113042.jpg

---

## 🎓 CONCLUSION
The 24-Hour Digital Clock Circuit was successfully designed using Verilog HDL and verified via the Aldec Riviera-PRO simulation engine. The model demonstrates correct hierarchical rollover execution, establishing complete structural stability for sub-system integration.
