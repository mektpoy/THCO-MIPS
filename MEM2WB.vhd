library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MEM2WB is 
    Port ( 
        clk: in STD_LOGIC;
        rst: in STD_LOGIC;
        aluResultIn : in STD_LOGIC_VECTOR(15 downto 0);
        aluResultOut : out STD_LOGIC_VECTOR(15 downto 0);
        readDataIn : in STD_LOGIC_VECTOR(15 downto 0);
        readDataOut : out STD_LOGIC_VECTOR(15 downto 0);
        regWbAddrIn : in STD_LOGIC_VECTOR (3 downto 0);
        regWbAddrOut : out STD_LOGIC_VECTOR (3 downto 0);

        --W
        resultSrcIn : in STD_LOGIC;
        resultSrcOut : out STD_LOGIC;
        regWriteIn : in STD_LOGIC;
        regWriteOut : out STD_LOGIC
    );
end MEM2WB;

architecture Behavioral of MEM2WB is
begin
    process(clk, rst)
    begin
        if(rising_edge(rst)) then
            readDataOut <= "0000000000000000";
            aluResultOut <= "0000000000000000";
            regWbAddrOut <= "0000";
            resultSrcOut <= "0";
            regWriteOut <= "0";

        elsif(rising_edge(clk)) then
            readDataOut <= readDataIn;
            aluResultOut <= aluResultIn;
            regWbAddrOut <= regWbAddrIn;
            resultSrcOut <= resultSrcIn;
            regWriteOut <= regWriteIn;
        end if;
    end process;
end Behavioral;