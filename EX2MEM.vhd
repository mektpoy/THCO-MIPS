library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity EX2MEM is 
    Port ( 
        clk: in STD_LOGIC;
        rst: in STD_LOGIC;
        ALUResultIn : in STD_LOGIC_VECTOR(15 downto 0);
        ALUResultOut : out STD_LOGIC_VECTOR(15 downto 0);
        InputBIn : in STD_LOGIC_VECTOR(15 downto 0);
        InputBOut : out STD_LOGIC_VECTOR(15 downto 0);
        regWbAddrIn : in STD_LOGIC_VECTOR (3 downto 0);
        regWbAddrOut : out STD_LOGIC_VECTOR (3 downto 0);

        --M
        MemoryModeIn : in STD_LOGIC_VECTOR(1 downto 0);
        MemoryModeOut: out STD_LOGIC_VECTOR(1 downto 0);

        --W
        ResultSrcIn : in STD_LOGIC;
        ResultSrcOut : out STD_LOGIC;
        RegWriteClkIn : in STD_LOGIC;
        RegWriteClkOut : out STD_LOGIC;

        --USED IN BOTH M AND W
        RegWriteIn : in STD_LOGIC;
        RegWriteOut : out STD_LOGIC
    );
end EX2MEM;

architecture Behavioral of EX2MEM is
begin
    process(clk, rst)
    begin
        if(rst = '0') then
            ALUResultOut <= "0000000000000000";
            InputBOut <= "0000000000000000";
            regWbAddrOut <= "0000";
            MemoryModeOut <= "00";
            ResultSrcOut <= "0";
            RegWriteClkOut <= "0";
            RegWriteOut <= "0";

        elsif(clk 'event and clk = '1') then
            ALUResultOut <= ALUResultIn;
            InputBOut <= InputBIn;
            regWbAddrOut <= regWbAddrIn;
            MemoryModeOut <= MemoryModeIn;
            ResultSrcOut <= ResultSrcIn;
            RegWriteClkOut <= RegWriteClkIn;
            RegWriteOut <= RegWriteIn;
        end if;
    end process;
end Behavioral;