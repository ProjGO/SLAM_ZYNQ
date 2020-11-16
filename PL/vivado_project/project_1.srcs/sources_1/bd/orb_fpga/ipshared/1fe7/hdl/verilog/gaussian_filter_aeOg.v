
`timescale 1 ns / 1 ps

  module gaussian_filter_aeOg_DSP48_3(clk, rst, ce, a, b, p);
input clk;
input rst;
input ce;
input [17 - 1 : 0] a;
input [7 - 1 : 0] b;
output [24 - 1 : 0] p;

reg [24 - 1 : 0] p_reg; 

reg [17 - 1 : 0] a_reg; 
reg [7 - 1 : 0] b_reg; 

reg [24 - 1 : 0] p_reg_tmp; 

always @ (posedge clk) begin
    if (ce) begin
        a_reg <= a;
        b_reg <= b;
        p_reg_tmp <= $unsigned (a_reg) * $unsigned (b_reg);
        p_reg <= p_reg_tmp;
    end
end

assign p = p_reg;

endmodule
`timescale 1 ns / 1 ps
module gaussian_filter_aeOg(
    clk,
    reset,
    ce,
    din0,
    din1,
    dout);

parameter ID = 32'd1;
parameter NUM_STAGE = 32'd1;
parameter din0_WIDTH = 32'd1;
parameter din1_WIDTH = 32'd1;
parameter dout_WIDTH = 32'd1;
input clk;
input reset;
input ce;
input[din0_WIDTH - 1:0] din0;
input[din1_WIDTH - 1:0] din1;
output[dout_WIDTH - 1:0] dout;



gaussian_filter_aeOg_DSP48_3 gaussian_filter_aeOg_DSP48_3_U(
    .clk( clk ),
    .rst( reset ),
    .ce( ce ),
    .a( din0 ),
    .b( din1 ),
    .p( dout ));

endmodule

