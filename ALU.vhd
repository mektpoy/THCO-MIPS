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
    Port ( inputA : in  STD_LOGIC_VECTOR (15 downto 0);
           inputB : in  STD_LOGIC_VECTOR (15 downto 0);
           aluOp : in  STD_LOGIC_VECTOR (3 downto 0);
           result : buffer  STD_LOGIC_VECTOR (15 downto 0);
           aluZero : out STD_LOGIC;
           aluSign : out STD_LOGIC;
end ALU;

architecture Behavioral of ALU is
begin
	aluSign <= result(15);--sign bit
	process (result) --zero bit
	begin
		if (result = X"0000") then
			aluZero <= '1';
		else
			aluZero <= '0';
		end if;
	end process;
	
	process (inputA, inputB, aluOp)
	begin
		case op is
			when "0000" =>
				result <= ('0' & inputA) + ('0' & inputB);
			when "0001" =>
				result <= ('0' & inputA) - ('0' & inputB);
			when "0010" =>
				result <= (inputA and inputB);
				flag(0)<= '0';
			when "0011" =>	
				result <= (inputA or inputB);
				flag(0) <= '0';
			when "0100" =>
				result <= (inputA xor inputB);
				flag(0) <= '0';
			when "0101" => -- SLL
				if InputB = "0000000000000000" then
					result <= to_stdlogicvector(to_bitvector(inputA) sll 8);
				else
					result <= to_stdlogicvector(to_bitvector(inputA) sll conv_integer(inputB));
				end if;
				flag(0) <= '0';
			when "0110" => -- SRA
				if InputB = "0000000000000000" then
					result <= to_stdlogicvector(to_bitvector(inputA) srl 8);
				else
					result <= to_stdlogicvector(to_bitvector(inputA) srl conv_integer(inputB));
				end if;
				flag(0) <= '0';
			when others =>
				result <= "1111111111111111";
		end case;
	end process;
end Behavioral;

