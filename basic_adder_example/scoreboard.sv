class scoreboard extends uvm_scoreboard;

    // Register the scoreboard with the UVM factory
    `uvm_component_utils(scoreboard)

    // Declare analysis implementation port to receive transactions from the monitor
    uvm_analysis_imp#(seq_item, scoreboard) item_collect_export;

    // Queue to store incoming transactions
    seq_item item_q[$];

    // Constructor
    function new(string name = "monitor", uvm_component parent);
        super.new(name, parent);

        // Connect the analysis implementation
        item_collect_export = new("item_collect_export", this);
    endfunction

    // Build phase (no additional components created here)
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    // Write function: called when monitor writes a transaction
    function void write(seq_item req);
        item_q.push_back(req); // Push the received item into the queue
    endfunction

    // Run phase: continuously check and compare items from the queue
    task run_phase(uvm_phase phase);
        seq_item sb_item;

        forever begin
            // Wait until the queue has at least one item
            wait(item_q.size > 0);

            if (item_q.size > 0) begin
                // Pop the front item for checking
                sb_item = item_q.pop_front();

                $display("------------------------------------------------------");

                // Compare expected result with actual output
                if (sb_item.ip1 + sb_item.ip2 == sb_item.out) begin
                    `uvm_info(get_type_name(),
                        $sformatf("Matched: ip1 = %0d, ip2 = %0d, out = %0d",
                        sb_item.ip1, sb_item.ip2, sb_item.out),
                        UVM_LOW)
                end
                else begin
                    `uvm_error(get_type_name(),
                        $sformatf("Mismatch: ip1 = %0d, ip2 = %0d, out = %0d",
                        sb_item.ip1, sb_item.ip2, sb_item.out))
                end

                $display("------------------------------------------------------");
            end
        end
    endtask

endclass
