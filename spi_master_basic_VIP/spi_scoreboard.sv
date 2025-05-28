class spi_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(spi_scoreboard)

    uvm_analysis_imp#(spi_seq_item, spi_scoreboard) item_collected_export;

    spi_seq_item pkt_qu[$];

    //constructor
    function new(string name = "spi_scoreboard", uvm_component parent);
      super.new(name, parent);
    endfunction

    //Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        item_collected_export = new("item_collected_export", this);
    endfunction

    function void write(spi_seq_item item);
        pkt_qu.push_back(item);
    endfunction

    task run_phase(uvm_phase phase);
        spi_seq_item item_collected;
        forever begin
            wait(pkt_qu.size() > 0);

            item_collected = pkt_qu.pop_front;

          `uvm_info("SCOREBOARD", $sformatf("Collected data: %d", item_collected.mosi), UVM_LOW)
        end
    endtask
endclass