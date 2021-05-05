library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity ramtest is

end;



architecture sim of ramtest is


component ram is 
port ( clk: in std_logic;
		write_enable: in std_logic;
		addr: in unsigned(31 downto 0);
		write_data: in unsigned(31 downto 0);
		read_data: out unsigned(31 downto 0)
);
end component;

signal clk, write_enable: std_logic;
signal addr, write_data, read_data: unsigned(31 downto 0);


begin

dut: ram port map (clk, write_enable, addr, write_data, read_data);

process begin
	-- writing data to ram when clk = 0, write_enable = 1 (should read UUUUUU...)
		clk <= '0';
		addr <= 32d"5";
		write_data <= 32d"17";
		wait for 10 ns;
		
		write_enable <= '1';
		
		wait for 10 ns;
		assert read_data = 32b"U" report "clk = 0; we = 1 failed.";
		
	-- writing data to ram when clk = rising edge, write_enable = 1 (should read 17)
		clk <= '0';
		addr <= 32d"5";
		write_data <= 32d"17";
		wait for 10 ns;
		write_enable <= '1';
		clk <= '1';
		wait for 10 ns;
		assert read_data = 32d"17" report "clk = rising edge; we = 1 failed.";
		
	-- writing data = 10 to ram when clk = rising edge, write_enable = 0 (should read 17)
		clk <= '0';
		addr <= 32d"5";
		write_data <= 32d"10";
		wait for 10 ns;
		write_enable <= '0';
		clk <= '1';
		wait for 10 ns;
		assert read_data = 32d"17" report "clk = rising edge; we = 0 failed.";

	-- writing data to ram when clk = 0, write_enable = 0 (should read 17)
		clk <= '0';
		addr <= 32d"5";
		write_data <= 32d"27";
		wait for 10 ns;
		
		write_enable <= '0';
		
		wait for 10 ns;
		assert read_data = 32d"17" report "clk = 0; we = 0 failed.";
		
		
	-- overwriting data to ram when clk = rising edge, write_enable = 1 (should read 10)
		clk <= '0';
		addr <= 32d"5";
		write_data <= 32d"10";
		wait for 10 ns;
		write_enable <= '1';
		clk <= '1';
		wait for 10 ns;
		assert read_data = 32d"10" report "clk = rising edge; we = 1 failed.";

	-- reading data from invalid address (should be XXXXX...)
		clk <= '0';
		addr <= 32d"32768";
		write_data <= 32d"17";
		wait for 10 ns;
		write_enable <= '0';
		wait for 10 ns;
		assert read_data = 32b"X" report "reading from invalid address failed.";

	wait;
end process;



end;
