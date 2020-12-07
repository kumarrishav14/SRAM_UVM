import uvm_pkg::*;

class environment extends uvm_env;
    `uvm_component_utils(environment)
    agent agnt;
    scoreboard scb;
    fun_cov fc;
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        agnt = agent::type_id::create("agnt", this);
        scb = scoreboard::type_id::create("scb", this);
        fc = fun_cov::type_id::create("fc", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        agnt.mon.analysis_port.connect(scb.analysis_export);
        agnt.mon.analysis_port.connect(fc.analysis_export);
    endfunction
endclass //environment extends uvm_environment