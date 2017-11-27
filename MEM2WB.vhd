library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MEM2WB is 
    Port ( 
        clk: in STD_LOGIC;
        rst: in STD_LOGIC;
        ResultIn : in STD_LOGIC_VECTOR(15 downto 0);
        ResultOut : out STD_LOGIC_VECTOR(15 downto 0);
        ReadDataIn : in STD_LOGIC_VECTOR(15 downto 0);
        ReadDataOut : out STD_LOGIC_VECTOR(15 downto 0);
        regWbAddrIn : in STD_LOGIC_VECTOR (3 downto 0);
        regWbAddrOut : out STD_LOGIC_VECTOR (3 downto 0);

        --W
        ResultSrcIn : in STD_LOGIC;
        ResultSrcOut : out STD_LOGIC;
        RegWriteClkIn : in STD_LOGIC;
        RegWriteClkOut : out STD_LOGIC;

        --USED IN BOTH M AND W
        RegWriteIn : in STD_LOGIC;
        RegWriteOut : out STD_LOGIC
    );
end MEM2WB;

architecture Behavioral of MEM2WB is
begin
    process(clk, rst)
    begin
        if(rst = '0') then
            ReadDataOut <= "0000000000000000";
            ResultOut <= "0000000000000000";
            regWbAddrOut <= "0000";
            ResultSrcOut <= "0";
            RegWriteClkOut <= "0";
            RegWriteOut <= "0";

        elsif(clk 'event and clk = '1') then
            ReadDataOut <= ReadDataIn;
            ResultOut <= ALUResultIn;
            regWbAddrOut <= regWbAddrIn;
            ResultSrcOut <= ResultSrcIn;
            RegWriteClkOut <= RegWriteClkIn;
            RegWriteOut <= RegWriteIn;
        end if;
    end process;
end Behavioral;