import uvm_pkg::*;
class transaction extends uvm_sequence_item;

    // data that needs to be sent
    rand bit [1:0]  addr;
    rand bit        wr_en;
    rand bit        rd_en;
    rand bit [7:0]  wdata;

    // Analysis data
    bit [7:0]   rdata;
    int         cnt; 

    `uvm_object_utils(transaction)
    function new(string name="");
        super.new(name);
    endfunction //new()

    function void do_copy(uvm_object rhs);
        transaction _rhs;
        if(!$cast(_rhs, rhs))
            `uvm_fatal(get_type_name(), "rhs is not compatible with this class");
        
        addr    = _rhs.addr;
        wr_en   = _rhs.wr_en;
        rd_en   = _rhs.rd_en;
        wdata   = _rhs.wdata;
        rdata   = _rhs.rdata;
        cnt     = _rhs.cnt;
    endfunction

    function void do_print(uvm_printer printer);
        printer.print_field("addr", addr, 2, UVM_BIN);
        printer.print_field("wr_en", wr_en, 1, UVM_BIN);
        printer.print_field("rd_en", rd_en, 1, UVM_BIN);
        printer.print_field("wdata", wdata, 8, UVM_HEX);
        printer.print_field("rdata", rdata, 8, UVM_HEX);
        printer.print_field("cnt", cnt, 32, UVM_DEC);
    endfunction
endclass //transaction extends uvm_sequence_item

/* module top;
    transaction trans, trans_copy;

    initial begin
        trans = transaction::type_id::create("trans");
        trans_copy = transaction::type_id::create("trans_copy");
        trans.randomize();
        trans.print();
        trans_copy.copy(trans);
        trans_copy.print();
    end

    initial begin
        run_test();
    end
endmodule */