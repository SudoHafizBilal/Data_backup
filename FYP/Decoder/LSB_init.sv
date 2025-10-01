module LBS_init #(
    parameter Z = 52,        
    parameter Q = 6          
)(
    input  logic                  clk,
    input  logic                  rst,
    input  logic                  enable,
    input  logic [Q-1:0]          data_in [Z],
    input  logic [$clog2(Z)-1:0]  shift_amount,
    output logic [Q-1:0]          data_out [Z]
);

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            for (int i = 0; i < Z; i++) begin
                data_out[i] <= '0;
            end
        end
        else if (enable) begin
            for (int i = 0; i < Z; i++) begin
                data_out[i] <= data_in[(i + shift_amount) % Z];
            end
        end
    end

endmodule