// Test class for the D Flip-Flop (DFF)
// Instantiates environment and sequence, and starts the test run
class dff_test extends uvm_test;

    // Register the test class with the UVM factory
    `uvm_component_utils(dff_test)

    // Environment and sequence handles
    dff_env      env;
    dff_sequence seq;

    // Constructor
    function new(string name = "dff_test", uvm_component parent = null);
        super.new(name, parent); // Call base class constructor
        `uvm_info("DFF_TEST", "Constructor called", UVM_MEDIUM)
    endfunction

    // Build phase: create environment and sequence
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("DFF_TEST", "Build phase started", UVM_MEDIUM)

        env = dff_env::type_id::create("env", this);
        seq = dff_sequence::type_id::create("seq", this);
    endfunction

    // Connect phase (currently no connections needed here)
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("DFF_TEST", "Connect phase completed", UVM_MEDIUM)
    endfunction

    // End of elaboration phase for final setup or debug printing
    virtual function void end_of_elaboration();
        print(); // Print UVM component hierarchy and config info
        `uvm_info("DFF_TEST", "End of elaboration phase", UVM_MEDIUM)
    endfunction

    // Run phase: start the sequence on the sequencer
    task run_phase(uvm_phase phase);
        phase.raise_objection(this); // Signal test is running
        `uvm_info("DFF_TEST", "Run phase started: Starting sequence", UVM_MEDIUM)

        seq.start(env.agent.seqr);

        `uvm_info("DFF_TEST", "Run phase completed: Sequence finished", UVM_MEDIUM)
        phase.drop_objection(this);  // Signal test completion
    endtask

endclass
