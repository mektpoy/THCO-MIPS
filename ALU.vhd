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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating  
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( InputA : in  STD_LOGIC_VECTOR (15 downto 0);
           InputB : in  STD_LOGIC_VECTOR (15 downto 0);
           op : in  STD_LOGIC_VECTOR (3 downto 0);
           Fout : buffer  STD_LOGIC_VECTOR (15 downto 0);
           Flag : out  STD_LOGIC_VECTOR (3 downto 0));--0 carry out; 1 zero; 2 sign
end ALU;

architecture Behavioral of ALU is
signal temp:std_logic_vector(16 downto 0);--17bits in case of overflow and need sig-extend
begin
	flag(2) <= Fout(15);--sign bit
	
	process (Fout) --zero bit
	begin
		if (Fout = X"0000") then
			flag(1) <= '1';
		else
			flag(1) <= '0';
		end if;
	end process;
	
	process (InputA, InputB, op, temp)
	begin
		case op is
			when "0000" =>
				Fout <= ('0' & InputA) + ('0' & InputB);
				flag(0) <= temp(16);--
			when "0001" =>
				Fout <= ('0' & InputA) - ('0' & InputB);
				flag(0) <= temp(16);
			when "0010" =>
				Fout <= (InputA and InputB);
				flag(0)<= '0';
			when "0011" =>	
				Fout <= (InputA or InputB);
				flag(0) <= '0';
			when "0100" =>
				Fout <= (InputA xor InputB);
				flag(0) <= '0';
			when "0101" => -- SLL
				if InputB = "0000000000000000" then
					Fout <= to_stdlogicvector(to_bitvector(InputA) sll 8);
				else
					Fout <= to_stdlogicvector(to_bitvector(InputA) sll conv_integer(InputB));
				end if;
				flag(0) <= '0';
			when "0110" => -- SRA
				if InputB = "0000000000000000" then
					Fout <= to_stdlogicvector(to_bitvector(InputA) srl 8);
				else
					Fout <= to_stdlogicvector(to_bitvector(InputA) srl conv_integer(InputB));
				end if;
				flag(0) <= '0';
			when others =>
				Fout <= "1111111111111111";
				flag(0) <= '0';
		end case;
	end process;
end Behavioral;

