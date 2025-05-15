class seqcr extends uvm_sequencer#(seq_item);
    `uvm_component_utils(seqcr)
    
    //Constructor
    function new(string name = "seqcr", uvm_component parent);
        super.new(name, parent);
    endfunction

    //Build phase
    virtual function build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction
endclass