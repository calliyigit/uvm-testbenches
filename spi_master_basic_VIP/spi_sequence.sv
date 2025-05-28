class spi_sequence extends uvm_sequence#(spi_seq_item);
    `uvm_object_utils(spi_sequence)

    function new(string name = "spi_sequence");
        super.new(name);
    endfunction

    //Body 
    task body();
        `uvm_info(get_type_name(), "Base seq: Inside Body", UVM_LOW)
        `uvm_do(req)
        
        // -------------------------------------------------------
        //We can do these code instead of `uvm_do()
        // -------------------------------------------------------        
        //req = seq_item::type_id::create("req");
        //start_item(req);
        //if (!req.randomize()) begin
        //    `uvm_error(get_type_name(), "Randomization Failed!")
        //end
        //finish_item(req);
        // -------------------------------------------------------
        

        `uvm_info(get_type_name(), $sformatf("Generated item: %s", req.convert2str()), UVM_LOW)
    endtask
endclass