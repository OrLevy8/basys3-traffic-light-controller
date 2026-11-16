library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;

entity TB_TOP_LEVEL is
end TB_TOP_LEVEL;

architecture TB_TOP_LEVEL_ARC of TB_TOP_LEVEL is

component TOP_LEVEL
port
(
  CLK	: in  std_logic;
  RESET	: in  std_logic;
  TPL	: out std_logic_vector(4 downto 0)
);
end component;

signal  TB_CLK		: std_logic := '0';
signal  TB_RESET	: std_logic;
signal  TB_TPL		: std_logic_vector(4 downto 0);

begin

DUT: TOP_LEVEL
port map
(
  RESET => TB_RESET,
  CLK	=> TB_CLK,
  TPL 	=> TB_TPL
);

process
begin
  wait for 5 ns;
  TB_CLK <= not(TB_CLK);
end process;

TB_RESET <= '1',
		   '0' after 113 ns;
		 
end TB_TOP_LEVEL_ARC;