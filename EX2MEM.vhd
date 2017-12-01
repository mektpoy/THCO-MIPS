library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity EX2MEM is 
    Port 
    ( 
        clk: in STD_LOGIC;
        rst: in STD_LOGIC;
        aluResultIn : in STD_LOGIC_VECTOR(15 downto 0);
        aluResultOut : out STD_LOGIC_VECTOR(15 downto 0);
        inputB : in STD_LOGIC_VECTOR(15 downto 0);
        writeData : out STD_LOGIC_VECTOR(15 downto 0);
        regWbAddrIn : in STD_LOGIC_VECTOR (3 downto 0);
        regWbAddrOut : out STD_LOGIC_VECTOR (3 downto 0);

        --M
        memoryModeIn : in STD_LOGIC_VECTOR(1 downto 0);
        memoryModeOut: out STD_LOGIC_VECTOR(1 downto 0);

        --W
        resultSrcIn : in STD_LOGIC;
        resultSrcOut : out STD_LOGIC;
        regWriteClkIn : in STD_LOGIC;
        regWriteClkOut : out STD_LOGIC
    );
end EX2MEM;

architecture Behavioral of EX2MEM is
begin
    process(clk, rst)
    begin
        if(rst = '0') then
            ALUResultOut <= "0000000000000000";
            writeData <= "0000000000000000";
            regWbAddrOut <= "0000";
            MemoryModeOut <= "00";
            ResultSrcOut <= '0';
            RegWriteClkOut <= '0';

        elsif(rising_edge(clk)) then
            aluResultOut <= aluResultIn;
            writeData <= inputB;
            regWbAddrOut <= regWbAddrIn;
            memoryModeOut <= memoryModeIn;
            resultSrcOut <= resultSrcIn;
            regWriteClkOut <= regWriteClkIn;
        end if;
    end process;
end Behavioral;