class spi_env extends uvm_env;
    `uvm_component_utils(spi_env)

    spi_agent agnt;
    spi_scoreboard scb;

    //constructor
    function new(string name = "spi_env", uvm_component parent);
      super.new(name, parent);
    endfunction

    //Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        agnt = spi_agent::type_id::create("agnt", this);
        scb = spi_scoreboard::type_id::create("scb", this);
        
    endfunction

  	function void connect_phase(uvm_phase phase);
        agnt.mon.item_collected_port.connect(scb.item_collected_export);
    endfunction
endclass