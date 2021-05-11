library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity immextend is
	port(
		operation: in std_logic_vector(1 downto 0);
		imm : in std_logic_vector(23 downto 0);
		immout : out std_logic_vector(31 downto 0)
	);
end;

architecture synth of immextend is


begin

	process (all) begin
		case (operation) is
		
		when "00" => immout <= (31 downto 8 => '0', 7 downto 0 => imm(7 downto 0)) ror (2*to_integer(unsigned(imm(11 downto 8))));
		
		when "01" => immout <= (20b"0", imm(11 downto 0));
		
		when "10" => immout <= (imm(23), imm(23), imm(23), imm(23), imm(23), imm(23), imm(23 downto 0), "00");
	
		when others => immout <= 32b"0";
	
	end case;
	
	end process;
	
	
	
end;
