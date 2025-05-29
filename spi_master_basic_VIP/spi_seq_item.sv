class spi_seq_item extends uvm_sequence_item;
    

    rand bit[7:0] mosi_data_di; //master send this data
    rand bit[7:0] miso_data;  //our vip send this data to master
                              //then we read this data via data_out
         bit[7:0] mosi;
  		 bit[7:0] miso;
         

    `uvm_object_utils_begin(spi_seq_item)
        `uvm_field_int(mosi_data_di, UVM_ALL_ON)
        `uvm_field_int(miso_data, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "spi_seq_item");
        super.new(name);
    endfunction

    
    function string convert2str();
        return $sformatf("mosi data = %d, miso data=%d", mosi_data_di, miso_data);
    endfunction
endclass
