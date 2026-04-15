`timescale 1ns/1ps

module tb_frontdoor;
    reg clk;
    reg rst;

    // Frontdoor program load signals
    reg        prog_we;
    reg [7:0]  prog_addr;
    reg [31:0] prog_data;

    // Instantiate SoC
    soc_top dut (
        .clk(clk),
        .rst(rst),
        .prog_we(prog_we),
        .prog_addr(prog_addr),
        .prog_data(prog_data)
    );

    // Clock = 100MHz (10ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Frontdoor transmission scenario
    initial begin
        $display("==================================================");
        $display("   STARTING FRONTDOOR BUS FIRMWARE LOAD TEST      ");
        $display("==================================================");

        // 1. Hold CPU in Reset state
        rst = 1;
        prog_we = 0;
        prog_addr = 0;
        prog_data = 0;
        #20;

        // 2. LOAD FIRMWARE SEQUENTIALLY (Clock by Clock)
        $display("[+] Loading instruction 1: ADDI x1, x0, 10");
        @(posedge clk);
        prog_we = 1;
        prog_addr = 8'd0;
        prog_data = 32'h00A00093;

        $display("[+] Loading instruction 2: ADDI x2, x0, 20");
        @(posedge clk);
        prog_we = 1;
        prog_addr = 8'd1;
        prog_data = 32'h01400113;

        $display("[+] Loading instruction 3: ADD x3, x1, x2");
        @(posedge clk);
        prog_we = 1;
        prog_addr = 8'd2;
        prog_data = 32'h002081B3;

        $display("[+] Loading instruction 4: BEQ x0, x0, 0 (Loop)");
        @(posedge clk);
        prog_we = 1;
        prog_addr = 8'd3;
        prog_data = 32'h00000063;

        // Disable Write Enable after loading finishes
        @(posedge clk);
        prog_we = 0;
        $display("[+] Firmware loading complete!");

        // 3. Release Reset to let CPU run the code
        #20;
        rst = 0;
        $display("[+] Reset = 0 asserted. CPU is running code...");

        // Wait ~15 clock cycles for Pipeline execution
        #150;

        // 4. Verify the outcome by peeking into register x3
        $display("==================================================");
        if (dut.cpu_core.regfile_inst.regs[3] === 32'd30) begin
            $display("   [PASS] Frontdoor successful! x3 = 30 (10 + 20)");
        end else begin
            $display("   [FAIL] Expected x3=30, got %0d (Load or CPU Error)", dut.cpu_core.regfile_inst.regs[3]);
        end
        $display("==================================================");

        $finish;
    end

    // Dump VCD waves
    initial begin
        $dumpfile("tb_frontdoor.vcd");
        $dumpvars(0, tb_frontdoor);
    end

endmodule
