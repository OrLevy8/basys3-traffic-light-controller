library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;

entity TIMEBASE is
port
(
  CLK:    in  std_logic;
  RESET:  in  std_logic;
  TC_TIMEBASE:     out std_logic
);
end TIMEBASE;

architecture TIMEBASE_ARC of TIMEBASE is
	signal Q: std_logic_vector(26 downto 0);
begin

process
begin
 wait until rising_edge(CLK);
 if (RESET = '1') then
 Q <= (others => '0');
 else
    if (Q < 9) then
    Q <= Q + 1;
    else
    Q <= (others => '0');
    end if;
 end if;
end process;

TC_TIMEBASE <= '1' when (Q = 0) else '0';

end TIMEBASE_ARC;
