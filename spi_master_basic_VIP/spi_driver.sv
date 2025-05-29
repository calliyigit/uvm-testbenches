class spi_driver extends uvm_driver#(spi_seq_item);
    `uvm_component_utils(spi_driver)

    //Define interface
    virtual spi_interface vif;
  
  	uvm_analysis_port #(spi_seq_item) expected_ap;
    
    //Constructor
    function new(string name = "spi_driver", uvm_component parent);
        super.new(name, parent);
      	expected_ap = new("expected_ap", this);
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
            seq_item_port.get_next_item(req);
          `uvm_info(get_type_name(), $sformatf("Masterin rastgele gonderecegi veri (sequence tarafindan random uretilir) (mosi) - MOSI %d,, masterin almasi beklenen veri (slave random surer) (miso) - MISO %d", req.mosi_data_di, req.miso_data), UVM_LOW)
          	expected_ap.write(req);
            drive(req);                              
            seq_item_port.item_done();               
        end
    endtask
  
  task drive(spi_seq_item item);
    	vif.data_in <= item.mosi_data_di;
        wait(vif.reset);
        vif.start <= 1;
    	vif.read = 0;
    	vif.load <= 1;
    	vif.miso <= item.miso_data[0];
    	@(negedge vif.sclk)
    	vif.load <= 0;
    
    	for (int i = 1; i < 8; i++) begin
          @(negedge vif.sclk)
          vif.miso <= item.miso_data[i];
        end	
    	@(posedge vif.sclk)
    	vif.read <= 1;
    	@(posedge vif.sclk)
    	@(posedge vif.sclk)
    	vif.read <= 0;
    	vif.start <= 0;
    	
    endtask
endclass
