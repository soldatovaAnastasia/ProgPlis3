`timescale 1us/1ns
`include "top_1.v"
`ifdef USE_REF
`include "blocks_dut.v"
`include "top_1_ref.v"
`else
`include "blocks_dut_stb.v"
`endif

module tb_top_1;

    localparam CLK_PERIOD = 10;

    reg clk;
    initial clk = 1'b0;
    always #(CLK_PERIOD/2) clk = ~clk;

`ifdef USE_REF
    // ---- комплект DUT-ов для stb ----
    reg         stb_counter_rst;
    wire [15:0] stb_counter_count;
    wire        stb_counter_done;
    wire [15:0] stb_counter_code;
    wire        stb_counter_code_valid;

    reg  [4:0] stb_rom_addr;
    wire [15:0] stb_rom_data;

    reg         stb_ram_we;
    reg  [31:0] stb_ram_addr;
    reg  [15:0] stb_ram_data_in;
    wire [15:0] stb_ram_data_out;
    wire [15:0] stb_ram_done_code;
    wire        stb_ram_done_valid;

    reg  [4:0]  stb_alu_op;
    reg  [31:0] stb_alu_a;
    reg  [31:0] stb_alu_b;
    wire [31:0] stb_alu_result_raw;
    wire        stb_alu_flag;
    wire [15:0] stb_alu_code;
    wire        stb_alu_code_valid;

    counter_dut u_stb_counter (
        .clk          (clk),
        .rst_i        (stb_counter_rst),
        .count_o      (stb_counter_count),
        .done_o       (stb_counter_done),
        .code_o       (stb_counter_code),
        .code_valid_o (stb_counter_code_valid)
    );

    rom_dut u_stb_rom (
        .addr_i (stb_rom_addr),
        .data_o (stb_rom_data)
    );

    ram_dut u_stb_ram (
        .clk          (clk),
        .we_i         (stb_ram_we),
        .addr_i       (stb_ram_addr),
        .data_i       (stb_ram_data_in),
        .data_o       (stb_ram_data_out),
        .done_code_o  (stb_ram_done_code),
        .done_valid_o (stb_ram_done_valid)
    );

    alu_dut u_stb_alu (
        .op_i     (stb_alu_op),
        .a_i      (stb_alu_a),
        .b_i      (stb_alu_b),
        .result_o (stb_alu_result_raw),
        .flag_o   (stb_alu_flag)
    );

    alu_checker_dut u_stb_alu_checker (
        .clk          (clk),
        .op_i         (stb_alu_op),
        .a_i          (stb_alu_a),
        .b_i          (stb_alu_b),
        .code_o       (stb_alu_code),
        .code_valid_o (stb_alu_code_valid)
    );

`else
    // ---- комплект DUT-ов для stb ----
    reg         stb_counter_rst;
    wire [15:0] stb_counter_count;
    wire        stb_counter_done;
    wire [15:0] stb_counter_code;
    wire        stb_counter_code_valid;

    reg  [4:0] stb_rom_addr;
    wire [15:0] stb_rom_data;

    reg         stb_ram_we;
    reg  [31:0] stb_ram_addr;
    reg  [15:0] stb_ram_data_in;
    wire [15:0] stb_ram_data_out;
    wire [15:0] stb_ram_done_code;
    wire        stb_ram_done_valid;

    reg  [4:0]  stb_alu_op;
    reg  [31:0] stb_alu_a;
    reg  [31:0] stb_alu_b;
    wire [31:0] stb_alu_result_raw;
    wire        stb_alu_flag;
    wire [15:0] stb_alu_code;
    wire        stb_alu_code_valid;

    counter_dut_stb u_stb_counter (
        .clk          (clk),
        .rst_i        (stb_counter_rst),
        .count_o      (stb_counter_count),
        .done_o       (stb_counter_done),
        .code_o       (stb_counter_code),
        .code_valid_o (stb_counter_code_valid)
    );

    rom_dut_stb u_stb_rom (
        .addr_i (stb_rom_addr),
        .data_o (stb_rom_data)
    );

    ram_dut_stb u_stb_ram (
        .clk          (clk),
        .we_i         (stb_ram_we),
        .addr_i       (stb_ram_addr),
        .data_i       (stb_ram_data_in),
        .data_o       (stb_ram_data_out),
        .done_code_o  (stb_ram_done_code),
        .done_valid_o (stb_ram_done_valid)
    );

    alu_dut_stb u_stb_alu (
        .op_i     (stb_alu_op),
        .a_i      (stb_alu_a),
        .b_i      (stb_alu_b),
        .result_o (stb_alu_result_raw),
        .flag_o   (stb_alu_flag)
    );


`endif

`ifdef USE_REF
    // ---- комплект DUT-ов для ref ----
    reg         ref_counter_rst;
    wire [15:0] ref_counter_count;
    wire        ref_counter_done;
    wire [15:0] ref_counter_code;
    wire        ref_counter_code_valid;

    reg  [4:0] ref_rom_addr;
    wire [15:0] ref_rom_data;

    reg         ref_ram_we;
    reg  [31:0] ref_ram_addr;
    reg  [15:0] ref_ram_data_in;
    wire [15:0] ref_ram_data_out;
    wire [15:0] ref_ram_done_code;
    wire        ref_ram_done_valid;

    reg  [4:0]  ref_alu_op;
    reg  [31:0] ref_alu_a;
    reg  [31:0] ref_alu_b;
    wire [31:0] ref_alu_result_raw;
    wire        ref_alu_flag;
    wire [15:0] ref_alu_code;
    wire        ref_alu_code_valid;

    counter_dut u_ref_counter (
        .clk          (clk),
        .rst_i        (ref_counter_rst),
        .count_o      (ref_counter_count),
        .done_o       (ref_counter_done),
        .code_o       (ref_counter_code),
        .code_valid_o (ref_counter_code_valid)
    );

    rom_dut u_ref_rom (
        .addr_i (ref_rom_addr),
        .data_o (ref_rom_data)
    );

    ram_dut u_ref_ram (
        .clk          (clk),
        .we_i         (ref_ram_we),
        .addr_i       (ref_ram_addr),
        .data_i       (ref_ram_data_in),
        .data_o       (ref_ram_data_out),
        .done_code_o  (ref_ram_done_code),
        .done_valid_o (ref_ram_done_valid)
    );

    alu_dut u_ref_alu (
        .op_i     (ref_alu_op),
        .a_i      (ref_alu_a),
        .b_i      (ref_alu_b),
        .result_o (ref_alu_result_raw),
        .flag_o   (ref_alu_flag)
    );

    alu_checker_dut u_ref_alu_checker (
        .clk          (clk),
        .op_i         (ref_alu_op),
        .a_i          (ref_alu_a),
        .b_i          (ref_alu_b),
        .code_o       (ref_alu_code),
        .code_valid_o (ref_alu_code_valid)
    );

`endif
    wire [15:0] stb_counter_result;
    wire [63:0] stb_counter_timestamp;
    wire [15:0] stb_rom_result;
    wire [63:0] stb_rom_timestamp;
    wire [15:0] stb_ram_result;
    wire [63:0] stb_ram_timestamp;
    wire [15:0] stb_alu_result;
    wire [63:0] stb_alu_timestamp;

    top_1 u_stb (
        .clk                  (clk),
        .counter_rst_o        (stb_counter_rst),
        .counter_count_i      (stb_counter_count),
        .counter_done_i       (stb_counter_done),
        .counter_code_i       (stb_counter_code),
        .counter_code_valid_i (stb_counter_code_valid),
        .rom_addr_o           (stb_rom_addr),
        .rom_data_i           (stb_rom_data),
        .ram_we_o             (stb_ram_we),
        .ram_addr_o           (stb_ram_addr),
        .ram_data_o           (stb_ram_data_in),
        .ram_data_i           (stb_ram_data_out),
        .ram_done_code_i      (stb_ram_done_code),
        .ram_done_valid_i     (stb_ram_done_valid),
        .alu_op_o             (stb_alu_op),
        .alu_a_o              (stb_alu_a),
        .alu_b_o              (stb_alu_b),
        .alu_result_i         (stb_alu_result_raw),
        .alu_flag_i           (stb_alu_flag),
        .alu_code_i           (stb_alu_code),
        .alu_code_valid_i     (stb_alu_code_valid),
        .counter_result_o     (stb_counter_result),
        .counter_timestamp_o  (stb_counter_timestamp),
        .rom_result_o         (stb_rom_result),
        .rom_timestamp_o      (stb_rom_timestamp),
        .ram_result_o         (stb_ram_result),
        .ram_timestamp_o      (stb_ram_timestamp),
        .alu_result_o         (stb_alu_result),
        .alu_timestamp_o      (stb_alu_timestamp)
    );

`ifdef USE_REF
    wire [15:0] ref_counter_result;
    wire [63:0] ref_counter_timestamp;
    wire [15:0] ref_rom_result;
    wire [63:0] ref_rom_timestamp;
    wire [15:0] ref_ram_result;
    wire [63:0] ref_ram_timestamp;
    wire [15:0] ref_alu_result;
    wire [63:0] ref_alu_timestamp;

    top_1_ref u_ref (
        .clk                  (clk),
        .counter_rst_o        (ref_counter_rst),
        .counter_count_i      (ref_counter_count),
        .counter_done_i       (ref_counter_done),
        .counter_code_i       (ref_counter_code),
        .counter_code_valid_i (ref_counter_code_valid),
        .rom_addr_o           (ref_rom_addr),
        .rom_data_i           (ref_rom_data),
        .ram_we_o             (ref_ram_we),
        .ram_addr_o           (ref_ram_addr),
        .ram_data_o           (ref_ram_data_in),
        .ram_data_i           (ref_ram_data_out),
        .ram_done_code_i      (ref_ram_done_code),
        .ram_done_valid_i     (ref_ram_done_valid),
        .alu_op_o             (ref_alu_op),
        .alu_a_o              (ref_alu_a),
        .alu_b_o              (ref_alu_b),
        .alu_result_i         (ref_alu_result_raw),
        .alu_flag_i           (ref_alu_flag),
        .alu_code_i           (ref_alu_code),
        .alu_code_valid_i     (ref_alu_code_valid),
        .counter_result_o     (ref_counter_result),
        .counter_timestamp_o  (ref_counter_timestamp),
        .rom_result_o         (ref_rom_result),
        .rom_timestamp_o      (ref_rom_timestamp),
        .ram_result_o         (ref_ram_result),
        .ram_timestamp_o      (ref_ram_timestamp),
        .alu_result_o         (ref_alu_result),
        .alu_timestamp_o      (ref_alu_timestamp)
    );

`endif
`ifdef USE_REF
    integer errors;
    initial errors = 0;

    reg checked_counter;
    initial checked_counter = 1'b0;
    always @(stb_counter_result or stb_counter_timestamp or ref_counter_result or ref_counter_timestamp) begin
        if (!$isunknown(stb_counter_result) && !$isunknown(stb_counter_timestamp) &&
            !$isunknown(ref_counter_result) && !$isunknown(ref_counter_timestamp)) begin
            checked_counter = 1'b1;
            if (stb_counter_result !== ref_counter_result || stb_counter_timestamp !== ref_counter_timestamp) begin
                $display("FAIL [COUNTER]: student value=%0d time=%0d  / reference value=%0d time=%0d",
                         stb_counter_result, stb_counter_timestamp, ref_counter_result, ref_counter_timestamp);
                errors = errors + 1;
            end else begin
                $display("PASS [COUNTER]: value=%0d  time=%0d", stb_counter_result, stb_counter_timestamp);
            end
        end
    end

    reg checked_rom;
    initial checked_rom = 1'b0;
    always @(stb_rom_result or stb_rom_timestamp or ref_rom_result or ref_rom_timestamp) begin
        if (!$isunknown(stb_rom_result) && !$isunknown(stb_rom_timestamp) &&
            !$isunknown(ref_rom_result) && !$isunknown(ref_rom_timestamp)) begin
            checked_rom = 1'b1;
            if (stb_rom_result !== ref_rom_result || stb_rom_timestamp !== ref_rom_timestamp) begin
                $display("FAIL [ROM]: student value=%0d time=%0d  / reference value=%0d time=%0d",
                         stb_rom_result, stb_rom_timestamp, ref_rom_result, ref_rom_timestamp);
                errors = errors + 1;
            end else begin
                $display("PASS [ROM]: value=%0d  time=%0d", stb_rom_result, stb_rom_timestamp);
            end
        end
    end

    reg checked_ram;
    initial checked_ram = 1'b0;
    always @(stb_ram_result or stb_ram_timestamp or ref_ram_result or ref_ram_timestamp) begin
        if (!$isunknown(stb_ram_result) && !$isunknown(stb_ram_timestamp) &&
            !$isunknown(ref_ram_result) && !$isunknown(ref_ram_timestamp)) begin
            checked_ram = 1'b1;
            if (stb_ram_result !== ref_ram_result || stb_ram_timestamp !== ref_ram_timestamp) begin
                $display("FAIL [RAM]: student value=%0d time=%0d  / reference value=%0d time=%0d",
                         stb_ram_result, stb_ram_timestamp, ref_ram_result, ref_ram_timestamp);
                errors = errors + 1;
            end else begin
                $display("PASS [RAM]: value=%0d  time=%0d", stb_ram_result, stb_ram_timestamp);
            end
        end
    end

    reg checked_alu;
    initial checked_alu = 1'b0;
    always @(stb_alu_result or stb_alu_timestamp or ref_alu_result or ref_alu_timestamp) begin
        if (!$isunknown(stb_alu_result) && !$isunknown(stb_alu_timestamp) &&
            !$isunknown(ref_alu_result) && !$isunknown(ref_alu_timestamp)) begin
            checked_alu = 1'b1;
            if (stb_alu_result !== ref_alu_result || stb_alu_timestamp !== ref_alu_timestamp) begin
                $display("FAIL [ALU]: student value=%0d time=%0d  / reference value=%0d time=%0d",
                         stb_alu_result, stb_alu_timestamp, ref_alu_result, ref_alu_timestamp);
                errors = errors + 1;
            end else begin
                $display("PASS [ALU]: value=%0d  time=%0d", stb_alu_result, stb_alu_timestamp);
            end
        end
    end

`endif

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, tb_top_1);
        $display("=== Checking variant 409605 ===");

`ifdef USE_REF
        wait (!$isunknown(ref_counter_timestamp) && !$isunknown(ref_rom_timestamp) &&
              !$isunknown(ref_ram_timestamp) && !$isunknown(ref_alu_timestamp));
        #(50 * CLK_PERIOD);

        if (!checked_counter) begin
            $display("FAIL [COUNTER]: top_1 does not set result (timeout)");
            errors = errors + 1;
        end
        if (!checked_rom) begin
            $display("FAIL [ROM]: top_1 does not set result (timeout)");
            errors = errors + 1;
        end
        if (!checked_ram) begin
            $display("FAIL [RAM]: top_1 does not set result (timeout)");
            errors = errors + 1;
        end
        if (!checked_alu) begin
            $display("FAIL [ALU]: top_1 does not set result (timeout)");
            errors = errors + 1;
        end

        if (errors == 0)
            $display("PASS: All tests of the variant passed successfully.");
        else
            $display("FAIL: Errors found: %0d", errors);
`else
        #(100 * CLK_PERIOD);
        $display("Simulation finished. Check counter/rom/ram/alu result_o/timestamp_o in GTKWave (waveform.vcd).");
`endif

        $finish;
    end

endmodule // tb_top_1
