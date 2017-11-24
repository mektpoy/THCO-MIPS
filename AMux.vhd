----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:11:20 11/23/2017 
-- Design Name: 
-- Module Name:    AMux - Behavioral 
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

entity AMux is
    Port ( forwardOp0 : in STD_LOGIC_VECTOR (1 downto 0);
           result : in STD_LOGIC_VECTOR (15 downto 0);
           regWbValue : in STD_LOGIC_VECTOR (15 downto 0);
           rxValue : in STD_LOGIC_VECTOR (15 downto 0);
           inputA : out STD_LOGIC_VECTOR (15 downto 0));
end AMux;

architecture Behavioral of AMux is
begin
	process (forwardOp0, result, regWbValue, rxValue)
	begin
		case forwardOp0 is
			when "00" =>
				inputA <= result;
			when "01" =>
				inputA <= regWbValue;
			when "10" =>
				inputA <= rxValue;
		end case;
	end process;
end Behavioral;

