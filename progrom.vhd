library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity progrom is

	port(
		addr : in unsigned(31 downto 0);
		data : out std_logic_vector(31 downto 0)
		);

end;



architecture synth of progrom is

constant rom_depth : natural := 2**10;
constant rom_width : natural := 32;

 
type rom_type is array (0 to rom_depth - 1)
  of std_logic_vector(rom_width - 1 downto 0);
  
 signal rom: rom_type;
begin

	--hard coding memeory
	
	
	
	process (all) begin
	
		rom(0) <= "00000011101000000001" & 12d"5"; -- MOV R1, #5
		rom(4) <= "00000011101000000010" & 12d"10"; -- MOV R2, #10
		rom(8) <= "00000011101000000011" & 12d"27"; -- MOV R3, #27
		rom(12) <= "00000000100000010010000000000011"; -- ADD R1, R2, R3
		
		for i in 13 to (rom_depth-1) loop
			rom(i) <= 32d"0"; -- MOV R1, R1
		end loop;
		
	end process;

data <= rom(to_integer(unsigned(addr)));

end;