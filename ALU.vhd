
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu is
port(
srcA : in std_logic_vector(31 downto 0);
srcB : in std_logic_vector(31 downto 0);
command : in std_logic_vector(3 downto 0);
result : out std_logic_vector(31 downto 0);
flags : out std_logic_vector(3 downto 0) -- NZCV
);
end;


architecture synth of alu is

signal a,b: unsigned(32 downto 0);
signal intermediate: std_logic_vector(32 downto 0); 

begin
	a <= '0' & unsigned(srcA);
	b <= '0' & unsigned(srcB);
	
	intermediate <= ('0' & (srcA and srcB)) when command = "0000" else --AND
					('0' & (srcA or srcB)) when command = "1100" else -- OR
					('0' & srcB) when command = "1101" else -- MOV
					std_logic_vector(a + b) when command = "0100" else --ADD
					std_logic_vector(a - b) when command = "0010" else --SUB
					std_logic_vector(b - a) when command = "0011"; --RSB
	
	result <= intermediate(31 downto 0);
	
	flags(2) <= '1' when result = 32d"0" else '0'; -- Zero flag
	flags(3) <= '1' when result(31) = '1' else '0'; -- Negative flag
	flags(0) <= '1' when (command = "0100") and (srcA(31) = srcB(31)) and (result(31) /= srcA(31)) else
				'1' when (command = "0010" or command = "0011") and (srcA(31) /= srcB(31)) and (result(31) /= srcA (31))
				else '0'; -- Overflow flag
				
	-- bug when 127 + 1
	-- this is probably wrong
	--flags(1) <= '1' when (command = "0100") and (srcA(31) = srcB(31)) and (result(31) = srcA(31)) else
	--			'1' when (command = "0010" or command = "0011") and (srcA(31) = srcB(31)) and (result(31) = srcA (31)) else '0';

	flags(1) <= '1' when intermediate(32) = '1' else '0';



end;