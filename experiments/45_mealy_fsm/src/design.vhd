library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mealy_1011 is port(clk, rst_n, din : in std_logic; detected : out std_logic); end entity;
architecture rtl of mealy_1011 is
  type state_t is (s0, s1, s10, s101);
  signal state, next_state : state_t;
begin
  process(clk, rst_n) begin if rst_n='0' then state <= s0; elsif rising_edge(clk) then state <= next_state; end if; end process;
  process(state, din) begin
    detected <= '0';
    case state is
      when s0 => if din='1' then next_state <= s1; else next_state <= s0; end if;
      when s1 => if din='1' then next_state <= s1; else next_state <= s10; end if;
      when s10 => if din='1' then next_state <= s101; else next_state <= s0; end if;
      when others => detected <= din; if din='1' then next_state <= s1; else next_state <= s10; end if;
    end case;
  end process;
end architecture;
