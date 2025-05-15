class seq_item extends uvm_sequence_item;
    rand bit [7:0] ip1, ip2;
         bit [8:0] out;

    //Constructor
    function new(string name = "seq_item");
        super.new(name);
    endfunction

    `uvm_object_utils_begin(seq_item)
        `uvm_field_int(ip1, UVM_ALL_ON)
        `uvm_field_int(ip2, UVM_ALL_ON)
        `uvm_field_int(out, UVM_ALL_ON)
    `uvm_object_utils_end

    constraint ip_c {ip1 < 100; ip2 < 100;}

    function string convert2str();
        return $sformatf("ip1=0x%0h, ip2=0x%0h", ip1, ip2);
    endfunction

endclass