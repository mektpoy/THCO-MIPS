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
    Port ( 
           clk: in STD_LOGIC;
           rst: in STD_LOGIC;
           rxValueIn : in STD_LOGIC_VECTOR (15 downto 0);
    	   ryValueIn : in STD_LOGIC_VECTOR (15 downto 0);
    	   immeIn : in STD_LOGIC_VECTOR (15 downto 0);
    	   regWryAddrIn : in STD_LOGIC_VECTOR (3 downto 0);

           rxValueOutbAddrIn : in STD_LOGIC_VECTOR (3 downto 0);
    	   rxAddrIn : in STD_LOGIC_VECTOR (3 downto 0);
    	    : out STD_LOGIC_VECTOR (15 downto 0);
    	   ryValueOut : out STD_LOGIC_VECTOR (15 downto 0);
    	   immeOut : out STD_LOGIC_VECTOR (15 downto 0);
    	   regWbAddrOut : out STD_LOGIC_VECTOR (3 downto 0);
    	   rxAddrOut : out STD_LOGIC_VECTOR (3 downto 0);
    	   ryAddrOut : out STD_LOGIC_VECTOR (3 downto 0));
end ID2EX;

architecture Behavioral of ID2EX is
begin
    process(clk, rst)
    begin
        if(rst = '0') then
            rxValueOut <= "0000000000000000";
            ryValueOut <= "0000000000000000";
            immeOut <= "0000000000000000";
            regWbAddrOut <= "0000000000000000";
            rxAddrOut <= "0000000000000000";
            ryAddrOut <= "0000000000000000";

        elsif(clk 'event and clk = '1') then
            rxValueOut <= rxValueIn;
            ryValueOut <= ryValueIn;
            immeOut <= immeIn;
            regWbAddrOut <= regWbAddrIn;
            rxAddrOut <= rxAddrIn;
            ryAddrOut <= ryAddrIn;
        end if;
end Behavioral;

