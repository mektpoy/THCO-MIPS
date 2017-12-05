library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DM is
	Port 
	( 
		writeData : in  STD_LOGIC_VECTOR (15 downto 0);
		addr : in  STD_LOGIC_VECTOR (15 downto 0);
		rst, clk : in  STD_LOGIC;
		memoryMode : in  STD_LOGIC_VECTOR (1 downto 0);
		ramAddr : out STD_LOGIC_VECTOR (17 downto 0);
		ramData : inout STD_LOGIC_VECTOR (15 downto 0);
		readData : out STD_LOGIC_VECTOR (15 downto 0);
		en, oe, we : out  STD_LOGIC;
		tsre, tbre : in STD_LOGIC;
		rdn, wrn : out STD_LOGIC
	); --"00" Disabled; "01" Write; "10" Read; "11" Enabled;
	-- 0 Write 1 Read
end DM;

architecture Behavioral of DM is

	signal tempMemData : STD_LOGIC_VECTOR (15 downto 0);
	signal tempRam1Src : STD_LOGIC_VECTOR (1 downto 0);
	signal tempRam1En : STD_LOGIC;
	signal tempRam1Oe : STD_LOGIC;
	signal tempRam1We : STD_LOGIC;
	signal tempRam1Rdn : STD_LOGIC;
	signal tempRam1Wrn : STD_LOGIC;

begin
	rdn <= '1';
	wrn <= '1';
	process (rst)
	begin
		if (rst = '0') then
			wrn <= '1';
			oe <= '1';
			en <= '1';
			we <= '1';
		end if;
	end process;

	process (tbre, tsre, addr, dataReady)
	VARIABLE temp : STD_LOGIC_VECTOR (15 downto 0);
	begin
		if (addr = X"BF01") then
			temp := X"0001";
			temp(0) := tsre and tbre;
			temp(1) := dataReady;
			tempMemData <= temp;
		elsif (addr = X"BF00") then
			tempMemData <= ramData;
		else
			tempMemData <= ramData;
		end if;
	end process;

	process (addr, memoryMode)
	begin
		if (memoryMode(1) = '1' or memoryMode(0) = '1') then -- Read or Write
			if (addr = X"BF01") then    -- Port Status
				tempRam1Src <= "01";
			elsif (addr = X"BF00") then -- Port
				tempRam1Src <= "10";
			else                        -- Read or Write Memory
				tempRam1Src <= "00";
			end if;
		else
			tempRam1Src <= "00";
		end if;
	end process;

	process (addr, memoryMode, tempRam1Src, writeData, tempMemData)
	begin
		ramAddr <= "00" & addr;
		if (memoryMode(1) = '1') then -- Read
			if (tempRam1Src = "01") then -- Port Status
				ramData <= tempMemData;
			else -- Port / Read Memory
				ramData <= "ZZZZZZZZZZZZZZZZ";
			end if;
		elsif (memoryMode(0) = '1') then -- Write
			if (tempRam1Src = "01") then -- Port Status
				ramData <= "ZZZZZZZZZZZZZZZZ";
			else -- Port / Write Memory
				ramData <= writeData;
			end if;
		else
			ramData <= "ZZZZZZZZZZZZZZZZ";
		end if;
	end process;

	en <= tempRam1En;
	oe <= tempRam1Oe;
	we <= tempRam1We;
	rdn <= tempRam1Rdn;
	wrn <= tempRam1Wrn;

	process (clk, addr, memoryMode, tempRam1Src)
	begin
		--if (memoryMode(1) = '1') then
		--	readData <= ramData;
		--else
		--	readData <= X"0000";
		--end if;
		--if (memoryMode(0) = '1') then
		--	ramData <= writeData;
		--else
		--	ramData <= "ZZZZZZZZZZZZZZZZ";
		--end if;
		--ramAddr <= "00" & addr;
		if (clk = '0') then
			--oe <= not memoryMode(1);
			--we <= not memoryMode(0);
			--if (memoryMode /= "00") then
			--	en <= '0';
			--else
			--	en <= '1';
			--end if;
			if (addr = X"BF00") then
				tempRam1En <= '1';
				tempRam1Oe <= '1';
				tempRam1We <= '1';
				if (memoryMode(1) = '1') -- Read
					tempRam1Rdn <= '0';
					tempRam1Wrn <= '1';
				elsif (memoryMode(0) = '1') -- Write
					tempRam1Rdn <= '1';
					tempRam1Wrn <= '0';
				else
					tempRam1Rdn <= '1';
					tempRam1Wrn <= '1';
				end if;
			else
				tempRam1En <= (not memoryMode(0)) and (not memoryMode(1));
				tempRam1Oe <= not memoryMode(1);
				tempRam1We <= not memoryMode(0);
				tempRam1Rdn <= '1';
				tempRam1Wrn <= '1';
			end if;
		elsif (clk = '1') then
			tempRam1En <= '1';
			tempRam1Oe <= '1';
			tempRam1We <= '1';
			tempRam1Rdn <= '1';
			tempRam1Wrn <= '1';
		end if;
	end process;
end Behavioral;