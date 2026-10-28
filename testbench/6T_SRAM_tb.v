
`timescale 1ns / 1ps

module tb_sram_6t;

    // Testbench signals
    reg WL;
    reg WE;
    reg tb_bl_drive;
    reg tb_bl_bar_drive;
    reg write_data_val;

    wire BL;
    wire BL_bar;

    // External bit-line drivers
    assign BL = (tb_bl_drive) ? write_data_val : 1'bz;

    assign BL_bar = (tb_bl_bar_drive) ? ~write_data_val : 1'bz;

    // Instantiate SRAM cell
    sram_6t_cell uut (
        .WL(WL),
        .WE(WE),
        .BL(BL),
        .BL_bar(BL_bar)
    );

    initial begin

        // INITIALIZATION
        WL = 0;
        WE = 0;
        tb_bl_drive = 0;
        tb_bl_bar_drive = 0;
        write_data_val = 0;

        #10;

        // TEST 1: WRITE 1
        WE = 1;
        write_data_val = 1;
        tb_bl_drive = 1;
        tb_bl_bar_drive = 1;

        #10;
        WL = 1;

        #20;
        WL = 0;
        tb_bl_drive = 0;
        tb_bl_bar_drive = 0;

        #20;

        // TEST 2: HOLD 1
        WE = 0;
        #20;

        // TEST 3: READ 1
        WE = 0;
        WL = 1;

        #20;
        WL = 0;

        #20;

        // TEST 4: WRITE 0
        WE = 1;
        write_data_val = 0;
        tb_bl_drive = 1;
        tb_bl_bar_drive = 1;

        #10;
        WL = 1;

        #20;
        WL = 0;
        tb_bl_drive = 0;
        tb_bl_bar_drive = 0;

        #20;

        // TEST 5: READ 0
        WE = 0;
        WL = 1;

        #20;
        WL = 0;

        #20;

        $finish;

    end

endmodule
