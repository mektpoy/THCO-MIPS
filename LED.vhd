library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity LED is
	Port 
	( 
		ledIn : in STD_LOGIC_VECTOR (15 downto 0);
		ledOut : out STD_LOGIC_VECTOR (15 downto 0)
	); --"00" Disabled; "01" Read; "10" Write; "11" Enabled;
	-- 0 Read 1 Write
end LED;

architecture Behavioral of LED is
begin
	ledOut <= ledIn;
end Behavioral;