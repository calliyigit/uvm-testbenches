// Monitor class for the D Flip-Flop (DFF)
// Observes DUT signal activity and sends it to analysis components like the scoreboard
class dff_monitor extends uvm_monitor#(dff_seq_item);

    // Register this class with the UVM factory
    `uvm_component_utils(dff_monitor)

    // Virtual interface for observing DUT signals
    virtual dff_intf vif;

    // Analysis port for sending observed transactions
    uvm_analysis_port#(dff_seq_item) item_collected_port;

    // Holds the transaction item being collected
    dff_seq_item item_collected;

    // Constructor
    function new(string name = "dff_monitor", uvm_component parent);
        super.new(name, parent); // Call base class constructor
        `uvm_info("DFF_MONITOR", "Constructor called", UVM_MEDIUM)
        // Create analysis port instance
        item_collected_port = new("item_collected_port", this);
    endfunction

    // Build phase: get the virtual interface from the config DB
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("DFF_MONITOR", "Build phase started", UVM_MEDIUM)

        if (!uvm_config_db#(virtual dff_intf)::get(this, "", "vif", vif)) begin
            `uvm_fatal("DFF_MONITOR", "Virtual interface get failed from config DB")
        end else begin
            `uvm_info("DFF_MONITOR", "Virtual interface successfully received", UVM_MEDIUM)
        end
    endfunction

    // Run phase: capture signal activity from the DUT
    task run_phase(uvm_phase phase);
        `uvm_info("DFF_MONITOR", "Run phase started", UVM_MEDIUM)

        // Create a transaction item to store the observed values
        item_collected = dff_seq_item::type_id::create("item_collected");

        // Wait until reset is deasserted
        wait(!vif.rst);
        `uvm_info("DFF_MONITOR", "Reset deasserted, starting observation", UVM_MEDIUM)

        @(posedge vif.clk); // Wait for next clock edge

        // Capture current signal values from the interface
        item_collected.rst = vif.rst;
        item_collected.d   = vif.d;
        item_collected.q   = vif.q;

        // Send the captured transaction to connected analysis components
        item_collected_port.write(item_collected);

        `uvm_info("DFF_MONITOR", $sformatf("Observed: d = %0b, q = %0b", item_collected.d, item_collected.q), UVM_MEDIUM)
    endtask

endclass
