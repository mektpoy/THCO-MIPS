library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity ID_PCAdder is
    Port 
    ( 
        ID_PC_in : in STD_LOGIC_VECTOR(15 downto 0);
        imme : in STD_LOGIC_VECTOR(15 downto 0);
        ID_PC_out : out STD_LOGIC_VECTOR(15 downto 0)
    );
end ID_PCAdder;

architecture Behavioral of ID_PCAdder is
begin
    ID_PC_out <= ID_PC_in + imme;
end Behavioral;