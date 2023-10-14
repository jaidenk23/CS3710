`timescale 1ns/100ps
////////////////////////////////////////////////////////////////////////////////
// Jaiden Kazemini
//   u0895422
//
// ECE3710 - Mini MIPS
//
// Module Name:   C:\intelFPGA_lite\18.1\quartus\3710_lab\miniMips\exmem.v
// Project Name:  miniMips
// 
//
////////////////////////////////////////////////////////////////////////////////

module exmem #(parameter DATA_WIDTH=8, parameter ADDR_WIDTH=8)
(
    input  [(DATA_WIDTH-1):0] data,
    input  [(ADDR_WIDTH-1):0] addr,
    input                     we, clk,
    output reg [(DATA_WIDTH-1):0] q
);

    // Declare the RAM variable
    reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

    // Mocking the I/O devices
    reg [DATA_WIDTH-1:0] switches;
    reg [DATA_WIDTH-1:0] LEDs;

    // Variable to hold the read address
    reg [ADDR_WIDTH-1:0] addr_reg;

    // RAM initialization
    initial begin
        $display("Loading memory");
        $readmemb("C:\\intelFPGA_lite\\18.1\\quartus\\3710_lab\\miniMips\\fib-new.dat", ram);
        $display("done loading");
    end

    always @(posedge clk) begin
        // Checking if the operation is for I/O space or regular memory
        if (addr[ADDR_WIDTH-1:ADDR_WIDTH-2] == 2'b11) begin
            if (we) LEDs <= data;    // Writing to LEDs if it's a write operation
            addr_reg <= addr;
        end else begin
            if (we) ram[addr] <= data;   // Normal memory operation
            addr_reg <= addr;
        end
    end

    // Continuous assignment for reading
    always @(*) begin
        if (addr_reg[ADDR_WIDTH-1:ADDR_WIDTH-2] == 2'b11) 
            q = switches;  // Reading from I/O space: Fetch switches value
        else
            q = ram[addr_reg];  // Reading from regular memory
    end
endmodule

