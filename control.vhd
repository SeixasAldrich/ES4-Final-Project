library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity control is
port( 	clk, reset, use_immed: in std_logic;
		instruction: in std_logic_vector(31 downto 0);
		flags: in std_logic_vector(3 downto 0);
		ImmSrc: out std_logic_vector(1 downto 0);
		MemToReg, MemWrite, RegWrite, RegSrc, PCSrc, ALUSrc: out std_logic -- add ALUControl and use_immed?
	);
end;


architecture synth of control is

signal CPSR: std_logic_vector(3 downto 0);
signal PCS: std_logic;

begin

	process(all) begin
	
	if (instruction(27 downto 26) = "00") then
	
		if instruction(20) = '1' then
			CPSR <= flags;
		end if;
	
			case(instruction(24 downto 21)) is
				
				when "0000" =>	PCSrc <= '0';     -- AND
								RegSrc <= '0';
								RegWrite <= '1';
								ImmSrc <= "01";
								MemWrite <= '0';
								MemToreg <= '0';
								ALUSrc <= use_immed;
				
				when "1100" => PCSrc <= '0';     -- ORR
								RegSrc <= '0';
								RegWrite <= '1';
								ImmSrc <= "01";
								MemWrite <= '0';
								MemToreg <= '0';
								ALUSrc <= use_immed;
								
				when "0100" =>  PCSrc <= '0';     -- ADD
								RegSrc <= '0';
								RegWrite <= '1';
								ImmSrc <= "01";
								MemWrite <= '0';
								MemToreg <= '0';
								ALUSrc <= use_immed;
								
				when "0010" => PCSrc <= '0';     -- SUB
								RegSrc <= '0';
								RegWrite <= '1';
								ImmSrc <= "01";
								MemWrite <= '0';
								MemToreg <= '0';
								ALUSrc <= use_immed;
								
				when "0011" => PCSrc <= '0';     -- RSB
								RegSrc <= '0';
								RegWrite <= '1';
								ImmSrc <= "01";
								MemWrite <= '0';
								MemToreg <= '0';
								ALUSrc <= use_immed;
			
				when "1101" => PCSrc <= '0';     -- MOV
								RegSrc <= '0';
								RegWrite <= '1';
								ImmSrc <= "01";
								MemWrite <= '0';
								MemToreg <= '0';
								ALUSrc <= use_immed;
				
				when others =>  PCSrc <= '0';    
								RegSrc <= '0';
								RegWrite <= '0';
								ImmSrc <= "11";
								MemWrite <= '0';
								MemToreg <= '0';
								ALUSrc <= use_immed;

				end case;
		
		elsif (instruction(27 downto 26) = "01") then
			
			case(instruction(20)) is
				
				when '0' => 	PCSrc <= '0';     -- STR
								RegSrc <= '1';
								RegWrite <= '0';
								ImmSrc <= "01";
								MemWrite <= '1';
								MemToreg <= '0';
								ALUSrc <= '1'; 
								
				when '1' => 	PCSrc <= '0';     -- LDR
								RegSrc <= '1';
								RegWrite <= '1';
								ImmSrc <= "01";
								MemWrite <= '0';
								MemToreg <= '1';
								ALUSrc <= '1';
				
				when others => PCSrc <= '0';     
								RegSrc <= '0';
								RegWrite <= '0';
								ImmSrc <= "11";
								MemWrite <= '0';
								MemToreg <= '0';
								ALUSrc <= '0';
				end case;
				
		end if;


end process;




end;