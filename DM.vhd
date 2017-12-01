entity DM is
	Port 
	( 
		writeData : in  STD_LOGIC_VECTOR (15 downto 0);
		addr : in  STD_LOGIC_VECTOR (15 downto 0);
		clk, rst : in  STD_LOGIC;
		memoryMode : in  STD_LOGIC_VECTOR (1 downto 0);
		ramAddr : out STD_LOGIC_VECTOR (15 downto 0);
		ramData : inout STD_LOGIC_VECTOR (15 downto 0);
		readData : out STD_LOGIC_VECTOR (15 downto 0);
		oe, we : out  STD_LOGIC
	); --"00" Disabled; "01" Read; "10" Write; "11" Enabled;
end DM;

architecture Behavioral of DM is
begin
	en <= memoryMode(0) xor memoryMode(1);
	we <= memoryMode(0) or not clk;
	oe <= memoryMode(1) or not clk;
	memoryAddr <= addr;

	readData <= ramData when memoryMode(0) = '1' else X"0000";
	ramData <= writeData when memoryMode(1) = '1' else "ZZZZZZZZZZZZZZZZ";
	ramAddr <= addr;
	oe <= "0" when memoryMode(0) = '0' and clk = '0' else '1';
	we <= (not memoryMode(0)) or clk;
end Behavioral;