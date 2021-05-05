library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity progromTest is
end;

architecture sim of progromTest is

component progrom is
port(
		addr : in unsigned(31 downto 0);
		data : out std_logic_vector(31 downto 0)
);
end component;

signal addr: unsigned(31 downto 0);
signal data: std_logic_vector(31 downto 0);

begin

	rom: progrom port map(addr, data);

	process begin
	
	for i in 0 to 200 loop
		addr <= to_unsigned(i,32);
		wait for 10 ns;
	end loop;
	
	wait;
	end process;

end;