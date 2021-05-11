library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity decoder_test is
end;

architecture sim of decoder_test is

component decoder is
port(
instruction : in std_logic_vector(31 downto 0);
aluControl : out std_logic_vector(3 downto 0);
addrA : out unsigned(3 downto 0);
addrB : out unsigned(3 downto 0);
addrC : out unsigned(3 downto 0);
useImm : out std_logic
);
end component;



signal instruct: std_logic_vector(31 downto 0);
signal aluCtrl: std_logic_vector(3 downto 0);
signal A, B, C: unsigned(3 downto 0);
signal use_immediate: std_logic;

begin

	dut: decoder port map (instruct, aluCtrl, A, B, C, use_immediate);

	process begin
	
		for i in 0 to 2**10 loop
			instruct <= std_logic_vector(to_unsigned(i,32));
			wait for 10 ns;
			assert aluCtrl = instruct(24 downto 21) report "alu control signal failed";
			assert A = unsigned(instruct(19 downto 16)) report "addrA failed";
			assert B = unsigned(instruct(15 downto 12)) report "addrB failed";
			assert C = unsigned(instruct(3 downto 0)) report "addrC failed";
			assert use_immediate = instruct(25) report "use immediate signal failed";
		end loop;
		
		-- ALU control mux test, data instructions
		instruct <= (31 downto 28 => '0', 27 downto 26 => "01", 25 downto 0 => '0');
		wait for 10 ns;
		assert aluCtrl = "0100" report "alu control signal failed";
		
		-- ALU control mux test, branch instructions
		instruct <= (31 downto 28 => '0', 27 downto 26 => "10", 25 downto 0 => '0');
		wait for 10 ns;
		assert aluCtrl = "0100" report "alu control signal failed";
		
		
		
		
		wait;
	end process;


end;