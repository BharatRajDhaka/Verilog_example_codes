module psa_multiplier (
	input clk,
	input rst,
	input start,
	input [3:0] M_in,
	input [3:0] Q_in,
	output reg [7:0] product,
	output reg done
);

	reg [3:0] M;
	reg [3:0] A;
	reg [3:0] Q;
	reg carry;
	reg [1:0] count;

	parameter IDLE = 2'b00,
		  ADD = 2'b01,
		  SHIFT = 2'b10,
		  DONE = 2'b11;

	reg [1:0] current_state, next_state;

	always @(posedge clk or posedge rst) begin
		if (rst)
			current_state <= IDLE;
		else
			current_state <= next_state;
	end

	always @(*) begin
		case (current_state)
			IDLE: next_state = start ? ADD: IDLE;
			ADD: next_state = SHIFT;
			SHIFT: next_state = (count == 2'b11) ? DONE : ADD;
			DONE: next_state = IDLE;
			default: next_state = IDLE;
		endcase
	end

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			M <= 4'b0;
			A <= 4'b0;
			Q <= 4'b0;
			carry <= 1'b0;
			count <= 2'b0;
			done <= 1'b0;
			product <= 8'b0;
		end else begin
			case (current_state)
				IDLE: begin
					if (start) begin
						M <= M_in;
						Q <= Q_in;
						A <= 4'b0;
						carry <= 1'b0;
						count <= 2'b0;
						done <= 1'b0;
					end
				end

				ADD: begin
					if (Q[0] == 1'b1) begin
						{carry, A} <= A + M;
					end
				end

				SHIFT: begin
					{carry, A, Q} <= {1'b0, carry, A, Q[3:1]};
					count <= count + 1'b1;
				end

				DONE: begin
					product <= {A, Q}; 
					done <= 1'b1;
				end
			endcase
		end
	end
endmodule

