library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALUMux is
    Port 
	( 
		result : in STD_LOGIC_VECTOR (16 downto 0);
		inputB : in STD_LOGIC_VECTOR (15 downto 0);
		aluResultSrc : in STD_LOGIC_VECTOR (1 downto 0);
		aluResult : out STD_LOGIC_VECTOR (15 downto 0)
	);
end ALUMux;

architecture Behavioral of ALUMux is
begin
	process (result, inputB, aluResultSrc)
	begin
		case aluResultSrc is
			when "00" =>
				if (result = X"0000" & '0') then
					aluResult <= result (15 downto 0);
				else
					aluResult <= X"000" & "0001";
				end if;
			when "01" =>
				aluResult <= X"000" & "000" & result(15);
			when "10" =>
				aluResult <= result (15 downto 0);
			when others =>
				aluResult <= inputB;
		end case;
	end process;
end Behavioral;

