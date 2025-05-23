// Scoreboard class for the D Flip-Flop (DFF)
// Collects transactions from the monitor and stores them for checking
class dff_scoreboard extends uvm_scoreboard;

    // Register the scoreboard with the UVM factory
    `uvm_component_utils(dff_scoreboard)

    // Analysis implementation port to receive data from monitor
    uvm_analysis_imp#(dff_seq_item, dff_scoreboard) item_collected_export;

    // Queue to hold incoming sequence items from monitor
    dff_seq_item pkt_qu[$];

    // Constructor
    function new(string name = "dff_scoreboard", uvm_component parent);
        super.new(name, parent); // Call base constructor
        `uvm_info("DFF_SCOREBOARD", "Constructor called", UVM_MEDIUM)
    endfunction

    // Build phase: create the analysis implementation port
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("DFF_SCOREBOARD", "Build phase started", UVM_MEDIUM)

        // Instantiate the analysis export for incoming transactions
        item_collected_export = new("item_collected_export", this);
    endfunction

    // Write function: receives the transaction from the monitor and pushes it into the queue
  virtual function void write(dff_seq_item pkt);
    pkt_qu.push_back(pkt); // Store transaction in queue
    `uvm_info("DFF_SCOREBOARD", $sformatf("Received item: d = %0b, q = %0b", pkt.d, pkt.q), UVM_MEDIUM)

    endfunction

endclass
