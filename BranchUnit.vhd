library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BranchUnit is
	Port ( 
		jumptype : in STD_LOGIC_VECTOR(2 downto 0);
		equal : in STD_LOGIC;
		PCsrc : out STD_LOGIC_VECTOR(1 to 0)
	);
end BranchUnit;


-- pcsrc 
-- 00	not jump
-- 01	offset jump
-- 10	reg jump
architecture Behavioral of BranchUnit is
begin
	process (jumptype, equal)
	begin
		case jumptype is
			when "000" =>
				PCsrc <= "00";
			when "001" =>
				PCsrc <= "01";
			when "010" =>
				case equal is:
					when "0":
						PCsrc <= "01";
					when "1":
						pcsrc <= "00";
				end case;
			when "011" =>
				case equal is:
					when "0":
						PCsrc <= "00";
					when "1":
						PCsrc <= "01";
				end case;
			when "100" =>
				PCsrc <= "10";
			when others =>
				PCsrc <= "00"
		end case;
	end process;
end Behavioral;