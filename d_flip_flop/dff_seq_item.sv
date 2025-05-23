// Sequence item for D Flip-Flop (DFF)
// Represents a single transaction with inputs (rst, d) and output (q)
class dff_seq_item extends uvm_sequence_item;

    // Register the sequence item class with the UVM factory
    `uvm_object_utils(dff_seq_item)

    // Transaction fields
    rand bit rst; // Reset input
    rand bit d;   // Data input
         bit q;   // Output from DUT (not randomized, will be sampled by monitor)

    // Constructor
    function new(string name = "dff_seq_item");
        super.new(name); // Call base class constructor
        `uvm_info("DFF_SEQ_ITEM", "Constructor called", UVM_MEDIUM)
    endfunction

    // Constraint: Prevent reset from being asserted during normal operation
    constraint wr_rd_c { rst != 1; }

endclass
