library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity IF_PCAdder is
	Port 
	( 
		IF_PC_in : in STD_LOGIC_VECTOR(15 downto 0);
		IF_PC_out : out STD_LOGIC_VECTOR(15 downto 0)
	);   
end IF_PCAdder;

architecture Behavioral of IF_PCAdder is
begin
    IF_PC_out <= IF_PC_in + 1;
end Behavioral;