class driver extends uvm_driver#(seq_item);

    // Register the driver class with the UVM factory
    `uvm_component_utils(driver)

    // Define the virtual interface to drive signals to DUT
    virtual add_if vif;

    // Constructor
    function new(string name = "driver", uvm_component parent);
        super.new(name, parent); // Call base class constructor
    endfunction

    // Build phase: retrieve the virtual interface from the configuration database
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual add_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal(get_type_name(), "Virtual interface not set at top level")
        end
    endfunction

    // Run phase: drive stimulus to the DUT continuously
    task run_phase(uvm_phase phase);
        forever begin
            // Since we extend uvm_driver#(seq_item), the `req` object is already of type seq_item

            // Get the next sequence item from the sequencer
            seq_item_port.get_next_item(req);

            // Print the values being driven
            `uvm_info(get_type_name(), $sformatf("ip1 = %0d, ip2 = %0d", req.ip1, req.ip2), UVM_LOW)

            // Wait for positive edge of clock and then drive inputs to DUT
            @(posedge vif.clk)
            vif.ip1 <= req.ip1;
            vif.ip2 <= req.ip2;

            // Notify that the sequence item is done
            seq_item_port.item_done();
        end
    endtask

endclass
