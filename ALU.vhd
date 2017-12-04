----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:44:28 07/27/2017 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

entity ALU is
    Port 
	(
		inputA : in  STD_LOGIC_VECTOR (15 downto 0);
		inputB : in  STD_LOGIC_VECTOR (15 downto 0);
		aluOp : in  STD_LOGIC_VECTOR (2 downto 0);
		result : out STD_LOGIC_VECTOR (16 downto 0)
	);
end ALU;

architecture Behavioral of ALU is
begin
	process (inputA, inputB, aluOp)
	begin
		case aluOp is
			when "000" =>
				result <= (inputA(15) & inputA) + (inputB(15) & inputB);
			when "001" =>
				result <= (inputA(15) & inputA) - (inputB(15) & inputB);
			when "010" =>
				result <= '0' & (inputA and inputB);
			when "011" =>	
				result <= '0' & (inputA or  inputB);
			when "100" =>
				result <= '0' & (inputA xor inputB);
			when "101" => -- SLL
				if InputB = X"0000" then
					result <= '0' & to_stdlogicvector(to_bitvector(inputA) sll 8);
				else  
					result <= '0' & to_stdlogicvector(to_bitvector(inputA) sll conv_integer(inputB));
				end if;
			when "110" => -- SRA
				if InputB = X"0000" then
					result <= '0' & to_stdlogicvector(to_bitvector(inputA) srl 8);
				else
					result <= '0' & to_stdlogicvector(to_bitvector(inputA) srl conv_integer(inputB));
				end if;
			when others =>
				result <= X"0000" & '0';
		end case;
	end process;
end Behavioral;

