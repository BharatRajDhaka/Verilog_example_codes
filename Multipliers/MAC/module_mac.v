module mac(
	input clk,
	input rst,
	input [3:0] a,
	input [3:0] b,
	output reg [11:0] A_reg
);


	always @(posedge clk or posedge rst) begin
		if (rst) begin
			A_reg <= 12'b000000000000;
		end

		else begin
			A_reg <= A_reg + (a*b);
		end
	end
endmodule

