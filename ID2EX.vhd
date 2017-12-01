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
    Port 
    ( 
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
        BMuxOpIn : in STD_LOGIC;
        BMuxOpOut : out STD_LOGIC;
        aluOpIn : in STD_LOGIC_VECTOR(2 downto 0);
        aluOpOut : out STD_LOGIC_VECTOR(2 downto 0);
        aluResultSrcIn : in STD_LOGIC_VECTOR(1 downto 0);
        aluResultSrcOut : out STD_LOGIC_VECTOR(1 downto 0);
        memoryReadIn : in STD_LOGIC;
        memoryReadOut : out STD_LOGIC;


        --M
        memoryModeIn : in STD_LOGIC_VECTOR(1 downto 0);
        memoryModeOut: out STD_LOGIC_VECTOR(1 downto 0);

        --W
        resultSrcIn : in STD_LOGIC;
        resultSrcOut : out STD_LOGIC;
        regWriteClkIn : in STD_LOGIC;
        regWriteClkOut : out STD_LOGIC
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
            memoryReadOut <= "0";
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
            BMuxOpOut <= BMuxOpIn;
            aluOpOut <= aluOpIn;
            aluResultSrcOut <= aluResultSrcIn;
            memoryReadOut <= memoryReadIn;
            memoryModeOut <= memoryModeIn;
            resultSrcOut <= resultSrcIn;
            regWriteClkOut <= regWriteClkIn;
        end if;
    end process;
end Behavioral;

