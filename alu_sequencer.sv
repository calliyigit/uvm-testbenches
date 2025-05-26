// ALU Sequencer class extending from uvm_sequencer
// Responsible for arbitrating and sending alu_seq_item transactions to the driver
class alu_sequencer extends uvm_sequencer#(alu_seq_item);

    // Register this sequencer with the UVM factory
    `uvm_component_utils(alu_sequencer)

    // Constructor: initializes the sequencer and calls base class constructor
    function new(string name = "alu_sequencer", uvm_component parent);
        super.new(name, parent);  // Call base class constructor with name and parent
        `uvm_info("sequencer_CLASS", "Inside constructor!", UVM_HIGH) // Debug message
    endfunction


endclass
