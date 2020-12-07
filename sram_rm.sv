class ref_model extends uvm_component;
    `uvm_component_utils(ref_model)
    transaction trans;
    bit [15:0] mem [];
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        // trans = transaction::type_id::create("trans");
        mem = new[2**8-1];
    endfunction

    // In this there is single monitor which samples both input and output data and is sent in a singl
    // packet. The input values are used here to generate the expected output and the output values are
    // changed accordingly.
    function transaction get_ref_value(transaction rcvd_trans);
        $cast(trans, rcvd_trans.clone());
        if(trans.valid) begin
            trans.ready = 1;
            if(trans.wr_rd)
                mem[trans.addr] = trans.wdata;
            else begin
                trans.rdata = mem[trans.addr];
            end
        end
        else
            trans.ready = 0;
        `uvm_info(get_type_name(), $sformatf("GENERATED REFERENCE PACKET:: %s", trans.convert2string()), UVM_MEDIUM);
        return trans;
    endfunction
endclass //ref_model extends uvm_component