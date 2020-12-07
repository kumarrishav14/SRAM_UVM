import uvm_pkg::*;

class driver extends uvm_driver#(transaction);
    `uvm_component_utils(driver)
    transaction trans;
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    virtual sram_intf.drv_mp vif;

    function void build_phase(uvm_phase phase);
        `uvm_info("DEBUG", "Building Driver", UVM_DEBUG);
        if(!uvm_config_db#(virtual sram_intf)::get(this, "*", "vif", vif))
            `uvm_fatal(get_type_name(), "Virtual interface not found")
    endfunction

    task run_phase(uvm_phase phase);
        @(vif.drv_cb);
        vif.rst = 1;
        @(vif.drv_cb);
        vif.rst = 0;
        forever begin
            seq_item_port.get_next_item(trans);
            `uvm_info(get_type_name(), $sformatf("RECIEVED FROM SEQUENCER:: %s", trans.convert2string()), UVM_MEDIUM);
            @(vif.drv_cb); //nxt posedge of clk as in clking block as posedge of clk defined

            vif.drv_cb.addr     <= trans.addr;
            vif.drv_cb.wr_rd    <=  trans.wr_rd;

            if(trans.wr_rd==1) 
                vif.drv_cb.wr_data <= trans.wdata;
            vif.drv_cb.valid<=1;
            wait(vif.drv_cb.ready);
            vif.drv_cb.valid<=0;
            seq_item_port.item_done();
        end
    endtask
    
endclass //driver extends uvm_driver