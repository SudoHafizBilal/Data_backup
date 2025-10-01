module read_network #(
    parameter Z  = 4,          // lifting size
    parameter Q  = 6,          // APP value width
    parameter DC = 6,          // max check node degree (VNs per layer)
    parameter NB = 52          // total VN groups
)(
    input  logic                     clk,
    input  logic                     rst,
    
    // Input APP memory
    input  logic [Q-1:0] app_mem [NB][Z],
    
    // Layer-specific inputs
    input  logic [$clog2(NB)-1:0]    col_indices [DC],     // indices of active VN groups
    input  logic [$clog2(Z)-1:0]     shift_values [DC],    // shift values from H_B

    // Outputs to LBS
    output logic [Q-1:0]             app_out [DC][Z],      // selected APP values
    output logic [$clog2(Z)-1:0]     shift_out [DC]        // shift values
);

    always_comb begin
        for (int i = 0; i < DC; i++) begin
            for (int j = 0; j < Z; j++) begin
                app_out[i][j] = app_mem[col_indices[i]][j];
            end
            shift_out[i] = shift_values[i];
        end
    end

endmodule
