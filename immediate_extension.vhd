library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity immextend is
	port(
		imm : in std_logic_vector(11 downto 0);
		immout : out std_logic_vector(31 downto 0)
	);
end;

architecture synth of immextend is

signal rot : unsigned(3 downto 0);
signal immediate : unsigned(31 downto 0);
signal rot2 : unsigned(7 downto 0);
--signal i : unsigned(4 downto 0);

begin
	
	--process is
	
	--	rot <= unsigned(imm(11 downto 8));
	--	immediate <= 24b"0" + unsigned(imm(7 downto 0));
		
	--	rot2 <= rot * 2;
		
	--	i <= 5b"0";
		
	--	while (i < rot2) loop
		--	immediate <= immediate(0) + immediate(31 downto 1);
	--	end loop;
		
	--	immout <= std_logic_vector(immediate);
	
	--end process;
	
	rot <= unsigned(imm(11 downto 8));
	
	immediate <= 24b"0" & unsigned(imm(7 downto 0));
	
	rot2 <= rot * 2;
	
	immout <= std_logic_vector(immediate) ror to_integer(rot2);
	
end;
