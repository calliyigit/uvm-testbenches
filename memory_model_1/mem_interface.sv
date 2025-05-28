interface mem_interface(input logic clk, reset);

    //signals
    logic       wr_en;
    logic       rd_en;
    logic [1:0] addr;
    logic [7:0] wdata;
    logic [7:0] rdata;

    //driver clocking block
    //@() ifadesi bu blockingteki islemlerin ne zaman gerceklesecegini soyler
   clocking driver_cb @(posedge clk);
        default input #1 output #1; //sinyalleri clktan 1 birim sonra surer
        output wr_en;
        output rd_en;
        output addr;
        output wdata;
        input  rdata;
    endclocking

    //monitor clocking block
    //@() ifadesi bu blockingteki islemlerin ne zaman gerceklesecegini soyler
   clocking monitor_cb @(posedge clk);
        default input #1 output #1; //sinyalleri clktan 1 birim sonra surer
        input wr_en;
        input rd_en;
        input addr;
        input wdata;
        input rdata;
    endclocking

    //driver modport
    modport DRIVER (clocking driver_cb, input clk, reset);

    //monitor modport
    modport MONITOR (clocking monitor_cb, input clk, reset);
    
endinterface