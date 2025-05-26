class base_seq extends uvm_sequence#(seq_item);

    // Register the sequence with the UVM factory
    `uvm_object_utils(base_seq)

    //seq_item req; // The sequence item that will be generated and sent

    // Constructor
    function new(string name = "seq_item");
        super.new(name); // Call base class constructor
    endfunction

    // Main sequence body
    virtual task body();
        // Generate and send a sequence item using the `uvm_do` macro
        `uvm_do(req);

        // -------------------------------------------------------
        // Alternatively, the above macro expands to the code below:
        // -------------------------------------------------------
        // req = seq_item::type_id::create("req"); // Create sequence item
        // start_item(req);                         // Start the item
        // if (!req.randomize()) begin              // Randomize it
        //     `uvm_error(get_type_name(), "Randomization Failed!")
        // end
        // finish_item(req);                        // Complete the item
        // -------------------------------------------------------

        // Print out the generated item information
        `uvm_info(get_type_name(), $sformatf("Generated item: %s", req.convert2str()), UVM_LOW)
    endtask

endclass
