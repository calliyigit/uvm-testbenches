class spi_monitor extends uvm_monitor;
    `uvm_component_utils(spi_monitor)

    //Define interface
    virtual spi_interface vif;

    uvm_analysis_port #(spi_seq_item) actual_ap;

    spi_seq_item item_collected;
    
    //Constructor
    function new(string name = "spi_monitor", uvm_component parent);
        super.new(name, parent);
        item_collected = new();
        actual_ap = new("actual_ap", this);
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
        $display("----------------------------------------------------------------");
        for (int i = 0; i<8; i++) begin
          @(negedge vif.sclk)
          item_collected.mosi[i] = vif.mosi;
          `uvm_info("MONITOR", $sformatf("Collected 1 bit MOSI data: %d", vif.mosi), UVM_LOW)
        end
        `uvm_info("MONITOR", $sformatf("Finally Collected 8 bit MOSI data: %d (%b)", item_collected.mosi, item_collected.mosi), UVM_LOW)
        $display("----------------------------------------------------------------");
        wait(vif.read);
        @(posedge vif.sclk)
        @(negedge vif.sclk)
        item_collected.miso = vif.data_out;
        actual_ap.write(item_collected);
      end
    endtask
endclass
