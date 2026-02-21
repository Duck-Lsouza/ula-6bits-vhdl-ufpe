library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
	port(
		a : in std_logic;
		b : in std_logic;
		cin : in std_logic;
		s : out std_logic;
		cout : out std_logic 
	
	);
	end entity;
	
	architecture arch_full_adder of full_adder is 
	begin
		-- a equação da soma é s =
		
		s <= a xor b xor cin;
		
		cout <= (a and b) or (a and cin) or (b and cin);
end architecture;