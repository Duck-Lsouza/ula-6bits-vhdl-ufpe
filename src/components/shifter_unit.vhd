library ieee;
use ieee
.std_logic_1164.all;

entity shifter_unit is
	port(
		a,b : in std_logic_vector(5 downto 0);
		sel : in std_logic_vector (1 downto 0 ); --00 SLA 01 SRA 10 SLB 11 SRB
		
		s : out std_logic_vector(5 downto 0)
		
		);
end entity;
		
architecture dataflow of shifter_unit is
begin

	with sel select --queria usar o case aquiiii
		
		s <=(a(4 downto 0) & '0') when "00", --multiplica o A por dois(shift_left )
		(a(5)& a(5 downto 1)) when "01", --divide o A por dois (shif right)
		(b(4 downto 0 )& '0') when "10", --multiplica B por dois (shift left)
		(b(5) & b(5 downto 1)) when "11", -- divide B por dois (shift right)
		(others => '0') when others;
		
end architecture;		
		