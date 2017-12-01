library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity HazardUnit is
	Port 
	( 
		memoryRead : in STD_LOGIC;
		regWbAddr : in STD_LOGIC_VECTOR (3 downto 0);
		rxAddr : in STD_LOGIC_VECTOR (15 downto 0);
		ryAddr : in STD_LOGIC_VECTOR (15 downto 0);
		stay : out STD_LOGIC
	);
end HazardUnit;

architecture Behavioral of HazardUnit is
	begin
	process(memoryRead, regWbAddr, rxAddr, ryAddr)
	begin
		if (memoryRead = '1') then
			if (rxAddr = regWbAddr or ryAddr = regWbAddr) then
				stay <= 1;
			else
				stay <= 0;
			end if;
		end if;
	end process;
	end Behavioral;