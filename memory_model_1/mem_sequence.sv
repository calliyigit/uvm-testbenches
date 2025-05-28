class mem_sequence extends uvm_sequence #(mem_seq_item); // random stimilus
    `uvm_object_utils(mem_sequence)

    //constructor
    function new(string name = "mem_sequence");
        super.new(name);
    endfunction

    task body();
        repeat(2) begin
            req = mem_seq_item::type_id::create("req");
            wait_for_grant();
            req.randomize();
            send_request(req);
            wait_for_item_done();
        end
    endtask
endclass