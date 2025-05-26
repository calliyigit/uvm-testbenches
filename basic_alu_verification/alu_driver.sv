// ALU Driver class extending from uvm_driver
// Responsible for receiving sequence items and driving them onto the DUT interface
class alu_driver extends uvm_driver#(alu_seq_item);

    // Register the driver with the UVM factory
    `uvm_component_utils(alu_driver)

    // Virtual interface used to drive signals to the DUT
    virtual alu_interface vif;

    // Constructor: initializes the driver
    function new(string name = "alu_driver", uvm_component parent);
        super.new(name, parent); // Call base constructor
        `uvm_info("driver_CLASS", "Inside constructor!", UVM_HIGH)
    endfunction

    // Build phase: fetch virtual interface from configuration database
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("driver_CLASS", "Inside build_phase!", UVM_HIGH)

        // Try to get the virtual interface from UVM config DB
        if (!uvm_config_db#(virtual alu_interface)::get(this, "", "vif", vif)) begin
            // Fatal error if interface is not set
            `uvm_fatal("NO_VIF", "Virtual interface 'vif' not set in config DB!")
        end
    endfunction

    // Run phase: continuously get and drive sequence items
    task run_phase(uvm_phase phase);
        forever begin
            // Wait for next sequence item from sequencer
            seq_item_port.get_next_item(req);
            
            // Call drive task to drive signals to the DUT
            drive(req);
            
            // Indicate to sequencer that driving is done
            seq_item_port.item_done();
        end
    endtask

    // Drive task: apply input signals to the DUT at posedge of clock
    task drive(alu_seq_item item);
        wait(!vif.reset);
        @(posedge vif.clock)                  // Synchronize to clock edge
        vif.a       <= item.a;                // Drive input 'a'
        vif.b       <= item.b;                // Drive input 'b'
        vif.op_code <= item.op_code;          // Drive opcode to perform ALU operation
    endtask

endclass
