set_property PACKAGE_PIN Y18 [get_ports clk]       
set_property IOSTANDARD LVCMOS33 [get_ports clk]

set_property PACKAGE_PIN R1 [get_ports rst]    
set_property IOSTANDARD LVCMOS33 [get_ports rst]

set_property -dict { PACKAGE_PIN Y19 IOSTANDARD LVCMOS33 } [get_ports  uart_rx];  
set_property -dict { PACKAGE_PIN V18 IOSTANDARD LVCMOS33 } [get_ports  uart_tx];