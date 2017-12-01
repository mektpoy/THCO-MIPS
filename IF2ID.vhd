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
			PCout <= "0000000000000000";
			Instructionout <= "0000000000000000";

		elsif(clk 'event and clk = '1') then
				if(stay = '0') then
					Instructionout <= Instructionin;
					PCout <= PCin;
				end if;
		end if;
	end process;
end Behavioral;

