class spi_test extends uvm_test;
    `uvm_component_utils(spi_test)

    spi_env env;
    spi_sequence seq;

    //constructor
    function new(string name = "spi_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction

    //Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        env = spi_env::type_id::create("env", this);
        seq = spi_sequence::type_id::create("seq", this);
        
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
      	
      repeat(10) begin
            seq.start(env.agnt.seqr);
            #10;
        end
      `uvm_info(get_type_name(), $sformatf("TEST DONE!"), UVM_LOW)    
        phase.drop_objection(this);
    endtask
endclass