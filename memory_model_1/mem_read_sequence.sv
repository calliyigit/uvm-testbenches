class mem_read_sequence extends uvm_sequence #(mem_seq_item); // random stimilus
    `uvm_object_utils(mem_read_sequence)

    //constructor
    function new(string name = "mem_read_sequence");
        super.new(name);
    endfunction

  	//only read
    task body();
        `uvm_do_with(req, {req.rd_en == 1;})
    endtask
endclass