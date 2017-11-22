----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:44:28 11/22/2017 
-- Design Name: 
-- Module Name:    Register - Behavioral 
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating  
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RegisterFile is
    Port ( rxAddr : in STD_LOGIC_VECTOR (3 downto 0);
           ryAddr : in STD_LOGIC_VECTOR (3 downto 0);
           regWbAddr : in STD_LOGIC_VECTOR (3 downto 0);
           regWbValue : in STD_LOGIC_VECTOR (15 downto 0);
           regWriteClk : in STD_LOGIC;
           rxValue : out STD_LOGIC_VECTOR (15 downto 0);
           ryValue : out STD_LOGIC_VECTOR (15 downto 0);
end RegisterFile;

architecture Behavioral of RegisterFile is
	type regs is array(15 downto 0) of STD_LOGIC_VECTOR(15 downto 0);
	signal data : regs := (others => (others => '0'));
begin
	process (regWriteClk) --zero bit
	begin
		if (rising_edge(regWriteClk)) then
			data(regWbAddr) <= data(regWbValue);
		end if;
	end process;
	
	process (rxAddr, ryAddr)
	begin
		rxValue <= data(rxAddr);
		ryValue <= data(ryAddr);
	end process;
end Behavioral;

