class spi_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(spi_scoreboard)

    //uvm_analysis_imp#(spi_seq_item, spi_scoreboard) item_collected_export;
  	
  	`uvm_analysis_imp_decl(_expected)
	`uvm_analysis_imp_decl(_actual)
  
  	uvm_analysis_imp_expected #(spi_seq_item, spi_scoreboard) expected_ap;
    uvm_analysis_imp_actual  #(spi_seq_item, spi_scoreboard) actual_ap;
 	

	//Driver ve monitorden gelen veriler queue si
    spi_seq_item expected_q[$];
    spi_seq_item actual_q[$];

    function new(string name = "spi_scoreboard", uvm_component parent);
        super.new(name, parent);
        expected_ap = new("expected_ap", this);
        actual_ap  = new("actual_ap", this);
    endfunction

    //Driverden gelen
    function void write_expected(spi_seq_item t);
        expected_q.push_back(t);
       
    endfunction

    //Monitörden gelen
    function void write_actual(spi_seq_item t);
        actual_q.push_back(t);
        
    endfunction

    task run_phase(uvm_phase phase);
        spi_seq_item item_collected;
      	spi_seq_item item_expected;
        forever begin
            wait(expected_q.size() > 0 && actual_q.size() > 0);

            item_collected = actual_q.pop_front;
          	item_expected = expected_q.pop_front;
          	
          
          //Compare
          if (item_collected.mosi == item_expected.mosi_data_di && item_expected.miso_data == item_collected.miso) begin
             $display("----------------------------------------------------------------");
            `uvm_info("SCOREBOARD_MATCH", $sformatf("BASARILI: Beklenen MOSI verisi = %d, Gelen MOSI verisi = %d", item_collected.mosi, item_expected.mosi_data_di), UVM_LOW)
            `uvm_info("SCOREBOARD_MATCH", $sformatf("MASTERE RANDOM SURDUGUMUZ VERI(slave gonderir) - %d VE MASTERIN EN SONDA SHIFT REGISTERINDE OLAN VERI - %d", item_expected.miso_data, item_collected.miso), UVM_LOW)
            $display("----------------------------------------------------------------");
            $display("----------------------------------------------------------------");
            end else begin
              if(item_collected.mosi != item_expected.mosi_data_di)begin
                $display("----------------------------------------------------------------");
                `uvm_error("SCOREBOARD_MISMATCH", $sformatf("HATA: Beklenen MOSI = %d, Gelen MOSI = %d", item_collected.mosi, item_expected.mosi_data_di))
                $display("----------------------------------------------------------------");
                $display("----------------------------------------------------------------");
              end
              if(item_expected.miso_data != item_collected.miso)begin
                $display("----------------------------------------------------------------");
                `uvm_error("SCOREBOARD_MISMATCH", $sformatf("HATA: Gonderilen MISO = %d, SHIFT REGTEKI MISO = %d", item_expected.miso_data, item_collected.miso))
                $display("----------------------------------------------------------------");
                $display("----------------------------------------------------------------");
              end
       
            end

        end
    endtask
endclass
