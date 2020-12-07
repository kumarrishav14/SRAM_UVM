import uvm_pkg::*;

class agent extends uvm_agent;
    `uvm_component_utils(agent)
    driver drv;
    uvm_sequencer #(transaction) seqr;
    monitor mon;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        
        drv = driver::type_id::create("drv", this);
        seqr = uvm_sequencer#(transaction)::type_id::create("seqr", this);
        mon = monitor::type_id::create("mon", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(seqr.seq_item_export);
    endfunction

    function void end_of_elaboration_phase(uvm_phase phase);
        // uvm_test_top.print_topology();
    endfunction
endclass //agent extends uvm_agent