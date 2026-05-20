module top_fifo (
    input wire clock,
    input wire reset,
    input wire [7:0] data_in,
    output wire [7:0] data_out
);

    // Internal interconnect nets
    wire [7:0] data_out_temp;
    wire [7:0] data_out_fifo;
    wire w_en, r_en;
    wire fifo_full, fifo_empty;

    // Instantiate Module A (Producer)
    mod_a mod1 (
        .clock(clock),
        .reset(reset),
        .data_in(data_in),
        .data_out(data_out_temp),
        .write_enable(w_en)
    );

    // Instantiate FIFO Core Buffer
    fifo_8_8 fifo_inst (
        .clock(clock),
        .reset(reset),
        .write_enable(w_en),
        .read_enable(r_en),
        .data_in(data_out_temp),
        .data_out(data_out_fifo),
        .full(fifo_full),
        .empty(fifo_empty)
    );

    // Instantiate Module B (Consumer)
    mod_b mod2 (
        .clock(clock),
        .reset(reset),
        .data_in(data_out_fifo),
        .data_out(data_out),
        .read_enable(r_en)
    );

endmodule