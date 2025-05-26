class base_test extends uvm_test;

    // Register the test with the UVM factory
    `uvm_component_utils(base_test)
    
    env env_o;         // Handle for the environment
    base_seq bseq;     // Handle for the base sequence
    
    // Constructor
    function new(string name = "base_test", uvm_component parent = null);
        super.new(name, parent); // Call base class constructor
    endfunction
    
    // Build phase: create the environment
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env_o = env::type_id::create("env_o", this); // Instantiate the environment
    endfunction
    
    // Run phase: apply sequences to the DUT via the sequencer
    task run_phase(uvm_phase phase);
        phase.raise_objection(this); // Raise objection to keep the simulation running
        
        bseq = base_seq::type_id::create("bseq"); // Create the base sequence
        
        repeat(10) begin 
            bseq.start(env_o.agnt.seqr); // Start the sequence on the agent's sequencer
            #5; // Optional delay between sequences
        end
        
        phase.drop_objection(this); // Drop the objection to end simulation

        `uvm_info(get_type_name, "End of testcase", UVM_LOW) // Info message at end
    endtask

endclass
