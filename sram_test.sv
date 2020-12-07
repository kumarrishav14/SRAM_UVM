class base_test extends uvm_test;
    `uvm_component_utils(base_test)
    ram_sequence seq;
    environment env;

    int no_of_pckt = 400;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        uvm_config_db#(int)::set(null, "seq", "no_pckt", no_of_pckt);
        seq = ram_sequence::type_id::create("seq");
        env = environment::type_id::create("env", this);
    endfunction

    function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        seq.start(env.agnt.seqr);
        phase.drop_objection(this);
    endtask
endclass //base_test extends uvm_test