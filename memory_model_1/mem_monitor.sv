class mem_monitor extends uvm_monitor;
    `uvm_component_utils(mem_monitor)
    
    //define interface
    virtual mem_interface vif;

    //define analysis port to send pkt to scoreboard
    uvm_analysis_port #(mem_seq_item) item_collected_port;

    //captured pkt
    mem_seq_item item_collected;

    //constructor
    function new(string name = "mem_monitor", uvm_component parent);
        super.new(name, parent);
        item_collected = new();
        item_collected_port = new("item_collected_port", this);
    endfunction

    //build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        //get the interface if not send fatal
        if (!uvm_config_db#(virtual mem_interface)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"})
        end
    endfunction

    //run phase
    task run_phase(uvm_phase phase);
        forever begin
            @(posedge vif.MONITOR.clk);
            wait(vif.monitor_cb.wr_en || vif.monitor_cb.rd_en);
                item_collected.addr = vif.monitor_cb.addr;
            if (vif.monitor_cb.wr_en) begin
                item_collected.wr_en = vif.monitor_cb.wr_en;
                item_collected.wdata = vif.monitor_cb.wdata;
                item_collected.rd_en = 0;
        
                @(posedge vif.MONITOR.clk);
              	
            end
            if (vif.monitor_cb.rd_en) begin
                item_collected.rd_en = vif.monitor_cb.rd_en;
                item_collected.wr_en = 0;
                @(posedge vif.MONITOR.clk);
                @(posedge vif.MONITOR.clk);
              `uvm_info(get_type_name(), $sformatf("rdata sampling"), UVM_LOW)
                item_collected.rdata = vif.monitor_cb.rdata;
            end
            item_collected_port.write(item_collected);
        end
    endtask


    
endclass