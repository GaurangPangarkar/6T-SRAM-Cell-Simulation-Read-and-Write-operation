`timescale 1ns / 1ps

module sram_6t_cell (
    input wire WL,
    input wire WE,
    inout wire BL,
    inout wire BL_bar
);

    reg stored_bit = 1'b0;

    // Write operation
    always @(posedge WL) begin
        if (WE) begin
            stored_bit <= BL;
        end
    end

    // Read operation
    assign BL = (WL && !WE) ? stored_bit : 1'bz;

    assign BL_bar = (WL && !WE) ? ~stored_bit : 1'bz;

endmodule