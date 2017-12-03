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
		en, oe, we : out  STD_LOGIC;
		rdn, wrn : out STD_LOGIC;
		tbre, tsre : in STD_LOGIC
	); --"00" Disabled; "01" Write; "10" Read; "11" Enabled;
	-- 0 Write 1 Read
end DM;

architecture Behavioral of DM is
begin
	rdn <= '1';
	wrn <= '1';
	process (clk, memoryMode)
	begin
		if (memoryMode(1) = '1') then
			readData <= X"0000";
		else
			readData <= ramData;
		end if;
		if (memoryMode(0) = '1') then
			ramData <= writeData;
		else
			ramData <= "ZZZZZZZZZZZZZZZZ";
		end if;
		ramAddr <= "00" & addr;
		if (clk = '0') then
			oe <= memoryMode(1);
			we <= memoryMode(0);
			en <= '0';
		elsif (clk = '1') then
			oe <= '1';
			we <= '1';
			en <= '1';
		end if;
	end process;
end Behavioral;