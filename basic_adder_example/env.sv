class env extends uvm_env;

    // Register the environment with the UVM factory
    `uvm_component_utils(env)

    // Declare environment components
    agent      agnt;  // The UVM agent (contains sequencer, driver, monitor)
    scoreboard sb;    // The scoreboard to check DUT outputs

    // Constructor
    function new(string name = "monitor", uvm_component parent);
        super.new(name, parent); // Call the base class constructor
    endfunction

    // Build phase: create agent and scoreboard instances
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agnt = agent::type_id::create("agnt", this); // Create agent instance
        sb   = scoreboard::type_id::create("sb", this); // Create scoreboard instance
    endfunction

    // Connect phase: connect monitor's analysis port to scoreboard's export
    function void connect_phase(uvm_phase phase);
        agnt.mon.item_collected_port.connect(sb.item_collect_export); 
    endfunction

endclass
