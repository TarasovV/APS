`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.09.2022 14:47:40
// Design Name: 
// Module Name: register_file
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


module register_file #(int N = 32)(
    input           clk,
    input           WE3,
    input  logic    [4:0]RA1,
    input  logic    [4:0]RA2,
    input  logic    [4:0]WA3,
    
    output logic    [N-1:0]RD1,
    output logic    [N-1:0]RD2,
    input  logic    [N-1:0]WD3
    );
    
logic [N-1:0] RAM [0:N-1];

assign RD1 = RAM[RA1];
assign RD2 = RAM[RA2];

always_ff @(posedge clk)
begin
    if (WE3)
        begin
        RAM[WA3] <= WD3;
        end
end

endmodule
