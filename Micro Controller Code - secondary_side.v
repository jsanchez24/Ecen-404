module secondary_side (
      input clk,  // clock
      input rst,  // reset
      input posvoltage,negvoltage,posvoltage_2,negvoltage_2,posvoltage_3,negvoltage_3,
      input square_wave,
      input PWM, // PWM 1 positive sin 1
      input PWM2,// PWM 2 positive sin 2
      input PWM3,// PWM 3 positive sin 3
      input PWM_1,// PWM 1 negative sin 1
      input PWM_2,// PWM 2 negative sin 2
      input PWM_3,// PWM 3 negative sin 3
   
      output reg s1a,s2a,s3a,s4a,s1b,s2b,s3b,s4b,s1c,s2c,s3c,s4c,
      output reg [7:0] led  
    );
  reg [10:0] State = 51;
  reg limit = 0;
  reg [27:0] count;
  reg clk_state = 0;
  //Sets the ouput signals to be set at a frequency of 60 Hz
  always @(posedge clk)begin
    count = count + 1;
    if(count ==  833333)begin // Set the frequency to 60 Hz from 50 MHz
      clk_state = ~ clk_state;
    end
  end 
  //State Machine To Control the ac-ac board
  always @(posedge clk_state)begin
    if(rst == 1)begin
      State = 51; 
     end 
    else begin
      State = State;
    end
  case(State)
    51:begin
      s1a = PWM;
      s2a = 0;
      s3a = 1 - PWM;
      s4a = 0;
      s1b = 1 - PWM_2;
      s2b = 0;
      s3b = PWM_2;
      s4b = 0;
      s1c = 1 - PWM_3;
      s2c = 0;
      s3c = PWM_3;
      s4c = 0;
      led = 8'b00010001;
        if(square_wave < 0 && negvoltage_3 > limit)begin
          State = 52;
        end
        else if(posvoltage_3 > limit && negvoltage_2 > limit && posvoltage > limit)begin
          State = 41;
        end
        else begin
          State = 51;
        end
      end
    41:begin
      s1a = PWM;
      s2a = 0;
      s3a = 1 - PWM;
      s4a = 0;
      s1b = 1 - PWM_2;
      s2b = 0;
      s3b = PWM_2;
      s4b = 0;
      s1c = PWM3;
      s2c = 0;
      s3c = 1 - PWM3;
      s4c = 0;
      led = 8'b00001001;
      if(negvoltage > limit && negvoltage_2 > limit && posvoltage_3 > limit)begin
        State = 31;
      end
      else if (square_wave < 0 && posvoltage > limit)begin
        State = 42;
      end
      else begin
        State  = 41;
      end
     end
    31:begin
      s1a = 1-PWM_1;
      s2a = 0;
      s3a = PWM_1;
      s4a = 0;
      s1b = 1 - PWM_2;
      s2b = 0;
      s3b = PWM_2;
      s4b = 0;
      s1c = PWM3;
      s2c = 0;
      s3c = 1 - PWM3;
      s4c = 0;
      led = 8'b00000101;
      if(posvoltage_2 > limit && posvoltage_3 > limit && negvoltage > limit)begin
        State = 21;
      end
      else if(square_wave < 0 && negvoltage_2 > limit) begin
        State = 32;
      end
      else begin
        State = 31;  
      end
     end
    21:begin
      s1a = 1 - PWM_1;
      s2a = 0;
      s3a = PWM_1;
      s4a = 0;
      s1b = PWM2;
      s2b = 0;
      s3b = 1 - PWM2;
      s4b = 0;
      s1c = PWM3;
      s2c = 0;
      s3c = 1 - PWM3;
      s4c = 0;
      led = 8'b00000011;
      if(negvoltage_3 > limit && negvoltage > limit && posvoltage_2 > limit)begin
        State = 11;
      end
      else if(square_wave > 0 && posvoltage_3 > limit) begin
         State = 22;
      end
      else begin
        State = 21;
      end
     end
    11:begin
      s1a = 1 - PWM_1;
      s2a = 0;
      s3a = PWM_1;
      s4a = 0;
      s1b = PWM2;
      s2b = 0;
      s3b = 1 - PWM2;
      s4b = 0;
      s1c = 1 - PWM_3;
      s2c = 0;
      s3c = PWM_3;
      s4c = 0;
      led = 8'b00000001;
      if(posvoltage > limit && posvoltage_2 > limit && negvoltage_3 > limit)begin
        State = 61;
      end
      else if(square_wave < 0 && negvoltage > limit)begin
        State = 12;
      end
      else begin
        State = 11;
      end
     end
    61:begin
      s1a = PWM;
      s2a = 0;
      s3a = 1 - PWM;
      s4a = 0;
      s1b = PWM2;
      s2b = 0;
      s3b = 1 - PWM2;
      s4b = 0;
      s1c = 1 - PWM_3;
      s2c = 0;
      s3c = PWM_3;
      s4c = 0;
      led = 8'b00100001;
      if(negvoltage_2 > limit && negvoltage_3 > limit && posvoltage > limit)begin
        State = 51;
      end
      else if(square_wave < 0 && posvoltage_2 > limit) begin
        State = 62;
      end
      else begin
        State = 61;
      end
     end
    62:begin
      s1a = 0;
      s2a = PWM;
      s3a = 0;
      s4a = 1 - PWM;
      s1b = 0;
      s2b = PWM2;
      s3b = 0;
      s4b = 1 - PWM2;
      s1c = 0;
      s2c = 1 - PWM_3;
      s3c = 0;
      s4c = PWM_3;
      led = 8'b00100010;
      if(negvoltage_2 > limit && negvoltage_3 > limit && posvoltage > limit)begin
        State = 52;
      end 
      else if(square_wave > 0 && posvoltage_2 > limit)begin
        State = 61;
      end
      else begin
        State = 62;
      end
     end
    52:begin
      s1a = 0;
      s2a = PWM;
      s3a = 0;
      s4a = 1 - PWM;
      s1b = 0;
      s2b = 1 - PWM_2;
      s3b = 0;
      s4b = PWM_2;
      s1c = 0;
      s2c = 1 - PWM_3;
      s3c = 0;
      s4c = PWM_3;
      led = 8'b00010010;
      if(posvoltage_3 > limit && negvoltage_2 > limit && posvoltage > limit)begin
        State = 42;
      end
      else if(square_wave > 0 && negvoltage_3 > limit)begin
        State = 51;
      end
      else begin
        State = 52;
      end
     end
    42:begin
      s1a = 0;
      s2a = PWM;
      s3a = 0;
      s4a = 1 - PWM;
      s1b = 0;
      s2b = 1 - PWM_2;
      s3b = 0;
      s4b = PWM_2;
      s1c = 0;
      s2c = PWM3;
      s3c = 0;
      s4c = 1 - PWM3;
      led = 8'b00001010;
      if(negvoltage > limit && negvoltage_2 > limit && posvoltage_3 > limit)begin
        State = 32;
      end
      else if(square_wave > 0 && posvoltage > limit)begin
        State = 41;
      end 
      else begin
        State = 42;
      end
     end
    32:begin
      s1a = 0;
      s2a = 1 - PWM_1;
      s3a = 0;
      s4a = PWM_1;
      s1b = 0;
      s2b = 1 - PWM_2;
      s3b = 0;
      s4b = PWM_2;
      s1c = 0;
      s2c = PWM3;
      s3c = 0;
      s4c = 1 - PWM3;
      led = 8'b00000110;
      if(posvoltage_2 > limit && posvoltage_3 > limit && negvoltage > limit) begin
        State = 22;
      end
      else if(square_wave > 0 && posvoltage > limit)begin
        State = 31;
      end
      else begin
        State = 32;
      end
     end
    22:begin
      s1a = 0;
      s2a = 1 - PWM_1;
      s3a = 0;
      s4a = PWM_1;
      s1b = 0;
      s2b = PWM2;
      s3b = 0;
      s4b = 1 - PWM2;
      s1c = 0;
      s2c = PWM3;
      s3c = 0;
      s4c = 1 - PWM3;
      led = 8'b00000010;
      if(negvoltage_3 > limit && negvoltage > limit && posvoltage_2 > limit)begin
        State = 12;
      end
      else if(square_wave > 0 && posvoltage_3 > limit)begin
        State = 21;
      end
      else begin
        State = 22;
      end
     end
    12:begin
      s1a = 0;
      s2a = 1 - PWM_1;
      s3a = 0;
      s4a = PWM_1;
      s1b = 0;
      s2b = PWM2;
      s3b = 0;
      s4b = 1 - PWM2;
      s1c = 0;
      s2c = 1 - PWM_3;
      s3c = 0;
      s4c = PWM_3;
      led = 8'b11000000;
      if(posvoltage > limit && posvoltage_2 > limit && negvoltage_3 > limit)begin
        State = 62;
      end
      else if(square_wave > 0 && negvoltage > limit)begin
        State = 11;
      end
      else begin
        State = 12;
      end
    end
  endcase
  end
  
  endmodule
