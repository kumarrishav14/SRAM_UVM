class scoreboard extends uvm_scoreboard;
    `uvm_component_utils(scoreboard)

    transaction ref_trans;
    ref_model rm;
    uvm_analysis_imp#(transaction, scoreboard) analysis_export;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        analysis_export = new("analysis_export", this);
        rm = ref_model::type_id::create("rm", this);
    endfunction

    // Scoreboard receives a single packet from monitor which consists the input and the actual
    // output. This packet is sent to ref_model and it changes the actual output with the reference 
    // ouput.
    function void write(transaction act_trans);
        // act_trans.print();
        ref_trans = rm.get_ref_value(act_trans);
        if(act_trans.compare(ref_trans)) begin
            `uvm_info(get_type_name(), "PASSED", UVM_LOW)
        end
        else begin
            `uvm_error(get_type_name(), "FAILED");
        end
    endfunction
endclass //scoreboard extends uvm_scoreboard