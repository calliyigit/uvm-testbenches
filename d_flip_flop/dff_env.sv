// Environment class for the D Flip-Flop (DFF) UVM testbench
// Contains the agent and the scoreboard
class dff_env extends uvm_env;

    // Register the environment class with the UVM factory
    `uvm_component_utils(dff_env)

    // Components in the environment
    dff_scoreboard scb; // Scoreboard to check expected vs actual behavior
    dff_agent      agent; // Agent that contains driver, monitor, and sequencer

    // Constructor
    function new(string name = "dff_env", uvm_component parent);
        super.new(name, parent); // Call base class constructor
        `uvm_info("DFF_ENV", "Constructor called", UVM_MEDIUM)
    endfunction

    // Build phase: create agent and scoreboard instances
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("DFF_ENV", "Build phase started", UVM_MEDIUM)

        scb = dff_scoreboard::type_id::create("scb", this);   // Instantiate scoreboard
        agent = dff_agent::type_id::create("agent", this);    // Instantiate agent

        `uvm_info("DFF_ENV", "Agent and Scoreboard created", UVM_MEDIUM)
    endfunction

    // Connect phase: connect monitor output to scoreboard input
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("DFF_ENV", "Connect phase started", UVM_MEDIUM)

        agent.mon.item_collected_port.connect(scb.item_collected_export); // Connect monitor to scoreboard

        `uvm_info("DFF_ENV", "Monitor connected to Scoreboard", UVM_MEDIUM)
    endfunction

endclass
