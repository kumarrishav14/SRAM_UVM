import uvm_pkg::*;

class monitor extends uvm_monitor;
    `uvm_component_utils(monitor)

    virtual sram_intf.mon_mp vif;
    transaction trans;

    uvm_analysis_port#(transaction) analysis_port;
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        if(!uvm_config_db#(virtual sram_intf)::get(this,"*", "vif", vif))
            `uvm_fatal(get_type_name(), "Cant get virtual interface");
        trans = transaction::type_id::create("trans");
        analysis_port = new("analysis_port", this); 
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            @(vif.mon_cb);
            wait(vif.mon_cb.ready);
            trans.valid = vif.mon_cb.valid;
            trans.ready = vif.mon_cb.ready;
            trans.wr_rd = vif.mon_cb.wr_rd;
            trans.addr = vif.mon_cb.addr;
            trans.wdata = vif.mon_cb.wr_data;
            trans.rdata = vif.mon_cb.rd_data;
            `uvm_info(get_type_name(), $sformatf("Sampled packet:: %s", trans.convert2string()), UVM_MEDIUM)
            analysis_port.write(trans);
        end
    endtask
endclass //monitor extends uvm_monitor