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

		WriteInstruction : in STD_LOGIC_VECTOR(16 downto 0)
		--16 : write instruction or not
		--15 downto 0 : instruction to write
	); --"00" Disabled; "01" Write; "10" Read; "11" Enabled;
	-- 0 Write 1 Read
end IMBubbleUnit;

architecture Behavioral of IMBubbleUnit is
begin
	process (WriteInstruction)
		IMStay <= WriteInstruction(16);
	begin
end Behavioral;