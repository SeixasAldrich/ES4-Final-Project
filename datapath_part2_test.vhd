library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity testbench is 
end;


architecture sim of testbench is 


component datapath is
port(
clk: in std_logic;
writeEnable3: in std_logic;
PCreset : in std_logic;
output : out std_logic_vector(31 downto 0);
flags : out std_logic_vector(3 downto 0) -- NZCV

);
end component;





signal WE3, clk, reset: std_logic;
signal output: std_logic_vector(31 downto 0);
signal flags: std_logic_vector(3 downto 0);

begin

dut: datapath port map(clk, WE3, reset, output, flags);

process begin

	WE3 <= '1'; reset <= '1'; clk <= '1'; wait for 10 ns;
	
	clk <= '0'; wait for 10 ns;
	
	clk <= '1';  wait for 10 ns;
	
	clk <= '0'; reset <= '0'; wait for 10 ns;
	
	clk <= '1'; wait for 10 ns;
	
	clk <= '0'; wait for 10 ns;
	
	clk <= '1'; wait for 10 ns;
	
	clk <= '0'; wait for 10 ns;
	
	clk <= '1'; wait for 10 ns;
	
	clk <= '0'; wait for 10 ns;
	
	clk <= '1'; wait for 10 ns;
	
	clk <= '0'; wait for 10 ns;
	
	clk <= '1'; wait for 10 ns;
	
	clk <= '0'; wait for 10 ns;
	
	clk <= '1'; wait for 10 ns;
	
	clk <= '0'; wait for 10 ns;
	
	clk <= '1'; wait for 10 ns;
	
	clk <= '0'; wait for 10 ns;
	
	clk <= '1'; wait for 10 ns;
	
	clk <= '0'; wait for 10 ns;


wait;
end process;





end;