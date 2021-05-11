library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;
use IEEE.std_logic_textio.all;
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
  --file read_file : text;
  --file text_file : text open read_mode is "source/impl_1/instructions.txt";
  file text_file: text;
  variable text_line : line;
  variable rom_content : rom_type;
  variable i : integer := 0;
begin
	file_open(text_file, "/home/es4user/Desktop/ES4/es4_final_5_2_2021/source/impl_1/LED_game.txt", read_mode);
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

	-- drop 2 lsb of address
	mem_address <= "00" & addr(31 downto 2);
	
	--rom(0) <= "11100011101000000000000000000000";
	--rom(1) <= "11100011101000000001000000000000";
	--rom(2) <= "11100011101000000010000000000001";
	--rom(3) <= "11100101100000000001000000000001";
	--rom(4) <= "11100101100000000010000000000010";
	
	
	
data <= rom(to_integer(mem_address)) when addr < to_unsigned(rom_depth, 32) else (31 downto 0 => 'X');

end;