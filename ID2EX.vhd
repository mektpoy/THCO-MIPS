----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:45:20 11/23/2017 
-- Design Name: 
-- Module Name:    ID2EX - Behavioral 
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

entity ID2EX is
    Port ( rxValueIn : in STD_LOGIC_VECTOR (15 downto 0);
    	   ryValueIn : in STD_LOGIC_VECTOR (15 downto 0);
    	   immeIn : in STD_LOGIC_VECTOR (15 downto 0);
    	   regWbAddrIn : in STD_LOGIC_VECTOR (3 downto 0);
    	   rxAddrIn : in STD_LOGIC_VECTOR (3 downto 0);
    	   ryAddrIn : in STD_LOGIC_VECTOR (3 downto 0);

           rxValueOut : out STD_LOGIC_VECTOR (15 downto 0);
    	   ryValueOut : out STD_LOGIC_VECTOR (15 downto 0);
    	   immeOut : out STD_LOGIC_VECTOR (15 downto 0);
    	   regWbAddrOut : out STD_LOGIC_VECTOR (3 downto 0);
    	   rxAddrOut : out STD_LOGIC_VECTOR (3 downto 0);
    	   ryAddrOut : out STD_LOGIC_VECTOR (3 downto 0);
end ID2EX;

architecture Behavioral of ID2EX is
begin
	process (rxValueIn, ryValueIn, immeIn, regWbAddrIn, rxAddrIn, ryAddrIn)
	begin
		rxValueOut <= rxValueIn;
		ryValueOut <= ryValueIn;
		immeOut <= immeIn;
		regWbAddrOut <= regWbAddrIn;
		rxAddrOut <= rxAddrIn;
		ryAddrOut <= ryAddrIn;
	end process;
end Behavioral;

