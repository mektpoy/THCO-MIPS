----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:11:20 11/23/2017 
-- Design Name: 
-- Module Name:    BMux0 - Behavioral 
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

entity BMux0 is
    Port ( forwardOp1 : in STD_LOGIC_VECTOR (1 downto 0);
           ryValue : in STD_LOGIC_VECTOR (15 downto 0);
           result : in STD_LOGIC_VECTOR (15 downto 0);
           regWbValue : in STD_LOGIC_VECTOR (15 downto 0);
           inputA : out STD_LOGIC_VECTOR (15 downto 0);
end BMux0;

architecture Behavioral of BMux0 is
begin
	process (forwardOp1, ryValue, result, regWbValue)
	begin
		case forwardOp1 is
			when "00" =>
				inputA <= ryValue;
			when "01" =>
				inputA <= result;
			when "10" =>
				inputA <= regWbValue;
		end case;
	end process;
end Behavioral;
