module half_adder (
    input a, b,
    output sum, carry
);
    assign sum = a ^ b;
    assign carry = a & b;
endmodule

module full_adder (
    input a, b, cin,
    output sum, carry
);
    assign sum = a ^ b ^ cin;
    assign carry = (a & b) | (b & cin) | (a & cin);
endmodule

module array_multiplier( 
  input [3:0] A,
  input [3:0] B,
  output [7:0] P
	);

	wire [3:0] p0 = A & {4{B[0]}};
  wire [3:0] p1 = A & {4{B[1]}};
  wire [3:0] p2 = A & {4{B[2]}};
  wire [3:0] p3 = A & {4{B[3]}};

	wire s1, s2, s3, s4, s5, s6;
	wire c1, c2, c3, c4, c5, c6;
	wire c7, c8, c9, c10, c11;

	assign P[0] = p0[0];

	    half_adder ha10 (.a(p0[1]), .b(p1[0]), .sum(P[1]),   .carry(c1));
    	full_adder fa11 (.a(p0[2]), .b(p1[1]), .cin(c1),    .sum(s1), .carry(c2));
    	full_adder fa12 (.a(p0[3]), .b(p1[2]), .cin(c2),    .sum(s2), .carry(c3));
 	    half_adder ha13 (.a(c3), .b(p1[3]), .sum(s3), .carry(c4));
    

	    half_adder ha20 (.a(s1),   .b(p2[0]), .sum(P[2]),   .carry(c5));
    	full_adder fa21 (.a(s2),   .b(p2[1]), .cin(c5),    .sum(s4), .carry(c6));
    	full_adder fa22 (.a(s3),   .b(p2[2]), .cin(c6),    .sum(s5), .carry(c7));
    	full_adder fa23 (.a(c3),   .b(p2[3]), .cin(c7),    .sum(s6), .carry(c8));

	    half_adder ha30 (.a(s4),   .b(p3[0]), .sum(P[3]),   .carry(c9));
    	full_adder fa31 (.a(s5),   .b(p3[1]), .cin(c9),    .sum(P[4]), .carry(c10));
    	full_adder fa32 (.a(s6),   .b(p3[2]), .cin(c10),    .sum(P[5]), .carry(c11));
    	full_adder fa33 (.a(c8),   .b(p3[3]), .cin(c11),    .sum(P[6]), .carry(P[7]));

endmodule


