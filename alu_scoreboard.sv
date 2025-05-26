// ALU Scoreboard class extending from uvm_scoreboard
// It receives transactions from the monitor and compares expected vs actual results
class alu_scoreboard extends uvm_scoreboard;

    // Register the scoreboard with UVM factory
    `uvm_component_utils(alu_scoreboard)

    // Analysis implementation port to receive transactions from monitor
    uvm_analysis_imp#(alu_seq_item, alu_scoreboard) ap;

    // Queue to store incoming sequence items for comparison
    alu_seq_item pkt_q[$];

    // Constructor: initializes the scoreboard
    function new(string name = "alu_scoreboard", uvm_component parent);
        super.new(name, parent);
        `uvm_info("scoreboard_CLASS", "Inside constructor!", UVM_HIGH)
    endfunction

    // Build phase: construct the analysis implementation port
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("scoreboard_CLASS", "Inside build_phase!", UVM_HIGH)

        // Create analysis port to receive transactions
        ap = new("ap", this);
    endfunction

    // Write method: receives sequence items and stores them in queue
    function void write(alu_seq_item item);
        pkt_q.push_back(item);
    endfunction

    // Run phase: constantly process items from the queue and compare them
    task run_phase(uvm_phase phase);
        forever begin
            alu_seq_item curr_trans;
            wait(pkt_q.size() != 0); // Wait for an item to arrive
            curr_trans = pkt_q.pop_front(); // Dequeue the item
            compare(curr_trans); // Call comparison task
        end
    endtask

    // Compare method: calculates expected result and compares with actual DUT output
    task compare(alu_seq_item curr_trans);
        logic [7:0] expected;
        logic [7:0] actual;

        // Calculate expected result based on opcode
        case (curr_trans.op_code)
            0: expected = curr_trans.a + curr_trans.b; // ADD
            1: expected = curr_trans.a - curr_trans.b; // SUB
            2: expected = curr_trans.a * curr_trans.b; // MUL
            3: begin
                if (curr_trans.b != 0)
                    expected = curr_trans.a / curr_trans.b; // DIV
                else begin
                    `uvm_error("Compare", "Division by zero encountered!")
                    return;
                end
            end
            default: begin
                `uvm_error("Compare", $sformatf("Unsupported op_code: %0d", curr_trans.op_code))
                return;
            end
        endcase

        actual = curr_trans.result;

        // Check for match/mismatch and log result
        if (actual != expected) begin
            `uvm_error("Compare", $sformatf("Transaction failed! ACT = %0d, EXP = %0d", actual, expected))
        end else begin
            `uvm_info("Compare", $sformatf("Transaction passed! ACT = %0d, EXP = %0d", actual, expected), UVM_LOW)
        end
    endtask

endclass
