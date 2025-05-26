// ALU Sequence Item class extending from uvm_sequence_item
class alu_seq_item extends uvm_sequence_item;

    // Randomized input operands and operation code
    rand bit [7:0] a, b;            // Input operands 'a' and 'b'
    rand bit [3:0] op_code;         // ALU operation code (e.g., add, sub, etc.)

    // Output result and carry-out (not randomized)
    bit [7:0] result;               // Output result of the ALU
    bit       carry_out;           // Carry out bit for operations like addition

    // Register class with UVM factory and enable field automation for printing, copying, comparing
    `uvm_object_utils_begin(alu_seq_item)
        `uvm_field_int(a, UVM_ALL_ON)          // Register field 'a' for automation
        `uvm_field_int(b, UVM_ALL_ON)          // Register field 'b' for automation
        `uvm_field_int(op_code, UVM_ALL_ON)    // Register field 'op_code' for automation
        `uvm_field_int(result, UVM_ALL_ON)     // Register output 'result' for automation
        `uvm_field_int(carry_out, UVM_ALL_ON)  // Register output 'carry_out' for automation
    `uvm_object_utils_end

    // Constructor for the sequence item
    function new(string name = "alu_seq_item");
        super.new(name);                       // Call base class constructor
        `uvm_info("seq_item_CLASS", "Inside constructor!", UVM_HIGH)  // Debug message
    endfunction

    // Constraints for input values
    constraint input_a_c { a inside {[10:20]}; }      // Constraint for operand 'a'
    constraint input_b_c { b inside {[1:10]}; }       // Constraint for operand 'b'
    constraint op_code_c { op_code inside {0,1,2,3}; } // Allowed opcodes (e.g., 0: add, 1: sub, etc.)

endclass
