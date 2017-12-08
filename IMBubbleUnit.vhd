library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity IMBubbleUnit is
	Port 
	( 
		IMStay : out STD_LOGIC;
		PCStay : out STD_LOGIC;
		branchBubble : in STD_LOGIC;
		writeInstruction : in STD_LOGIC
	);
end IMBubbleUnit;

architecture Behavioral of IMBubbleUnit is
begin
	process (writeInstruction, branchBubble)
	begin
		--if (branchBubble = '0' and writeInstruction = '0') then
		--	IMStay <= '0';
		--	PCStay <= '0';
		--elsif (branchBubble = '0' and writeInstruction = '1') then
		--	IMStay <= '1';
		--	PCStay <= '1';
		--elsif (branchBubble = '1' and writeInstruction = '0') then
		--	IMStay <= '1';
		--	PCStay <= '0';
		--else 
		--	IMStay <= '1';
		--	PCStay <= '0';
		--end if;
		IMStay <= branchBubble or writeInstruction;
		PCStay <= (not branchBubble) and writeInstruction;
	end process;
end Behavioral;