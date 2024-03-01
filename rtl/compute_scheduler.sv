/*
 * Scheduler for doing computing of actual neural network values
 * Uses circular buffers for caching input and output data
 */
module compute_scheduler #(
    parameter IO_DATA_WIDTH,
    parameter IO_ADDR_WIDTH,
    parameter DATA_WIDTH,
    parameter WEIGHT_WIDTH,
    parameter VECTOR_WIDTH,
    parameter DATA_BUFFER_DEPTH, // depth of input / output data buffer
    parameter WEIGHT_BUFFER_DEPTH // depth of input weight buffer
) (
    input clk,
    input rstn,
    input [IO_DATA_WIDTH-1:0] data_in,
    output [IO_ADDR_WIDTH-1:0] data_req_addr
);
    localparam DATA_BUF_ADDR_WIDTH = $clog2(DATA_BUFFER_DEPTH);
    localparam WEIGHT_BUF_ADDR_WIDTH = $clog2(WEIGHT_BUFFER_DEPTH);

    // input data buffer signals
    logic [DATA_BUF_ADDR_WIDTH-1:0] in_data_buf_usage;
    logic [DATA_BUF_ADDR_WIDTH-1:0] in_data_write_addr;
    logic [DATA_BUF_ADDR_WIDTH-1:0] in_data_read_addr;

    // input weight buffer signals
    logic [WEIGHT_BUF_ADDR_WIDTH-1:0] in_weight_buf_usage;
    logic [WEIGHT_BUF_ADDR_WIDTH-1:0] in_weight_write_addr;
    logic [WEIGHT_BUF_ADDR_WIDTH-1:0] in_weight_read_addr;

    // output data buffer signals
    logic [DATA_BUF_ADDR_WIDTH-1:0] out_data_buf_usage;
    logic [DATA_BUF_ADDR_WIDTH-1:0] out_data_write_addr;
    logic [DATA_BUF_ADDR_WIDTH-1:0] out_data_read_addr;

    // input bias buffer signals
    logic [DATA_BUF_ADDR_WIDTH-1:0] in_bias_buf_usage;
    logic [DATA_BUF_ADDR_WIDTH-1:0] in_bias_write_addr;
    logic [DATA_BUF_ADDR_WIDTH-1:0] in_bias_read_addr;

    always_ff @(posedge clk) begin
        if (rstn == 1'b0) begin
            in_data_buf_usage = 'b0;
            in_data_write_addr = 'b0;
            in_data_read_addr = 'b0;

            in_weight_buf_usage = 'b0;
            in_weight_write_addr = 'b0;
            in_weight_read_addr = 'b0;

            out_data_buf_usage = 'b0;
            out_data_write_addr = 'b0;
            out_data_read_addr = 'b0;

            in_bias_buf_usage = 'b0;
            in_bias_write_addr = 'b0;
            in_bias_read_addr = 'b0;
        end
        else begin
            
        end
    end
endmodule