library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PCMUX is
	Port 
	( 
		pcSrc : in STD_LOGIC_VECTOR(1 downto 0);
		normal : in STD_LOGIC_VECTOR (15 downto 0);
		regJump : in STD_LOGIC_VECTOR (15 downto 0);
		offsetJump : in STD_LOGIC_VECTOR (15 downto 0);
		PCMuxOut : out STD_LOGIC_VECTOR (15 downto 0)
	);
end PCMUX;

architecture Behavioral of PCMux is
begin
	process (pcSrc, normal, regJump, offsetJump)
	begin
		case pcSrc is
			when "00" =>
				PCMuxOut <= regJump;
			when "01" =>
				PCMuxOut <= offsetJump;
			when "10" =>
				PCMuxOut <= normal;
			when "11" =>
				PCMuxOut <= normal;
			when others =>
				PCMuxOut <= normal;
		end case;
	end process;
end Behavioral;