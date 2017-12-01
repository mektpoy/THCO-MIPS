library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CPU is
    Port ( 
    		clk : in STD_LOGIC;
			rst : in STD_LOGIC;
			ram1Addr : out STD_LOGIC_VECTOR (17 downto 0);
			ram1En : out STD_LOGIC;
			ram1We : out STD_LOGIC;
			ram1Oe : out STD_LOGIC;
			ram1Data : inout STD_LOGIC_VECTOR (15 downto 0);

			ram2Addr : out STD_LOGIC_VECTOR (17 downto 0);
			ram2En : out STD_LOGIC;
			ram2We : out STD_LOGIC;
			ram2Oe : out STD_LOGIC;
			ram2Data : inout STD_LOGIC_VECTOR (15 downto 0)
         );
end CPU;

architecture Behavioral of CPU is
	component ALU is
	Port 
	(
		inputA : in  STD_LOGIC_VECTOR (15 downto 0);
		inputB : in  STD_LOGIC_VECTOR (15 downto 0);
		aluOp : in  STD_LOGIC_VECTOR (2 downto 0);
		result : out  STD_LOGIC_VECTOR (15 downto 0);
		aluZero : out STD_LOGIC;
		aluSign : out STD_LOGIC
	);
	end component;

	component ALUMux is
	Port 
	( 
		aluZero : in STD_LOGIC;
		aluSign : in STD_LOGIC;
		result : in STD_LOGIC_VECTOR (15 downto 0);
		inputB : in STD_LOGIC_VECTOR (15 downto 0);
		aluResultSrc : in STD_LOGIC_VECTOR (1 downto 0);
		aluResult : out STD_LOGIC_VECTOR (15 downto 0)
	);
	end component;

	component AMux is
	Port 
	( 
		forwardOp0 : in STD_LOGIC_VECTOR (1 downto 0);
		result : in STD_LOGIC_VECTOR (15 downto 0);
		regWbValue : in STD_LOGIC_VECTOR (15 downto 0);
		rxValue : in STD_LOGIC_VECTOR (15 downto 0);
		inputA : out STD_LOGIC_VECTOR (15 downto 0)
	);
	end component;

	component BMux is
	Port 
	( 
		BMuxOp : in STD_LOGIC;
		inputB0 : in STD_LOGIC_VECTOR (15 downto 0);
		imme : in STD_LOGIC_VECTOR (15 downto 0);
		inputB : out STD_LOGIC_VECTOR (15 downto 0)
	);
	end component;

	component BMux0 is
	Port 
	( 
		forwardOp1 : in STD_LOGIC_VECTOR (1 downto 0);
		result : in STD_LOGIC_VECTOR (15 downto 0);
		regWbValue : in STD_LOGIC_VECTOR (15 downto 0);
		ryValue : in STD_LOGIC_VECTOR (15 downto 0);
		inputB0 : out STD_LOGIC_VECTOR (15 downto 0)
	);
	end component;

	component BranchUnit is
	Port
	(
		jumpType : in STD_LOGIC_VECTOR(2 downto 0);
		rxValue : in STD_LOGIC_VECTOR(15 downto 0);
		pcSrc : out STD_LOGIC_VECTOR(1 to 0)
	);
	end component;

	component controller is
	Port 
    ( 
		instrId : in STD_LOGIC_VECTOR (4 downto 0);
		stay : in STD_LOGIC;
		aluOp : out STD_LOGIC_VECTOR (2 downto 0);
		BMuxOp : out STD_LOGIC;
		jumpType : out STD_LOGIC_VECTOR (2 downto 0);
		resultSrc : out STD_LOGIC;
		memoryMode : out STD_LOGIC_VECTOR (1 downto 0);
		aluResultSrc : out STD_LOGIC_VECTOR (1 downto 0);
		regWriteClk : out STD_LOGIC
	);
	end component;

	component Decoder is
	Port
	(
		instruction : in STD_LOGIC_VECTOR (15 downto 0);
		rxAddr : out STD_LOGIC_VECTOR (3 downto 0);
		ryAddr : out STD_LOGIC_VECTOR (3 downto 0);
		imme : out STD_LOGIC_VECTOR (15 downto 0);
		regWbAddr : out STD_LOGIC_VECTOR (3 downto 0);
		instrId : out STD_LOGIC_VECTOR (4 downto 0)
    );
    end component;

    component DM is
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
    );
    end component;

    component EX2MEM is
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
    end component;

    component HazardUnit is
    Port 
	( 
		memoryRead : in STD_LOGIC;
		regWbAddr : in STD_LOGIC_VECTOR (3 downto 0);
		rxAddr : in STD_LOGIC_VECTOR (15 downto 0);
		ryAddr : in STD_LOGIC_VECTOR (15 downto 0);
		stayPC : out STD_LOGIC;
		stayIF2ID : out STD_LOGIC;
		dataSetZero : out STD_LOGIC
	);
    end component;

    component ID2EX is
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
    end component;

    component ID_PCAdder is
    Port 
    ( 
        ID_PC_in : in STD_LOGIC_VECTOR(15 downto 0);
        imme : in STD_LOGIC_VECTOR(15 downto 0);
        ID_PC_out : out STD_LOGIC_VECTOR(15 downto 0)
    );
    end component;

    component IF2ID is
    Port 
    ( 
		clk: in STD_LOGIC;
		rst: in STD_LOGIC;
		stay: in STD_LOGIC;
		PCin : in  STD_LOGIC_VECTOR (15 downto 0);
		PCout : out STD_LOGIC_VECTOR (15 downto 0);
		Instructionin : in  STD_LOGIC_VECTOR (15 downto 0);
		Instructionout : out  STD_LOGIC_VECTOR (15 downto 0)
	);
    end component;

    component IF_PCAdder is
    Port 
	( 
		IF_PC_in : in STD_LOGIC_VECTOR(15 downto 0);
		IF_PC_out : out STD_LOGIC_VECTOR(15 downto 0)
	);   
    end component;

    component IM is
    Port 
	( 
		ReadAddress : in STD_LOGIC_VECTOR (15 downto 0);
		Instruction : out STD_LOGIC_VECTOR (15 downto 0);
		ADDR : out  STD_LOGIC_VECTOR (17 downto 0);
		DATA : inout  STD_LOGIC_VECTOR (15 downto 0);
		EN : out  STD_LOGIC;
		OE : out  STD_LOGIC;
		WE : out  STD_LOGIC;
		CLK : in  STD_LOGIC;
		MODE : in  STD_LOGIC_VECTOR (1 downto 0)
		MODE : in  STD_LOGIC_VECTOR (1 downto 0)
	); --"00" Disabled; "01" Read; "10" Write; "11" Enabled;
    end component;

    component MEM2WB is
    Port 
    ( 
        clk: in STD_LOGIC;
        rst: in STD_LOGIC;
        aluResultIn : in STD_LOGIC_VECTOR(15 downto 0);
        aluResultOut : out STD_LOGIC_VECTOR(15 downto 0);
        readDataIn : in STD_LOGIC_VECTOR(15 downto 0);
        readDataOut : out STD_LOGIC_VECTOR(15 downto 0);
        regWbAddrIn : in STD_LOGIC_VECTOR (3 downto 0);
        regWbAddrOut : out STD_LOGIC_VECTOR (3 downto 0);

        --W
        resultSrcIn : in STD_LOGIC;
        resultSrcOut : out STD_LOGIC;
        regWriteIn : in STD_LOGIC;
        regWriteOut : out STD_LOGIC
    );
    end component;

    component PC is
    port
    ( 
		clk, rst: in std_logic;
		PCMuxOut: in std_logic_vector(15 downto 0);
		stayPC: in std_logic;
		outPC: out std_logic_vector(15 downto 0)
	);
    end component;

    component PCMux is
    Port 
	( 
		pcSrc : in STD_LOGIC_VECTOR(1 downto 0);
		normal : in STD_LOGIC_VECTOR (15 downto 0);
		regJump : in STD_LOGIC_VECTOR (15 downto 0);
		offsetJump : in STD_LOGIC_VECTOR (15 downto 0);
		PCMuxOut : out STD_LOGIC_VECTOR (15 downto 0)
	);
    end component;

    component RegisterFile is
    Port 
    ( 
		rxAddr : in STD_LOGIC_VECTOR (3 downto 0);
		ryAddr : in STD_LOGIC_VECTOR (3 downto 0);
		regWbAddr : in STD_LOGIC_VECTOR (3 downto 0);
		regWbValue : in STD_LOGIC_VECTOR (15 downto 0);
		regWrite : in STD_LOGIC;
		clk : in STD_LOGIC;
		rxValue : out STD_LOGIC_VECTOR (15 downto 0);
		ryValue : out STD_LOGIC_VECTOR (15 downto 0)
	);
    end component;

    component WBMux is
    Port 
    ( 
		readData : in STD_LOGIC_VECTOR (15 downto 0);
		aluResult : in STD_LOGIC_VECTOR (15 downto 0);
		resultSrc : in STD_LOGIC;
		regWbValue : out STD_LOGIC_VECTOR (15 downto 0)
	);
    end component;

    signal stay : STD_LOGIC;
    signal PCMuxOut : STD_LOGIC_VECTOR (15 downto 0);
    signal outPC : STD_LOGIC_VECTOR (15 downto 0);
    signal normal : STD_LOGIC_VECTOR (15 downto 0);
    signal offsetJump : STD_LOGIC_VECTOR (15 downto 0);
    signal regJump : STD_LOGIC_VECTOR (15 downto 0);
    signal pcSrc : STD_LOGIC_VECTOR (1 downto 0);
    signal IFInstruction : STD_LOGIC_VECTOR(15 downto 0);

    signal IDPCIn : STD_LOGIC_VECTOR (15 downto 0);
    signal IDImme : STD_LOGIC_VECTOR (15 downto 0);
    signal IDRxAddr : STD_LOGIC_VECTOR (3 downto 0);
    signal IDRyAddr : STD_LOGIC_VECTOR (3 downto 0);
    signal IDRegWbAddr : STD_LOGIC_VECTOR (3 downto 0);
    signal IDRxValue : STD_LOGIC_VECTOR (15 downto 0);
    signal IDRyValue : STD_LOGIC_VECTOR (15 downto 0);
    signal instrId : STD_LOGIC_VECTOR (15 downto 0);
    signal jumpType : STD_LOGIC_VECTOR (2 downto 0);
    signal IDAluOp : STD_LOGIC(2 downto 0);
    signal IDBMuxOp : STD_LOGIC;
    signal IDResultSrc : STD_LOGIC;
    signal IDMemoryRead : STD_LOGIC;
    signal IDMemoryMode : STD_LOGIC_VECTOR (1 downto 0);
    signal IDAluResultSrc : STD_LOGIC_VECTOR (1 downto 0);
    signal IDRegWrite : STD_LOGIC;
    signal IDInstuction : STD_LOGIC_VECTOR (15 downto 0);

    signal EXRxValue : STD_LOGIC_VECTOR (15 downto 0);
    signal EXRyValue : STD_LOGIC_VECTOR (15 downto 0);
    signal EXImme : STD_LOGIC_VECTOR (15 downto 0);
    signal EXRegWbAddr : STD_LOGIC_VECTOR (15 downto 0);
    signal aluOp : STD_LOGIC_VECTOR (2 downto 0);
    signal BMuxOp : STD_LOGIC;
    signal aluResultSrc : STD_LOGIC_VECTOR (1 downto 0);
    signal EXMemoryMode : STD_LOGIC_VECTOR (1 downto 0);
    signal EXResultSrc : STD_LOGIC;
    signal EXRegWrite : STD_LOGIC;
    signal aluZero : STD_LOGIC;
    signal aluSign : STD_LOGIC;
    signal result : STD_LOGIC_VECTOR (15 downto 0);
    signal inputA : STD_LOGIC_VECTOR (15 downto 0);
    signal inputB : STD_LOGIC_VECTOR (15 downto 0);
    signal inputB0 : STD_LOGIC_VECTOR (15 downto 0);
    signal aluResult : STD_LOGIC_VECTOR (15 downto 0);
    signal EXRxAddr : STD_LOGIC_VECTOR (3 downto 0);
    signal EXRyAddr : STD_LOGIC_VECTOR (3 downto 0);
    signal memoryRead : STD_LOGIC;
    signal forwardOp0 : STD_LOGIC_VECTOR (1 downto 0);
    signal forwardOp1 : STD_LOGIC_VECTOR (1 downto 0);

    signal MEMAluResult : STD_LOGIC_VECTOR (15 downto 0);
    signal MEMRegWbAddr : STD_LOGIC_VECTOR (3 downto 0);
    signal writeDate : STD_LOGIC_VECTOR (15 downto 0);
    signal readData : STD_LOGIC_VECTOR (15 downto 0);
    signal MEMMoemoryMode : STD_LOGIC_VECTOR (1 downto 0);
    signal MEMResultSrc : STD_LOGIC;
    signal MEMRegWrite : STD_LOGIC;

    signal WBRegWrite : STD_LOGIC;
    signal WBResultSrc : STD_LOGIC;
    signal WBValue : STD_LOGIC_VECTOR (15 downto 0);
    signal WBRegWbAddr : STD_LOGIC_VECTOR (3 downto 0);
    signal WBReadData : STD_LOGIC_VECTOR (15 downto 0);
    signal WBAluResult : STD_LOGIC_VECTOR (15 downto 0);

begin
	u0 : ALU port map
	(
		inputA => inputA,
		inputB => inputB,
		aluOp => aluOp,

		result => result,
		aluZero => aluZero,
		aluSign => aluSign
	);

	u1 : ALUMux port map
	(
		aluZero => aluZero,
		aluSign => aluSign,
		result => result,
		inputB => inputB,
		aluResultSrc => aluResultSrc,

		aluResult => aluResult
	);

	u2 : AMux port map
	(
		forwardOp0 => forwardOp0,
		result => result,
		regWbValue => WBValue,
		rxValue => EXRxValue,

		inputA => inputA
	);

	u3 : BMux port map
	(
		BMuxOp => BMuxOp,
		inputB0 => inputB0,
		imme => EXImme,

		inputB => inputB
	);

	u4 : BMux0 port map
	(
		forwardOp1 => forwardOp1,
		result => result,
		regWbValue => WBValue,
		ryValue => EXRyValue,

		inputB0 => inputB0
	);

	u5 : BranchUnit port map
	(
		jumpType => jumpType,
		rxValue => IDRxValue,
		pcSrc => pcSrc
	);

	u6 : controller port map
	(
		instrId => instrId,
		stay => stay,

		aluOp => IDAluOp,
		BMuxOp => IDBMuxOp,
		jumpType => jumpType,
		resultSrc => IDResultSrc,
		memoryMode => IDMemoryMode,
		aluResultSrc => IDAluResultSrc,
		regWrite => IDRegWrite,
		memoryRead => IDMemoryRead
	);

	u7 : decoder port map
	(
		instruction => IDInstuction,
		rxAddr => IDRxAddr,
		ryAddr => IDRyAddr,
		imme => IDImme,
		regWbAddr => IDRegWbAddr,
		instrId => instrId
	);

	u8 : DM port map
	(
		writeData => writeData,
		addr => MEMAluResult,
		clk => clk,
		rst => rst,
		memoryMode => MEMMoemoryMode,
		ramAddr => ram1Addr,
		ramData => ram1Data,
		readData => readData,
		oe => ram1Oe,
		we => ram1We
	);

	u9 : EX2MEM port map
	(
		clk => clk,
        rst => rst,
        aluResultIn => aluResult,
        aluResultOut => MEMAluResult,
        inputB => inputB,
        writeData => writeData,
        regWbAddrIn => EXRegWbAddr,
        regWbAddrOut => MEMRegWbAddr,

        --M
        memoryModeIn => EXMemoryMode,
        memoryModeOut => MEMMoemoryMode,

        --W
        resultSrcIn => EXResultSrc,
        resultSrcOut => MEMResultSrc,
        regWriteClkIn => EXRegWrite,
        regWriteClkOut => MEMRegWrite
	);

	u10 : ForwardUnit port map
	(
		resultAddr => MEMRegWbAddr,
		regWbAddr => WBRegWbAddr,
		rxAddr => EXRxAddr,
		ryAddr => EXRyAddr,
		forwardOp0 => forwardOp0,
		forwardOp1 => forwardOp1
	);

	u11 : HazardUnit port map
	(
		memoryRead => memoryRead,
		regWbAddr => EXRegWbAddr,
		rxAddr => IDRxAddr,
		ryAddr => IDRyAddr,
		stay => stay
	);

	u12 : ID2EX port map
	(
		clk => clk,
        rst => rst,
        rxValueIn => IDRxValue,
        rxValueOut => EXRxValue,
        ryValueIn => IDRyValue,
        ryValueOut => EXRyValue,
        immeIn => IDImme,
        immeOut => EXImme,
        rxAddrIn => IDRxAddr,
        rxAddrOut => EXRxAddr,
        ryAddrIn => IDRyAddr,
        ryAddrOut => EXRyAddr,
        regWbAddrIn => IDRegWbAddr,
        regWbAddrOut => EXRegWbAddr,

        --control signals
        --E
        BMuxOpIn => IDBMuxOp,
        BMuxOpOut => BMuxOp,
        aluOpIn => IDAluOp,
        aluOpOut => aluOp,
        aluResultSrcIn => IDAluResultSrc,
        aluResultSrcOut => aluResultSrc,
        memoryReadIn => IDMemoryRead,
        memoryReadOut => memoryRead,

        --M
        memoryModeIn => IDMemoryMode,
        memoryModeOut => EXMemoryMode,

        --W
        resultSrcIn => IDResultSrc,
        resultSrcOut => EXResultSrc,
        regWriteClkIn => IDRegWrite,
        regWriteClkOut => EXRegWrite
	);

	u13 : ID_PCAdder port map
	(
		ID_PC_in => IDPCIn,
		imme => IDImme,
		ID_PC_out => offsetJump
	);

	u14 : IF2ID port map
	(
		clk => clk,
		rst => rst,
		stay => stay,
		PCin => normal,
		PCout => IDPCIn,
		Instructionin => IFInstruction,
		Instructionout => IDInstuction
	);

	u15 : IF_PCAdder port map
	(
		IF_PC_in => outPC,
		IF_PC_out => normal
	);

	u16 : IM port map
	(
		ReadAddress : in STD_LOGIC_VECTOR (15 downto 0);
		Instruction : out STD_LOGIC_VECTOR (15 downto 0);
		ADDR : out  STD_LOGIC_VECTOR (17 downto 0);
		DATA : inout  STD_LOGIC_VECTOR (15 downto 0);
		EN : out  STD_LOGIC;
		OE : out  STD_LOGIC;
		WE : out  STD_LOGIC;
		CLK : in  STD_LOGIC;
		MODE : in  STD_LOGIC_VECTOR (1 downto 0)
	);

	u17 : MEM2WB port map
	(
		clk => clk,
		rst => rst,
		aluResultIn => MEMAluResult,
		aluResultOut => WBAluResult,
		readDataIn => readData,
		readDataOut => WBReadData,
		regWbAddrIn => MEMRegWbAddr,
		regWbAddrOut => WBRegWbAddr,

		--W
		resultSrcIn => MEMResultSrc,
		resultSrcOut => WBResultSrc,
		regWriteIn => MEMRegWrite,
		regWriteOut => WBRegWrite
	);

	u18 : PC port map
	(
		clk => clk,
		rst => rst,
		PCMuxOut => PCMuxOut,
		stayPC => stay,
		outPC => outPC
	);

	u19 : PCMux port map
	(
		pcSrc => pcSrc,
		normal => normal,
		regJump => regJump,
		offsetJump => offsetJump,
		PCMuxOut => PCMuxOut
	);

	u20 : RegisterFile port map
	(
		rxAddr => IDRxAddr,
		ryAddr => IDRyAddr,
		regWbAddr => WBRegWbAddr,
		regWbValue => WBValue,
		regWrite => WBRegWrite,
		clk => clk,
		rxValue => IDRxValue,
		ryValue => IDRyValue
	);

	u21 : WBMux port map
	(
		readData => WBReadData,
		aluResult => WBAluResult,
		resultSrc =>  WBResultSrc,
		regWbValue => WBValue
	);
end Behavioral;

