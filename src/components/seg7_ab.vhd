library ieee;
use ieee.std_logic_1164.all;

entity seg7_ab is
port(
    entrada  : in  std_logic_vector(5 downto 0);
    sinal    : out std_logic;                   
    saida0 : out std_logic_vector(6 downto 0); -- dezena
    saida1 : out std_logic_vector(6 downto 0)  -- unidade
);
end seg7_ab;

architecture arq_seg7_ab of seg7_ab is
begin

sinal <= entrada(5);

-- Dezena
with entrada select
saida0 <=
    "1000000" when "000000", --  0 -> dezena 0
    "1000000" when "000001", --  1 -> dezena 0
    "1000000" when "000010", --  2 -> dezena 0
    "1000000" when "000011", --  3 -> dezena 0
    "1000000" when "000100", --  4 -> dezena 0
    "1000000" when "000101", --  5 -> dezena 0
    "1000000" when "000110", --  6 -> dezena 0
    "1000000" when "000111", --  7 -> dezena 0
    "1000000" when "001000", --  8 -> dezena 0
    "1000000" when "001001", --  9 -> dezena 0
    "1111001" when "001010", -- 10 -> dezena 1
    "1111001" when "001011", -- 11 -> dezena 1
    "1111001" when "001100", -- 12 -> dezena 1
    "1111001" when "001101", -- 13 -> dezena 1
    "1111001" when "001110", -- 14 -> dezena 1
    "1111001" when "001111", -- 15 -> dezena 1
    "1111001" when "010000", -- 16 -> dezena 1
    "1111001" when "010001", -- 17 -> dezena 1
    "1111001" when "010010", -- 18 -> dezena 1
    "1111001" when "010011", -- 19 -> dezena 1
    "0100100" when "010100", -- 20 -> dezena 2
    "0100100" when "010101", -- 21 -> dezena 2
    "0100100" when "010110", -- 22 -> dezena 2
    "0100100" when "010111", -- 23 -> dezena 2
    "0100100" when "011000", -- 24 -> dezena 2
    "0100100" when "011001", -- 25 -> dezena 2
    "0100100" when "011010", -- 26 -> dezena 2
    "0100100" when "011011", -- 27 -> dezena 2
    "0100100" when "011100", -- 28 -> dezena 2
    "0100100" when "011101", -- 29 -> dezena 2
    "0110000" when "011110", -- 30 -> dezena 3
    "0110000" when "011111", -- 31 -> dezena 3
    "0110000" when "100000", -- -32 -> dezena 3
    "0110000" when "100001", -- -31 -> dezena 3
    "0110000" when "100010", -- -30 -> dezena 3
    "0100100" when "100011", -- -29 -> dezena 2
    "0100100" when "100100", -- -28 -> dezena 2
    "0100100" when "100101", -- -27 -> dezena 2
    "0100100" when "100110", -- -26 -> dezena 2
    "0100100" when "100111", -- -25 -> dezena 2
    "0100100" when "101000", -- -24 -> dezena 2
    "0100100" when "101001", -- -23 -> dezena 2
    "0100100" when "101010", -- -22 -> dezena 2
    "0100100" when "101011", -- -21 -> dezena 2
    "0100100" when "101100", -- -20 -> dezena 2
    "1111001" when "101101", -- -19 -> dezena 1
    "1111001" when "101110", -- -18 -> dezena 1
    "1111001" when "101111", -- -17 -> dezena 1
    "1111001" when "110000", -- -16 -> dezena 1
    "1111001" when "110001", -- -15 -> dezena 1
    "1111001" when "110010", -- -14 -> dezena 1
    "1111001" when "110011", -- -13 -> dezena 1
    "1111001" when "110100", -- -12 -> dezena 1
    "1111001" when "110101", -- -11 -> dezena 1
    "1111001" when "110110", -- -10 -> dezena 1
    "1000000" when "110111", --  -9 -> dezena 0
    "1000000" when "111000", --  -8 -> dezena 0
    "1000000" when "111001", --  -7 -> dezena 0
    "1000000" when "111010", --  -6 -> dezena 0
    "1000000" when "111011", --  -5 -> dezena 0
    "1000000" when "111100", --  -4 -> dezena 0
    "1000000" when "111101", --  -3 -> dezena 0
    "1000000" when "111110", --  -2 -> dezena 0
    "1000000" when others;   --  -1 -> dezena 0

-- Unidade
with entrada select
saida1 <=
    "1000000" when "000000", --  0 -> unidade 0
    "1111001" when "000001", --  1 -> unidade 1
    "0100100" when "000010", --  2 -> unidade 2
    "0110000" when "000011", --  3 -> unidade 3
    "0011001" when "000100", --  4 -> unidade 4
    "0010010" when "000101", --  5 -> unidade 5
    "0000010" when "000110", --  6 -> unidade 6
    "1111000" when "000111", --  7 -> unidade 7
    "0000000" when "001000", --  8 -> unidade 8
    "0010000" when "001001", --  9 -> unidade 9
    "1000000" when "001010", -- 10 -> unidade 0
    "1111001" when "001011", -- 11 -> unidade 1
    "0100100" when "001100", -- 12 -> unidade 2
    "0110000" when "001101", -- 13 -> unidade 3
    "0011001" when "001110", -- 14 -> unidade 4
    "0010010" when "001111", -- 15 -> unidade 5
    "0000010" when "010000", -- 16 -> unidade 6
    "1111000" when "010001", -- 17 -> unidade 7
    "0000000" when "010010", -- 18 -> unidade 8
    "0010000" when "010011", -- 19 -> unidade 9
    "1000000" when "010100", -- 20 -> unidade 0
    "1111001" when "010101", -- 21 -> unidade 1
    "0100100" when "010110", -- 22 -> unidade 2
    "0110000" when "010111", -- 23 -> unidade 3
    "0011001" when "011000", -- 24 -> unidade 4
    "0010010" when "011001", -- 25 -> unidade 5
    "0000010" when "011010", -- 26 -> unidade 6
    "1111000" when "011011", -- 27 -> unidade 7
    "0000000" when "011100", -- 28 -> unidade 8
    "0010000" when "011101", -- 29 -> unidade 9
    "1000000" when "011110", -- 30 -> unidade 0
    "1111001" when "011111", -- 31 -> unidade 1
    "0100100" when "100000", -- -32 -> unidade 2
    "1111001" when "100001", -- -31 -> unidade 1
    "1000000" when "100010", -- -30 -> unidade 0
    "0010000" when "100011", -- -29 -> unidade 9
    "0000000" when "100100", -- -28 -> unidade 8
    "1111000" when "100101", -- -27 -> unidade 7
    "0000010" when "100110", -- -26 -> unidade 6
    "0010010" when "100111", -- -25 -> unidade 5
    "0011001" when "101000", -- -24 -> unidade 4
    "0110000" when "101001", -- -23 -> unidade 3
    "0100100" when "101010", -- -22 -> unidade 2
    "1111001" when "101011", -- -21 -> unidade 1
    "1000000" when "101100", -- -20 -> unidade 0
    "0010000" when "101101", -- -19 -> unidade 9
    "0000000" when "101110", -- -18 -> unidade 8
    "1111000" when "101111", -- -17 -> unidade 7
    "0000010" when "110000", -- -16 -> unidade 6
    "0010010" when "110001", -- -15 -> unidade 5
    "0011001" when "110010", -- -14 -> unidade 4
    "0110000" when "110011", -- -13 -> unidade 3
    "0100100" when "110100", -- -12 -> unidade 2
    "1111001" when "110101", -- -11 -> unidade 1
    "1000000" when "110110", -- -10 -> unidade 0
    "0010000" when "110111", --  -9 -> unidade 9
    "0000000" when "111000", --  -8 -> unidade 8
    "1111000" when "111001", --  -7 -> unidade 7
    "0000010" when "111010", --  -6 -> unidade 6
    "0010010" when "111011", --  -5 -> unidade 5
    "0011001" when "111100", --  -4 -> unidade 4
    "0110000" when "111101", --  -3 -> unidade 3
    "0100100" when "111110", --  -2 -> unidade 2
    "1111001" when others;   --  -1 -> unidade 1

end arq_seg7_ab;
