`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.09.2022 23:54:56
// Design Name: 
// Module Name: computing_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module instruction_memory #(
        int WIDTH = 32,
        int DEPTH = 64
    )(
        input logic [$clog2(DEPTH)-1:0] program_counter,
        output logic [WIDTH-1:0] instruction
    );
    
    logic [WIDTH - 1:0] ROM [DEPTH - 1:0];
    
    initial  $readmemb("D:/stud_projs/Vivado/RTL/test_data.mem", ROM);
        
    assign Data = ROM[program_counter];
    
endmodule
