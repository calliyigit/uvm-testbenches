`define DRIV_IF vif.DRIVER.driver_cb
class mem_driver extends uvm_driver #(mem_seq_item);
    `uvm_component_utils(mem_driver)
    
    //define interface
    virtual mem_interface vif;

    //constructor
    function new(string name = "mem_driver", uvm_component parent);
        super.new(name, parent);
    endfunction

    //build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        //get the interface if not send fatal
        if (!uvm_config_db#(virtual mem_interface)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"})
        end
    endfunction

    //run phase
    task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(req);
            drive();
            seq_item_port.item_done();
        end
    endtask

    //drive task
    task drive();
        `DRIV_IF.wr_en <= 0;
        `DRIV_IF.rd_en <= 0;
    
        @(posedge vif.DRIVER.clk);

        `DRIV_IF.addr <= req.addr;

        //write operation
        if (req.wr_en) begin
            `DRIV_IF.wr_en <= req.wr_en;
            `DRIV_IF.wdata <= req.wdata;
            @(posedge vif.DRIVER.clk);
        end
        //read operation
        else if (req.rd_en) begin
            `DRIV_IF.rd_en <= req.rd_en;
            @(posedge vif.DRIVER.clk);
            `DRIV_IF.rd_en <= 0;
        end
    endtask

    
endclass