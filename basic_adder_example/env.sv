class env extends uvm_env;
    `uvm_component_utils(env)
    //declare env components
    agent      agnt;
    scoreboard sb;
    
    
    //Constructor
    function new(string name = "monitor", uvm_component parent);
        super.new(name, parent);
        
    endfunction

    //Build phase
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agnt = agent::type_id::create("agnt", this);
        sb = scoreboard::type_id::create("sb", this);
    endfunction

    //Connect phase (connect scoreboard to monitor)
    virtual function void connect_phase(uvm_phase phase);
        agnt.mon.item_collected_port.connect(sb.item_collect_export);
    endfunction
endclass