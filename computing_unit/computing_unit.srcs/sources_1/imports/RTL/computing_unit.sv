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

module computing_unit #(
        int N = 32
)(
    
    logic rst
    //input 
    );


logic [5:0]SW = 5'b00000;
logic clk = 1'b0;
logic [N-1:0]program_counter;
logic [4:0]RA1;
logic [4:0]RA2;
logic [4:0]WA3;
logic [3:0]ALUControl;
logic [7:0]constant;

logic [N-1:0]RD1;    
logic [N-1:0]RD2;
logic [N-1:0]WD3;
logic [N-1:0]Result;
logic [N-1:0]instruction;
logic [N-1:0]A;
logic [N-1:0]B;

logic Flag;    
logic WE3;
   
logic [N-1:0]constant_extended = (32'hFFFFFF00 + constant[7:0]);
logic PC_control = ((Flag && instruction[30]) || instruction[31]);

assign A = RD1;
assign B = RD2;

import ALUOps::*;

ALU alu(
    .A(A),
    .B(B),
    .ALUControl(ALUControl),
    .Flag(Flag),
    .Result(Result)
);

instruction_memory memory_stack(
    .program_counter(program_counter[4:0]),
    .instruction(instruction)
);

register_file register_instruction(
    .clk(clk),
    .WE3(WE3),
    .RA1(RA1),
    .RA2(RA2),
    .WA3(WA3),
    .RD1(RD1),
    .RD2(RD2),
    .WD3(WD3)
);

initial forever begin
      SW[5:0] = SW[5:0] + 1'b1;
      #5; clk = 1'b1;
      #5; clk = 1'b0;
end

always_ff @(posedge clk)
    begin
        case(instruction[28:27])
        2'b00 : WD3[N-1:0] = constant_extended[32:0];
        2'b01 : WD3[N-1:0] = SW[5:0];
        2'b10 : WD3[N-1:0] = Result[N-1:0];
        endcase
       
    end
     
 always_ff @(posedge clk)  
    begin 
        case(PC_control)
        1'b0 : program_counter[N-1:0] = program_counter[N-1:0] + 1'b1;
        1'b1 : program_counter[N-1:0] = program_counter[N-1:0] + constant_extended[31:0];
        endcase
    end    
always_ff @(posedge clk)  
    begin 

        WE3 = instruction[29];

        ALUControl[3:0] = instruction[26:23];   
        RA1[4:0] = instruction[22:18];
        RA2[4:0] = instruction[17:13];
        WA3[4:0] = instruction[12:8];
        constant[7:0] = instruction[7:0];
    end           
endmodule
