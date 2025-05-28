class mem_seq_item extends uvm_sequence_item;
    //define the items
    rand bit [7:0] wdata;
    rand bit [1:0] addr;
    rand bit       wr_en;
    rand bit       rd_en;
         bit [7:0] rdata;  

    //define the utility and field macros
    `uvm_object_utils_begin(mem_seq_item)
        `uvm_field_int(wdata, UVM_ALL_ON)
        `uvm_field_int(addr, UVM_ALL_ON)
        `uvm_field_int(wr_en, UVM_ALL_ON)
        `uvm_field_int(rd_en, UVM_ALL_ON)
        `uvm_field_int(rdata, UVM_ALL_ON)
    `uvm_object_utils_end

    //constructor
    function new(string name = "mem_seq_item");
        super.new(name);
    endfunction

    //constaint write and read cannot happen the same time
    constraint wr_rd_c { wr_en != rd_en;}
endclass