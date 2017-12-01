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
		clk : in STD_LOGIC;
		rst : in STD_LOGIC
	); --"00" Disabled; "01" Read; "10" Write; "11" Enabled;
end IM;

architecture Behavioral of IM is
begin
	en <= '0'; --enable the ram
	we <= '1'; --disable writing
	process(clk)
	begin
		if(rising_edge(clk))then			--prepare the signals needed for reading the ram on the rising edge.
			we <= '1';
			oe <= '0';
			ramAddr <= "00" & readAddr;
			ramData <= "ZZZZZZZZZZZZZZZZ";
		end if;
	end process;
	
	process(clk)
	begin
		if(falling_edge(clk)) then			--assign the read out data to the instr signal on the falling edge.
			instr <= ramdata;
			we <= '1';
			oe <= '1';			--disable reading after finishing.
		end if;
	end process;
end Behavioral;