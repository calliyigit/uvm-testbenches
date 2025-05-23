// Agent class for the D Flip-Flop (DFF) UVM environment
class dff_agent extends uvm_agent;

    // Macro to register this class with the UVM factory
    `uvm_component_utils(dff_agent)

    // Driver, Monitor, and Sequencer components of the agent
    dff_driver    drv;      // Responsible for driving signals to the DUT
    dff_monitor   mon;      // Observes DUT outputs and transactions
    dff_sequencer seqr;     // Supplies stimulus items (sequence items) to the driver

    // Constructor for the agent class
    function new(string name = "dff_agent", uvm_component parent);
        super.new(name, parent); // Call base class constructor
        `uvm_info("agent class", "constructor", UVM_MEDIUM) // Informational message during construction
    endfunction

    // Build phase: create subcomponents using the factory
    function void build_phase(uvm_phase phase);
        super.build_phase(phase); // Call base class build_phase
        drv = dff_driver::type_id::create("drv", this); // Create driver instance
        mon = dff_monitor::type_id::create("mon", this); // Create monitor instance
        seqr = dff_sequencer::type_id::create("seqr", this); // Create sequencer instance
    endfunction

    // Connect phase: connect driver to sequencer
    function void connect_phase(uvm_phase phase); 
        drv.seq_item_port.connect(seqr.seq_item_export); // Connect sequencer to driver
    endfunction

endclass
