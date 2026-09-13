library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seven_segment_decoder is
  port(hex : in std_logic_vector(3 downto 0); seg : out std_logic_vector(6 downto 0));
end entity;
architecture rtl of seven_segment_decoder is
begin
  with hex select seg <=
    "1111110" when x"0", "0110000" when x"1", "1101101" when x"2", "1111001" when x"3",
    "0110011" when x"4", "1011011" when x"5", "1011111" when x"6", "1110000" when x"7",
    "1111111" when x"8", "1111011" when x"9", "1110111" when x"A", "0011111" when x"B",
    "1001110" when x"C", "0111101" when x"D", "1001111" when x"E", "1000111" when others;
end architecture;
