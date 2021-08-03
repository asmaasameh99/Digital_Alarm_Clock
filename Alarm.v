`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:53:36 08/03/2021 
// Design Name: 
// Module Name:    Alaarm 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Alaarm(
    input reset,
    input CLK,
    input Load_time,
    input Load_Alarm,
    input Stop_Alarm,
    input Alarm_on,
    input [1:0] Hour_in1,
    input [3:0] Hour_in0,
    input [3:0] Min_in1,
    input [3:0] Min_in0,
    output reg Alarm,
	 output [1:0] Hour_out1,
	 output [3:0] Hour_out0,
	 output [3:0] Min_out1,
	 output [3:0] Min_out0,
	 output [3:0] Sec_out1,
	 output [3:0] Sec_out0
    );


///// internal signals /////

reg CLK_1s;
reg [3:0] temp_1s;
reg [4:0] temp_Hour;
reg [5:0] temp_Min;
reg [5:0] temp_Sec;

reg [1:0] Clock_Hour1,Alarm_Hour1;
reg [3:0] Clock_Hour0,Alarm_Hour0;

reg [3:0] Clock_Min1,Alarm_Min1;
reg [3:0] Clock_Min0,Alarm_Min0;

reg [3:0] Clock_Sec1,Alarm_Sec1;
reg [3:0] Clock_Sec0,Alarm_Sec0;




////////////// Clock Operation //////////////////////

always @(posedge CLK_1s or posedge reset)
begin
	if(reset)
	begin
		//Set all alarm to zero//
		Alarm_Hour1<= 0;
		Alarm_Hour0<=0;
		Alarm_Min0<=0;
		Alarm_Min1<=0;
		Alarm_Sec1<=0;
		Alarm_Sec0<=0;
		temp_Hour<=Hour_in1*10+Hour_in0;
		temp_Min<=Min_in1*10+Min_in0;
		temp_Sec<=0;
	end
	else
	begin
		
		if(Load_Alarm)
		begin
			Alarm_Hour1<=Hour_in1;
			Alarm_Hour0<=Hour_in0;
			Alarm_Min1<=Min_in1;
			Alarm_Min0<=Min_in0;
			Alarm_Sec1<=0;
			Alarm_Sec0<=0;
		end
		
		if(Load_time)
		begin
			temp_Hour<=Hour_in1*10+Hour_in0;
			temp_Min<=Min_in1*10+Min_in0;
			temp_Sec<=0;
		end
		
		else 
		begin
			temp_Sec<=temp_Sec+1;
			
			if(temp_Sec>=59)
			begin
				temp_Min<=temp_Min+1;
				temp_Sec<=0;
			
			
				if(temp_Min>=59)
				begin
					temp_Hour<=temp_Hour+1;
					temp_Min<=0;
			
			
					if(temp_Hour>=24)
					begin
						temp_Hour<=0;
					end
				end
			end	
		end
		
	end
end



//////////////// Create 1_S clock/////////////////////

always @(posedge CLK or posedge reset)
begin
	
	if(reset)
	begin
		temp_1s<=0;
		CLK_1s<=0;
	end
	
	else
	begin
		temp_1s<=temp_1s+1;
		
		if(temp_1s<=5)
			CLK_1s<=0;
		else if(temp_1s>=10)
		begin
			CLK_1s<=1;
			temp_1s<=1;
		end
		else
		CLK_1s<=1;
		
	end
	
end


//////////////// OUTPUT of Clock ////////////////////////

always @(*)
begin
	
	///// Calculating Hour ////////////////
	if(temp_Hour>=20)
	begin
		Clock_Hour1=2;
	end
	else 
	begin
		if ( temp_Hour>=10)
			Clock_Hour1=1;
		else
			Clock_Hour1=0;
	end 
	
	Clock_Hour0=temp_Hour-Clock_Hour1*10;
	
	//// Calculating Minutes//////////////
	if(temp_Min>50)
		Clock_Min1=5;
	else if (temp_Min>40 )
		Clock_Min1=4;
	else if (temp_Min>30 )
		Clock_Min1=3;
	else if (temp_Min>20 )
		Clock_Min1=2;
	else if (temp_Min>10 )
		Clock_Min1=1;
	else 
		Clock_Min1=0;
		
	Clock_Min0=temp_Min-Clock_Min1*10;
	
	//// Calculating Seconds//////////////
	if(temp_Sec>50)
		Clock_Sec1=5;
	else if (temp_Sec>40 )
		Clock_Sec1=4;
	else if (temp_Sec>30 )
		Clock_Sec1=3;
	else if (temp_Sec>20 )
		Clock_Sec1=2;
	else if (temp_Sec>10 )
		Clock_Sec1=1;
	else 
		Clock_Sec1=0;
		
	Clock_Sec0=temp_Sec-Clock_Sec1*10;	
	
end

assign Hour_Out1=Clock_Hour1;
assign Hour_Out0=Clock_Hour0;

assign Min_Out1=Clock_Min1;
assign Min_Out0=Clock_Min0;

assign Sec_Out1=Clock_Sec1;
assign Sec_Out0=Clock_Sec0;


/////////// Set Alarm ////////////////////

always @ (posedge CLK_1s or posedge reset)
begin
	if(reset)
		Alarm<=0;
	else 
	begin
		if ({Alarm_Hour1,Alarm_Hour0,Alarm_Min1,Alarm_Min0,Alarm_Sec1,Alarm_Sec0}=={Clock_Hour1,Clock_Hour0,Clock_Min1,Clock_Min0,Clock_Sec1,Clock_Sec0})
		begin
			if(Alarm_on)
				Alarm<=1;
		end
		
		if (Stop_Alarm)
			Alarm<=0;
		
	end
	
end


endmodule
