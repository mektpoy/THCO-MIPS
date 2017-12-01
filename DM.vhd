library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DM is
	Port 
	( 
		writeData : in  STD_LOGIC_VECTOR (15 downto 0);
		addr : in  STD_LOGIC_VECTOR (15 downto 0);
		clk : in  STD_LOGIC;
		memoryMode : in  STD_LOGIC_VECTOR (1 downto 0);
		ramAddr : out STD_LOGIC_VECTOR (17 downto 0);
		ramData : inout STD_LOGIC_VECTOR (15 downto 0);
		readData : out STD_LOGIC_VECTOR (15 downto 0);
		en, oe, we : out  STD_LOGIC
	); --"00" Disabled; "01" Read; "10" Write; "11" Enabled;
end DM;

architecture Behavioral of DM is
begin
	readData <= ramData when memoryMode(0) = '1' else X"0000";
	ramData <= writeData when memoryMode(1) = '1' else "ZZZZZZZZZZZZZZZZ";
	ramAddr <= "00" & addr;
	oe <= '0' when memoryMode(0) = '0' and clk = '0' else '1';
	we <= (not memoryMode(0)) or clk;
	en <= '0';
end Behavioral;