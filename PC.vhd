library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PC is
    port( NextPC: in std_logic_vector(15 downto 0);
          HazardCtrl: in std_logic;
          clk, rst: in std_logic;
		  outPC: out std_logic_vector(15 downto 0));
end PC;

architecture Behavioral of PC is

begin
	process(clk, rst)
	begin
		if rst = '0' then
			outPC <= "0000000000000000";
		elsif clk = '1' and clk'event then
			if HazardCtrl = '0' then
				outPC <= NextPC;
			end if;
		end if;
	end process;

end Behavioral;

