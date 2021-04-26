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
		-- and zero flag
		
		
		-- or zero flag
		
		
		-- MOV zero flag
		
	
	
		-- add with overflow
		srcA <= (31=> '0', 30 downto 0 => '1'); srcB <= (31=> '0', 30 downto 0 => '1'); command <= "0100"; wait for 10 ns;
			assert flags(0) = '1' report "overflow detection failed";
	
	
		-- add without overflow
		srcA <= 32d"32"; srcB <= 32d"32"; command <= "0100"; wait for 10 ns;
			assert result = 32d"64" report "32 + 32 failed";
			
			
		-- carry, no overflow
		srcA <= (31 downto 0 => '1'); srcB <= (31 downto 0 => '1'); command <= "0100"; wait for 10 ns;
			--assert result = (31 downto 1 => '1', 0 => '0') report "-1 + -1 failed";
			assert (flags(1) = '1' and flags(0) = '0') report "Carry, no overflow detection failed";
			
		-- no carry overflow	
		srcA <= (31 => '0' ,30 downto 0 => '1'); srcB <= (31 downto 1 => '0', 0=>'1'); command <= "0100"; wait for 10 ns;
			assert result = (31 downto 30 => "10", 29 downto 0 =>'1') report "-1+-128 failed";
			assert (flags(0) = '1' and flags(1) = '0') report "overflow, no carry detection failed";
	wait;
	end process;








end;