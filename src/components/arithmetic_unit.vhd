library ieee;
use ieee.std_logic_1164.all;

entity arithmetic_unit is
	port (
		a, b : in std_logic_vector(5 downto 0);
		ctrl : in std_logic; -- o ctrl é o bit de controle o qual os meus colegas de turma chama de "sel", mas bit de controle pra mim é mais elegante, né ?
		s : out std_logic_vector(5 downto 0);
		cout: out std_logic;
		overflow : out std_logic
	);
	
end entity;

architecture structural of arithmetic_unit is

	component full_adder is
		port(
			a,b, cin : in std_logic;
			s, cout : out std_logic
		);
	end component;
	
	signal c : std_logic_vector(6 downto 0);
	signal b_xor : std_logic_vector(5 downto 0);
	
begin

	c(0) <= ctrl;
	
	--agora é so vai e vem fi
	
	BIT0: full_adder port map(
		a => a(0),
		b => b(0) xor ctrl,
		cin => c(0),
		s => s(0),
		cout => c(1)
		);
		
	BIT1: full_adder port map (
		a => a(1),
		b => b(1) xor ctrl,
		cin => c(1),
		s => s(1),
		cout => c(2)
	);
	
	BIT2: full_adder port map(
		a => a(2),
		b => b(2) xor ctrl,
		cin => c(2),
		s => s(2),
		cout => c(3)
	);
	
	BIT3: full_adder port map(
		a => a(3),
		b => b(3) xor ctrl,
		cin => c(3),
		s => s(3),
		cout => c(4)
		
	);
	
	BIT4: full_adder port map(
		a => a(4),
		b => b(4) xor ctrl,
		cin => c(4),
		s => s(4),
		cout => c(5)
	);
	
	BIT5: full_adder port map(
		a => a(5),
		b => b(5) xor ctrl,
		cin => c(5),
		s => s(5),
		cout => c(6)
	);
	
	cout <= c(6);
	overflow <= c(6) xor c(5);
end architecture;
	
	
	
	
	
	