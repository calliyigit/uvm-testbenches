class mem_write_sequence extends uvm_sequence #(mem_seq_item); // random stimilus
    `uvm_object_utils(mem_write_sequence)

    //constructor
    function new(string name = "mem_write_sequence");
        super.new(name);
    endfunction

    task body();
        `uvm_do_with(req, {req.wr_en == 1;})
    endtask
endclass