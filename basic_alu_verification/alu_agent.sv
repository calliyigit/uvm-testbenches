class alu_agent extends uvm_agent;
    `uvm_component_utils(alu_agent)

    // Agent components: driver, monitor, and sequencer
    alu_driver    drv;  
    alu_monitor   mon;
    alu_sequencer seqr;

    // Constructor: initialize agent component
    function new(string name = "alu_agent", uvm_component parent);
        super.new(name, parent);
        `uvm_info("AGENT_CLASS","Inside constructor!",UVM_HIGH)
    endfunction

    // Build phase: create instances of driver, monitor, and sequencer
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("AGENT_CLASS","Inside build_phase!",UVM_HIGH)
        drv = alu_driver::type_id::create("drv", this);
        mon = alu_monitor::type_id::create("mon", this);
        seqr = alu_sequencer::type_id::create("seqr", this);
    endfunction

    // Connect phase: connect driver’s sequencer port to the sequencer export
    function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(seqr.seq_item_export);
    endfunction
endclass
