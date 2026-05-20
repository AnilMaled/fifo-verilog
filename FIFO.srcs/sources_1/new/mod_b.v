module mod_b (
    input wire clock,
    input wire reset,
    input wire [7:0] data_in,
    output reg [7:0] data_out,
    output reg read_enable
);

  //FSM cancept
    parameter IDLE       = 2'b00;
    parameter S1         = 2'b01;
    parameter DATA_STATE = 2'b10;

    reg [1:0] ps, ns;

    
    always @(posedge clock) begin
        if (reset) begin
            ps <= IDLE;
        end else begin
            ps <= ns;
        end
    end

   
    always @(*) begin
        case (ps)
            IDLE:       ns = S1;
            S1:         ns = DATA_STATE;
            DATA_STATE: ns = IDLE;
            default:    ns = IDLE;
        endcase
    end

    // Output and Control Signal Assignments
    always @(posedge clock) begin
        if (reset) begin
            read_enable <= 1'b0;
            data_out    <= 8'h00;
        end else begin
            if (ns == DATA_STATE) begin
                read_enable <= 1'b1;
                data_out    <= data_in;
            end else begin
                read_enable <= 1'b0;
            end
        end
    end

endmodule