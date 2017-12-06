----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:03:19 23/11/2074 
-- Design Name: 
-- Module Name:    IF2ID - Behavioral 
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

entity IF2ID is
    Port 
    ( 
		clk: in STD_LOGIC;
		rst: in STD_LOGIC;
		stay: in STD_LOGIC;
		IMstay : in STD_LOGIC;
		branchBubble : in STD_LOGIC;
		PCin : in  STD_LOGIC_VECTOR (15 downto 0);
		PCout : out STD_LOGIC_VECTOR (15 downto 0);
		Instructionin : in  STD_LOGIC_VECTOR (15 downto 0);
		Instructionout : out  STD_LOGIC_VECTOR (15 downto 0)
	);
end IF2ID;

architecture Behavioral of IF2ID is

begin
	process(clk, rst)
	begin
		if(rst = '0') then
			PCout <= X"0000";
			Instructionout <= "0000100000000000";
		elsif(rising_edge(clk)) then
			if (stay = '0' and IMstay = '0') then
				Instructionout <= Instructionin;
				PCout <= PCin;
			end if;
			if (branchBubble = '1') then
				PCout <= X"0000";
				Instructionout <= "0000100000000000";
			end if;
		end if;
	end process;
end Behavioral;

