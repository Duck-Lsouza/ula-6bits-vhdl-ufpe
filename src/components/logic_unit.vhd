-- nenhuma operação da unidade logica vai precisar dos carries 


library ieee;
use ieee.std_logic_1164.all;

	entity logic_unit is
		port(
			a, b : in std_logic_vector(5 downto 0);
			sel : in std_logic_vector(1 downto 0); -- seletor apenas para as operacoes logiccas
			s : out std_logic_vector(5 downto 0)
			
			);
		end entity;
		
architecture behavioral of logic_unit is
begin
		process(a, b, sel)
		begin
		
			case sel is
				when "00" => s <= a or b ; --00 faz a ou b S = A v B
				when "01" => s <=  a and b; -- 01 faz a and b S = A ^ B
				when "10" => s <= not a; --10 nega o A
				when "11" => s <= not b; --11 nega o B	
				when others => s <= (others => '0'); --casos indefinidos, adicionar outras operações logicas depois ?
			end case;
			
		end process;
	end architecture;