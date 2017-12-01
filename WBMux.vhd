----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:57:20 11/23/2017 
-- Design Name: 
-- Module Name:    ALUMux - Behavioral 
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

entity WBMux is
    Port 
    ( 
		readData : in STD_LOGIC_VECTOR (15 downto 0);
		aluResult : in STD_LOGIC_VECTOR (15 downto 0);
		resultSrc : in STD_LOGIC;
		regWbValue : out STD_LOGIC_VECTOR (15 downto 0)
	);
end WBMux;

architecture Behavioral of WBMux is
begin
	process (readData, aluResult, resultSrc)
	begin
		case resultSrc is
			when '0' =>
				regWbValue <= readData;
			when '1' =>
				regWbValue <= aluResult;
			when others =>
				regWbValue <= aluResult;
		end case;
	end process;
end Behavioral;

