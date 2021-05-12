library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is
port ( reset: in std_logic;
		PC: out std_logic_vector(5 downto 0);
		output1, output2, output3: out std_logic;
		input1, input2: in std_logic
);

end;



architecture synth of top is


component HSOSC is
	generic (
	CLKHF_DIV : String := "0b00"); -- Divide 48MHz clock by 2ˆN (0-3)
	port(
	CLKHFPU : in std_logic := 'X'; -- Set to 1 to power up
	CLKHFEN : in std_logic := 'X'; -- Set to 1 to enable output
	CLKHF : out std_logic := 'X'); -- Clock output
	end component;
	
component datapath is
port(
clk: in std_logic;
PCreset : in std_logic;
PCcount: out std_logic_vector(5 downto 0);
output1, output2, output3: out std_logic;
input1, input2: in std_logic
);
end component;
	
signal count: std_logic_vector(31 downto 0);
signal clk: std_logic;
signal reg: std_logic_vector(2 downto 0):= "000";
signal bloop: std_logic;
signal temp, temp2: std_logic;

begin

clock: HSOSC port map ('1','1',clk);


process (clk) is
begin
if rising_edge(clk) then
	count <= std_logic_vector(unsigned(count) + 1);
end if;
end process;

bloop <= not reset;

cpu: datapath port map(count(18), bloop, PC, output1, output2, output3, input1, input2);


end;

