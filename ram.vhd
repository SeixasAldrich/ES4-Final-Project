library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ram is 
port ( clk: in std_logic;
		write_enable: in std_logic;
		addr: in unsigned(31 downto 0);
		write_data: in unsigned(31 downto 0);
		read_data: out unsigned(31 downto 0)
);
end;


architecture synth of ram is 

constant ram_depth : natural := 2**10;
constant ram_width : natural := 32;

 
type ram_type is array (0 to ram_depth - 1)
  of unsigned(ram_width - 1 downto 0);
  
 signal ram: ram_type;

begin

process (clk) begin
	if rising_edge(clk) then
	
		if write_enable then
			ram(to_integer(addr)) <= write_data;
		end if;
	end if;

end process;


read_data <= ram(to_integer(addr)) when addr < 2**10 else 32b"X";



end;