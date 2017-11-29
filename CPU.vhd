library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CPU is
    Port ( 
    		clk : in STD_LOGIC;
			rst : in STD_LOGIC
         );
end CPU;

architecture Behavioral of CPU is
begin
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
		Instructionin : in  STD_LOGIC_VECTOR (15 downto 0));
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
end Behavioral;
