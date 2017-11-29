library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PC is
    port( 
          clk, rst: in std_logic;
          PCMuxOut: in std_logic_vector(15 downto 0);
          stayPC: in std_logic;
		  outPC: out std_logic_vector(15 downto 0)
		 );
end PC;

architecture Behavioral of PC is

begin
	process(clk, rst)
	begin
		if (rising_edge(rst)) then
			outPC <= X"0000";
		elsif(rising_edge(clk)) then
			if stayPC = '0' then
				outPC <= PCMuxOut;
			end if;
		end if;
	end process;

end Behavioral;

