class mem_sequencer extends uvm_sequencer #(mem_seq_item);
    `uvm_component_utils(mem_sequencer)

    //constructor
    function new(string name = "mem_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction

    
endclass