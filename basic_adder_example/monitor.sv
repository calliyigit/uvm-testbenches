class monitor extends uvm_monitor;

    // Register this monitor with the UVM factory
    `uvm_component_utils(monitor)

    // Virtual interface to observe DUT signals
    virtual add_if vif;

    // Analysis port to send observed transactions to scoreboard
    uvm_analysis_port#(seq_item) item_collected_port;

    // Temporary sequence item used for sampling transactions
    seq_item mon_item;

    // Constructor
    function new(string name = "monitor", uvm_component parent);
        super.new(name, parent);
        
        // Create the analysis port
        item_collected_port = new("item_collected_port", this);

        // Allocate memory for mon_item (temporary observation object)
        mon_item = new();
    endfunction

    // Build phase: retrieve the virtual interface
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual add_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal(get_type_name(), "Virtual interface not set at top level")
        end
    endfunction

    // Run phase: observe input and output values from the DUT
    task run_phase(uvm_phase phase);
        forever begin 
            // Wait until reset is deasserted
            wait(!vif.reset);

            // Sample inputs on rising edge of clock
            @(posedge vif.clk);
            mon_item.ip1 = vif.ip1;
            mon_item.ip2 = vif.ip2;

            `uvm_info(get_type_name(), $sformatf("ip1 = %0d, ip2 = %0d", mon_item.ip1, mon_item.ip2), UVM_LOW)

            // Wait one more cycle to capture the output (assumes 1-cycle latency)
            @(posedge vif.clk);
            mon_item.out = vif.out;

            `uvm_info(get_type_name(), $sformatf("out = %0d", mon_item.out), UVM_LOW)

            // Send the observed item to the scoreboard (or any other subscriber)
            item_collected_port.write(mon_item);
        end
    endtask

endclass
