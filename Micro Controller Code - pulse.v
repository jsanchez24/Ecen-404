module pulse (
    input clk,  // clock
    input rst,  // reset
    output PWM,PWM2,PWM3,PWM_1,PWM_2,PWM_3
    );
reg [11:0] sin = 0; // Sin wave 1 positive 
reg [11:0] sin_1 = 0; //Sin wave 1 negative 
reg [11:0] sin2 = -766; // Sin wave 2 (120 deg) positive 
reg [11:0] sin_2 = -776;// Sin wave 2 (120 deg) negative 
reg [11:0] sin3 = 766; // Sin wave 3 (240 deg) positive 
reg [11:0] sin_3 = 776; // Sin wave 3 (120 deg) negative 
reg [11:0] deg = 0; // Degree Value
reg clk_sin = 0; // Clock for Sin Waves 60 Hz
reg [27:0] count = 0; 
reg [11:0] saw = -1000; // Value for sawtooth 
reg [5:0] count2 = 0;
reg PWM; // PWM 1 positive sin 1
reg PWM2;// PWM 2 positive sin 2
reg PWM3;// PWM 3 positive sin 3
 reg PWM_1;// PWM 1 negative sin 1
 reg PWM_2;// PWM 2 negative sin 2
 reg PWM_3;// PWM 3 negative sin 3

//Clock divider for sin function
always @(posedge clk)begin
   count= count + 1;
	if(count == 833333)begin // Sets the frequency from 60 Hz to 50 MHz 
	    count = 0; // count reset
	    clk_sin <= ~clk_sin; // opposite value of clk_sin
	   end
	end
 //Sawtooth function generator
always @(posedge clk)begin
  if(count2 <10)begin // If count2 is less than 10
     saw = saw + 200; // Saw will increase by 200
     count2 = count2 + 1; // Count2 increases by 1
   end
  else begin // If its not less than 10
	saw = -1000; // Saw Resets to -1000
	count2 = 0; // Count2 resets
   end
end
//Sin function generator 
always @(posedge clk_sin)begin
  if(deg <= 180)begin //Values for sin less than or equal 180 degress
	case(deg)//Case statement for deg values less than or equal to 180 degress
		0: begin
		    sin = 0; // Corresponding sin value in radian
		    sin_1 = 0;
		    sin2 = -866; // New sin value for 120 degrees from original
		    sin_2 = 866;
		    sin3 = 866; // New sin value for 240 degrees from original
		    sin_3 = -866;
		    deg = 10;// New Degree Value
		end
		10: begin
		    sin = 174;
		    sin_1 = -174;
		    sin2 = -940;
		    sin_2 = 940;
		    sin3 = 766;
		    sin_3 = -766;
		    deg = 20;
		end
		20: begin
		    sin = 342;
		    sin_1 = -342;
		    sin2 = -985;
		    sin_2 = 985;
		    sin3 = 643;
		    sin_3 = -643;
		    deg = 30;
		end
		30: begin
		    sin = 500;
		    sin_1 = -500;
		    sin2 = -1000;
		    sin_2 = 1000;
		    sin3 = 500;
		    sin_3 = -500;
		    deg = 40;
		end
		40: begin
		    sin = 643;
		    sin_1 = -643;
		    sin2 = -985;
		    sin_2 = 985;
		    sin3 = 342;
		    sin_3 = -342;
		    deg = 50;
		end
		50: begin
		    sin = 766;
		    sin_1 = -766;
		    sin2 = -940;
		    sin_2 = 940;
		    sin3 = 174;
		    sin_3 = -174;
		    deg = 60;
		end
		60: begin
		    sin = 866;
		    sin_1 = -866;
		    sin2 = -866;
		    sin_2 = 866;
		    sin3 = 0;
		    sin_3 = 0;
		    deg = 70;
		end
		70: begin
		    sin = 940;
		    sin_1 = -940;
		    sin2 = -766;
		    sin_2 = 766;
		    sin3 = -174;
		    sin_3 = 174;
		    deg = 80;
		end
		80: begin
		    sin = 985;
		    sin_1 = -985;
		    sin2 = -643;
		    sin_2 = 643;
		    sin3 = -342;
		    sin_3 = 342;
		    deg = 90;
		end
		90: begin
		    sin = 1000;
		    sin_1 = -1000;
		    sin2 = -500;
		    sin_2 = 500;
		    sin3 = -500;
		    sin_3 = 500;
		    deg = 100;
		end
		100: begin
		    sin = 985;
		    sin_1 = -985;
		    sin2 = -342;
		    sin_2 = 342;
		    sin3 = -643;
		    sin_3 = 643;
		    deg = 110;
		end
		110: begin
		    sin = 940;
		    sin_1 = -940;
		    sin2 = -174;
		    sin_2 = 174;
		    sin3 = -766;
		    sin_3 = 766;
		    deg = 120;
		end
		120: begin
		    sin = 866;
		    sin_1 = -866;
		    sin2 = 0;
		    sin_2 = 0;
		    sin3 = -866;
		    sin_3 = 866;
		    deg = 130;
		end 
		130: begin
		    sin = 766;
		    sin_1 = -766;
		    sin2 = 174;
		    sin_2 = -174;
		    sin3 = -940;
		    sin_3 = 940;
		    deg = 140;
		end
		140: begin
		    sin = 643;
		    sin_1 = -643;
		    sin2 = 342;
		    sin_2 = -342;
		    sin3 = -985;
		    sin_3 = 985;
		    deg = 150;
		end
		150: begin
		    sin = 500;
		    sin_1 = -500;
		    sin2 = 500;
		    sin_2 = -500;
		    sin3 = -1000;
		    sin_3 = 1000;
		    deg = 160;
		end
		160: begin
		    sin = 342;
		    sin_1 = -342;
		    sin2 = 643;
		    sin_2 = -643;
		    sin3 = -985;
		    sin_3 = 985;
		    deg = 170;
		end	
		170: begin
		    sin = 174;
		    sin_1 = -174;
		    sin2 = 766;
		    sin_2 = -766;
		    sin3 = -940;
		    sin_3 = 940;
		    deg = 180;
		end 
		180: begin
		    sin = 0;
		    sin_1 = 0;
		    sin_1 = 0;
		    sin2 = 866;
		    sin_2 = -866;
		    sin3 = -866;
		    sin_3 = 866;
		    deg = 190;
		end
	    endcase
        end
else begin // Values of deg greater than 180
	case(deg)
		190: begin
		    sin = -174;
		    sin_1 = 174;
		    sin2 = 940;
		    sin_2 = -940;
		    sin3 = -766;
		    sin_3 = 766;
		    deg = 200;
		end
		200: begin
		    sin = -342;
		    sin_1 = 342;
		    sin2 = 985;
		    sin_2 = -985;
		    sin3 = -643;
		    sin_3 = 643;
		    deg = 210;
		end
		210: begin
		    sin = -500;
		    sin_1 = 500;
		    sin2 = 1000;
		    sin_2 = -1000;
		    sin3 = -500;
		    sin_3 = 500;
		    deg = 220;
		end
		220: begin
		    sin = -643;
		    sin_1 = 643;
		    sin2 = 985;
		    sin_2 = -985;
		    sin3 = -342;
		    sin_3 = 342;
		    deg = 230;
		end
		230: begin
		    sin = -766;
		    sin_1 = 766;
		    sin2 = 940;
		    sin_2 = -940;
		    sin3 = -174;
		    sin_3 = 174;
		    deg = 240;
		end
		240: begin
		    sin = -866;
		    sin_1 = 866;
		    sin2 = 866;
		    sin_2 = -866;
		    sin3 = 0;
		    sin_3 = 0;
		    deg = 250;
		end
		250: begin
		    sin = -940;
		    sin_1 = 940;
		    sin2 = 766;
		    sin_2 = -766;
		    sin3 = 174;
		    sin_3 = -174;
		    deg = 260;
		end
		260: begin
		    sin = -985;
		    sin_1 = 985;
		    sin2 = 643;
		    sin_2 = -643;
		    sin3 = 342;
		    sin_3 = -342;
		    deg = 270;
		end
		270: begin
		    sin = -1000;
		    sin_1 = 1000;
		    sin2 = 500;
		    sin_2 = -500;
		    sin3 = 500;
		    sin_3 = -500;
		    deg = 280;
		end
		280: begin
		    sin = -985;
		    sin_1 = 985;
		    sin2 = 342;
		    sin_2 = -342;
		    sin3 = 643;
		    sin_3 = -643;
		    deg = 290;
		end
		290: begin
		    sin = -940;
		    sin_1 = 940;
		    sin2 = 174;
		    sin_2 = -174;
		    sin3 = 766;
		    sin_3 = -766;
		    deg = 300;
		end
		300: begin
		    sin = -866;
		    sin_1 = 866;
		    sin2 = 0;
		    sin_2 = 0;
		    sin3 = 866;
		    sin_3 = -866;
		    deg = 310;
		end
		310: begin
		    sin = -766;
		    sin_1 = 766;
		    sin2 = -174;
		    sin_2 = 174;
		    sin3 = 940;
		    sin_3 = -940;
		    deg = 320;
		end
		320: begin
		    sin = -643;
		    sin_1 = 643;
		    sin2 = -342;
		    sin_2 = 342;
		    sin3 = 985;
		    sin_3 = -985;
		    deg = 330;
		end
		330: begin
		    sin = -500;
		    sin_1 = 500;
		    sin2 = -500;
		    sin_2 = 500;
		    sin3 = 1000;
		    sin_3 = -1000;
		    deg = 340;
		end
		340: begin
		    sin = -342;
		    sin_1 = 342;
		    sin2 = -643;
		    sin_2 = 643;
		    sin3 = 985;
		    sin_3 = -985;
		    deg = 350;
		end	
		350: begin
		    sin = -174;
		    sin_1 = 174;
		    sin2 = -766;
		    sin_2 = 766;
		    sin3 = 940;
		    sin_3 = -940;
		    deg = 0;
		end 
	endcase
	end
   end

//Comparing Sawtooth and sin functions
always @(posedge clk)begin 
	if(sin < saw)begin // if sin is less than sawtooth 
		PWM = 1; // PWM will be 1 
	end
	if(sin > saw)begin // if sin is greater than sawtooth
		PWM = 0; // PWM will be  0
	end
	if(sin2 < saw)begin
		PWM2 = 1;
	end
	if(sin2 > saw)begin
		PWM2 = 0;
	end
	if(sin3 < saw)begin
		PWM3 = 1;
	end
	if(sin3 > saw)begin
		PWM3 = 0;
	end
	if(sin_1 < saw)begin
		PWM_1 = 1;
	end
	if(sin_1 > saw)begin
		PWM_1 = 0;
	end
	if(sin_2 < saw)begin
		PWM_2 = 1;
	end
	if(sin_2 > saw)begin
		PWM_2 = 0;
	end
	if(sin_3 < saw)begin
		PWM_3 = 1;
	end
	if(sin_3 > saw)begin
		PWM_3 = 0;
	end
end

endmodule	
