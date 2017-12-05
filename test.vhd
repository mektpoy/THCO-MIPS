--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:15:33 12/05/2017
-- Design Name:   
-- Module Name:   C:/Users/cdogemaru/Desktop/THINPAD/THCO-MIPS/test.vhd
-- Project Name:  CPU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CPU
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test IS
END test;
 
ARCHITECTURE behavior OF test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CPU
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         ram1Addr : OUT  std_logic_vector(17 downto 0);
         ram1En : OUT  std_logic;
         ram1We : OUT  std_logic;
         ram1Oe : OUT  std_logic;
         ram1Data : INOUT  std_logic_vector(15 downto 0);
         rdn : OUT  std_logic;
         wrn : OUT  std_logic;
         tbre : IN  std_logic;
         tsre : IN  std_logic;
         ram2Addr : OUT  std_logic_vector(17 downto 0);
         ram2En : OUT  std_logic;
         ram2We : OUT  std_logic;
         ram2Oe : OUT  std_logic;
         ram2Data : INOUT  std_logic_vector(15 downto 0);
         ledOut : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal tbre : std_logic := '0';
   signal tsre : std_logic := '0';

	--BiDirs
   signal ram1Data : std_logic_vector(15 downto 0);
   signal ram2Data : std_logic_vector(15 downto 0);

 	--Outputs
   signal ram1Addr : std_logic_vector(17 downto 0);
   signal ram1En : std_logic;
   signal ram1We : std_logic;
   signal ram1Oe : std_logic;
   signal rdn : std_logic;
   signal wrn : std_logic;
   signal ram2Addr : std_logic_vector(17 downto 0);
   signal ram2En : std_logic;
   signal ram2We : std_logic;
   signal ram2Oe : std_logic;
   signal ledOut : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CPU PORT MAP (
          clk => clk,
          rst => rst,
          ram1Addr => ram1Addr,
          ram1En => ram1En,
          ram1We => ram1We,
          ram1Oe => ram1Oe,
          ram1Data => ram1Data,
          rdn => rdn,
          wrn => wrn,
          tbre => tbre,
          tsre => tsre,
          ram2Addr => ram2Addr,
          ram2En => ram2En,
          ram2We => ram2We,
          ram2Oe => ram2Oe,
          ram2Data => ram2Data,
          ledOut => ledOut
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
