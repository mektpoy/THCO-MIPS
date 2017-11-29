library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity IM is
	Port 
	( 
		ReadAddress : in STD_LOGIC_VECTOR (15 downto 0);
		Instruction : out STD_LOGIC_VECTOR (15 downto 0);
		ADDR : out  STD_LOGIC_VECTOR (17 downto 0);
		DATA : inout  STD_LOGIC_VECTOR (15 downto 0);
		EN : out  STD_LOGIC;
		OE : out  STD_LOGIC;
		WE : out  STD_LOGIC;
		CLK : in  STD_LOGIC;
		MODE : in  STD_LOGIC_VECTOR (1 downto 0)
	); --"00" Disabled; "01" Read; "10" Write; "11" Enabled;
end IM;

architecture Behavioral of IM is
	signal Reading: STD_LOGIC:='1';
	signal Writing: STD_LOGIC:='1';
	begin
		EN<='0';
		process(CLK,MODE)
		begin
			if(CLK'event and CLK='1')then
				if(Reading='0')then
					Instruction<=DATA;
					Reading<='1';
					OE<='1';
				elsif(MODE="01")then
					WE<='1';
					OE<='0';
					ADDR<="00"&ReadAddress;
					DATA<="ZZZZZZZZZZZZZZZZ";
					Reading<='0';
				else
					WE<='1';
					OE<='1';
					Reading<='1';
				end if;
			end if;
		end process;
	end Behavioral;