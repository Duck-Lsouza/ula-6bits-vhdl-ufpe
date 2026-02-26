library ieee;
use ieee.std_logic_1164.all;


-- Codificacao das operacoes pq senao nos se perde
-- 0000: S = A + B
-- 0001: S = A - B
-- 0010: S = A or B
-- 0011: S = A and B
-- 0100: S = not A
-- 0101: S = not B
-- 0110: S = shift left A
-- 0111: S = shift right A
-- 1000: S = A
-- 1001: S = B
-- 1010: S = shift left B
-- 1011: S = shift right B
-- 1100: S = A + 1
-- 1101: S = A - 1

entity mux_16to1 is
    port(
        sel    : in  std_logic_vector(3 downto 0);
        a_add_b  : in  std_logic_vector(5 downto 0);
        a_sub_b  : in  std_logic_vector(5 downto 0); 
        a_or_b   : in  std_logic_vector(5 downto 0); 
        a_and_b  : in  std_logic_vector(5 downto 0); 
        not_a    : in  std_logic_vector(5 downto 0); 
        not_b    : in  std_logic_vector(5 downto 0); 
        sl_a     : in  std_logic_vector(5 downto 0); 
        sr_a     : in  std_logic_vector(5 downto 0); 
        pass_a   : in  std_logic_vector(5 downto 0);
        pass_b   : in  std_logic_vector(5 downto 0); 
        sl_b     : in  std_logic_vector(5 downto 0); 
        sr_b     : in  std_logic_vector(5 downto 0); 
        a_inc    : in  std_logic_vector(5 downto 0); 
        a_dec    : in  std_logic_vector(5 downto 0); 
        s        : out std_logic_vector(5 downto 0)
    );
end entity;

architecture arq_mux_16tol of mux_16to1 is
begin
    with sel select
        s <= a_add_b  when "0000",
             a_sub_b  when "0001",
             a_or_b   when "0010",
             a_and_b  when "0011",
             not_a    when "0100",
             not_b    when "0101",
             sl_a     when "0110",
             sr_a     when "0111",
             pass_a   when "1000",
             pass_b   when "1001",
             sl_b     when "1010",
             sr_b     when "1011",
             a_inc    when "1100",
             a_dec    when "1101",
             "000000" when others;
end architecture;
