library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity VGA_Controller is
	port (
		reset	: in  std_logic;
		CLK_in	: in  std_logic;

	-- data
		--r0, r1, r2, r3, r4,r5,r6,r7 : in std_logic_vector(15 downto 0);

		readData : in std_logic_vector(7 downto 0);
		--PC : in std_logic_vector(15 downto 0);
		--CM : in std_logic_vector(15 downto 0);
		--Tdata : in std_logic_vector(15 downto 0);
		--SPdata : in std_logic_vector(15 downto 0);
		--IHdata : in std_logic_vector(15 downto 0);

	-- font rom
		romAddr : out std_logic_vector(7 downto 0);
		romData : in std_logic_vector(63 downto 0);
	--VGA Side
		hs,vs	: out std_logic;
		oRed	: out std_logic_vector (2 downto 0);
		oGreen	: out std_logic_vector (2 downto 0);
		oBlue	: out std_logic_vector (2 downto 0)
	);		
end entity VGA_Controller;

architecture behave of VGA_Controller is
	component charTable IS
	PORT (
		clka : IN STD_LOGIC;
		wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		addra : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		clkb : IN STD_LOGIC;
		addrb : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
	END component;


--VGA
	signal rt,gt,bt	: std_logic_vector (2 downto 0);
	signal hst,vst	: std_logic;
	signal x		: std_logic_vector (9 downto 0);		--X坐标
	signal y		: std_logic_vector (8 downto 0);		--Y坐标


	shared variable pos : integer range 0 to 100;
	shared variable intx : integer range 0 to 800;
	shared variable inty : integer range 0 to 500;
	shared variable tmpx : integer;
	shared variable tmpy : integer;
	shared variable nowx : integer range 0 to 80 := 0;
	shared variable nowy : integer range 0 to 60 := 0;
	type screendata is array(2400 downto 0) of STD_LOGIC_VECTOR(7 downto 0);
	shared variable data : screendata := (others => (others => '0'));
	
	
	--char table
	signal wea : std_logic_vector(0 downto 0);
	signal ctReadAddr : STD_LOGIC_VECTOR(11 downto 0);
	signal ctWriteAddr : STD_LOGIC_VECTOR(11 downto 0);
	signal ctReadData : STD_LOGIC_VECTOR(7 downto 0);
	signal ctWriteData : STD_LOGIC_VECTOR(7 downto 0);
begin

	u0: charTable port map
	(
		clka => CLK_in,
		wea => wea,
		addra => ctWriteAddr,
		dina => ctWriteData,
		clkb => CLK_in,
		addrb => ctReadAddr,
		doutb => ctReadData
	);
	END component;
 -----------------------------------------------------------------------
	process (CLK_in, reset)	--行区间像素数（含消隐区）
	begin
		if reset = '0' then
			x <= (others => '0');
		elsif CLK_in'event and CLK_in = '1' then
			if x = 799 then
				x <= (others => '0');
			else
				x <= x + 1;
			end if;
		end if;
	end process;

  -----------------------------------------------------------------------
	 process (CLK_in, reset)	--场区间行数（含消隐区�
	 begin
	  	if reset = '0' then
	   		y <= (others => '0');
	  	elsif CLK_in'event and CLK_in = '1' then
	   		if x = 799 then
	    		if y = 524 then
	     			y <= (others => '0');
	    		else
	     			y <= y + 1;
	    		end if;
	   		end if;
	  	end if;
	 end process;
 
  -----------------------------------------------------------------------
	 process (CLK_in, reset)	--行同步信号产生（同步宽度96，前�6�
	 begin
		  if reset = '0' then
		   hst <= '1';
		  elsif CLK_in'event and CLK_in = '1' then
		   	if x >= 656 and x < 752 then
		    	hst <= '0';
		   	else
		    	hst <= '1';
		   	end if;
		  end if;
	 end process;
 
 -----------------------------------------------------------------------
	 process (CLK_in, reset)	--场同步信号产生（同步宽度2，前�0�
	 begin
	  	if reset = '0' then
	   		vst <= '1';
	  	elsif CLK_in'event and CLK_in = '1' then
	   		if y >= 490 and y< 492 then
	    		vst <= '0';
	   		else
	    		vst <= '1';
	   		end if;
	  	end if;
	 end process;
 -----------------------------------------------------------------------
	 process (CLK_in, reset)	--行同步信号输�
	 begin
	  	if reset = '0' then
	   		hs <= '0';
	  	elsif CLK_in'event and CLK_in = '1' then
	   		hs <=  hst;
	  	end if;
	 end process;

 -----------------------------------------------------------------------
	 process (CLK_in, reset)	--场同步信号输�
	 begin
	  	if reset = '0' then
	   		vs <= '0';
	  	elsif CLK_in'event and CLK_in='1' then
	   		vs <=  vst;
	  	end if;
	 end process;

-----------------------------------------------------------------------
	process(readData) 
	begin
		if(readData = X"0D") then --endline
			nowx := 0;
			nowy := nowy + 1;
			if(nowy = 40) then
				nowy := 0;
			end if;
		elsif(readData = X"08") then -- backspace
			if(nowx = 0) then 
				nowy := nowy - 1;
				nowx := 59;
			else
				nowx := nowx - 1;
			end if;
			data(nowy * 60 + nowx) := X"00"; -- remove the char here
		else 
			data(nowy * 60 + nowx) := readData;
			nowx := nowx + 1;
			if(nowx = 60) then
				nowx := 0;
				nowy := nowy + 1;
			end if;
		end if;
	end process;

	process(reset, CLK_in , x, y)
	begin
		if reset='0' then
			rt  <= "000";
			gt	<= "000";
			bt	<= "000";
		elsif(CLK_in'event and CLK_in='1') then
			if((78 < x) and (x < 560) and (79 < y) and (y < 400)) then
				tmpx := conv_integer(x) + 1 - 80;
				tmpy := conv_integer(y) + 1 - 80;
				if((tmpx mod 8) = 0) then
					tmpx := tmpx / 8;
					tmpy := tmpy / 8;
					romAddr <= data(tmpx + tmpy * 60);
				else 
					intx := (tmpx - 1) mod 8;
					inty := (tmpy - 1) mod 8;
					pos := 63 - (8 * inty + intx);
					rt <= (others => romData(pos));
					gt <= (others => romData(pos));
					bt <= (others => romData(pos));
				end if;
			else 
				rt  <= "000";
				gt	<= "000";
				bt	<= "000";
			end if;
		end if;
	end process;
	--process(reset, CLK_in, x, y, readData)
	--begin
	--	if reset='0' then
	--		      rt <= "000";
	--			  gt	<= "000";
	--			  bt	<= "000";
	--	elsif(CLK_in'event and CLK_in='1')then 
	--		if (7 <= x) and (x < 16) and (160 <= y) and (y < 168) then
	--			if(x = 7) then
	--				romAddr <= readData;
	--			else
	--				intx := conv_integer(x);
	--				inty := conv_integer(y);
	--				pos := 63 - (8 * (inty - 160) + (intx - 8));
	--				rt <= (others => romData(pos));
	--				gt <= (others => romData(pos));
	--				bt <= (others => romData(pos));
	--			end if;
	--		else
	--			rt <= "111";
	--			gt <= "111";
	--			bt <= "111";
	--		end if;
	--	end if;
	--end process;

	process (hst, vst, rt, gt, bt)	--色彩输出
	begin
		if hst = '1' and vst = '1' then
			oRed	<= rt;
			oGreen	<= gt;
			oBlue	<= bt;
		else
			oRed	<= (others => '0');
			oGreen	<= (others => '0');
			oBlue	<= (others => '0');
		end if;
	end process;

end behave;