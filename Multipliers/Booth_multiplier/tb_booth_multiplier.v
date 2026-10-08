module tb_booth_multiplier;

	reg clk;
	reg rst;
	reg start;
	reg [3:0] M_in;
	reg [3:0] Q_in;
	wire [7:0] product;
	wire done;

	booth_multiplier dut (
		.clk(clk),
		.rst(rst),
		.start(start),
		.M_in(M_in),
		.Q_in(Q_in),
		.product(product),
		.done(done)
);

	always begin
      		#5 clk = ~clk;
  end

	initial begin
		clk = 0;
		rst = 1;
		start = 0;
		M_in = 4'b0000;
		Q_in = 4'b0000;

		#5;
		rst = 0;
		#5;

		M_in = 4'b1011;
		Q_in = 4'b1100;
		start = 1;
		#10;
		start = 0;
		wait(done == 1'b1);
		#1;
		$display("Time=%0t | M_in=%b Q_in=%b | Product=%b", $time, M_in, Q_in, product);
      
      		M_in = 4'b1111;
		Q_in = 4'b1111;
		start = 1;
		#10;
		start = 0;
		wait(done == 1'b1);
		#1;
		$display("Time=%0t | M_in=%b Q_in=%b | Product=%b", $time, M_in, Q_in, product);

		#10;
		$finish;
	end

	initial begin
		$dumpfile("simulation.vcd");
		$dumpvars(0, tb_booth_multiplier);
	end
endmodule

