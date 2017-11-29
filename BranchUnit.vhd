library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BranchUnit is
	Port ( 
		jumpType : in STD_LOGIC_VECTOR(2 downto 0);
		rxValue : in STD_LOGIC_VECTOR(15 downto 0);
		pcSrc : out STD_LOGIC_VECTOR(1 to 0)
	);
end BranchUnit;


-- pcsrc 
-- 00	not jump
-- 01	offset jump
-- 10	reg jump
architecture Behavioral of BranchUnit is
begin
	process (jumpType, rxValue)
	begin
		case jumptype is
			when "000" =>
				PCsrc <= "11";
			when "001" =>
				PCsrc <= "01";
			when "010" =>
				if (rxValue = X"0000") then
					pcSrc <= "01";
				else
					pcSrc <= "11";
				end if;
			when "011" =>
				if (rxValue = X"0000") then
					pcSrc <= "11";
				else
					pcSrc <= "01";
				end if;
			when "100" =>
				PCsrc <= "00";
			when others =>
				PCsrc <= "10";
		end case;
	end process;
end Behavioral;