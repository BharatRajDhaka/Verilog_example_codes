module booth_multiplier (
	input clk,
	input rst,
	input start,
	input [3:0] M_in,
	input [3:0] Q_in,
	output reg [7:0] product,
	output reg done
);

	reg [3:0] M;
	reg [3:0] Q;
	reg [3:0] A;
	reg Q_m1;
	reg [1:0] count;

	parameter IDLE = 3'b000,
		  CHECK = 3'b001,
		  ALU = 3'b010,
		  SHIFT = 3'b011,
		  DONE = 3'b100;

	reg [2:0] current_state, next_state;

	always @(posedge clk or negedge rst) begin
		if (rst) begin
			current_state <= IDLE;
			A <= 4'b0000;
			Q <= 4'b0000;
			M <= 4'b0000;
			Q_m1 <= 1'b0;
			product <= 8'b00000000;
			count <= 2'b00;
			done <= 1'b0;
		end else begin
			current_state <= next_state;

		case (current_state)
			IDLE: begin
				done <= 1'b0;
				if (start) begin
					A <= 4'b0000;
					Q <= Q_in;
					Q_m1 <= 1'b0;
					M <= M_in;
					count <= 2'b00;
				end
			end

			CHECK: begin

			end

			ALU: begin
				case ({Q[0], Q_m1})
					2'b01: A <= A + M;
					2'b10: A <= A + (~M + 1);
					default: A <= A;
				endcase
			end

			SHIFT: begin
				{A, Q, Q_m1} <= {A[3], A, Q};
				count <= count + 1'b1;
			end

			DONE: begin
				product <= {A, Q};
				done <= 1'b1;
			end
		endcase
		end
	end

	always @(*) begin
		next_state = current_state;
	
		case (current_state)
			IDLE: begin 
				if (start)
					next_state = CHECK;
			end

			CHECK: begin
				next_state = ALU;
			end

			ALU: begin
				next_state = SHIFT;
			end

			SHIFT: begin
				if (count == 2'b11)
					next_state = DONE;
				else
					next_state = CHECK;
			end

			DONE: begin
				next_state = IDLE;
			end

			default: next_state = IDLE;
		endcase
	end
endmodule

