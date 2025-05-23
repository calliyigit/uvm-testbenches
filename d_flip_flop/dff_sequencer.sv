// Sequencer class for D Flip-Flop (DFF)
// Controls the flow of sequence items from sequences to the driver
class dff_sequencer extends uvm_sequencer#(dff_seq_item);

    // Register the sequencer class with the UVM factory
    `uvm_component_utils(dff_sequencer)

    // Constructor
    function new(string name = "dff_sequencer", uvm_component parent);
        super.new(name, parent); // Call base class constructor
        `uvm_info("DFF_SEQUENCER", "Constructor called", UVM_MEDIUM)
    endfunction

endclass
