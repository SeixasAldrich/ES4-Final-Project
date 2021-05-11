library IEEE; 
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity programcounter_test is
end;

architecture sim of programcounter_test is
	component programcounter
    port(
      clk : in std_logic;
      reset : in std_logic;
      branch : in std_logic;
      branchAddr : in std_logic_vector(31 downto 0);
      pc : out unsigned(31 downto 0)
    );
	end component;
  
signal clk, reset, branch: std_logic;
signal branchAddr: std_logic_vector(31 downto 0);
signal pc: unsigned(31 downto 0);

begin
	dut: programcounter_test port map(clk, reset, branch, branchAddr, pc);
	process begin
    
		clk <= '0';
		reset <= '0';
		branch <= '0';
		-- check starting value of pc
			assert pc = 32D"0" report "starting value failed.";

		clk <= '1'; wait 10 ns;
		-- check incrementation of pc on rising edge of clock
			assert pc = 32D"4" report "first increment failed.";
		clk <= '0';

		reset <= '1';
		clk <= '1'; wait 10 ns;
		-- check reset of pc on rising edge of clock
			assert pc = 32D"0" report "reset failed.";
		clk <= '0';


		reset <= '0';
		branch <= '1';
		branchAddr <= 32D"12";
		clk <= '1'; wait 10 ns;
		-- check branching of pc on rising edge of clock
			assert pc = 32D"12" report "branch failed.";
		clk <= '0';

		wait;

	end process;
end;
