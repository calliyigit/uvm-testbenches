// ALU Sequence class extending from uvm_sequence
// This sequence generates and sends alu_seq_item transactions to the driver
class alu_sequence extends uvm_sequence#(alu_seq_item);

    // Register this sequence with the UVM factory
    `uvm_object_utils(alu_sequence)

    // Constructor for the sequence
    function new(string name = "alu_sequence");
        super.new(name); // Call base class constructor
        `uvm_info("sequence_CLASS", "Inside constructor!", UVM_HIGH) // Debug message
    endfunction


    // The main sequence body where sequence items are created and sent
    task body();
        // This macro creates, randomizes, and sends the sequence item 'req' to the driver
        `uvm_do(req)
    endtask

endclass
