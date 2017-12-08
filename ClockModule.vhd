library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ClockModule is
	Port 
	( 
		clockin : in STD_LOGIC;
		clockout : out STD_LOGIC
	);
end ClockModule;

architecture Behavioral of ClockModule is
	signal clock : STD_LOGIC := '0';
begin
	--process(clockin)
	--begin
	--	clockout <= clockin;
	--end process;
	clockout <= clock;
	process (clockin)
	begin
		if (rising_edge(clockin)) then
			clock <= not clock;
		end if;
	end process;
end Behavioral;