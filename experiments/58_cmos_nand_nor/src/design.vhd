library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cmos_nand2 is port(a, b : in std_logic; y : out std_logic); end entity;
architecture rtl of cmos_nand2 is begin y <= not (a and b); end architecture;

library ieee;
use ieee.std_logic_1164.all;
entity cmos_nor2 is port(a, b : in std_logic; y : out std_logic); end entity;
architecture rtl of cmos_nor2 is begin y <= not (a or b); end architecture;
