module fifo_8_8 (
    input wire clock,
    input wire reset,
    input wire write_enable,
    input wire read_enable,
    input wire [7:0] data_in,
    output reg [7:0] data_out,
    output wire full,
    output wire empty
);

    
    reg [7:0] mem [0:7]; //8:8 mem
    
   
    reg [2:0] write_pointer;
    reg [2:0] read_pointer;
    
    integer i;

   //full means all mem read //empty will 1 when 
    assign full  = ((write_pointer + 1'b1) == read_pointer) ? 1'b1 : 1'b0;
    assign empty = (write_pointer == read_pointer) ? 1'b1 : 1'b0;

   
    always @(posedge clock) begin
        if (reset)
         begin
            write_pointer <= 3'b000;
            read_pointer  <= 3'b000;
            data_out      <= 8'h00;
            for (i = 0; i < 8; i = i + 1) begin
                mem[i] <= 8'h00;
            end
        end 
        else 
        begin
            
          
            if (write_enable && !full)
             begin
                mem[write_pointer] <= data_in;
                write_pointer      <= write_pointer + 1'b1;
            end
            
           
            if (read_enable && !empty) 
            begin
                data_out     <= mem[read_pointer];
                read_pointer <= read_pointer + 1'b1;
           
            end
        end
    end

endmodule