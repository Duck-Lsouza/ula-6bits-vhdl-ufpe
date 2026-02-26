-- tamo comparando tamo comparando

library ieee;
use ieee.std_logic_1164.all;

entity comparators_unit is
	port(
		a, b : in std_logic_vector (5 downto 0);
		s : in std_logic_vector(5 downto 0);-- a saida final da ula pra testr o zero e negativo
		
		zero : out std_logic;
		neg: out std_logic;
		ig : out std_logic; --a =b
		me : out std_logic -- a<b considerando o complemeto de 2
		);
end entity;

architecture dataflow of comparators_unit	is

begin
	
	-- sai 1 quando for zero
		zero <= '1' when s = "000000" else '0';
		
		--o bit de sinal da saida vai ser copiado direto
		neg <= s(5);
		
	   -- recebe 1 se a = b	
		ig <= '1' when a = b else '0';
		
		--se a é negativo e b positivo o A é menor else
		-- a gente compara a magnitude que são os bits que sobraram excluindo sinal
		
		me   <= '1' when (a(5) = '1' and b(5) = '0') else
            '1' when (a(5) = b(5) and a(4 downto 0) < b(4 downto 0)) else
            '0';

end architecture;
		
	