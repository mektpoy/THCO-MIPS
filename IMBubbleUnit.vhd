library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity IMBubbleUnit is
	Port 
	( 
		IMStay : out STD_LOGIC;
		--0 : not stay
		--1 : stay
		writeInstruction : in STD_LOGIC
	);
end IMBubbleUnit;

architecture Behavioral of IMBubbleUnit is
begin
	process (writeInstruction)
	begin
		IMStay <= writeInstruction;
	end process;
end Behavioral;