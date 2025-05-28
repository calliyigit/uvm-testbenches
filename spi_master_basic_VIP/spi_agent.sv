class spi_agent extends uvm_agent;
    `uvm_component_utils(spi_agent)

    spi_monitor   mon;
    spi_sequencer seqr;
    spi_driver    drv;

    //constructor
    function new(string name = "spi_agent", uvm_component parent);
      super.new(name, parent);
    endfunction

    //Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        mon = spi_monitor::type_id::create("mon", this);
        seqr = spi_sequencer::type_id::create("seqr", this);
        drv = spi_driver::type_id::create("drv", this);
    endfunction

  function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(seqr.seq_item_export);
    endfunction
endclass