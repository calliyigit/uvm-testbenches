class scoreboard extends uvm_scoreboard;
    `uvm_component_utils(scoreboard)
    //analiz imp declare
    uvm_analysis_imp#(seq_item, scoreboard) item_collect_export;
    seq_item item_q[$];
    
    
    //Constructor
    function new(string name = "monitor", uvm_component parent);
        super.new(name, parent);
        item_collect_export = new("item_collect_export", this);
    endfunction

    //Build phase
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    //write function
    virtual function void write(seq_item req);
        item_q.push_back(req);
    endfunction

    //run phase
    virtual task run_phase(uvm_phase phase);
        seq_item sb_item;
        forever begin
            wait(item_q.size > 0);
            if (item_q.size > 0) begin
                sb_item = item_q.pop_front();
                $display("------------------------------------------------------")
                if (sb_item.ip1 + sb_item.ip2 != sb_item.out) begin
                    `uvm_info(get_type_name(), $sformatf(" Matched ip1 = %0d ip2 = %0d out = %0d", sb_item.ip1, sb_item.ip2, sb_item.out), UVM_LOW)
                end
                else begin
                    `uvm_error(get_type_name(), $sformatf(" Not Matced ip1 = %0d ip2 = %0d out = %0d", sb_item.ip1, sb_item.ip2, sb_item.out), UVM_LOW)
                end
                $display("------------------------------------------------------")
            end
            
        end
    endtask

    
endclass