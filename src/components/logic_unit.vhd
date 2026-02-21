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
		
architecture dataflow of logic_unit is
begin
		
		--fiquei muito muito tentando a usar o case is com o process
		with sel select
			s <= (a or b ) when "00", -- faz a ou b
					(a and b) when "01", -- faz a and b
					(not a) when "10", -- nega o a
					(not b) when "11", -- nega o b
					(others => '0') when others;
					
	end architecture;