library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity ALUtest is
end;

architecture sim of ALUtest is

component alu is
port(
srcA : in std_logic_vector(31 downto 0);
srcB : in std_logic_vector(31 downto 0);
command : in std_logic_vector(3 downto 0);
result : out std_logic_vector(31 downto 0);
flags : out std_logic_vector(3 downto 0) -- NZCV
);
end component;

signal srcA, srcB, result: std_logic_vector(31 downto 0);
signal command, flags: std_logic_vector(3 downto 0);


begin

	dut: alu port map(srcA, srcB, command, result, flags);

	process begin
		-- and functionality test
		srcA <= (31 downto 22 => "1101001110", 21 downto 0 => '0'); 
		srcB <= (31 downto 26 => "011110" , 25 downto 0 => '1'); 
		command <= "0000"; wait for 10 ns;
		assert flags = "0000" report "flag detection failed";
		assert result = (srcA and srcB) report "and functionality failed";		
		
			
		-- and zero flag
		srcA <= (31 downto 0 => '0'); 
		srcB <= (31 downto 26 => "011110" ,25 downto 0 => '1'); 
		command <= "0000"; wait for 10 ns;
		assert flags = "0100" report "flag detection failed";
		assert result = (srcA and srcB) report "and functionality failed";	
		
		-- and negative flag
		srcA <= (31 downto 22 => "1101001110" ,21 downto 0 => '0'); 
		srcB <= (31 downto 26 => "111110" ,25 downto 0 => '1'); 
		command <= "0000"; wait for 10 ns;
		assert flags = "1000" report "flag detection failed";
		assert result = (srcA and srcB) report "and functionality failed";	
		
		-- or functionality test
		srcA <= (31 downto 22 => "1101001110", 21 downto 0 => '0'); 
		srcB <= (31 downto 26 => "011110" , 25 downto 0 => '1'); 
		command <= "1100"; wait for 10 ns;
		assert flags = "1000" report "or flag detection failed";
		assert result = (srcA or srcB) report "or functionality failed";	
		
		-- or zero flag
		srcA <= (31 downto 0 => '0'); 
		srcB <= (31 downto 0 => '0'); 
		command <= "1100"; wait for 10 ns;
		assert flags = "0100" report "or zero flag detection failed";
		assert result = (srcA or srcB) report "or functionality failed";	
		
		-- or negative flag
		srcA <= (31 downto 22 => "1101001110" ,21 downto 0 => '0'); 
		srcB <= (31 downto 26 => "111110" ,25 downto 0 => '1'); 
		command <= "1100"; wait for 10 ns;
		assert flags = "1000" report "or negative flag detection failed";
		assert result = (srcA or srcB) report "or functionality failed";	
		
		-- mov functionality test
		srcA <= (31 downto 22 => "1101001110", 21 downto 0 => '0'); 
		srcB <= (31 downto 26 => "011110" , 25 downto 0 => '1'); 
		command <= "1101"; wait for 10 ns;
		assert flags = "0000" report "flag detection failed";
		assert result = srcB report "mov functionality failed";		
		
		-- mov zero flag
		srcA <= (31 downto 26 => "011110" ,25 downto 0 => '1'); 
		srcB <= (31 downto 0 => '0');
		command <= "1101"; wait for 10 ns;
		assert flags = "0100" report "flag detection failed";
		assert result = srcB report "mov functionality failed";	
		
		-- mov negative flag
		srcA <= (31 downto 22 => "1101001110" ,21 downto 0 => '0'); 
		srcB <= (31 downto 26 => "111110" ,25 downto 0 => '1'); 
		command <= "1101"; wait for 10 ns;
		assert flags = "1000" report "mov negative flag detection failed";
		assert result = srcB report "mov functionality failed";	
		
		
		-- add with overflow
		srcA <= (31=> '0', 30 downto 0 => '1'); 
		srcB <= (31=> '0', 30 downto 0 => '1'); 
		command <= "0100"; wait for 10 ns;
		assert flags = "1001" report "overflow detection failed";
		assert result = std_logic_vector(unsigned(srcA) + unsigned(srcB)) report "add with overflow result failed";
	
	
		-- add without overflow
		srcA <= 32d"32"; 
		srcB <= 32d"32"; 
		command <= "0100"; wait for 10 ns;
		assert result = 32d"64" report "32 + 32 failed";
		assert flags = "0000" report "add without overflow flags failed";
			
			
		-- add with carry, no overflow
		srcA <= (31 downto 0 => '1'); 
		srcB <= (31 downto 0 => '1'); 
		command <= "0100"; wait for 10 ns;
		assert result = std_logic_vector(unsigned(srcA) + unsigned(srcB)) report "-1 + -1 failed";
		assert flags = "1010" report "Carry, no overflow detection failed";
			
		-- add no carry, overflow	
		srcA <= (31 => '0', 30 downto 0 => '1'); 
		srcB <= (31 downto 1 => '0', 0=>'1'); 
		command <= "0100"; wait for 10 ns;
		assert result = std_logic_vector(unsigned(srcA) + unsigned(srcB)) report "no caryy, overflow result failed";
		assert flags = "1001" report "overflow, no carry detection failed";
		
		
		-- add zero flag (-1+1), should be a carry too
		srcA <= (31 downto 0 => '1'); 
		srcB <= (31 downto 1 => '0', 0=>'1'); 
		command <= "0100"; wait for 10 ns;
		assert result = std_logic_vector(unsigned(srcA) + unsigned(srcB)) report "-1+1 failed";
		assert flags = "0110" report "add zero flag detection failed";
		
		-- add negative flag (-15+1)
		srcA <= (31 downto 5 => '1', 4 downto 0 => "10001"); 
		srcB <= (31 downto 1 => '0', 0=>'1'); 
		command <= "0100"; wait for 10 ns;
		assert result = std_logic_vector(unsigned(srcA) + unsigned(srcB)) report "-15+1 failed";
		assert flags = "1000" report "add negative flag detection failed";
		
		
		
		-- sub with overflow, should be a carry too
		srcA <= (31 => '1', 30 downto 0 => '0'); 
		srcB <= (31 downto 1 => '0', 0 => '1'); 
		command <= "0010"; wait for 10 ns;
		assert flags = "0011" report "sub overflow + carry detection failed";
		assert result = std_logic_vector(unsigned(srcA) - unsigned(srcB)) report "sub with overflow and carry result failed";
	
	
		-- sub without overflow
		srcA <= 32d"56"; 
		srcB <= 32d"32"; 
		command <= "0010"; wait for 10 ns;
		assert result = 32d"24" report "56 - 32 failed";
		assert flags = "0010" report "sub without overflow flags failed";
			
			
		-- sub with carry, no overflow ( also zero flag test because 1-1 = 0)
		srcA <= (31 downto 1 => '0', 0 =>'1'); 
		srcB <= (31 downto 1 => '0', 0 =>'1'); 
		command <= "0010"; wait for 10 ns;
		assert result = std_logic_vector(unsigned(srcA) - unsigned(srcB)) report "1-1 failed";
		assert flags = "0110" report "sub carry, no overflow detection failed";
			
		-- sub no carry, overflow	
		srcA <= (31 => '0' ,30 downto 0 => '1'); 
		srcB <= (31 downto 0 => '1'); 
		command <= "0010"; wait for 10 ns;
		assert result = std_logic_vector(unsigned(srcA) - unsigned(srcB)) report "sub no carry overflow failed";
		assert flags = "1001" report "sub overflow, no carry detection failed";
		
		-- sub negative flag test (-15 - 1)
		srcA <= (31 downto 5 => '1', 4 downto 0 => "10001"); 
		srcB <= (31 downto 1 => '0', 0=>'1'); 
		command <= "0010"; wait for 10 ns;
		assert result = std_logic_vector(unsigned(srcA) - unsigned(srcB)) report "-15-1 failed";
		assert flags = "1010" report "sub negative flag detection failed";
		
		-- sub with overflow, should be a carry too
		srcA <= (31 => '1', 30 downto 0 => '0'); 
		srcB <= (31 downto 1 => '0', 0 => '1'); 
		command <= "0010"; wait for 10 ns;
		assert flags = "0011" report "sub overflow + carry detection failed";
		assert result = std_logic_vector(unsigned(srcA) - unsigned(srcB)) report "sub with overflow and carry result failed";
	
	
		-- RSB without overflow
		srcB <= 32d"56"; 
		srcA <= 32d"32"; 
		command <= "0011"; wait for 10 ns;
		assert result = 32d"24" report "56 - 32 failed";
		assert flags = "0010" report " rsb without overflow flags failed";
			
			
		-- RSB with carry, no overflow ( also zero flag test because 1-1 = 0)
		srcA <= (31 downto 1 => '0', 0 =>'1'); 
		srcB <= (31 downto 1 => '0', 0 =>'1'); 
		command <= "0011"; wait for 10 ns;
		assert result = std_logic_vector(unsigned(srcB) - unsigned(srcA)) report "1-1 failed";
		assert flags = "0110" report "rsb carry, no overflow detection failed";
			
		-- RSB no carry, overflow	
		srcB <= (31 => '0' ,30 downto 0 => '1'); 
		srcA <= (31 downto 0 => '1'); 
		command <= "0011"; wait for 10 ns;
		assert result = std_logic_vector(unsigned(srcB) - unsigned(srcA)) report "rsb no carry overflow failed";
		assert flags = "1001" report "rsb overflow, no carry detection failed";
		
		-- RSB negative flag test (-15 - 1)
		srcB <= (31 downto 5 => '1', 4 downto 0 => "10001"); 
		srcA <= (31 downto 1 => '0', 0=>'1'); 
		command <= "0011"; wait for 10 ns;
		assert result = std_logic_vector(unsigned(srcB) - unsigned(srcA)) report "-15-1 failed";
		assert flags = "1010" report "RSB negative flag detection failed";
		
		-- RSB with overflow, should be a carry too
		srcB <= (31 => '1', 30 downto 0 => '0'); 
		srcA <= (31 downto 1 => '0', 0 => '1'); 
		command <= "0011"; wait for 10 ns;
		assert flags = "0011" report "RSB overflow + carry detection failed";
		assert result = std_logic_vector(unsigned(srcB) - unsigned(srcA)) report "RSB with overflow and carry result failed";
		
		
	wait;
	end process;








end;