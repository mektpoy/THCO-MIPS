----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:11:20 11/23/2017 
-- Design Name: 
-- Module Name:    BMux - Behavioral 
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

entity BMux is
	Port 
	( 
		BMuxOp : in STD_LOGIC;
		inputB0 : in STD_LOGIC_VECTOR (15 downto 0);
		imme : in STD_LOGIC_VECTOR (15 downto 0);
		inputB : out STD_LOGIC_VECTOR (15 downto 0)
	);
end BMux;

architecture Behavioral of BMux is
begin
	process (BMuxOp, inputB0, imme)
	begin
		case BMuxOp is
			when '0' =>
				inputB <= inputB0;
			when '1' =>
				inputB <= imme;
			when others =>
				inputB <= inputB0;
		end case;
	end process;
end Behavioral;

