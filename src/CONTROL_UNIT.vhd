library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity CONTROL_UNIT is
port
(
	CLK		:	in  std_logic;
	RESET	:	in  std_logic;
	TC_CNTR	:	in	std_logic;
	SEL		:	out	std_logic;
	TPL		:	out	std_logic_vector(4 downto 0)
);
end CONTROL_UNIT;

architecture CONTROL_UNIT_ARC of CONTROL_UNIT is
	type StateType is (A, B, C, D);
	signal STATE: StateType;
begin
	P0: process
	begin
	wait until rising_edge(CLK);
		if (RESET = '1') then
			STATE <= A;
			TPL  <= "01100";
			SEL   <= '1';
		else
			case STATE is
				when A =>
					if (TC_CNTR = '1') then
						STATE <= B;
						TPL <= "10110";
						SEL   <= '0';
					else
						STATE <= A;
						TPL <= "01100";
						SEL   <= '1';
					end if;
				when B =>
					if (TC_CNTR = '1') then
						STATE <= C;
						TPL <= "10001";
						SEL   <= '1';
					else
						STATE <= B;
						TPL <= "10110";
						SEL   <= '0';
					end if;
				when C =>
					if (TC_CNTR = '1') then
						STATE <= D;
						TPL <= "10010";
						SEL   <= '0';
					else
						STATE <= C;
						TPL <= "10001";
						SEL   <= '1';
					end if;
				when D =>
					if (TC_CNTR = '1') then
						STATE <= A;
						TPL <= "01100";
						SEL   <= '1';
					else
						STATE <= D;
						TPL <= "10010";
						SEL   <= '0';
					end if;
			end case;
		end if;
	end process;
end CONTROL_UNIT_ARC;