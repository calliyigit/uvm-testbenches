class mem_wr_rd_sequence extends uvm_sequence #(mem_seq_item); // random stimilus
    `uvm_object_utils(mem_wr_rd_sequence)

    mem_read_sequence rd_seq;
    mem_write_sequence wr_seq;

    //constructor
    function new(string name = "mem_wr_rd_sequence");
        super.new(name);
    endfunction

    task body();
        `uvm_do(wr_seq)
        `uvm_do(rd_seq)
    endtask
endclass