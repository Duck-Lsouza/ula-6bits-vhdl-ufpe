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
end entity;

architecture structural of ula_top is

  
    -- tamo declarando os componentes tamo declarando
 

    component arithmetic_unit is
        port(
            a, b : in  std_logic_vector(5 downto 0);
            ctrl : in  std_logic;
            s    : out std_logic_vector(5 downto 0);
            cout : out std_logic;
            overflow : out std_logic
        );
    end component;

    component logic_unit is
        port(
            a, b : in  std_logic_vector(5 downto 0);
            sel  : in  std_logic_vector(1 downto 0);
            s    : out std_logic_vector(5 downto 0)
        );
    end component;

    component shifter_unit is
        port(
            a, b : in  std_logic_vector(5 downto 0);
            sel  : in  std_logic_vector(1 downto 0);
            s    : out std_logic_vector(5 downto 0)
        );
    end component;

    component comparators_unit is
        port(
            a, b : in  std_logic_vector(5 downto 0);
            s    : in  std_logic_vector(5 downto 0);
            zero : out std_logic;
            neg  : out std_logic;
            ig   : out std_logic;
            me   : out std_logic
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

    component seg7_ab is
        port(
            entrada  : in  std_logic_vector(5 downto 0);
            sinal    : out std_logic;
            saida0   : out std_logic_vector(6 downto 0);
            saida1   : out std_logic_vector(6 downto 0)
        );
    end component;

    component seg7_s is
        port(
            entrada  : in  std_logic_vector(5 downto 0);
            saida1   : out std_logic_vector(6 downto 0);
            saida2   : out std_logic_vector(6 downto 0);
            saida3   : out std_logic_vector(6 downto 0)
        );
    end component;

   
    signal wire_add    : std_logic_vector(5 downto 0); -- A + B
    signal wire_sub    : std_logic_vector(5 downto 0); -- A - B
    signal wire_inc    : std_logic_vector(5 downto 0); -- A + 1
    signal wire_dec    : std_logic_vector(5 downto 0); -- A - 1
    signal wire_logic  : std_logic_vector(5 downto 0); -- saida logica
    signal wire_shift  : std_logic_vector(5 downto 0); -- saida shift

    -- Saidas logica para o mux
    signal wire_or_ab  : std_logic_vector(5 downto 0);
    signal wire_and_ab : std_logic_vector(5 downto 0);
    signal wire_not_a  : std_logic_vector(5 downto 0);
    signal wire_not_b  : std_logic_vector(5 downto 0);

    -- Saidas shift separadas (para o mux)
    signal wire_sl_a   : std_logic_vector(5 downto 0);
    signal wire_sr_a   : std_logic_vector(5 downto 0);
    signal wire_sl_b   : std_logic_vector(5 downto 0);
    signal wire_sr_b   : std_logic_vector(5 downto 0);

    -- Saida final da ULA (saida do mux)
    signal wire_s      : std_logic_vector(5 downto 0);

    -- Overflows e couts
    signal wire_cout_add  : std_logic;
    signal wire_cout_sub  : std_logic;
    signal wire_cout_inc  : std_logic;
    signal wire_cout_dec  : std_logic;
    signal wire_ov_add    : std_logic;
    signal wire_ov_sub    : std_logic;
    signal wire_ov_inc    : std_logic;
    signal wire_ov_dec    : std_logic;

begin

    U_ADD: arithmetic_unit port map(
        a        => pin_A,
        b        => pin_B,
        ctrl     => '0',
        s        => wire_add,
        cout     => wire_cout_add,
        overflow => wire_ov_add
    );

   
    U_SUB: arithmetic_unit port map(
        a        => pin_A,
        b        => pin_B,
        ctrl     => '1',
        s        => wire_sub,
        cout     => wire_cout_sub,
        overflow => wire_ov_sub
    );

 
    U_INC: arithmetic_unit port map(
        a        => pin_A,
        b        => "000001",
        ctrl     => '0',
        s        => wire_inc,
        cout     => wire_cout_inc,
        overflow => wire_ov_inc
    );

   
    U_DEC: arithmetic_unit port map(
        a        => pin_A,
        b        => "000001",
        ctrl     => '1',
        s        => wire_dec,
        cout     => wire_cout_dec,
        overflow => wire_ov_dec
    );

 
    -- Unidade Logica: OR (sel=00), AND (sel=01), NOT A (sel=10), NOT B (sel=11)
    -- Instanciada 4 vezes com sel fixo para obter cada resultado separado
    -
    U_OR: logic_unit port map(
        a   => pin_A,
        b   => pin_B,
        sel => "00",
        s   => wire_or_ab
    );

    U_AND: logic_unit port map(
        a   => pin_A,
        b   => pin_B,
        sel => "01",
        s   => wire_and_ab
    );

    U_NOTA: logic_unit port map(
        a   => pin_A,
        b   => pin_B,
        sel => "10",
        s   => wire_not_a
    );

    U_NOTB: logic_unit port map(
        a   => pin_A,
        b   => pin_B,
        sel => "11",
        s   => wire_not_b
    );

 
    U_SLA: shifter_unit port map(
        a   => pin_A,
        b   => pin_B,
        sel => "00",
        s   => wire_sl_a
    );

    U_SRA: shifter_unit port map(
        a   => pin_A,
        b   => pin_B,
        sel => "01",
        s   => wire_sr_a
    );

    U_SLB: shifter_unit port map(
        a   => pin_A,
        b   => pin_B,
        sel => "10",
        s   => wire_sl_b
    );

    U_SRB: shifter_unit port map(
        a   => pin_A,
        b   => pin_B,
        sel => "11",
        s   => wire_sr_b
    );

    U_MUX: mux_16to1 port map(
        sel     => pin_sel,
        a_add_b => wire_add,
        a_sub_b => wire_sub,
        a_or_b  => wire_or_ab,
        a_and_b => wire_and_ab,
        not_a   => wire_not_a,
        not_b   => wire_not_b,
        sl_a    => wire_sl_a,
        sr_a    => wire_sr_a,
        pass_a  => pin_A,
        pass_b  => pin_B,
        sl_b    => wire_sl_b,
        sr_b    => wire_sr_b,
        a_inc   => wire_inc,
        a_dec   => wire_dec,
        s       => wire_s
    );

    -- Saida principal da ULA
    pin_S <= wire_s;

   
    flag_overflow <= wire_ov_add when pin_sel = "0000" else
                     wire_ov_sub when pin_sel = "0001" else
                     wire_ov_inc when pin_sel = "1100" else
                     wire_ov_dec when pin_sel = "1101" else
                     '0';

    U_CMP: comparators_unit port map(
        a    => pin_A,
        b    => pin_B,
        s    => wire_s,
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
        entrada => wire_s,
        saida1  => hex_s_sin,
        saida2  => hex_s_dez,
        saida3  => hex_s_uni
    );

end architecture;
