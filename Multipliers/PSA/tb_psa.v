module tb_psa_multiplier;

    reg clk;
    reg rst;
    reg start;
    reg [3:0] M_in;
    reg [3:0] Q_in;

    wire [7:0] product;
    wire done;

    psa_multiplier dut (
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

        #10;
        rst = 0;
        #10;

      
        M_in = 4'b1010; 
        Q_in = 4'b0101; 
      	start = 1;      
        #10;
        start = 0;  
        wait(done == 1'b1);
      	#1
      $display("Time=%0t | M_in=%b Q_in=%b | Product=%b", $time, M_in, Q_in, product);      

      	M_in = 4'b1110; 
        Q_in = 4'b0011; 
      	start = 1;      
        #10;
        start = 0;
        wait(done == 1'b1);
      	#1
      $display("Time=%0t | M_in=%b Q_in=%b | Product=%b", $time, M_in, Q_in, product);
      
        #10; 
        $finish;
    end
  
  initial begin
    $dumpfile("simulation.vcd"); 
    $dumpvars(0, tb_psa_multiplier); 
  end


endmodule

