
class mem_base_test extends uvm_test;
    `uvm_component_utils(mem_base_test)

    //define env components
    mem_env env;

    //constructor
    function new(string name = "mem_base_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    //build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = mem_env::type_id::create("env", this);
    endfunction

    //end of elaboeration phase
    function void end_of_elaboration();
        //prints the topology
        print();
    endfunction

    //report phase
    function void report_phase(uvm_phase phase);
        uvm_report_server svr;
        super.report_phase(phase);

        svr = uvm_report_server::get_server();
        if(svr.get_severity_count(UVM_FATAL)+svr.get_severity_count(UVM_ERROR)>0) begin
            `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
            `uvm_info(get_type_name(), "----            TEST FAIL          ----", UVM_NONE)
            `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
        end
        else begin
            `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
            `uvm_info(get_type_name(), "----           TEST PASS           ----", UVM_NONE)
            `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
        end
    endfunction

    
endclass