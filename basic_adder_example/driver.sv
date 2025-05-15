class driver extends uvm_driver#(seq_item);
    `uvm_component_utils(driver)

    //Define interface
    virtual add_if vif;
    
    //Constructor
    function new(string name = "driver", uvm_component parent);
        super.new(name, parent);
    endfunction

    //Build phase
    virtual function build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual add_if)::get(this, "", "add_if", vif)) begin
            `uvm_fatal(get_type_name(), "Not set at top level");
        end
    endfunction

    //Run phase
    virtual task run_phase(uvm_phase phase);
        forever begin
            //yukarida driver sinifini tanimlarken  uvm_driver#(seq_item) parentez icinde seq_item yazdigimiz icin 
            //req direkt seq_item turunde geliyor yeniden tanimlamamiza gerek yok
            seq_item_port.get_next_item(req);
            `uvm_info(get_type_name(), $sformatf("ip1 = %0d, ip2 = %0d", req.ip1, req.ip2), UVM_LOW)
            vif.ip1 <= req.ip1;
            vif.ip2 <= req.ip2;
            seq_item_port.item_done();
        end
    endtask
endclass