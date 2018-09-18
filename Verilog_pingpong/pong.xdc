#zybo board pins
#VGA

#clk of external reference clock
set_property PACKAGE_PIN L16 [get_ports clkl16]
set_property IOSTANDARD LVCMOS33 [get_ports clkl16]

#VGA
set_property PACKAGE_PIN P19 [get_ports vga_h_sync]
set_property IOSTANDARD LVCMOS33 [get_ports vga_h_sync]

set_property PACKAGE_PIN R19 [get_ports vga_v_sync]
set_property IOSTANDARD LVCMOS33 [get_ports vga_v_sync]

#R0
set_property PACKAGE_PIN M19 [get_ports vga_R]
set_property IOSTANDARD LVCMOS33 [get_ports vga_R]

#G0
set_property PACKAGE_PIN H18 [get_ports vga_G]
set_property IOSTANDARD LVCMOS33 [get_ports vga_G]

#B0
set_property PACKAGE_PIN P20 [get_ports vga_B]
set_property IOSTANDARD LVCMOS33 [get_ports vga_B]

#directions 
set_property PACKAGE_PIN R18 [get_ports btn0]
set_property IOSTANDARD LVCMOS33 [get_ports btn0]

set_property PACKAGE_PIN Y16 [get_ports btn3]
set_property IOSTANDARD LVCMOS33 [get_ports btn3]

#test1 fin