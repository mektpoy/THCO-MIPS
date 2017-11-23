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

entity ALUMux is
    Port ( aluZero : in STD_LOGIC;
           aluSign : in STD_LOGIC;
           result : in STD_LOGIC_VECTOR (15 downto 0);
           inputB : in STD_LOGIC_VECTOR (15 downto 0);
           aluResultSrc : in STD_LOGIC_VECTOR (1 downto 0);
           aluResult : out STD_LOGIC_VECTOR (15 downto 0));
end ALUMux;

architecture Behavioral of ALUMux is
begin
	process (aluZero, aluSign, result, inputB, aluResultSrc)
	begin
		case aluResultSrc is
			when "00" =>
				aluResult <= X"000" & "000" & aluZero;
			when "01" =>
				aluResult <= X"000" & "000" & aluSign;
			when "10" =>
				aluResult <= result;
			when "11" =>
				aluResult <= inputB;
		end case;
	end process;
end Behavioral;

