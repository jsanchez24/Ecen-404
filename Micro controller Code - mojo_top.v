module mojo_top(
    // 50MHz clock input
    input clk,
    // Input from reset button (active low)
    input rst_n,
    // cclk input from AVR, high when AVR is ready
    input cclk,
    // Outputs to the 8 onboard LEDs
    output  [7:0]led,
    // AVR SPI connections
    output spi_miso,
    input spi_ss,
    input spi_mosi,
    input spi_sck,
    // AVR ADC channel select
    output [3:0] spi_channel,
    output s1a,s2a,s3a,s4a,s1b,s2b,s3b,s4b,s1c,s2c,s3c,s4c,
    output  s1s3,s2s4,
    // Serial connections
    input avr_tx, // AVR Tx => FPGA Rx
    output avr_rx, // AVR Rx => FPGA Tx
    input avr_rx_busy // AVR Rx buffer full
    );

  wire rst = ~rst_n; // make reset active high

// wires to connect from the top mojo file to other files
  wire square_wave;
  wire PWM,PWM2,PWM3,PWM_1,PWM_2,PWM_3;
  reg [3:0] real_channel;
  wire [3:0] channel;
  wire new_sample;
  wire [9:0] sample;
  wire [3:0] sample_channel;
  reg [2:0] channel_ctr;
  reg [3:0] sample_d;
  wire posvoltage,negvoltage,posvoltage_2,negvoltage_2,posvoltage_3,negvoltage_3;
 
  
 // Instantiation of avr_interface
  avr_interface avr_interface (
    .clk(clk),
    .rst(rst),
    .cclk(cclk),
    .spi_miso(spi_miso),
    .spi_mosi(spi_mosi),
    .spi_sck(spi_sck),
    .spi_ss(spi_ss),
    .spi_channel(spi_channel),
    .tx(avr_rx),
    .rx(avr_tx),
    .channel(channel),
    .new_sample(new_sample),
    .sample(sample),
    .sample_channel(sample_channel),
    .tx_data(8'hxx),
    .new_tx_data(1'b0),
    .tx_busy(),
    .tx_block(avr_rx_busy),
    .rx_data(),
    .new_rx_data()
  );
  // Instantiation of input_caputre
     input_capture input_capture (
    .clk(clk),
    .rst(rst),
    .channel(channel),
    .new_sample(new_sample),
    .sample(sample),
    .sample_channel(sample_channel),
    .posvoltage(posvoltage),
    .negvoltage(negvoltage),
    .posvoltage_2(posvoltage_2),
    .negvoltage_2(negvoltage_2),
    .posvoltage_3(posvoltage_3),
    .negvoltage_3(negvoltage_3)
  );
  // Instantiation of pulse
  pulse pulse(
    .clk(clk),
    .rst(rst),
    .PWM(PWM),
    .PWM2(PWM2),
    .PWM3(PWM3),
    .PWM_1(PWM_1),
    .PWM_2(PWM_2),
    .PWM_3(PWM_3)
    );
    // Instantiation of primary_side
    primary_side primary_side(
    .clk(clk),
    .rst(rst),
    .s1s3(s1s3),
    .s2s4(s2s4),
    .square_wave(square_wave)
    );
    // Instantiation of secondary_side
    secondary_side secondary_side(
    .clk(clk),
    .rst(rst),
    .PWM(PWM),
    .PWM2(PWM2),
    .PWM3(PWM3),
    .PWM_1(PWM_1),
    .PWM_2(PWM_2),
    .PWM_3(PWM_3),
    .posvoltage(posvoltage),
    .negvoltage(negvoltage),
    .posvoltage_2(posvoltage_2),
    .negvoltage_2(negvoltage_2),
    .posvoltage_3(posvoltage_3),
    .negvoltage_3(negvoltage_3),
    .square_wave(square_wave),
    .s1a(s1a),
    .s2a(s2a),
    .s3a(s3a),
    .s4a(s4a),
    .s1b(s1b),
    .s2b(s2b),
    .s3b(s3b),
    .s4b(s4b),
    .s1c(s1c),
    .s2c(s2c),
    .s3c(s3c),
    .s4c(s4c),
    .led(led)
    );
endmodule
