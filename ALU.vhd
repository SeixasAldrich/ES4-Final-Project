
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
	a <= unsigned('0' & (srcA)); 
	b <= unsigned('0' & (srcB)); 
	
	intermediate <= ('0' & (srcA and srcB)) when command = "0000" else --AND
					('0' & (srcA or srcB)) when command = "1100" else -- OR
					('0' & srcB) when command = "1101" else -- MOV
					std_logic_vector(a + b) when command = "0100" else --ADD
					std_logic_vector(a + ('0' & (unsigned(not(srcB))+1)))  when command = "0010" else --SUB
					std_logic_vector(b + ('0' & (unsigned(not(srcA))+1))) when command = "0011"; --RSB
	
	result <= intermediate(31 downto 0);
	
	flags(2) <= '1' when result = 32d"0" else '0'; -- Zero flag
	flags(3) <= '1' when result(31) = '1' else '0'; -- Negative flag
	flags(0) <= '1' when (command = "0100") and (srcA(31) = srcB(31)) and (result(31) /= srcA(31)) else
				'1' when (command = "0010" ) and (srcA(31) /= srcB(31)) and (result(31) /= srcA (31)) else
				'1' when (command = "0011") and (srcA(31) /= srcB(31)) and (result(31) /= srcB(31))
				else '0'; -- Overflow flag
				
	

	flags(1) <= intermediate(32); --carry flag



end;