// ALU Monitor class extending from uvm_monitor
// It observes DUT signals via virtual interface and publishes transactions via analysis port
class alu_monitor extends uvm_monitor;

    // Register the monitor with the UVM factory
    `uvm_component_utils(alu_monitor)

    // Virtual interface to observe the DUT
    virtual alu_interface vif;

    // The transaction object to collect DUT activity
    alu_seq_item item_collected;

    // Analysis port to send collected items to scoreboard or other components
    uvm_analysis_port#(alu_seq_item) item_collected_port;

    // Constructor: initializes the monitor and creates the analysis port
    function new(string name = "alu_monitor", uvm_component parent);
        super.new(name, parent);
        `uvm_info("monitor_CLASS", "Inside constructor!", UVM_HIGH)

        // Allocate transaction object and analysis port
        item_collected = alu_seq_item::type_id::create("item_collected");
        item_collected_port = new("item_collected_port", this);
    endfunction

    // Build phase: retrieve virtual interface from configuration DB
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("monitor_CLASS", "Inside build_phase!", UVM_HIGH)

        // Try to get virtual interface; fatal error if not set
        if (!uvm_config_db#(virtual alu_interface)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NO_VIF", "Virtual interface 'vif' not set in config DB!")
        end
    endfunction

    // Run phase: actively monitor interface signals and collect transactions
    task run_phase(uvm_phase phase);
        forever begin
            wait (!vif.reset); // Wait until reset is deasserted

            // Collect input data at first posedge
            @(posedge vif.clock)
            item_collected.a        = vif.a;
            item_collected.b        = vif.b;
            item_collected.op_code  = vif.op_code;
          //`uvm_info("Compare", $sformatf(" a = %d, b = %d, opcode = %d", item_collected.a, item_collected.b, item_collected.op_code), UVM_LOW)

            // Collect output data at next posedge (assumes 1-cycle latency)
            @(posedge vif.clock)
            item_collected.result     = vif.result;
            item_collected.carry_out  = vif.carry_out;
			
          //`uvm_info("Compare", $sformatf(" result = %d, cout = %d", item_collected.result, item_collected.carry_out), UVM_LOW)
            // Publish the collected item
            item_collected_port.write(item_collected);
        end
    endtask

endclass
