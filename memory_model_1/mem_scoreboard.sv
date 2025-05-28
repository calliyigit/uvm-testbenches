
class mem_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(mem_scoreboard)

    //declaring the queue for store pkts received from monitor
    mem_seq_item pkt_qu[$];

    //sc_mem
 	 bit [7:0] sc_mem [3:0];
    
    //define analysis imp to get pkt from monitor
    uvm_analysis_imp #(mem_seq_item, mem_scoreboard) item_collected_export;
    

    //constructor
    function new(string name = "mem_driver", uvm_component parent);
        super.new(name, parent);
    endfunction

    //build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        item_collected_export = new("item_collected_export", this);
      //reset memory
      for(int i=0;i<4;i++) begin
        	sc_mem[i]=8'hFF;   
           `uvm_info(get_type_name(), $sformatf("sc_mem[%d] = %D", i, sc_mem[i]), UVM_LOW)
        end
    endfunction
    
    //write function
    function void write(mem_seq_item pkt);
        pkt_qu.push_back(pkt);
    endfunction

    //run phase
    task run_phase(uvm_phase phase);
        mem_seq_item mem_pkt;

        forever begin
            wait(pkt_qu.size() > 0);
            mem_pkt = pkt_qu.pop_front();

          	if (mem_pkt.wr_en) begin
                sc_mem[mem_pkt.addr] = mem_pkt.wdata;
                `uvm_info(get_type_name(), $sformatf("-------- :: WRITE DATA         :: ------------"), UVM_LOW)
                `uvm_info(get_type_name(), $sformatf("Addr: %0h", mem_pkt.addr), UVM_LOW)
                `uvm_info(get_type_name(), $sformatf("Data: %0h", mem_pkt.wdata), UVM_LOW)
                `uvm_info(get_type_name(), $sformatf("------------------------------------------------"), UVM_LOW)
            end
            else if (mem_pkt.rd_en) begin
                if (sc_mem[mem_pkt.addr] == mem_pkt.rdata) begin
                    `uvm_info(get_type_name(), $sformatf("-------- :: READ DATA match         :: ------------"), UVM_LOW)
                    `uvm_info(get_type_name(), $sformatf("Addr: %0h", mem_pkt.addr), UVM_LOW)
                    `uvm_info(get_type_name(), $sformatf("Expected Data: %0h  Actual data: %0h ",sc_mem[mem_pkt.addr], mem_pkt.rdata), UVM_LOW)
                    `uvm_info(get_type_name(), $sformatf("------------------------------------------------"), UVM_LOW)
                end
                else begin
                    `uvm_info(get_type_name(), $sformatf("-------- :: READ DATA mismatch         :: ------------"), UVM_LOW)
                    `uvm_info(get_type_name(), $sformatf("Addr: %0h", mem_pkt.addr), UVM_LOW)
                    `uvm_info(get_type_name(), $sformatf("Expected Data: %0h  Actual data: %0h ",sc_mem[mem_pkt.addr], mem_pkt.rdata), UVM_LOW)
                    `uvm_info(get_type_name(), $sformatf("------------------------------------------------"), UVM_LOW)
                end
            end
        end
    endtask

    
endclass