----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:23:51 11/22/2017 
-- Design Name: 
-- Module Name:    Decoder - Behavioral 
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

entity Decoder is
    Port ( instruction : in STD_LOGIC_VECTOR (15 downto 0);
           regWbAddr : out STD_LOGIC_VECTOR (3 downto 0);
           rxAddr : out STD_LOGIC_VECTOR (3 downto 0);
           ryAddr : out STD_LOGIC_VECTOR (3 downto 0);
           imme : out STD_LOGIC_VECTOR (15 downto 0);
           instrId : out STD_LOGIC_VECTOR (4 downto 0);
end Decoder;

architecture Behavioral of Decoder is
begin
	process(insturction)
	begin
		
	end process;
end Behavioral;

