class alu_env extends uvm_env;
    `uvm_component_utils(alu_env)

    // Environment components: agent and scoreboard
    alu_agent      agnt;
    alu_scoreboard sb;

    // Constructor: initialize the environment component
    function new(string name = "alu_env", uvm_component parent);
        super.new(name, parent);
        `uvm_info("ENV_CLASS","Inside constructor!",UVM_HIGH)
    endfunction

    // Build phase: create agent and scoreboard instances
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("ENV_CLASS","Inside build_phase!",UVM_HIGH)
        agnt = alu_agent::type_id::create("agnt", this);
        sb = alu_scoreboard::type_id::create("sb", this);
    endfunction

    // Connect phase: connect monitor's analysis port to scoreboard's analysis implementation port
    function void connect_phase(uvm_phase phase);
        agnt.mon.item_collected_port.connect(sb.ap);
    endfunction
endclass
