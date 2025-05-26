class agent extends uvm_agent;

    // Register the agent with the UVM factory
    `uvm_component_utils(agent)

    // Declare agent components
    sequencer   seqr;   // Sequencer to generate sequence items
    driver      drv;    // Driver to drive signals to DUT
    monitor     mon;    // Monitor to observe DUT signals

    // Constructor
    function new(string name = "agent", uvm_component parent);
        super.new(name, parent); // Call base class constructor
    endfunction

    // Build phase: Create all components of the agent
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        drv = driver::type_id::create("drv", this);      // Create driver instance
        seqr = sequencer::type_id::create("seqr", this); // Create sequencer instance
        mon = monitor::type_id::create("mon", this);     // Create monitor instance
    endfunction

    // Connect phase: Connect sequencer and driver
    function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(seqr.seq_item_export); // Connect driver to sequencer
    endfunction

endclass
