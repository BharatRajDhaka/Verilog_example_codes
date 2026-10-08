module tb_array_multiplier;
    reg [3:0] A;
    reg [3:0] B;
    wire [7:0] P;

    array_multiplier dut (
        .A(A), 
        .B(B), 
        .P(P)
    );

    initial begin
        $monitor("Time=%0t | A=%d B=%d | Product=%d", $time, A, B, P);
   
        A = 4'd0; B = 4'd0; #10;
  
        A = 4'd5; B = 4'd3; #10;

        A = 4'd12; B = 4'd8; #10;
   
        A = 4'd15; B = 4'd10; #10;
        
        $finish;
    end
endmodule


