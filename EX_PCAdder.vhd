library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity EX_PCAdder is
    Port 
    ( 
		EXPC : in STD_LOGIC_VECTOR(15 downto 0);
		EXImme : in STD_LOGIC_VECTOR(15 downto 0);
		offsetJump : out STD_LOGIC_VECTOR(15 downto 0)
    );
end EX_PCAdder;

architecture Behavioral of EX_PCAdder is
begin
    offsetJump <= EXPC + EXImme;
end Behavioral;