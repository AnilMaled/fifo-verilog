module mod_a (
    input wire clock,
    input wire reset,
    input wire [7:0] data_in,//data input we need to give in tb
    output reg [7:0] data_out,
    output reg write_enable
);

    always @(posedge clock) begin
        if (reset) begin
            data_out     <= 8'h00;//it will be of 8 bit
            write_enable <= 1'b0;  //initially
        end 
        else 
        begin
            data_out     <= data_in;//may use d ff during synthesis
            write_enable <= 1'b1; 
        end
    end

endmodule