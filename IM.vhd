library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity IM is
	Port 
	(
		writeInstruction : in STD_LOGIC;
		IMValue : in STD_LOGIC_VECTOR (15 downto 0);
		IMAddr : in STD_LOGIC_VECTOR(15 downto 0);
		readAddr : in STD_LOGIC_VECTOR (15 downto 0);
		instr : out STD_LOGIC_VECTOR (15 downto 0);
		ramAddr : out  STD_LOGIC_VECTOR (17 downto 0);
		ramData : inout STD_LOGIC_VECTOR (15 downto 0);
		en : out  STD_LOGIC;
		oe : out  STD_LOGIC;
		we : out  STD_LOGIC;
		clk : in STD_LOGIC
	);
end IM;

architecture Behavioral of IM is
begin
	en <= '0'; --enable the ram
	process(readAddr, writeInstruction, IMAddr, IMValue)
	begin
		if(writeInstruction = '1') then
			ramAddr <= "00" & IMAddr;
			ramData <= IMValue;
		else
			ramAddr <= "00" & readAddr;
			ramData <= "ZZZZZZZZZZZZZZZZ";
		end if;
	end process;

	process(clk, writeInstruction)
	begin			--prepare the signals needed for reading the ram on the rising edge.
		if (clk = '0') then
			if(WriteInstruction = '1') then
				we <= '0';
				oe <= '1';
			else
				we <= '1';
				oe <= '0';
			end if;
		else
			oe <= '1';
			we <= '1'; --disable writing
		end if;
		instr <= ramData;
	end process;
end Behavioral;