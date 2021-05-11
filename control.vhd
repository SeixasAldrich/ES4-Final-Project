library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity control is
port( 	clk, reset, use_immed: in std_logic;
		instruction: in std_logic_vector(31 downto 0);
		flags: in std_logic_vector(3 downto 0);
		ImmSrc: out std_logic_vector(1 downto 0);
		MemToReg, MemWrite, RegWrite, RegSrc2, RegSrc1, PCSrc, ALUSrc: out std_logic
	);
end;


architecture synth of control is

component condcheck is
port( 	condition: in std_logic_vector(3 downto 0);
		flags: in std_logic_vector (3 downto 0);
		condEx: out std_logic
	);
end component;




signal CPSR: std_logic_vector(3 downto 0);
signal PCS, condEx: std_logic;



begin

	condchecker: condcheck port map(instruction(31 downto 28), CPSR, condEx);



	process(all) begin
	
	if (instruction(27 downto 26) = "00") then
	
		if (instruction(20) = '1' and condEx = '1') then
			if (instruction(24 downto 21) = "0000" or instruction(24 downto 21) = "1100" or instruction(24 downto 21) = "1101") then
				CPSR <= (flags( 3 downto 2), CPSR(1 downto 0));
			
			else
				CPSR <= flags;
			
			end if;
			
		end if;
	
			case(instruction(24 downto 21)) is
				
				when "0000" =>	 -- AND
								PCSrc <= '0';
								RegSrc2 <= '0';
								RegSrc1 <= '0';
								RegWrite <= '1' and condEx;
								ImmSrc <= "00";
								MemWrite <= '0';
								MemToreg <= '0';
								ALUSrc <= use_immed;
				
				when "1100" =>   -- ORR
								PCSrc <= '0';
								RegSrc2 <= '0';
								RegSrc1 <= '0';
								RegWrite <= '1' and condEx;
								ImmSrc <= "00";
								MemWrite <= '0';
								MemToreg <= '0';
								ALUSrc <= use_immed;
								
				when "0100" =>     -- ADD
								PCSrc <= '0';
								RegSrc2 <= '0';
								RegSrc1 <= '0';
								RegWrite <= '1' and condEx;
								ImmSrc <= "00";
								MemWrite <= '0';
								MemToreg <= '0';
								ALUSrc <= use_immed;
								
				when "0010" =>     -- SUB
								PCSrc <= '0';
								RegSrc2 <= '0';
								RegSrc1 <= '0';
								RegWrite <= '1' and condEx;
								ImmSrc <= "00";
								MemWrite <= '0';
								MemToreg <= '0';
								ALUSrc <= use_immed;
								
				when "0011" =>   -- RSB
								PCSrc <= '0';
								RegSrc2 <= '0';
								RegSrc1 <= '0';
								RegWrite <= '1' and condEx;
								ImmSrc <= "00";
								MemWrite <= '0';
								MemToreg <= '0';
								ALUSrc <= use_immed;
			
				when "1101" => 	     -- MOV
								PCSrc <= '0';
								RegSrc2 <= '0';
								RegSrc1 <= '0';
								RegWrite <= '1' and condEx;
								ImmSrc <= "00";
								MemWrite <= '0';
								MemToreg <= '0';
								ALUSrc <= use_immed;
				
				when others =>  PCSrc <= '0';    
								RegSrc2 <= '0';
								RegSrc1 <= '0';
								RegWrite <= '0';
								ImmSrc <= "11";
								MemWrite <= '0';
								MemToreg <= '0';
								ALUSrc <= use_immed;

				end case;
		
		elsif (instruction(27 downto 26) = "01") then
			
			case(instruction(20)) is
				
				when '0' =>		-- STR
								PCSrc <= '0';
								RegSrc2 <= '1';
								RegSrc1 <= '0';
								RegWrite <= '0';
								ImmSrc <= "01";
								MemWrite <= '1' and condEx;
								MemToreg <= '0';
								ALUSrc <= '1'; 
								
				when '1' =>     -- LDR
								PCSrc <= '0';
								RegSrc2 <= '0';
								RegSrc1 <= '0';
								RegWrite <= '1' and condEx;
								ImmSrc <= "01";
								MemWrite <= '0';
								MemToreg <= '1';
								ALUSrc <= '1';
				
				when others =>  PCSrc <= '0';
								RegSrc2 <= '0';
								RegSrc1 <= '0';
								RegWrite <= '0';
								ImmSrc <= "11";
								MemWrite <= '0';
								MemToreg <= '0';
								ALUSrc <= '0';
				end case;

		
		elsif (instruction(27 downto 26) = "10") then
			
				PCSrc <= '1' and condEx;
				RegSrc2 <= '1';
				RegSrc1 <= '1';
				RegWrite <= '0';
				ImmSrc <= "10";
				MemWrite <= '0';
				MemToreg <= '0';
				ALUSrc <= '1';
				
				
		end if;


end process;


--PCS <= '1' when ((instruction(19 downto 16) = "1111" and RegWrite = '1') or instruction (27 downto 26) = "10") else '0'; --writing to reg15 or branching

--PCSrc <= PCS and condEx;


end;