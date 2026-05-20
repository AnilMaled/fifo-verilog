`timescale 1ns / 1ps

module top_fifo_tb;

    reg clock;
    reg reset;
    reg [7:0] data_in;
    wire [7:0] data_out;

    // Unit Under Test (UUT)
    top_fifo uut (
        .clock(clock),
        .reset(reset),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock Generator (50 MHz clock speed: 20ns period)
    always #10 clock = ~clock;

    initial begin
        // Initialize Stimuli
        clock   = 1'b0;
        reset   = 1'b1;
        data_in = 8'h00;

        // Apply Reset
        #20;
        reset = 1'b0;

        // Transmit consecutive distinct data packets
        @(posedge clock);
        data_in = 8'h05;  // 1st Packet
        
        @(posedge clock);
        data_in = 8'h0A;  // 2nd Packet
        
        @(posedge clock);
        data_in = 8'h50;  // 3rd Packet

        // Wait to process and let mod_b output the received records sequentially
        #200;
        
        $finish;
    end

endmodule