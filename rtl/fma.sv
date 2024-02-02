module fma #(
    parameter DATA_WIDTH = 8,
    parameter WEIGHT_WIDTH = 8,
    parameter VECTOR_WIDTH = 4,
    parameter OUTPUT_WIDTH = 16
) (
    input logic clk, rstn, mode;

    // input from previous layer
    input signed logic [DATA_WIDTH-1:0] val_in [VECTOR_WIDTH-1:0];

    // weight from current layer
    input signed logic [WEIGHT_WIDTH-1:0] weight_in [VECTOR_WIDTH-1:0];

    // bias from current layer
    input signed logic [OUTPUT_WIDTH-1:0] bias_in [VECTOR_WIDTH-1:0];

    // output to next layer
    output signed logic [OUTPUT_WIDTH-1:0] sum_out [VECTOR_WIDTH-1:0];
);
    // first stage of pipeline -- product
    logic [OUTPUT_WIDTH-1:0] prod_reg [VECTOR_WIDTH-1:0];

    // second stage of pipeline -- sum
    logic [OUTPUT_WIDTH-1:0] partial_sum [VECTOR_WIDTH-1:0];

    genvar vind;

    // generate vectorized FMA hardware
    for (vind = 0; vind < VECTOR_WIDTH; vind++) begin
        always @(posedge clk) begin
            
            // initialize pipeline regs to 0
            if (rstn == 1'b0) begin
                partial_sum[vind] <= OUTPUT_WIDTH'b0;
                prod_reg[vind] <= OUTPUT_WIDTH'b0;
            end
            else begin
                case (mode)

                    // initialize partial sum with bias
                    1'b0: partial_sum[vind] <= bias_in[vind];

                    // add product to sum
                    1'b1: partial_sum[vind] <= partial_sum[vind] + prod_reg[vind];
                endcase

                // weight * input product -- first stage of pipeline
                prod_reg[vind] <= val_in[vind] * weight_in[vind];
            end
        end
    end

endmodule