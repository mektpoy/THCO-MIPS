----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:31:20 11/23/2017 
-- Design Name: 
-- Module Name:    ForwardUnit - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ForwardUnit is
    Port ( resultAddr : in STD_LOGIC_VECTOR (3 downto 0);
    	   regWbAddr : in STD_LOGIC_VECTOR (3 downto 0);
    	   rxAddr : in STD_LOGIC_VECTOR (3 downto 0);
    	   ryAddr : in STD_LOGIC_VECTOR (3 downto 0);
           forwardOp0 : out STD_LOGIC_VECTOR (1 downto 0);
           forwardOp1 : out STD_LOGIC_VECTOR (1 downto 0);
end ForwardUnit;

architecture Behavioral of ForwardUnit is
begin
	process (resultAddr, regWbAddr, rxAddr, ryAddr)
	begin
		if (rxAddr /= "1111") then
			if (rxAddr = resultAddr) then
				forwardOp0 <= "00";
			elsif (rxAddr = regWbAddr) then
				forwardOp0 <= "01";
			else
				forwardOp0 <= "10";
			end if;
		else
			forwardOp0 <= "10";
		end if;
		
		if (ryAddr /= "1111") then
			if (ryAddr = resultAddr) then
				forwardOp1 <= "00";
			elsif (ryAddr = regWbAddr) then
				forwardOp1 <= "01";
			else
				forwardOp1 <= "10";
			end if;
		else
			forwardOp1 <= "10";
		end if;

	end process;
end Behavioral;

