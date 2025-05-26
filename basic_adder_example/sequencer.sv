class sequencer extends uvm_sequencer#(seq_item);

    // Register the sequencer with the UVM factory
    `uvm_component_utils(sequencer)

    // Constructor
    function new(string name = "sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction

    // Build phase 
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

endclass
