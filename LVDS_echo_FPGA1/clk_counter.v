module clk_counter(
input wire CLK,
input wire RST_N,
//Avalon Bus interface
input wire read,
output [31:0] readdata
);

reg [31:0] counter;

assign readdata = counter;

always@(posedge CLK)
begin
    if(RST_N == 1'b0) begin
        counter = 32'h00000000;
    end
    else begin
        counter = counter + 1'b1;
    end
end

endmodule

