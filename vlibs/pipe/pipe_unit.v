module pipe_unit #(
    parameter DATA_WIDTH = 64
)(
    input                       clk             ,
    input                       rstn            ,
    input [DATA_WIDTH - 1:0]    data_in         ,
    input                       data_in_vld     ,
    output                      data_in_rdy     ,
    output [DATA_WIDTH - 1:0]   data_out        ,
    output                      data_out_vld    ,
    input                       data_out_rdy    
);

reg [DATA_WIDTH - 1:0] pipe_data;
reg pipe_valid;
wire pipe_ready;
wire pipe_ready_bc;

//## pipe (2) valid-ready-bubble-collapse
assign pipe_ready_bc = pipe_ready || !pipe_valid;

always @(posedge clk or negedge rstn) begin
  if (!rstn) begin
    pipe_valid <= 1'b0;
  end else begin
  pipe_valid <= (pipe_ready_bc)? data_in_vld : 1'd1;
  end
end
always @(posedge clk) begin
// VCS sop_coverage_off start
  pipe_data <= (pipe_ready_bc && data_in_vld)? data_in[DATA_WIDTH - 1:0] : pipe_data;
// VCS sop_coverage_off end
end

assign  data_in_rdy = pipe_ready_bc;

//## pipe (2) output
assign data_out_vld = pipe_valid;
assign pipe_ready = data_out_rdy;
assign data_out[DATA_WIDTH - 1:0] = pipe_data;

endmodule