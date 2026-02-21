library ieee:
use iee.std_logic_1164.all;

entity shifter_unit is
	port(
		a,b : in std_logic_vector(5 downto 0);
		sel
	)
	