library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RegisterFile is
    Port 
    ( 
		rxAddr : in STD_LOGIC_VECTOR (3 downto 0);
		ryAddr : in STD_LOGIC_VECTOR (3 downto 0);
		regWbAddr : in STD_LOGIC_VECTOR (3 downto 0);
		regWbValue : in STD_LOGIC_VECTOR (15 downto 0);
		pcValue : in STD_LOGIC_VECTOR (15 downto 0);
		regWrite : in STD_LOGIC;
		clk, rst : in STD_LOGIC;
		rxValue : out STD_LOGIC_VECTOR (15 downto 0);
		ryValue : out STD_LOGIC_VECTOR (15 downto 0)
	);
end RegisterFile;

architecture Behavioral of RegisterFile is
	type regs is array(15 downto 0) of STD_LOGIC_VECTOR(15 downto 0);
	signal data : regs := (others => (others => '0'));
begin
	rxValue <= data(conv_integer(rxAddr));
	ryValue <= data(conv_integer(ryAddr));
	process (rst, clk)
	begin
		if (rst = '0') then
			for i in 0 to 15 loop
			data(i) <= X"0000";
			end loop;
			data(9) <= "1011111011111111";
		elsif (falling_edge(clk)) then
			if (regWrite = '1') then
				data(conv_integer(regWbAddr)) <= regWbValue;
			end if;
			data(8) <= pcValue;
		end if;
	end process;
end Behavioral;

