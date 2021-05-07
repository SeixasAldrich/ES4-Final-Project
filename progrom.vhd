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
  
  
  impure function init_rom_bin return rom_type is
  file text_file : text open read_mode is "source/impl_1/bookTestBench.txt";
  variable text_line : line;
  variable rom_content : rom_type;
  variable i : integer := 0;
begin
  while not endfile(text_file) loop
    readline(text_file, text_line);
    bread(text_line, rom_content(i));
	i := i+1;
  end loop;
 
  return rom_content;
end function;
  
 signal rom: rom_type:= init_rom_bin;
 
 signal mem_address: unsigned (31 downto 0);
begin

	--hard coding memeory
	-- drop 2 lsb of address
	mem_address <= "00" & addr(31 downto 2);
	
	--process (all) begin
	
		--rom(0) <= "00000011101000000001" & 12d"5"; -- MOV R1, #5
		--rom(1) <= "00000011101000000010" & 12d"10"; -- MOV R2, #10
		--rom(2) <= "00000011101000000011" & 12d"27"; -- MOV R3, #27
		--rom(3) <= "00000000100000010010000000000011"; -- ADD R1, R2, R3
		
		--for i in 4 to (rom_depth-1) loop
			--rom(i) <= "00000001101000000001000000000001"; -- MOV R1, R1
		--end loop;
		
	--end process;
--
data <= rom(to_integer(mem_address)) when addr < 2**10 else 32b"X";

end;