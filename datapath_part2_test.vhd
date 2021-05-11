library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity testbench is 
end;


architecture sim of testbench is 


component datapath is
port(
clk: in std_logic;
PCreset : in std_logic
);
end component;





signal clk, reset: std_logic;

begin

dut: datapath port map(clk,reset);

process begin

	reset <= '1'; clk <= '1'; wait for 10 ns;
	
	clk <= '0'; wait for 10 ns;
	
	clk <= '1';  wait for 10 ns;
	
	clk <= '0'; reset <= '0'; wait for 10 ns;
	
	for i in 0 to 50 loop
		clk <= not clk;
		wait for 10 ns;
	end loop;


wait;
end process;





end;