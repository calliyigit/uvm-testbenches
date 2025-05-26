class seq_item extends uvm_sequence_item;

    // Randomizable 8-bit input variables
    rand bit [7:0] ip1, ip2;

    // 9-bit output variable (not randomized, will be set later)
    bit [8:0] out;

    // Constructor
    function new(string name = "seq_item");
        super.new(name);
    endfunction

    // Register class fields for automatic copying, printing, and packing
    `uvm_object_utils_begin(seq_item)
        `uvm_field_int(ip1, UVM_ALL_ON)  // Include ip1 in all operations
        `uvm_field_int(ip2, UVM_ALL_ON)  // Include ip2 in all operations
        `uvm_field_int(out, UVM_ALL_ON)  // Include out in all operations
    `uvm_object_utils_end

    // Constraint: limit inputs to values less than 100
    constraint ip_c { ip1 < 100; ip2 < 100; }

    // String conversion method to print meaningful info about the transaction
    function string convert2str();
        return $sformatf("ip1=%d, ip2=%d", ip1, ip2);
    endfunction

endclass
