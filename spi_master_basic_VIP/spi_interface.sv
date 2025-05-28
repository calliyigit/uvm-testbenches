interface spi_interface(input logic mclk, reset);
    logic mosi;
    logic miso;
    logic cs_n;
    logic sclk;
    logic load;
    logic start;
    logic read;
    logic[7:0] data_in;
    logic[7:0] data_out;
endinterface