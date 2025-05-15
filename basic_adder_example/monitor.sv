class monitor extends uvm_monitor;
    `uvm_component_utils(monitor)

    virtual add_if vif;
    uvm_analysis_port#(seq_item) item_collected_port;
    seq_item mon_item;
    
    //Constructor
    function new(string name = "monitor", uvm_component parent);
        super.new(name, parent);
        item_collected_port = new("item_collected_port", this);
        mon_item = new(); //create yapmadik cunku seq itemi gecici olarak kullanacagiz new yapmak dahja hafif
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
            wait(vif.reset);
            @(posedge vif.clk);
            mon_item.ip1 = vif.ip1;
            mon_item.ip2 = vif.ip2;
            `uvm_info(get_type_name(), $sformatf("ip1 = %0d, ip2 = %0d", mon_item.ip1, mon_item.ip2), UVM_HIGH)
            @(posedge vif.clk)
            mon_item.out = vif.out;
            item_collected_port.write(mon_item);
        end
    endtask
endclass