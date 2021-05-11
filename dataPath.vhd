library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity datapath is
port(
clk: in std_logic;
PCreset : in std_logic;
PCcount: out std_logic_vector(5 downto 0);
output1, output2, output3: out std_logic;
input1, input2: in std_logic
);
end;

architecture synth of datapath is 

component alu is
port(
srcA : in std_logic_vector(31 downto 0);
srcB : in std_logic_vector(31 downto 0);
command : in std_logic_vector(3 downto 0);
result : out std_logic_vector(31 downto 0);
flags : out std_logic_vector(3 downto 0) -- NZCV
);
end component;


component decoder is
port(
instruction : in std_logic_vector(31 downto 0);
aluControl : out std_logic_vector(3 downto 0);
addrA : out unsigned(3 downto 0);
addrB : out unsigned(3 downto 0);
addrC : out unsigned(3 downto 0);
useImm : out std_logic
);
end component;


component progrom is

	port(
		addr : in unsigned(31 downto 0);
		data : out std_logic_vector(31 downto 0)
		);

end component;


component immextend is
	port(
		operation: in std_logic_vector(1 downto 0);
		imm : in std_logic_vector(23 downto 0);
		immout : out std_logic_vector(31 downto 0)
	);
end component;


component add8 is
	port(
		x : in unsigned(31 downto 0);
		xplus8 : out unsigned(31 downto 0)
	);
end component;


component programcounter is
	port(
		clk : in std_logic;
		reset : in std_logic;
		branch : in std_logic;
		branchAddr : in std_logic_vector(31 downto 0);
		pc : out unsigned(31 downto 0)
	);
end component;


component regfile is
	port(
		clk : in std_logic;
		A1 : in unsigned(3 downto 0);
		A2 : in unsigned(3 downto 0);
		A3 : in unsigned(3 downto 0);
		WE3 : in std_logic;
		R15 : in std_logic_vector(31 downto 0);
		
		RD1 : out std_logic_vector(31 downto 0);
		RD2 : out std_logic_vector(31 downto 0);
		WD3 : in std_logic_vector(31 downto 0)
		);
end component;

component ram is 
port ( clk: in std_logic;
		write_enable: in std_logic;
		addr: in unsigned(31 downto 0);
		write_data: in unsigned(31 downto 0);
		read_data: out unsigned(31 downto 0);
		-- for I/O
		output1, output2, output3: out std_logic;
		input1, input2: in std_logic
);
end component;


component control is
port( 	clk, reset, use_immed: in std_logic;
		instruction: in std_logic_vector(31 downto 0);
		flags: in std_logic_vector(3 downto 0);
		ImmSrc: out std_logic_vector(1 downto 0);
		MemToReg, MemWrite, RegWrite, RegSrc2, RegSrc1, PCSrc, ALUSrc: out std_logic
	);
end component;



signal instruction, RD1, RD2, WD3, immout, srcA, srcB, ALUresult, result: std_logic_vector(31 downto 0);
signal PC, PcPlus, readMemData: unsigned(31 downto 0);
signal use_immed, memWrite, memtoReg,RegWrite, RegSrc2, RegSrc1, PCSrc, ALUSrc: std_logic; 
signal ImmSrc: std_logic_vector(1 downto 0);
signal regA1, regA2, regA3, tempAddress2, tempAddress1: unsigned(3 downto 0);
signal ALUControl, flags: std_logic_vector(3 downto 0);
signal temp: std_logic;


begin

ctrl: control port map(clk, '0', use_immed, instruction, flags, ImmSrc, memtoReg, memWrite, regWrite, regSrc2, RegSrc1, PCSrc, ALUSrc); 

progCounter: programcounter port map(clk, PCreset, PCSrc, std_logic_vector(result), PC);
rom: progrom port map(PC, instruction);

decoderComponent: decoder port map (instruction, ALUControl, tempAddress1, regA3, tempAddress2, use_immed); -- a1,2,3 signals ,ay be switched

registerFile: regfile port map (clk, regA1, regA2, regA3, RegWrite, std_logic_vector(PcPlus), RD1, RD2, WD3);
pls8: add8 port map(PC, PcPlus);

logicUnit: alu port map(srcA, srcB, ALUControl, ALUresult, flags); -- src signals may be switched

extender: immextend port map (ImmSrc, instruction(23 downto 0), immout);

ramUnit: ram port map (clk, memWrite, unsigned(ALUresult), unsigned(RD2), readMemData, output1, output2, output3, input1, input2);


regA2 <= tempAddress2 when RegSrc2 = '0' else regA3;

regA1 <= "1111" when RegSrc1 = '1' else tempAddress1;

result <= std_logic_vector(readMemData) when memtoReg = '1' else ALUresult;

srcA <= RD1; 

WD3 <= std_logic_vector(result);

srcB <= immout when ALUSrc = '1' else RD2;

PCcount <= std_logic_vector(PC(7 downto 2));


end;

