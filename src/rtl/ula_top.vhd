library ieee;
use ieee.std_logic_1164.all;

entity ula_top is
	port(
	
	--Duas entradas de 6 bits, a Saida e o seletor
		pin_A : in std_logic_vector(5 downto 0);
		pin_B : in std_logic_vector(5 downto 0);
		pin_sel : in std_logic_vector(3 downto 0);
		pin_S : out std_logic_vector(5 downto 0);
		--Flags para overflow, A < B, A=B e negativo
	
			--flag_overflow : out std_logic;
			
			--flag_negativo : out std_logic;
	
			--flag_zero : out std_logic;
			
			--flag_igualdade : out std_logic;
			
			--flag_grandeza : out std_logic;
			
			--dezena e unidade no display de 7seg
			
			hex0 : out std_logic_vector(6 downto 0);
			hex1 : out std_logic_vector(6 downto 0)
	);
end entity;
	
architecture structural of ula_top is
		
		--Declarando o componente unidade Aritmética
		component arithmetic_unit is
		port(
		a,b : in std_logic_vector(5 downto 0);
		sel : in std_logic_vector(2 downto 0);
		s : out std_logic_vector(5 downto 0);
		cout : out std_logic
		);
		end component;
		
		--Declarando o componente do display 7seg
		component bin_to_7seg is
		port(
			bin : in std_logic_vector(3 downto 0);
			seven: out std_logic_vector(6 downto 0)
		);
		end component;
		
		--sinais internos 
		
		signal  wire_arith_out :std_logic_vector(5 downto 0);
		signal wire_cout: std_logic;
		
		
		
begin
		
	--conectando a  unidade aritmética
	U1: arithmetic_unit port map (
		a => pin_A,
		b => pin_B,
		sel => pin_sel(2 downto 0),
		s => wire_arith_out,
		cout => wire_cout
		);
		--saida para a unidade aritmetica
		pin_S <= wire_arith_out;
	end architecture;
	