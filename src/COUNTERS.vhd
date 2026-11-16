library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity COUNTERS is
port
(
	CLK		:	in  std_logic;
	RESET	:	in  std_logic;
	C_EN	:	in 	std_logic;
	SEL		:	in	std_logic;
	TC_CNTR	:	out std_logic
);
end COUNTERS;

architecture COUNTERS_ARC of COUNTERS is
	signal Q2		: std_logic_vector(1 downto 0);
	signal Q10		: std_logic_vector(3 downto 0);
	signal TC_Q2, TC_Q10	: std_logic;
	
begin
	
	-- 2 second counter:
	process
	begin
		wait until rising_edge(CLK);
		if (RESET = '1') then
			Q2 	<= (others => '0');
			TC_Q2 	<= '0';
		else
			if (C_EN = '1') then
				if (SEL = '0') then
					if (Q2 < 1) then		
						Q2 <= Q2 + 1;
						TC_Q2 <= '0';
					else
						Q2 <= (others => '0');
						TC_Q2 <= '1';
					end if;
				else
					Q2 <= (others => '0');
					TC_Q2 <= '0';
				end if;
			end if;
		end if;
	end process;
	

	-- 10 second counter:
	process
	begin
		wait until rising_edge(CLK);
		if (RESET = '1') then
			Q10 <= (others => '0');
			TC_Q10 	<= '0';
		else
			if (C_EN = '1') then
				if (SEL = '1') then
					if (Q10 < 9) then			
						Q10 <= Q10 + 1;
						TC_Q10 <= '0';
					else
						Q10 <= (others => '0');
						TC_Q10 <= '1';
					end if;
				else
					Q10 <= (others => '0');
					TC_Q10 <= '0';
				end if;
			end if;
		end if;
	end process;
	
	-- MUX
	process (SEL, TC_Q2, TC_Q10)
    begin
        case SEL is
            when '0' => TC_CNTR <= TC_Q2;
            when '1' => TC_CNTR <= TC_Q10;
            when others => TC_CNTR <= '0';
        end case;
    end process;	
	
end COUNTERS_ARC;