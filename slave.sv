module sram(clk,rst,addr,wr_data,rd_data,wr_rd,valid,ready);
	input clk,rst;
	input [7:0] addr; //256 different memories are needed
	input [15:0] wr_data; //each memory size is 16bit
	output reg [15:0] rd_data;
	input wr_rd,valid;
	output reg ready;

	//memory craetion reg[width_of_memory] mem [depth_of_memory]
	reg [15:0] mem [255:0];

	//2. when rst=1 initialize all outputs=1
	
	always@(posedge clk) begin
		if(rst==1) begin
			rd_data=0;
			ready=0;
			for(int i=0; i<=255; i++) begin
				mem[i]=0;
			end
		end
        
		else begin
			if(valid==1) begin
				ready=1;
				//wr or read operation
				if(wr_rd==1)begin
					mem[addr]=wr_data;
				end
				else begin
					rd_data=mem[addr];
				end
			end
			else begin 
				ready=0;
			end
		end
	end
	endmodule
	
