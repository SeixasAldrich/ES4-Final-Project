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
  
  
  --impure function init_rom_bin return rom_type is
  --file read_file : text;
  --file text_file : text open read_mode is "source/impl_1/instructions.txt";
  --file text_file: text;
  --variable text_line : line;
  --variable rom_content : rom_type;
  --variable i : integer := 0;
--begin
	--file_open(text_file, "/home/es4user/Desktop/LED_game.txt", read_mode);
  --while not endfile(text_file) loop
   -- readline(text_file, text_line);
	--bread(text_line, rom_content(i));
	--i := i+1;
  --end loop;
 
  --return rom_content;
--end function;
  
 signal rom: rom_type;--:= init_rom_bin;
 
 signal mem_address: unsigned (31 downto 0);
begin

	-- drop 2 lsb of address
	mem_address <= "00" & addr(31 downto 2);
	
	--rom(0) <= "11100011101000000000000000000000"; --MOV R0, #0
	--rom(1) <= "11100011101000000001000000000000"; --MOV R1, #0
	--rom(2) <= "11100011101000000010000000000001"; --MOV R2, #1
	--rom(3) <= "11100101100000000001000000000001"; --STR R1, [R0, #1]
	--rom(4) <= "11100101100000000010000000000010"; --STR R2, [R0, #2]
	process (all) begin
		case (mem_address) is
		when 32d"0" => data <= "11100011101000000000000000000000";
		
		when 32d"1" => data <= "11100011101000000001000000000000";
		
		when 32d"2" => data <= "11100011101000000010000000000000";
		
		
		when 32d"3" => data <= "11100011101000000011000000000000";
		
		
		when 32d"4" => data <= "11100011101000000100000000000000";
		
		
		when 32d"5" => data <= "11100011101000000101000000000000";
		
		
		when 32d"6" => data <= "11100101100000000001000000000001";
		
		
		when 32d"7" => data <= "11100101100000000010000000000010";
		
		
		when 32d"8" => data <= "11100101100000000011000000000011";
		
		
		when 32d"9" => data <= "11100101100000000100000000000100";
		
		
		when 32d"10" => data <= "11100101100000000101000000000101";
		
		
		when 32d"11" => data <= "11100001101000000001000000000001";
		
		
		when 32d"12" => data <= "11100001101000000001000000000001";
		
		
		when 32d"13" => data <= "11100001101000000001000000000001";
		
		
		when 32d"14" => data <= "11100001101000000001000000000001";
		
		
		when 32d"15" => data <= "11100011101000000011000000000001";
		
		
		when 32d"16" => data <= "11100101100000000011000000000011";
		
		
		when 32d"17" => data <= "11100101100100000100000000000100";
		
		
		when 32d"18" => data <= "11100101100100000101000000000101";
		
		
		when 32d"19" => data <= "11100000010101000110000000000101";
		
		
		when 32d"20" => data <= "00001010111111111111111111111011";
		
		
		when 32d"21" => data <= "01001010000000000000000000000010";
		
		
		when 32d"22" => data <= "11100011101000000001000000000001";
		
		
		when 32d"23" => data <= "11100101100000000001000000000001";
		
		
		when 32d"24" => data <= "11101010000000000000000000000001";
		
		
		when 32d"25" => data <= "11100011101000000010000000000001";
		
		
		when 32d"26" => data <= "11100101100000000010000000000010";
		
		
		when 32d"27" => data <= "11100101100000000010000000000010";
		
		when others => data <= (31 downto 0 => 'X');
		
		end case;
		
		

	end process;

--data <= rom(to_integer(mem_address)) when addr < to_unsigned(rom_depth, 32) else (31 downto 0 => 'X');

end;