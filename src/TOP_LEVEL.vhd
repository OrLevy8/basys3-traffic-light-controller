library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity TOP_LEVEL is
port
(
	CLK		:	in  std_logic;
	RESET	:	in  std_logic;
	TPL		:	out	std_logic_vector(4 downto 0)
);
end TOP_LEVEL;

architecture TOP_LEVEL_ARC of TOP_LEVEL is

component TIMEBASE
port
(
	CLK		:	in  std_logic;
	RESET	:	in  std_logic;
	TC_TIMEBASE	:	out std_logic
);
end component;

component COUNTERS
port
(
	CLK		:	in  std_logic;
	RESET	:	in  std_logic;
	C_EN		:	in 	std_logic;
	SEL		:	in	std_logic;
	TC_CNTR	:	out std_logic
);
end component;

component CONTROL_UNIT
port
(
	CLK		:	in  std_logic;
	RESET	:	in  std_logic;
	TC_CNTR	:	in	std_logic;
	SEL		:	out	std_logic;
	TPL		:	out	std_logic_vector(4 downto 0)
);
end component;

signal	ENABLE	: std_logic;
signal	SEL		: std_logic;
signal	NEXT_STAGE	: std_logic;

begin

	U0:	TIMEBASE		port map(CLK, RESET, ENABLE);
	U1: COUNTERS		port map(CLK, RESET, ENABLE, SEL, NEXT_STAGE);
	U2: CONTROL_UNIT	port map(CLK, RESET, NEXT_STAGE, SEL, TPL);

end TOP_LEVEL_ARC;