`timescale 1ns/100ps
////////////////////////////////////////////////////////////////////////////////
// Jaiden Kazemini
//   u0895422
//
// ECE3710 - Mini MIPS
//
// Module Name:   C:\intelFPGA_lite\18.1\quartus\3710_lab\miniMips\mips.v
// Project Name:  miniMips
// 
//
////////////////////////////////////////////////////////////////////////////////


module mips(
    input clk, reset,
    output reg [7:0] LED,     
    input [7:0] switch_data  
);

    // Parameters
    parameter WIDTH = 8;
    parameter REGBITS = 3;

    // Signals
    wire [7:0] memdata;
    wire memwrite;
    wire [7:0] adr;
    wire [7:0] writedata;

    // Instantiate the mipscpu
    miniMips #(WIDTH, REGBITS) cpu_inst (
        .clk(clk),
        .reset(reset),
        .memdata(memdata),
        .memwrite(memwrite),
        .adr(adr),
        .writedata(writedata)
    );

    // Instantiate the exmem
    exmem #(WIDTH, REGBITS) mem_inst (
        .data(writedata),
        .addr(adr),
        .we(memwrite),
        .clk(clk),
        .q(memdata)
    );

    // Handle Memory-Mapped I/O
    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            LED <= 8'b0;
        end else if (adr[7:6] == 2'b11 && memwrite) begin  // Check if accessing memory-mapped I/O space for write
            LED <= writedata;  // Update LEDs
        end
    end

    // Mock the switch input for memory-mapped I/O read operation
    assign memdata = (adr[7:6] == 2'b11 && !memwrite) ? switch_data : memdata;

endmodule
