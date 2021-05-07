library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity condcheck is
port( 	condition: in std_logic_vector(3 downto 0);
		flags: in std_logic_vector (3 downto 0);
		condEx: out std_logic
	);
end;





architecture synth of condcheck is

signal N,Z,C,V: std_logic;

begin
	N <= flags(3);
	Z <= flags(2);
	C <= flags(1);
	V <= flags(0);
	
	
	process (all) begin
	
	
	case condition is 
		when "0000" => condEx <= Z;
		when "0001" => condEx <= not Z;
		when "0010" => condEx <= C;
		when "0011" => condEx <= not C;
		when "0100" => condEx <= N;
		when "0101" => condEx <= not N;
		when "0110" => condEx <= V;
		when "0111" => condEx <= not V;
		when "1000" => condEx <= (not Z) and C;
		when "1001" => condEx <= Z or (not C);
		when "1010" => condEx <= not (N xor V);
		when "1011" => condEx <= N xor V;
		when "1100" => condEx <= (not Z) and (not (N xor V));
		when "1101" => condEx <= Z or (N xor V);
		when "1110" => condEx <= '1';
		when others => condEx <= '-';
		
	end case;




end process;




end;