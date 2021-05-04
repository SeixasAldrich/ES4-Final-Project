library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity regFile_test is

end regFile_test;

architecture sim of regFile_test is

component regfile is

	port(
		clk : in std_logic;
		A1 : in unsigned(3 downto 0);
		A2 : in unsigned(3 downto 0);
		A3 : in unsigned(3 downto 0);
		WE3 : in std_logic;
		R15 : in std_logic_vector(31 downto 0);
		
		RD1 : out std_logic_vector(31 downto 0);
		RD2 : out std_logic_vector(31 downto 0);
		WD3 : in std_logic_vector(31 downto 0)
		);
		
end component;

signal clk, WE3 : std_logic;
signal A1, A2, A3 : unsigned(3 downto 0);
signal R15, RD1, RD2, WD3 : std_logic_vector(31 downto 0);

begin

	dut : regfile port map (clk, A1, A2, A3, WE3, R15, RD1, RD2, WD3);
	
	process begin
	
	clk <= '0';
	WE3 <= '1';
	A3 <= "0000"; -- Register file R0
	WD3 <= 32d"5";
	
	clk <= '1';
	wait 10 ns;
	
	
	
	
	end process;

end test;
