library ieee;
use ieee.std_logic_1164.all;

entity ula_top is
    port(
        pin_A   : in  std_logic_vector(5 downto 0);
        pin_B   : in  std_logic_vector(5 downto 0);
        pin_sel : in  std_logic_vector(3 downto 0);

        pin_S   : out std_logic_vector(5 downto 0);

        -- as flag dos guri
        flag_overflow  : out std_logic;
        flag_zero      : out std_logic;
        flag_negativo  : out std_logic;
        flag_igualdade : out std_logic;
        flag_grandeza  : out std_logic;

        -- Display do A 
        led_sinal_a : out std_logic;
        hex_a_dez   : out std_logic_vector(6 downto 0);
        hex_a_uni   : out std_logic_vector(6 downto 0);

        -- Display do Bzin 
        led_sinal_b : out std_logic;
        hex_b_dez   : out std_logic_vector(6 downto 0);
        hex_b_uni   : out std_logic_vector(6 downto 0);

        -- Display de s
        hex_s_sin   : out std_logic_vector(6 downto 0);
        hex_s_dez   : out std_logic_vector(6 downto 0);
        hex_s_uni   : out std_logic_vector(6 downto 0)
    );
end ula_top;

architecture structural of ula_top is
  
    component arithmetic_unit is
        port (
            a, b     : in std_logic_vector(5 downto 0);
            ctrl     : in std_logic; 
            s        : out std_logic_vector(5 downto 0);
            cout     : out std_logic;
            overflow : out std_logic
        );
    end component;

    component logic_unit is
        port(
            a, b : in std_logic_vector(5 downto 0);
            sel  : in std_logic_vector(1 downto 0); 
            s    : out std_logic_vector(5 downto 0)
        );
    end component;

    component shifter_unit is
        port(
            a, b : in std_logic_vector(5 downto 0);
            sel  : in std_logic_vector (1 downto 0); 
            s    : out std_logic_vector(5 downto 0)
        );
    end component;

    component mux_16to1 is
        port(
            sel      : in  std_logic_vector(3 downto 0);
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
    end component;

    component comparators_unit is
        port(
            a, b : in std_logic_vector (5 downto 0);
            s    : in std_logic_vector(5 downto 0);
            zero : out std_logic;
            neg  : out std_logic;
            ig   : out std_logic; 
            me   : out std_logic 
        );
    end component;

    component seg7_ab is
        port(
            entrada : in  std_logic_vector(5 downto 0);
            sinal   : out std_logic;                   
            saida0  : out std_logic_vector(6 downto 0); 
            saida1  : out std_logic_vector(6 downto 0)  
        );
    end component;

    component seg7_s is
        port(
            entrada : in  std_logic_vector(5 downto 0);
            saida1  : out std_logic_vector(6 downto 0); 
            saida2  : out std_logic_vector(6 downto 0); 
            saida3  : out std_logic_vector(6 downto 0)  
        );
    end component;

   
    signal wire_b_arith : std_logic_vector(5 downto 0);
    signal ctrl_arith   : std_logic;
    signal sel_logic    : std_logic_vector(1 downto 0);
    signal sel_shift    : std_logic_vector(1 downto 0);

    signal wire_s_arith : std_logic_vector(5 downto 0);
    signal wire_s_logic : std_logic_vector(5 downto 0);
    signal wire_s_shift : std_logic_vector(5 downto 0);
    
    -- Fio do MUX para a saída
    signal wire_s_final : std_logic_vector(5 downto 0);
    signal wire_ov_arith: std_logic;

begin


    wire_b_arith <= "000001" when (pin_sel = "1100" or pin_sel = "1101") else pin_B;
    
    -- Se for Subtração(0001) ou Decremento(1101), ativa o complemento de 2.
    ctrl_arith <= '1' when (pin_sel = "0001" or pin_sel = "1101") else '0';

						--  Unidade Lógica: 00=OR(0010), 01=AND(0011), 10=NOT_A(0100), 11=NOT_B(0101)
    sel_logic <= "00" when pin_sel = "0010" else
                 "01" when pin_sel = "0011" else
                 "10" when pin_sel = "0100" else
                 "11" when pin_sel = "0101" else
                 "00";

   --Unidade de Deslocamento: 00=SLA(0110), 01=SRA(0111), 10=SLB(1010), 11=SRB(1011)
    sel_shift <= "00" when pin_sel = "0110" else
                 "01" when pin_sel = "0111" else
                 "10" when pin_sel = "1010" else
                 "11" when pin_sel = "1011" else
                 "00";
					  
    U_ARITH: arithmetic_unit port map(
        a        => pin_A,
        b        => wire_b_arith,
        ctrl     => ctrl_arith,
        s        => wire_s_arith,
        cout     => open, 
        overflow => wire_ov_arith
    );

    U_LOGIC: logic_unit port map(
        a   => pin_A,
        b   => pin_B,
        sel => sel_logic,
        s   => wire_s_logic
    );

    U_SHIFT: shifter_unit port map(
        a   => pin_A,
        b   => pin_B,
        sel => sel_shift,
        s   => wire_s_shift
    );
    U_MUX: mux_16to1 port map(
        sel     => pin_sel,
        a_add_b => wire_s_arith, 
        a_sub_b => wire_s_arith, 
        a_or_b  => wire_s_logic,
        a_and_b => wire_s_logic,
        not_a   => wire_s_logic,
        not_b   => wire_s_logic,
        sl_a    => wire_s_shift,
        sr_a    => wire_s_shift,
        pass_a  => pin_A,
        pass_b  => pin_B,
        sl_b    => wire_s_shift,
        sr_b    => wire_s_shift,
        a_inc   => wire_s_arith, 
        a_dec   => wire_s_arith, 
        s       => wire_s_final
    );

    U_CMP: comparators_unit port map(
        a    => pin_A,
        b    => pin_B,
        s    => wire_s_final,
        zero => flag_zero,
        neg  => flag_negativo,
        ig   => flag_igualdade,
        me   => flag_grandeza
    );


    U_DISP_A: seg7_ab port map(
        entrada => pin_A,
        sinal   => led_sinal_a,
        saida0  => hex_a_dez,
        saida1  => hex_a_uni
    );

    U_DISP_B: seg7_ab port map(
        entrada => pin_B,
        sinal   => led_sinal_b,
        saida0  => hex_b_dez,
        saida1  => hex_b_uni
    );

    U_DISP_S: seg7_s port map(
        entrada => wire_s_final,
        saida1  => hex_s_sin,
        saida2  => hex_s_dez,
        saida3  => hex_s_uni
    );

    
    -- oia as saidas finais ai 
    pin_S <= wire_s_final;
    
    -- O Overflow só vai ser valido nas operacoes aritmeticaas
    flag_overflow <= wire_ov_arith when (pin_sel = "0000" or pin_sel = "0001" or pin_sel = "1100" or pin_sel = "1101") else '0';

end structural;