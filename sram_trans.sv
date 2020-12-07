`include "uvm_macros.svh"
import uvm_pkg::*;

class transaction extends uvm_sequence_item;
    `uvm_object_utils(transaction)

    // data that needs to be sent
    rand bit [7:0]  addr;
    rand bit        wr_rd;
    rand bit [15:0]  wdata;

    // Analysis data
    bit [15:0]   rdata;
    int         cnt; 
    bit valid, ready;
    
    // constraint addr_val { addr inside {['h0f:'h2f]}; }
    
    function new(string name="");
        super.new(name);
    endfunction //new()

    function void pre_randomize();
        cnt++;
    endfunction

    // Supporting functions
    function void do_copy(uvm_object rhs);
        transaction _rhs;
        if(!$cast(_rhs, rhs))
            `uvm_fatal(get_type_name(), "rhs is not compatible with this class");
        
        addr    = _rhs.addr;
        wr_rd   = _rhs.wr_rd;
        wdata   = _rhs.wdata;
        rdata   = _rhs.rdata;
        cnt     = _rhs.cnt;
    endfunction

    function void do_print(uvm_printer printer);
        $display("\nPACKET ID: %0d", cnt);
        //printer.print_field("cnt", cnt, 32, UVM_DEC);
        printer.print_field("addr", addr, 8, UVM_HEX);
        printer.print_field("wr_rd", wr_rd, 1, UVM_BIN);
        printer.print_field("wdata", wdata, 16, UVM_UNSIGNED);
        printer.print_field("rdata", rdata, 16, UVM_UNSIGNED);
    endfunction

    function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        transaction _rhs;
        bit cmp;
        if(!$cast(_rhs, rhs))
            `uvm_error(get_type_name(), "object passed is not compatible with Transaction");
        cmp = comparer.compare_field("addr", addr, _rhs.addr, 2) & comparer.compare_field("wdata", wdata, _rhs.wdata, 8) &
        comparer.compare_field("rdata", rdata, _rhs.rdata, 8) & comparer.compare_field("wr_rd", wr_rd, _rhs.wr_rd, 1);
        return (cmp & cnt == _rhs.cnt);
    endfunction

    function string convert2string();
        string s;
        s = $sformatf("Packet ID: %0d, wr_rd = %b, addr = %h, wdata = %0d, rdata = %0d", cnt, wr_rd, addr, wdata, rdata);
        return s;
    endfunction
endclass //transaction extends uvm_sequence_item

/* module top;
    transaction trans, trans_copy, trans_cloned;

    initial begin
        trans = transaction::type_id::create("trans");
        trans_copy = transaction::type_id::create("trans_copy");
        void'(trans.randomize());
        trans.print();
        trans_copy.copy(trans);
        trans_copy.print();
        `uvm_info("MON", $sformatf("Value of trans copy %s" ,trans_copy.convert2string()), UVM_LOW);
        if(trans.compare(trans_copy))
            `uvm_info("MON", "BOTH ARE SAME", UVM_LOW);

        $cast(trans_cloned, trans_copy.clone());
        `uvm_info("MON", $sformatf("Value of trans cloned %s" ,trans_cloned.convert2string()), UVM_LOW);
        trans_cloned.addr = 1;
        trans_cloned.wdata = 'd23;
        trans_cloned.print();
        if (trans.compare(trans_cloned)) begin
            `uvm_info("MON", "BOTH ARE SAME", UVM_LOW);
        end
        else begin
            `uvm_info("MON", "BOTH ARE NOT SAME", UVM_LOW);
        end
    end
endmodule */