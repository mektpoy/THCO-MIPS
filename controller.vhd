library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Controller is
    Port 
    ( 
		instrId : in STD_LOGIC_VECTOR (4 downto 0);
		aluOp : out STD_LOGIC_VECTOR (2 downto 0);
		BMuxOp : out STD_LOGIC;
		jumpType : out STD_LOGIC_VECTOR (2 downto 0);
		resultSrc : out STD_LOGIC;
		memoryMode : out STD_LOGIC_VECTOR (1 downto 0);
		aluResultSrc : out STD_LOGIC_VECTOR (1 downto 0);
		regWriteClk : out STD_LOGIC
	);
end Controller;

architecture Behavioral of Controller is
begin
	process (instrId)
	begin
		case instrId is
			when "00001" =>
				aluOp <= "000";
				BMuxOp <= "1";
				jumpType <= "000";
				resultSrc <= "1";
				memoryMode <= "00";
				aluResultSrc <= "10";
			when "00010" =>
				aluOp <= "000";
				BMuxOp <= "1";
				jumpType <= "000";
				resultSrc <= "1";
				memoryMode <= "00";
				aluResultSrc <= "10";
			when "00011" =>
				aluOp <= "000";
				BMuxOp <= "1";
				jumpType <= "000";
				resultSrc <= "1";
				memoryMode <= "00";
				aluResultSrc <= "10";
			when "00100" =>
				aluOp <= "000";
				BMuxOp <= "1";
				jumpType <= "000";
				resultSrc <= "1";
				memoryMode <= "00";
				aluResultSrc <= "10";
			when "00101" =>
				aluOp <= "000";
				BMuxOp <= "0";
				jumpType <= "000";
				resultSrc <= "1";
				memoryMode <= "00";
				aluResultSrc <= "10";
			when "00110" =>
				aluOp <= "010";
				BMuxOp <= "0";
				jumpType <= "000";
				resultSrc <= "1";
				memoryMode <= "00";
				aluResultSrc <= "10";
			when "00111" =>
				jumpType <= "001";
			when "01000" =>
				jumpType <= "010";
			when "01001" =>
				jumpType <= "011";
			when "01010" =>
				jumpType <= "010";
			when "01011" =>
				aluOp <= "100";
				BMuxOp <= "0";
				jumpType <= "000";
				resultSrc <= "1";
				memoryMode <= "00";
				aluResultSrc <= "00";
			when "01100" =>
				jumpType <= "100";
			when "01101" =>
				aluOp <= "111";
				BMuxOp <= "1";
				jumpType <= "000";
				resultSrc <= "1";
				memoryMode <= "00";
				aluResultSrc <= "11";
			when "01110" =>
				aluOp <= "000";
				BMuxOp <= "1";
				jumpType <= "000";
				resultSrc <= "0";
				memoryMode <= "10";
				aluResultSrc <= "10";
			when "01111" =>
				aluOp <= "000";
				BMuxOp <= "1";
				jumpType <= "000";
				resultSrc <= "0";
				memoryMode <= "10";
				aluResultSrc <= "10";
			when "10000" =>
				aluOp <= "111";
				BMuxOp <= "0";
				jumpType <= "000";
				resultSrc <= "1";
				memoryMode <= "00";
				aluResultSrc <= "11";
			when "10001" =>
				aluOp <= "111";
				BMuxOp <= "0";
				jumpType <= "000";
				resultSrc <= "1";
				memoryMode <= "00";
				aluResultSrc <= "11";
			when "10010" =>
				aluOp <= "111";
				BMuxOp <= "0";
				jumpType <= "000";
				resultSrc <= "1";
				memoryMode <= "00";
				aluResultSrc <= "11";
			when "10011" =>
				aluOp <= "111";
				BMuxOp <= "0";
				jumpType <= "000";
				resultSrc <= "1";
				memoryMode <= "00";
				aluResultSrc <= "11";
			when "10100" =>
				aluOp <= "111";
				BMuxOp <= "0";
				jumpType <= "000";
				resultSrc <= "1";
				memoryMode <= "00";
				aluResultSrc <= "11";
			when "10101" =>
				aluOp <= "111";
				jumpType <= "000";
				memoryMode <= "00";
			when "10110" =>
				aluOp <= "011";
				BMuxOp <= "0";
				jumpType <= "000";
				resultSrc <= "1";
				memoryMode <= "00";
				aluResultSrc <= "10";
			when "10111" =>
				aluOp <= "101";
				BMuxOp <= "1";
				jumpType <= "000";
				resultSrc <= "1";
				memoryMode <= "00";
				aluResultSrc <= "10";
			when "11000" =>
				aluOp <= "001";
				BMuxOp <= "0";
				jumpType <= "000";
				resultSrc <= "1";
				memoryMode <= "00";
				aluResultSrc <= "01";
			when "11001" =>
				aluOp <= "001";
				BMuxOp <= "1";
				jumpType <= "000";
				resultSrc <= "1";
				memoryMode <= "00";
				aluResultSrc <= "01";
			when "11010" =>
				aluOp <= "110";
				BMuxOp <= "1";
				jumpType <= "000";
				resultSrc <= "1";
				memoryMode <= "00";
				aluResultSrc <= "10";
			when "11011" =>
				aluOp <= "001";
				BMuxOp <= "0";
				jumpType <= "000";
				resultSrc <= "1";
				memoryMode <= "00";
				aluResultSrc <= "10";
			when "11100" =>
				aluOp <= "000";
				BMuxOp <= "1";
				jumpType <= "000";
				resultSrc <= "1";
				memoryMode <= "01";
				aluResultSrc <= "10";
			when "11101" =>
				aluOp <= "000";
				BMuxOp <= "1";
				jumpType <= "000";
				resultSrc <= "1";
				memoryMode <= "01";
				aluResultSrc <= "10";
			when "11110" =>
				aluOp <= "000";
				BMuxOp <= "1";
				jumpType <= "000";
				resultSrc <= "1";
				memoryMode <= "01";
				aluResultSrc <= "10";
		end case;
	end process;
end Behavioral;