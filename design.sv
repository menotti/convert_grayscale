module convert_pixel(clk, rst, data_o, done);
  input clk, rst;
  output [23:0] data_o;
  output reg done;
  
  reg [9:0] addr;
  wire [23:0] data;
  
  sram #(10, 24, 600, "ram_pixel.hex") mem(clk, addr, 0, 0, data); 
  gray conv(data, data_o);
  
  always@(posedge clk, posedge rst)
    if (rst) begin
      addr <= 0;
      done <= 0;
    end
  	else begin
      addr <= addr + 1;
      if (addr >= 600) 
        done <= 1;
    end
endmodule

module convert_line(clk, rst, data_o, done);
  input clk, rst;
  output [719:0] data_o;
  output reg done;
  
  reg [4:0] addr;
  wire [719:0] data;
  
  sram #(5, 720, 20, "ram_line.hex") mem(clk, addr, 0, 0, data); 
  genvar i; 
  generate
    for (i=0; i<720; i+=24)  
      gray conv(data[i+23:i], data_o[i+23:i]);
  endgenerate; 
  
  always@(posedge clk, posedge rst)
    if (rst) begin
      addr <= 0;
      done <= 0;
    end
  	else begin
      addr <= addr + 1;
      if (addr >= 20) 
        done <= 1;
    end
endmodule

module gray(i_rgb, o_rgb);
  input  [23:0] i_rgb;
  output [23:0] o_rgb;

  wire [9:0] rgb;
  
  assign rgb = (i_rgb[23:16]+(i_rgb[15:8]<<1)+i_rgb[7:0])>>2;
  assign o_rgb = {rgb[7:0], rgb[7:0], rgb[7:0]};
endmodule
  
module sram #(parameter ADDR_WIDTH = 8, DATA_WIDTH = 32, DEPTH = 256, filename = "ram.hex") (
    input wire i_clk,
    input wire [ADDR_WIDTH-1:0] i_addr, 
    input wire i_write,
    input wire [DATA_WIDTH-1:0] i_data,
    output reg [DATA_WIDTH-1:0] o_data 
    );
  
    reg [DATA_WIDTH-1:0] memory_array [0:DEPTH-1]; 
  
    initial
      $readmemh(filename, memory_array);

    always @ (posedge i_clk)
    begin
        if(i_write) begin
            memory_array[i_addr] <= i_data;
        end
        else begin
            o_data <= memory_array[i_addr];
        end     
    end
endmodule
 
