`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:41:17 08/03/2021
// Design Name:   Alaarm
// Module Name:   E:/GRADUATION PROJECT/Projects/Alarm/Alarm_tb.v
// Project Name:  Alarm
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Alaarm
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Alarm_tb;

	// Inputs
	reg reset;
	reg CLK;
	reg Load_time;
	reg Load_Alarm;
	reg Stop_Alarm;
	reg Alarm_on;
	reg [1:0] Hour_in1;
	reg [3:0] Hour_in0;
	reg [3:0] Min_in1;
	reg [3:0] Min_in0;

	// Outputs
	wire Alarm;
	wire [1:0] Hour_out1;
	wire [3:0] Hour_out0;
	wire [3:0] Min_out1;
	wire [3:0] Min_out0;
	wire [3:0] Sec_out1;
	wire [3:0] Sec_out0;

	// Instantiate the Unit Under Test (UUT)
	Alaarm uut (
		.reset(reset), 
		.CLK(CLK), 
		.Load_time(Load_time), 
		.Load_Alarm(Load_Alarm), 
		.Stop_Alarm(Stop_Alarm), 
		.Alarm_on(Alarm_on), 
		.Hour_in1(Hour_in1), 
		.Hour_in0(Hour_in0), 
		.Min_in1(Min_in1), 
		.Min_in0(Min_in0), 
		.Alarm(Alarm), 
		.Hour_out1(Hour_out1), 
		.Hour_out0(Hour_out0), 
		.Min_out1(Min_out1), 
		.Min_out0(Min_out0), 
		.Sec_out1(Sec_out1), 
		.Sec_out0(Sec_out0)
	);

	initial
	begin
		CLK = 0;
		forever #50 CLK=~CLK;
	end
	
	initial
	begin
		$dumpfile("Up_Dn_Counter.vcd") ;
		$dumpvars ;
		// Initialize Inputs
		reset = 0;		
		Load_time = 0;
		Load_Alarm = 0;
		Stop_Alarm = 0;
		Alarm_on = 0;
		Hour_in1 = 0;
		Hour_in0 = 0;
		Min_in1 = 0;
		Min_in0 = 0;
		
		$display ("TEST CASE 1") ;
		#10
		reset = 1;		
		Load_time = 0;
		Load_Alarm = 0;
		Stop_Alarm = 0;
		Alarm_on = 0;
		Hour_in1 = 1;
		Hour_in0 = 0;
		Min_in1 = 1;
		Min_in0 = 4;
		
		$display (Hour_out1," " ,Hour_out0," ");

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

