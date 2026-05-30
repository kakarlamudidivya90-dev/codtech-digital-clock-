// =======================================================================
// COMPANY NAME: CODTECH IT SOLUTIONS 
// INTERN NAME : KAKARLAMUDI DIVYA 
// INTERN ID : CITS998
// DOMAIN : VLSI DRSIGN
// BATCH DURATION : MAY-JuNE 2026
// TASK TITLE : DIGITAL ClOCK CIRCUIT DESIGN AND SIMULATION
// =======================================================================

module digital_clock (
    input wire clk,       // Main system clock input
    input wire rst,       // Active-high synchronous reset signal
    output reg [5:0] sec, // 6-bit register to store seconds (0 to 59)
    output reg [5:0] min, // 6-bit register to store minutes (0 to 59)
    output reg [4:0] hrs  // 5-bit register to store hours (0 to 23)
);

    // Sequential logic triggered at the rising edge of the clock
    always @(posedge clk) begin
        if (rst) begin
            // Synchronous Reset: Clear all time registers to 00:00:00
            sec <= 6'd0;
            min <= 6'd0;
            hrs <= 5'd0;
        end else begin
            // Check if seconds reached upper limit (59)
            if (sec == 6'd59) begin
                sec <= 6'd0; // Reset seconds counter to 0
                
                // Check if minutes reached upper limit (59)
                if (min == 6'd59) begin
                    min <= 6'd0; // Reset minutes counter to 0
                    
                    // Check if hours reached upper limit of 24-hour format (23)
                    if (hrs == 5'd23) begin
                        hrs <= 5'd0; // Reset hours counter to 0 (New Day starts)
                    end else begin
                        hrs <= hrs + 1'b1; // Increment hours counter by 1
                    end
                end else begin
                    min <= min + 1'b1; // Increment minutes counter by 1
                end
            end else begin
                sec <= sec + 1'b1; // Increment seconds counter by 1
            end
        end
    end

endmodule
