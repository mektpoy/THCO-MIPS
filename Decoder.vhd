----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:23:51 11/22/2017 
-- Design Name: 
-- Module Name:    Decoder - Behavioral 
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

entity Decoder is
    Port ( instruction : in STD_LOGIC_VECTOR (15 downto 0);
           rxAddr : out STD_LOGIC_VECTOR (3 downto 0);
           ryAddr : out STD_LOGIC_VECTOR (3 downto 0);
           imme : out STD_LOGIC_VECTOR (15 downto 0);
           regWbAddr : out STD_LOGIC_VECTOR (3 downto 0);
           instrId : out STD_LOGIC_VECTOR (4 downto 0));
end Decoder;

architecture Behavioral of Decoder is
begin
	process(instruction)
	begin
		case instruction (15 downto 11) is
			when "01001" => -- ADDIU
				rxAddr <= '0' & instruction(10 downto 8);
				ryAddr <= "1111";
				imme(7 downto 0) <= instruction(7 downto 0);
				imme(15 downto 8) <= (others => instruction(7));
				regWbAddr <= '0' & instruction(10 downto 8);
				instrId <= "00001";
			when "01000" => -- ADDIU3
				rxAddr <= '0' & instruction(10 downto 8);
				ryAddr <= "1111";
				imme(3 downto 0) <= instruction(3 downto 0);
				imme(15 downto 4) <= (others => instruction(3));
				regWbAddr <= '0' & instruction(7 downto 5);
				instrId <= "00010";
			when "00000" => -- ADDSP3
				rxAddr <= "1010";
				ryAddr <= "1111";
				imme(7 downto 0) <= instruction(7 downto 0);
				imme(15 downto 8) <= (others => instruction(7));
				regWbAddr <= '0' & instruction(10 downto 8);
				instrId <= "00011";
			when "11100" =>
				case instruction (1 downto 0) is
					when "01" => -- ADDU
						rxAddr <= '0' & instruction(10 downto 8);
						ryAddr <= '0' & instruction(7 downto 5);
						imme(15 downto 0) <= X"0000";
						regWbAddr <= '0' & instruction(4 downto 2);
						instrId <= "00101";
					when "11" => -- SUBU
						rxAddr <= '0' & instruction(10 downto 8);
						ryAddr <= '0' & instruction(7 downto 5);
						imme(15 downto 0) <= (others => '0');
						regWbAddr <= '0' & instruction(4 downto 2);
						instrId <= "11011";
				end case;
			when "11101" => 
				case instruction (4 downto 0) is
					when "01100" => -- AND
						rxAddr <= '0' & instruction(10 downto 8);
						ryAddr <= '0' & instruction(7 downto 5);
						imme(15 downto 0) <= X"0000";
						regWbAddr <= '0' & instruction(10 downto 8);
						instrId <= "00110";
					when "01010" => -- CMP
						rxAddr <= '0' & instruction(10 downto 8);
						ryAddr <= '0' & instruction(7 downto 5);
						imme(15 downto 0) <= X"0000";
						regWbAddr <= "1010";
						instrId <= "01011";
					when "00000" => -- JR
						if (instruction(7 downto 5) = "000") then
							rxAddr <= '0' & instruction(10 downto 8);
							ryAddr <= "1111";
							imme(15 downto 0) <= X"0000";
							regWbAddr <= "1111";
							instrId <= "01100";
						else -- MFPC
							rxAddr <= "1000";
							ryAddr <= "1111";
							imme(15 downto 0) <= X"0000";
							regWbAddr <= '0' & instruction(10 downto 8);
							instrId <= "10001";
						end if;
					when "01101" => -- OR
						rxAddr <= '0' & instruction(10 downto 8);
						ryAddr <= '0' & instruction(7 downto 5);
						imme(15 downto 0) <= X"0000";
						regWbAddr <= '0' & instruction(10 downto 8);
						instrId <= "10110";
				end case;
			when "00010" => -- B
				rxAddr <= "1111";
				ryAddr <= "1111";
				imme(10 downto 0) <= instruction(10 downto 0);
				imme(15 downto 11) <= (others => instruction(10));
				regWbAddr <= "1111";
				instrId <= "00111";
			when "00100" => -- BEQZ
				rxAddr <= '0' & instruction(10 downto 8);
				ryAddr <= "1111";
				imme(7 downto 0) <= instruction(7 downto 0);
				imme(15 downto 8) <= (others => instruction(7));
				regWbAddr <= "1111";
				instrId <= "01000";
			when "00101" => -- BNEZ
				rxAddr <= '0' & instruction(10 downto 8);
				ryAddr <= "1111";
				imme(7 downto 0) <= instruction(7 downto 0);
				imme(15 downto 8) <= (others => instruction(7));
				regWbAddr <= "1111";
				instrId <= "01001";
			when "00101" => -- BTEQZ
				rxAddr <= '0' & instruction(10 downto 8);
				ryAddr <= "1111";
				imme(7 downto 0) <= instruction(7 downto 0);
				imme(15 downto 8) <= (others => instruction(7));
				regWbAddr <= "1111";
				instrId <= "01010";
			when "01101" => -- LI
				rxAddr <= "1111";
				ryAddr <= "1111";
				imme(7 downto 0) <= instruction(7 downto 0);
				imme(15 downto 8) <= X"00";
				regWbAddr <= '0' & instruction(10 downto 8);
				instrId <= "01101";
			when "10011" => -- LW
				rxAddr <= '0' & instruction(10 downto 8);
				ryAddr <= "1111";
				imme(4 downto 0) <= instruction(4 downto 0);
				imme(15 downto 5) <= (others => instruction(4));
				regWbAddr <= '0' & instruction(7 downto 5);
				instrId <= "01110";
			when "10010" => -- LW_SP
				rxAddr <= "0101";
				ryAddr <= "1111";
				imme(7 downto 0) <= instruction(7 downto 0);
				imme(15 downto 8) <= (others => instruction(7));
				regWbAddr <= '0' & instruction(10 downto 8);
				instrId <= "01111";
			when "11110" => 
				case instruction(0) is
					when '0' => -- MFIH
						rxAddr <= "1111";
						ryAddr <= "1010";
						imme(15 downto 0) <= X"0000";
						regWbAddr <= '0' & instruction(10 downto 8);
						instrId <= "10000";
					when '1' => -- MTIH
						rxAddr <= "1111";
						ryAddr <= '0' & instruction(10 downto 8);
						imme(15 downto 0) <= X"0000";
						regWbAddr <= "1010";
						instrId <= "10011";
				end case;
			when "01111" => -- MOVE
				rxAddr <= "1111";
				ryAddr <= '0' & instruction(7 downto 5);
				imme(15 downto 0) <= X"0000";
				regWbAddr <= '0' & instruction(10 downto 8);
				instrId <= "10010";
			when "00001" => -- NOP
				rxAddr <= "1111";
				ryAddr <= "1111";
				imme(15 downto 0) <= X"0000";
				regWbAddr <= "1111";
				instrId <= "10101";
			when "00110" =>
				case instruction(1 downto 0) is
					when "00" => -- SLL
						rxAddr <= '0' & instruction(7 downto 5);
						ryAddr <= "1111";
						imme(2 downto 0) <= instruction(4 downto 2);
						imme(15 downto 3) <= (others => '0');
						regWbAddr <= '0' & instruction(10 downto 8);
						instrId <= "10111";
					when "11" => -- SRA
						rxAddr <= '0' & instruction(7 downto 5);
						ryAddr <= "1111";
						imme(2 downto 0) <= instruction(4 downto 2);
						imme(15 downto 3) <= (others => '0');
						regWbAddr <= '0' & instruction(10 downto 8);
						instrId <= "11010";
				end case;
			when "11101" => -- SLT
				rxAddr <= '0' & instruction(10 downto 8);
				ryAddr <= '0' & instruction(7 downto 5);
				imme(15 downto 0) <= X"0000";
				regWbAddr <= "1100";
				instrId <= "11000";
			when "01010" => -- SLTI
				rxAddr <= '0' & instruction(10 downto 8);
				ryAddr <= "1111";
				imme(7 downto 0) <= instruction(7 downto 0);
				imme(15 downto 8) <= (others => instruction(7));
				regWbAddr <= "1100";
				instrId <= "11001";
			when "11011" => -- SW
				rxAddr <= '0' & instruction(10 downto 8);
				ryAddr <= '0' & instruction(7 downto 5);
				imme(4 downto 0) <= instruction(4 downto 0);
				imme(15 downto 5) <= (others => instruction(4));
				regWbAddr <= "1111";
				instrId <= "11100";
			when "01100" =>
				case instruction(10 downto 8) is
					when "100" => -- MTSP
						rxAddr <= "1111";
						ryAddr <= instruction(7 downto 5);
						imme(15 downto 0) <= (others => '0');
						regWbAddr <= "1001";
						instrId <= "10100";
					when "011" => -- SW_RS
						rxAddr <= "1001";
						ryAddr <= "1111";
						imme(7 downto 0) <= instruction(7 downto 0);
						imme(15 downto 8) <= (others => instruction(7));
						regWbAddr <= "1001";
						instrId <= "11101";
					when "010" => -- ADDSP
						rxAddr <= "1001";
						ryAddr <= "1111";
						imme(7 downto 0) <= instruction(7 downto 0);
						imme(15 downto 8) <= (others => instruction(7));
						regWbAddr <= "1111";
						instrId <= "00100";
				end case;
			when "11010" => -- SW_SP
				rxAddr <= instruction(10 downto 8);
				ryAddr <= "1111";
				imme(7 downto 0) <= instruction(7 downto 0);
				imme(15 downto 8) <= (others => instruction(7));
				regWbAddr <= "1111";
				instrId <= "11110";
		end case;
	end process;
end Behavioral;

