library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tri_state_mux4 is
  generic(W : integer := 8);
  port(en : in std_logic; sel : in std_logic_vector(1 downto 0);
       d0,d1,d2,d3 : in std_logic_vector(W-1 downto 0); y : out std_logic_vector(W-1 downto 0));
end entity;
architecture rtl of tri_state_mux4 is
begin
  y <= d0 when en='1' and sel="00" else d1 when en='1' and sel="01" else
       d2 when en='1' and sel="10" else d3 when en='1' and sel="11" else (others => 'Z');
end architecture;
