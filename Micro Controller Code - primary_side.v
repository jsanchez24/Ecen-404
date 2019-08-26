module primary_side (
    input clk,  // clock
    input rst,  // reset
    output reg s1s3,
    output reg s2s4,
    output reg [4:0] square_wave
  );


 reg [27:0] count = 0;
 reg primary_clk = 0;
//Sets the output signal freqeuncy to 1 kHz
 always @(posedge clk)begin // Slows down 50 Mhz to 1 kHz 
   if(count == 500) begin
     count = 0;
     primary_clk = ~primary_clk;
     end
   else begin
     count = count + 1;
     end
 end
//Square Wave Generator 
always @(posedge primary_clk)begin
	if(square_wave == 1)begin // If Square wave is positive 
		square_wave = -1; // Then is must know be negative 
	end
	else begin
		square_wave = 1; // If its negative then it must know be positive 
	end
end
//Switch Controls Based on Square Wave
always @(posedge primary_clk)begin
	if(square_wave == 1)begin // If high Square Wave
     s1s3 = 1; // Then Switch 1 and 3 is on
     s2s4 = 0; // Then Switch 2 and 4 is off
	end
	else begin // If Square Wave is low or negative 
     s1s3 = 0; // Then Switch 1 and Switch 3 are off
     s2s4 = 1; // And Switch 2 and Switch 4 are on
	   end
   end

endmodule	
