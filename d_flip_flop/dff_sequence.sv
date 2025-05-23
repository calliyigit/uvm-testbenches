// Sequence class for D Flip-Flop (DFF)
// Generates a series of dff_seq_item transactions to drive the DUT
class dff_sequence extends uvm_sequence#(dff_seq_item);

    // Register the sequence class with the UVM factory
    `uvm_object_utils(dff_sequence)

    // Temporary handle for sequence items (optional here)
    dff_seq_item item;

    // Constructor
    function new(string name = "dff_sequence");
        super.new(name); // Call base class constructor
        `uvm_info("DFF_SEQUENCE", "Constructor called", UVM_MEDIUM)
    endfunction

    // Main task that generates and sends sequence items
    task body();
        // Repeat sending 50 sequence items
        repeat (50) begin
            `uvm_do(req); // Send the item `req` to the sequencer/driver
        end
        `uvm_info("DFF_SEQUENCE", "Completed sending 50 transactions", UVM_MEDIUM)
    endtask

endclass
