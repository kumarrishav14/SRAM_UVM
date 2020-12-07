class fun_cov extends uvm_subscriber#(transaction);
    `uvm_component_utils(fun_cov)
    transaction trans;

    covergroup cg;
        WR_RD:coverpoint trans.wr_rd { bins wr = {1};
                                       bins rd = {0}; }
        ADDR:coverpoint trans.addr { bins ad[8] = {[0:255]}; }
        WDATA:coverpoint trans.wdata { bins wd[16] = {[0:2**16-1]}; }
        RDATA:coverpoint trans.rdata { bins rd[16] = {[0:2**16-1]}; }
    endgroup
    function new(string name, uvm_component parent);
        super.new(name, parent);
        cg = new();
    endfunction //new()

    function void build_phase(uvm_phase phase);
        trans = transaction::type_id::create("trans");
    endfunction

    function void write(transaction t);
        this.trans = t;
        cg.sample();
    endfunction
endclass //fun_cov extends uvm_subscriber