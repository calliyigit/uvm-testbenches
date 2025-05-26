class alu_test extends uvm_test;
    `uvm_component_utils(alu_test)

    // Environment instance containing agent and scoreboard
    alu_env           env;
    // Main test sequence to apply stimulus to DUT
    alu_sequence      test_seq;
    
    // Constructor: initializes the test component
    function new(string name = "alu_test", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("TEST_CLASS","Inside constructor!",UVM_HIGH)
    endfunction

    // Build phase: create the environment instance
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("TEST_CLASS","Inside build_phase!",UVM_HIGH)
        env = alu_env::type_id::create("env", this);
    endfunction

    // Run phase: generate stimulus by starting test sequences repeatedly
    task run_phase(uvm_phase phase);
        phase.raise_objection(this); // Prevent simulation from ending prematurely

        // Repeat the test sequence 100 times
        repeat(100) begin
            test_seq = alu_sequence::type_id::create("test_seq", this);
            test_seq.start(env.agnt.seqr); // Start sequence on sequencer
            #10; // Wait some time between sequences
        end

        phase.drop_objection(this); // Allow simulation to finish
    endtask
endclass
