class spi_monitor extends uvm_monitor;
    `uvm_component_utils(spi_monitor)

    //Define interface
    virtual spi_interface vif;

    uvm_analysis_port#(spi_seq_item) item_collected_port;

    spi_seq_item item_collected;
    
    //Constructor
    function new(string name = "spi_monitor", uvm_component parent);
        super.new(name, parent);
        item_collected = new();
        item_collected_port = new("item_collected_port", this);
    endfunction

    //Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual spi_interface)::get(this, "", "vif", vif)) begin
            `uvm_fatal(get_type_name(), "Not set at top level");
        end
    endfunction

    //Run phase
    task run_phase(uvm_phase phase);
      forever begin
        wait(!vif.load && vif.start && !vif.read);
        for (int i = 0; i<8; i++) begin
          @(negedge vif.sclk)
          item_collected.mosi[i] = vif.mosi;
        end
        `uvm_info("MONITOR", $sformatf("Collected data: %d", item_collected.mosi), UVM_LOW)
        
      end
    endtask
endclass