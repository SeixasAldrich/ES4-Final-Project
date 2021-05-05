library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity decoder is
port(
instruction : in std_logic_vector(31 downto 0);
aluControl : out std_logic_vector(3 downto 0);
addrA : out unsigned(3 downto 0);
addrB : out unsigned(3 downto 0);
addrC : out unsigned(3 downto 0);
useImm : out std_logic
);
end;

architecture synth of decoder is




begin

	aluControl <= "0100" when (instruction(27 downto 26) = "01" or instruction(27 downto 26) = "10") else instruction(24 downto 21);
	addrA <= unsigned(instruction(19 downto 16)); --Rn
	addrB <= unsigned(instruction(15 downto 12)); --Rd
	addrC <= unsigned(instruction (3 downto 0)); -- Rm
	useImm <= instruction(25);

end;