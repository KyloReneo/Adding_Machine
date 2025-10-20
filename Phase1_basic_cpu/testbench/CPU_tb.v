module CPU_tb;

    reg clk;
    reg rst;
    reg [7:0] data_bus_in;
    wire rd_mem;
    wire wr_mem;
    wire [5:0] adr_bus;
    wire [7:0] data_bus_out;
    
    reg [7:0] memory [0:63];
    integer output_file;
    integer i;
    
    CPU dut(.clk(clk), .rst(rst), .data_bus_in(data_bus_in), 
            .rd_mem(rd_mem), .wr_mem(wr_mem), .adr_bus(adr_bus), 
            .data_bus_out(data_bus_out));
    
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end
    
    // Memory read
    always @(*) begin
        if (rd_mem) begin
            data_bus_in = memory[adr_bus];
        end else begin
            data_bus_in = 8'b0;
        end
    end
    
    // Memory write
    always @(posedge clk) begin
        if (wr_mem) begin
            memory[adr_bus] <= data_bus_out;
            $display("Time %0t: MEM[%0d] = %0d", $time, adr_bus, data_bus_out);
        end
    end
    
    initial begin
        // Initialize memory
        for (i = 0; i < 64; i = i + 1) begin
            memory[i] = 8'b0;
        end
        
        // Load instructions
        $readmemb("programs/instructions.txt", memory);
        $display("Instructions loaded");
        
        // Open output file
        output_file = $fopen("outputs/output.txt", "w");
        
        // Reset
        rst = 1;
        #100;
        rst = 0;
        
        // Run
        #1750;
        
        // Write results
        $fdisplay(output_file, "Fibonacci Results:");
        for (i = 32; i <= 40; i = i + 1) begin
            $fdisplay(output_file, "MEM[%0d] = %0d", i, memory[i]);
        end
        $fclose(output_file);
        
        $display("Simulation finished");
        $finish;
    end

endmodule
