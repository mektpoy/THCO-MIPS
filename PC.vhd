library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PC is
    port
    ( 
		clk, rst: in STD_LOGIC;
		PCMuxOut: in STD_LOGIC_VECTOR(15 downto 0);
		stayPC: in STD_LOGIC;
		IMstay : in STD_LOGIC;
		outPC: out STD_LOGIC_VECTOR(15 downto 0)
	);
end PC;

architecture Behavioral of PC is
	signal pcRegister : STD_LOGIC_VECTOR (15 downto 0) := X"0000";
begin
	outPC <= pcRegister;
	process(rst, clk)
	begin
		if (rst = '0') then
			pcRegister <= X"0000";
		elsif(rising_edge(clk)) then
			if (stayPC = '0') and (IMstay = '0') then
				pcRegister <= PCMuxOut;
			end if;
		end if;
	end process;

end Behavioral;

