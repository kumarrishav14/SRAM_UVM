interface sram_intf(input bit clk, rst);
	logic [7:0] addr;
	logic [15:0] wr_data;
	logic wr_rd;
	logic valid;
	wire ready;
	wire [15:0] rd_data;

	clocking drv_cb @(posedge clk);
		output addr;
		output wr_data;
		output wr_rd;
		output valid;
        input #0 ready;
	endclocking

	clocking mon_cb @(posedge clk);
		input addr;
		input wr_data;
		input wr_rd;
		input valid;
		input #0 ready;
		input #0 rd_data;
	endclocking
	
	modport drv_mp(clocking drv_cb, output rst);
	modport mon_mp(clocking mon_cb, input rst);
endinterface
