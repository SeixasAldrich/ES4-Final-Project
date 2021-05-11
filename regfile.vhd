library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity regfile is
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
end;

architecture synth of regfile is

	type ramtype is array(15 downto 0) of
		std_logic_vector(31 downto 0);
	signal mem : ramtype;

begin

	process(clk) is
	begin
	
		if rising_edge(clk) then
			if WE3 = '1' then
				mem(to_integer(A3)) <= WD3;
			end if;
		end if;
	
	end process;
	
	
	process(all) is
	begin
		
		if (A1 = "1111") then 
			RD1 <= R15;
		else 
			RD1 <= mem(to_integer(A1));
		end if;
		
		if (A2 = "1111") then 
			RD2 <= R15;
		else 
			RD2 <= mem(to_integer(A2));
		end if;
	
	end process;
		
end;
