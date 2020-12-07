import uvm_pkg::*;

class ram_sequence extends uvm_sequence;
    `uvm_object_utils(ram_sequence)
    transaction trans;
    int num = 10;
    
    function new(string name = "ram_sequence");
        super.new(name);
        void'(uvm_config_db#(int)::get(null, "seq", "no_pckt", num));
    endfunction //new()
    
    task pre_body();
        `uvm_info("DEBUG", "Starting sequence", UVM_DEBUG);
        trans = transaction::type_id::create("trans");
    endtask;
   
    task body();
        for (int i=0; i< num; i++) begin
            //trans = transaction::type_id::create("trans");
            start_item(trans);
            `uvm_info(get_type_name(), "Generating new item: ", UVM_MEDIUM);
            if(!trans.randomize())
                `uvm_fatal(get_type_name(), "Randomization failed");
            trans.print();
            finish_item(trans);
        end
        `uvm_info(get_type_name(), "Done generating items", UVM_MEDIUM);
    endtask
endclass //sequence extends uvm_sequence