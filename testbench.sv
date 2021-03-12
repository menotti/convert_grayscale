`timescale 100ms / 100ms

module test;
  logic clk, rst, done;
  //wire [23:0] pixel;
  wire [719:0] line;

  //convert_pixel dut(clk, rst, pixel, done);
  convert_line  dut(clk, rst, line, done);
 
  always 
  begin
    clk = 0;
    #5 clk = 1;
    #5 
    $display("%h", line); // discard 1st line! 
    //$display("%h", pixel); // discard 1st line! 
  end
  
  always @(posedge done) begin
    $display("Testbench finished at %0t!", $time);
    #10
    $finish;
  end
    
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
         rst = 1;
    #10  rst = 0;
  end
endmodule
