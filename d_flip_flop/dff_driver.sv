// Driver class for the D Flip-Flop (DFF)
// Responsible for driving stimulus from sequence items onto the DUT interface
class dff_driver extends uvm_driver#(dff_seq_item);

    // Register the driver class with the UVM factory
    `uvm_component_utils(dff_driver)

    // Virtual interface to interact with the DUT
    virtual dff_intf vif;

    // Constructor
    function new(string name = "dff_driver", uvm_component parent);
        super.new(name, parent); // Call base class constructor
        `uvm_info("DFF_DRIVER", "Constructor called", UVM_MEDIUM)
    endfunction

    // Build phase: get the virtual interface from the configuration database
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("DFF_DRIVER", "Build phase started", UVM_MEDIUM)

        // Try to get the virtual interface from the UVM config database
        if (!uvm_config_db#(virtual dff_intf)::get(this, "", "vif", vif)) begin
            `uvm_fatal("DFF_DRIVER", "Virtual interface not found in config DB")
        end else begin
            `uvm_info("DFF_DRIVER", "Virtual interface successfully received", UVM_MEDIUM)
        end
    endfunction

    // Run phase: continually fetch and drive sequence items
    task run_phase(uvm_phase phase);
        `uvm_info("DFF_DRIVER", "Run phase started", UVM_MEDIUM)
        forever begin
            seq_item_port.get_next_item(req);        // Wait for next sequence item
            `uvm_info("DFF_DRIVER", $sformatf("Driving value: d = %0b", req.d), UVM_MEDIUM)
            drive(req);                              // Drive the item onto the interface
            seq_item_port.item_done();               // Indicate the item is completed
        end
    endtask;

    // Task to drive inputs onto the DUT via the interface
    task drive(dff_seq_item item);
        @(posedge vif.clk);         // Wait for a positive clock edge
        vif.d <= item.d;            // Drive the data input onto the interface
    endtask

endclass
