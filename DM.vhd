entity DM is
    Port ( 
      Address : in  STD_LOGIC_VECTOR (15 downto 0);
      WriteData : in  STD_LOGIC_VECTOR (15 downto 0);
      ReadData : out  STD_LOGIC_VECTOR (15 downto 0);
      ADDR : out  STD_LOGIC_VECTOR (17 downto 0);
      DATA : inout  STD_LOGIC_VECTOR (15 downto 0);
      EN : out  STD_LOGIC;
      OE : out  STD_LOGIC;
      WE : out  STD_LOGIC;
      RDN : out  STD_LOGIC;
      WRN : out  STD_LOGIC;
      CLK : in  STD_LOGIC;
      MODE : in  STD_LOGIC_VECTOR (1 downto 0)
    ); --"00" Disabled; "01" Read; "10" Write; "11" Enabled;
end DM;

architecture Behavioral of DM is
signal Reading: STD_LOGIC:='1';
signal Writing: STD_LOGIC:='1';
begin

	process(CLK,MODE)
	begin
		if(MODE="00")then
			EN<='1';
			OE<='1';
			WE<='1';
			Reading<='1';
			Writing<='1';
			WRN<='1';
			RDN<='1';
		elsif(CLK'event and CLK='1')then
				ReadData<=DATA;
				EN<='1';
				OE<='1';
				WE<='1';
				RDN<='1';
				WRN<='1';
				Reading<='1';
			elsif(Writing='0')then
				EN<='1';
				OE<='1';
				WE<='1';
				RDN<='1';
				WRN<='1';
				Writing<='1';
			elsif(MODE="01")then
				Reading<='0';
				DATA<="ZZZZZZZZZZZZZZZZ";
				WE<='1';
				WRN<='1';
				ADDR<="00"&Address;
			elsif(MODE="10")then
				RDN<='1';
				OE<='1';
				Writing<='0';
				ADDR<="00"&Address;
				DATA<=WriteData;
				EN<='0';
				WE<='0';
				WRN<='1';
			else
				WE<='1';
				OE<='1';
				EN<='1';
				WRN<='1';
				RDN<='1';
				Reading<='1';
				Writing<='1';
			end if;
		end if;
	end process;

end Behavioral;