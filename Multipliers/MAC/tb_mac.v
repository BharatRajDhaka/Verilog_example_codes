module tb_mac;

	reg clk;
	reg rst;
	reg [3:0] a;
	reg [3:0] b;
	wire [11:0] A_reg;

	mac dut (
		.clk(clk),
		.rst(rst),
		.a(a),
		.b(b),
		.A_reg(A_reg)
);

	always begin
		#5 clk = ~clk;
	end

	initial begin
		clk = 0;
		rst = 1;
		a = 4'b0000;
		b = 4'b0000;
		
		#5;
		rst = 0;
		#5;

		a = 4'b1000;
		b = 4'b0010;
		#10;
		$display("Time=%0t | a=%b b=%b | A_reg=%b", $time, a, b, A_reg);

		a = 4'b0010;
		b = 4'b0010;
		#10;
		$display("Time=%0t | a=%b b=%b | A_reg=%b", $time, a, b, A_reg);		

		#10;
		$finish;
	end

	initial begin
		$dumpfile("mac_sim.vcd");
		$dumpvars(0, tb_mac);
	end
endmodule

