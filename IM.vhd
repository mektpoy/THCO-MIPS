library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity IM is
	Port 
	( 
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
	we <= '1'; --disable writing
	process(clk)
	begin			--prepare the signals needed for reading the ram on the rising edge.
		if (clk = '1') then
			oe <= '1';
		else
			oe <= '0';
		end if;
		ramAddr <= "00" & readAddr;
		instr <= ramData;
	end process;
end Behavioral;