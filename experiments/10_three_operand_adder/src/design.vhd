library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add3_8 is port(a,b,c : in std_logic_vector(7 downto 0); sum : out std_logic_vector(9 downto 0)); end entity;
architecture rtl of add3_8 is
begin
  sum <= std_logic_vector(resize(unsigned(a),10) + resize(unsigned(b),10) + resize(unsigned(c),10));
end architecture;
