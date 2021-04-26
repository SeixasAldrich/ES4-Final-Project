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
		for i in 0 to (rom_depth-1) loop
			rom(i) <= std_logic_vector(to_unsigned(2*i, rom_width));
		end loop;
		
	end process;

data <= rom(to_integer(addr));

end;
