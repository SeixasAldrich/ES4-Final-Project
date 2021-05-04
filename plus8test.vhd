library IEEE; 
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity plus8test is
end;

architecture sim of plus8test is
	component plus8
		port(x: in unsigned(31 downto 0);
		xplus8: out unsigned(31 downto 0));
	end component;
signal x, xplus8: unsigned(31 downto 0);

begin
	dut: plus8test port map(x, xplus8);
	process begin
		x <= 32D"0"; wait for 10 ns;
			assert xplus8 = 32D"8" report "0 failed.";
		x <= 32D"50"; wait for 10 ns;
			assert xplus8 = 32D"58" report "58 failed.";
		x <= 32D"10000"; wait for 10 ns;
			assert xplus8 = 32D"1008" report "1008 failed.";
	wait; 
	end process;
end;
