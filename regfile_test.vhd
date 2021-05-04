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
		
		WE3 <= '1';

		clk <= '0';
		A3 <= "0000"; WD3 <= 32d"0";  -- Write value 0 to R0
		clk <= '1'; wait for 10 ns;
			
		clk <= '0';
		A3 <= "0001"; WD3 <= 32d"100";  -- Write value 100 to R1
		clk <= '1'; wait for 10 ns;

		clk <= '0';
		A3 <= 4D"2"; WD3 <= 32d"200";  -- Write value 200 to R2
		clk <= '1'; wait for 10 ns;
			
		clk <= '0';
		A3 <= 4D"3"; WD3 <= 32d"300";  -- Write value 300 to R3
		clk <= '1'; wait for 10 ns;
			
		clk <= '0';
		A3 <= 4D"4"; WD3 <= 32d"400";  -- Write value 400 to R4
		clk <= '1'; wait for 10 ns;
			
		clk <= '0';
		A3 <= 4D"5"; WD3 <= 32d"500";  -- Write value 500 to R5
		clk <= '1'; wait for 10 ns;
			
		clk <= '0';
		A3 <= 4D"6"; WD3 <= 32d"600";  -- Write value 600 to R6
		clk <= '1'; wait for 10 ns;
			
		clk <= '0';
		A3 <= 4D"7"; WD3 <= 32d"700";  -- Write value 700 to R7
		clk <= '1'; wait for 10 ns;
			
		clk <= '0';
		A3 <= 4D"8"; WD3 <= 32d"800";  -- Write value 800 to R8
		clk <= '1'; wait for 10 ns;
			
		clk <= '0';
		A3 <= 4D"9"; WD3 <= 32d"900";  -- Write value 900 to R9
		clk <= '1'; wait for 10 ns;
			
		clk <= '0';
		A3 <= 4D"10"; WD3 <= 32d"1000";  -- Write value 1000 to R10
		clk <= '1'; wait for 10 ns;
			
		clk <= '0';
		A3 <= 4D"11"; WD3 <= 32d"1100";  -- Write value 1100 to R11
		clk <= '1'; wait for 10 ns;
			
		clk <= '0';
		A3 <= 4D"12"; WD3 <= 32d"1200";  -- Write value 1200 to R12
		clk <= '1'; wait for 10 ns;
			
		clk <= '0';
		A3 <= 4D"13"; WD3 <= 32d"1300";  -- Write value 1300 to R13
		clk <= '1'; wait for 10 ns;
			
		clk <= '0';
		A3 <= 4D"14"; WD3 <= 32d"1400";  -- Write value 1400 to R14
		clk <= '1'; wait for 10 ns;
			
		R15 <= 32d"1500"; 		 -- Write value 1500 to R15
			
			
		clk <= '0'; 
		A1 <= "0000"; A2 <= "0001"; 	-- Read value from R0 and R1
		clk <= '1'; wait for 10 ns;
			assert RD1 = 32D"0" report "R0 failed.";
			assert RD2 = 32D"100" report "R1 failed.";

		clk <= '0'; 
		A1 <= "0010"; A2 <= "0011"; 	-- Read value from R2 and R3
		clk <= '1'; wait for 10 ns;
			assert RD1 = 32D"200" report "R2 failed.";
			assert RD2 = 32D"300" report "R3 failed.";

		clk <= '0'; 
		A1 <= "0100"; A2 <= "0101"; 	-- Read value from R4 and R5
		clk <= '1'; wait for 10 ns;
			assert RD1 = 32D"400" report "R4 failed.";
			assert RD2 = 32D"500" report "R5 failed.";

		clk <= '0'; 
		A1 <= "0110"; A2 <= "0111"; 	-- Read value from R6 and R7
		clk <= '1'; wait for 10 ns;
			assert RD1 = 32D"600" report "R6 failed.";
			assert RD2 = 32D"700" report "R7 failed.";

		clk <= '0'; 
		A1 <= "1000"; A2 <= "1001"; 	-- Read value from R8 and R9
		clk <= '1'; wait for 10 ns;
			assert RD1 = 32D"800" report "R8 failed.";
			assert RD2 = 32D"900" report "R9 failed.";

		clk <= '0'; 
		A1 <= "1010"; A2 <= "1011"; 	-- Read value from R10 and R11
		clk <= '1'; wait for 10 ns;
			assert RD1 = 32D"1000" report "R10 failed.";
			assert RD2 = 32D"1100" report "R11 failed.";

		clk <= '0'; 
		A1 <= "1100"; A2 <= "1101"; 	-- Read value from R12 and R13
		clk <= '1'; wait for 10 ns;
			assert RD1 = 32D"1200" report "R12 failed.";
			assert RD2 = 32D"1300" report "R13 failed.";

		clk <= '0'; 
		A1 <= "1110"; A2 <= "1111"; 	-- Read value from R14 and R15
		clk <= '1'; wait for 10 ns;
			assert RD1 = 32D"1400" report "R14 failed.";
			assert RD2 = 32D"1500" report "R15 failed.";
		wait;

	end process;

end test;
