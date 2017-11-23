library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PCMUX is
	Port ( 
		PCsrc : in STD_LOGIC_VECTOR(1 downto 0);
		Normal : in STD_LOGIC_VECTOR (15 downto 0);
		RegJump : in STD_LOGIC_VECTOR (15 downto 0);
		OffsetJump : in STD_LOGIC_VECTOR (15 downto 0);
		PCMuxOut : out STD_LOGIC_VECTOR (15 downto 0)
	);
end PCMUX;

architecture Behavioral of PCMux is
begin
	process (PCsrc, Normal, RegJump, OffsetJump)
	begin
		case PCsrc is
			when "00" =>
				PCMuxOut <= Normal;
			when "01" =>
				PCMuxOut <= OffsetJump;
			when "10" =>
				PCMuxOut <= RegJump;
			when others =>
				PCMuxOut <= Normal;
		end case;
	end process;
end Behavioral;