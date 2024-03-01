module activation_function #(
    parameter IP_DATA_WIDTH,
    parameter OP_DATA_WIDTH
) (
    input af_control AF_CONTROL,                //Control Signal for AF
    input [IP_DATA_WIDTH - 1 : 0] IP_DATA,      //Input Data
    output [OP_DATA_WIDTH - 1 : 0] OP_DATA      //Output Data
);
    localparam WIDTH_DIFFERENCE = IP_DATA_WIDTH - OP_DATA_WIDTH;  //Assume Input Width is Greater than or Equal to Output Width
    always @(*) begin
        case (AF_CONTROL)
            //ReLu Operation
            ReLu: begin
                OP_DATA = (IP_DATA[IP_DATA_WIDTH - 1] == 1'b0) ? (IP_DATA[IP_DATA_WIDTH - 1 : WIDTH_DIFFERENCE]) : 0;
            end
            //Default to output of 0
            default: begin
                OP_DATA = 0;
            end
        endcase
    end
endmodule