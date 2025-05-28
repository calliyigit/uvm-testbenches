class mem_agent extends uvm_agent;
    `uvm_component_utils(mem_agent)
    
    //define agent components
    mem_monitor   monitor;
    mem_driver    driver;  
    mem_sequencer sequencer;
    

    //constructor
    function new(string name = "mem_agent", uvm_component parent);
        super.new(name, parent);
    endfunction

    //build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        monitor = mem_monitor::type_id::create("monitor", this);
        driver = mem_driver::type_id::create("driver", this);
        sequencer = mem_sequencer::type_id::create("sequencer", this);
    endfunction

    //connect phase
    function void connect_phase(uvm_phase phase);
        driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction
    

    
endclass