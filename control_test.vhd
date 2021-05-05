library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity control_test is
end;






architecture sim of control_test is


component control is
port( 	clk, reset, use_immed: in std_logic;
		instruction: in std_logic_vector(31 downto 0);
		flags: in std_logic_vector(3 downto 0);
		ImmSrc: out std_logic_vector(1 downto 0);
		MemToReg, MemWrite, RegWrite, RegSrc, PCSrc, ALUSrc: out std_logic
	);
end component;


signal clk, reset, use_immed: std_logic;
signal instruction: std_logic_vector(31 downto 0);
signal flags: std_logic_vector(3 downto 0);
signal ImmSrc: std_logic_vector(1 downto 0);
signal MemToReg, MemWrite, RegWrite, RegSrc, PCSrc, ALUSrc: std_logic;

begin

	dut: control port map(clk, reset, use_immed, instruction, flags, ImmSrc, MemToReg, MemWrite, RegWrite, RegSrc, PCSrc, ALUSrc);
	
	process begin
	
	-- ADD R1, R0, #2
	clk <= '0'; reset <= '0'; use_immed <= '1'; flags <= "1010";
	instruction <= "00000010100000000001000000000010";
	
	wait for 10 ns;
	
	assert ImmSrc = "01" report "immediate failed.";
	assert MemToReg = '0' report "memToReg failed.";
	assert memWrite = '0' report "memWrite failed.";
	assert RegWrite = '1' report "RegWrite failed.";
	assert RegSrc = '0' report "regSrc failed.";
	assert PCSrc = '0' report "PCSrc failed.";
	assert ALUSrc = '1' report "ALUSrc failed.";
	
	
	
	-- SUB R0, R1, R2 (with set)
	use_immed <= '0'; flags <= "1011";
	instruction <= "00000000010100010000000000000010";
	wait for 10 ns;
	
	assert ImmSrc = "01" report "immediate failed.";
	assert MemToReg = '0' report "memToReg failed.";
	assert memWrite = '0' report "memWrite failed.";
	assert RegWrite = '1' report "RegWrite failed.";
	assert RegSrc = '0' report "regSrc failed.";
	assert PCSrc = '0' report "PCSrc failed.";
	assert ALUSrc = '0' report "ALUSrc failed.";
	
	-- STR R1, [R0, #4]
	instruction <= "00000100000000000001000000000100";
	wait for 10 ns;
	
	assert ImmSrc = "01" report "immediate failed.";
	assert MemToReg = '0' report "memToReg failed.";
	assert memWrite = '1' report "memWrite failed.";
	assert RegWrite = '0' report "RegWrite failed.";
	assert RegSrc = '1' report "regSrc failed.";
	assert PCSrc = '0' report "PCSrc failed.";
	assert ALUSrc = '1' report "ALUSrc failed.";
	
	-- LDR R1, [R0, #4]
	instruction <= "00000100000100000001000000000100";
	wait for 10 ns;
	
	assert ImmSrc = "01" report "immediate failed.";
	assert MemToReg = '1' report "memToReg failed.";
	assert memWrite = '0' report "memWrite failed.";
	assert RegWrite = '1' report "RegWrite failed.";
	assert RegSrc = '1' report "regSrc failed.";
	assert PCSrc = '0' report "PCSrc failed.";
	assert ALUSrc = '1' report "ALUSrc failed.";
	
	wait;
	end process;


end;