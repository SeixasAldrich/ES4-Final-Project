library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity datapath is
port(
clk: in std_logic;
writeEnable3: in std_logic;
PCreset : in std_logic;
output : out std_logic_vector(31 downto 0);
flags : out std_logic_vector(3 downto 0) -- NZCV

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
		imm : in std_logic_vector(11 downto 0);
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

signal instruction, RD1, RD2, WD3, immout, srcA, srcB, result: std_logic_vector(31 downto 0); 
signal PC, PcPlus: unsigned(31 downto 0);
signal use_immed: std_logic; 
signal regA1, regA2, regA3: unsigned(3 downto 0);
signal ALUControl: std_logic_vector(3 downto 0);


begin

progCounter: programcounter port map(clk, PCreset, '0', 32d"0", PC);
rom: progrom port map(PC, instruction);

srcA <= RD1; -- temporary

WD3 <= result; -- temporary, result from ALU to register file immediately

decoderComponent: decoder port map (instruction, ALUControl, regA1, regA3, regA2, use_immed); -- a1,2,3 signals ,ay be switched

registerFile: regfile port map (clk, regA1, regA2, regA3, writeEnable3, std_logic_vector(PcPlus), RD1, RD2, WD3);
pls8: add8 port map(PC, PcPlus);

logicUnit: alu port map(srcA, srcB, ALUControl, result, flags); -- src signals may be switched


extender: immextend port map ( instruction(11 downto 0), immout);

srcB <= immout when use_immed = '1' else RD2;


output <= result; --temporary

end;

