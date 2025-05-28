class mem_wr_rd_test extends mem_base_test;
    `uvm_component_utils(mem_wr_rd_test)

    //define env components
    mem_wr_rd_sequence seq;

    //constructor
    function new(string name = "mem_wr_rd_test", uvm_component parent);
        super.new(name, parent);
    endfunction

    //build phase
  	function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        seq = mem_wr_rd_sequence::type_id::create("seq");
    endfunction

    //run phase
  	task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        repeat(100) begin
            seq.start(env.mem_agnt.sequencer);
            #10;
        end
        phase.drop_objection(this);

        phase.phase_done.set_drain_time(this, 50);
    endtask
endclass