----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:22:20 11/22/2017 
-- Design Name: 
-- Module Name:    RegisterFile - Behavioral 
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

entity RegisterFile is
    Port ( rxAddr : in STD_LOGIC_VECTOR (3 downto 0);
           ryAddr : in STD_LOGIC_VECTOR (3 downto 0);
           regWbAddr : in STD_LOGIC_VECTOR (3 downto 0);
           regWbValue : in STD_LOGIC_VECTOR (15 downto 0);
           regWriteClk : in STD_LOGIC;
           rxValue : out STD_LOGIC_VECTOR (15 downto 0);
           ryValue : out STD_LOGIC_VECTOR (15 downto 0));
end RegisterFile;

architecture Behavioral of RegisterFile is
	type regs is array(15 downto 0) of STD_LOGIC_VECTOR(15 downto 0);
	signal data : regs := (others => (others => '0'));
begin
	process (regWriteClk)
	begin
		if (rising_edge(regWriteClk)) then
			data(conv_integer(regWbAddr)) <= regWbValue;
			if (conv_integer(rxAddr) = conv_integer(regWbAddr)) then
				rxValue <= data(conv_integer(rxAddr));
			if (conv_integer(ryAddr) = conv_integer(regWbAddr)) then
				ryValue <= data(conv_integer(ryAddr));
		end if;
	end process;
	
	process (rxAddr, ryAddr)
	begin
		rxValue <= data(conv_integer(rxAddr));
		ryValue <= data(conv_integer(ryAddr));
	end process;
end Behavioral;

