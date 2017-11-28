----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:45:20 11/23/2017 
-- Design Name: 
-- Module Name:    ID2EX - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ID2EX is 
    Port ( 
        clk: in STD_LOGIC;
        rst: in STD_LOGIC;
        rxValueIn : in STD_LOGIC_VECTOR (15 downto 0);
        rxValueOut : out STD_LOGIC_VECTOR (15 downto 0);
        ryValueIn : in STD_LOGIC_VECTOR (15 downto 0);
        ryValueOut : out STD_LOGIC_VECTOR (15 downto 0);
        immeIn : in STD_LOGIC_VECTOR (15 downto 0);
        immeOut : out STD_LOGIC_VECTOR (15 downto 0);
        rxAddrIn : in STD_LOGIC_VECTOR (3 downto 0);
        rxAddrOut : out STD_LOGIC_VECTOR (3 downto 0);
        ryAddrIn: in STD_LOGIC_VECTOR (3 downto 0);
        ryAddrOut : out STD_LOGIC_VECTOR (3 downto 0);
        regWbAddrIn : in STD_LOGIC_VECTOR (3 downto 0);
        regWbAddrOut : out STD_LOGIC_VECTOR (3 downto 0);


        --control signals
        --E
        BMuxIn : in STD_LOGIC;
        BMuxOut : out STD_LOGIC;
        ALUOpIn : in STD_LOGIC_VECTOR(3 downto 0);
        ALUOpOut : out STD_LOGIC_VECTOR(3 downto 0);
        ALUResultSrcIn : in STD_LOGIC_VECTOR(1 downto 0);
        ALUResultSrcOut : out STD_LOGIC_VECTOR(1 downto 0);

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
end ID2EX;

architecture Behavioral of ID2EX is
begin
    process(clk, rst)
    begin
        if(rst = '0') then
            rxValueOut <= "0000000000000000";
            ryValueOut <= "0000000000000000";
            immeOut <= "0000000000000000";
            regWbAddrOut <= "0000";
            rxAddrOut <= "0000";
            ryAddrOut <= "0000";
            BMuxOut <= "0";
            ALUOpOut <= "0000";
            ALUResultSrcOut <= "00";
            MemoryModeOut <= "00";
            ResultSrcOut <= "0";
            RegWriteClkOut <= "0";
            RegWriteOut <= "0";

        elsif(rising_edge(clk)) then
            rxValueOut <= rxValueIn;
            ryValueOut <= ryValueIn;
            immeOut <= immeIn;
            regWbAddrOut <= regWbAddrIn;
            rxAddrOut <= rxAddrIn;
            ryAddrOut <= ryAddrIn;
            BMuxOut <= BMuxIn;
            ALUOpOut <= ALUOpIn;
            ALUResultSrcOut <= ALUResultSrcIn;
            MemoryModeOut <= MemoryModeIn;
            ResultSrcOut <= ResultSrcIn;
            RegWriteClkOut <= RegWriteClkIn;
            RegWriteOut <= RegWriteIn;
        end if;
    end process;
end Behavioral;

