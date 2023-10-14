`timescale 1ns/100ps
////////////////////////////////////////////////////////////////////////////////
// Jaiden Kazemini
//   u0895422
//
// ECE3710 - Mini MIPS
//
// Module Name:   C:\intelFPGA_lite\18.1\quartus\3710_lab\miniMips\tb_miniMips.v
// Project Name:  miniMips
// 
//
////////////////////////////////////////////////////////////////////////////////
module tb_miniMips;

    reg clk;
    reg reset;
    wire [7:0] memdata;
    wire memwrite;
    wire [7:0] adr;           
    wire [7:0] adr_monitor;   
    wire [7:0] writedata;
    reg [7:0] i;

    // Instantiate miniMips module
    miniMips uut (
        .clk(clk),
        .reset(reset),
        .memdata(memdata),
        .memwrite(memwrite),
        .adr(adr),            
        .writedata(writedata)
    );

    // Monitor 'adr' signal
    assign adr_monitor = adr;

    // Clock Generation
    always begin
        #5 clk = ~clk; 
    end

    // stimulus
    initial begin
        // Initialize
        clk = 0;
        reset = 1;
        #10 reset = 0; 

        // Wait for some time to let Fibonacci computation complete
        #500;

        // Monitor and display Fibonacci numbers from memory
        for(i = 8'd128; i < 8'd142; i = i + 1) begin
            #10; // Wait a little before checking the next memory location
            if(adr_monitor == i)
                $display("Fibonacci(%0d) = %0d", i-8'd128, memdata);
        end

        $finish;
    end

endmodule


