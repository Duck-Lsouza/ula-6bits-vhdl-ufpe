library ieee;
use iee.std_logic_1164.all;

entity ula_top is
	port(
	--Duas entradas de 6 bits, a Saida e o seletor
		pin_A : in std_logic_vector(5 downto 0);

		pin_B : in std_logic_vector(5 downto 0);

		pin_sel : in std_logic_vector(3 downto 0);
	
		pin_S : out std_logic_vector(5 downto 0);
	
		--Flags para overflow, A < B, A=B e negativo
		
			flag_overflow : out std_logic;
			
			flag_negativo : out std_logic;
	
			flag_zero : out std_logic;
			
			flag_igualdade : out std_logic;
			
			flag_Bmaior : out std_logic;
			
			--dezena e unidade no display de 7seg
			
			hex0 : out std_logic(6 downto 0);
			hex1 : out std_logic(6 downto 0)
	);
end entity;
	