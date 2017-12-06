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
		visitIM : in STD_LOGIC_VECTOR(1 downto 0)
	);
end IMBubbleUnit;

architecture Behavioral of IMBubbleUnit is
begin
	process (visitIM)
	begin
		IMStay <= visitIM(0) or visitIM(1);
	end process;
end Behavioral;