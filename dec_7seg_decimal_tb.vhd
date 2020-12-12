library ieee;
use ieee.std_logic_1164.all;

entity dec_7seg_decimal_tb is
end dec_7seg_decimal_tb;

architecture sim_dec_7seg_decimal of dec_7seg_decimal_tb is
    signal i_hexDigit_tb			: STD_LOGIC_VECTOR(3 downto 0);
    signal segment1_a_tb, segment1_b_tb, segment1_c_tb, segment1_d_tb, segment1_e_tb,
    segment1_f_tb, segment1_g_tb	: STD_LOGIC;
    signal segment2_a_tb, segment2_b_tb, segment2_c_tb, segment2_d_tb, segment2_e_tb,
    segment2_f_tb, segment2_g_tb : STD_LOGIC;

    component dec_7seg_decimal is
        PORT(i_hexDigit	: IN STD_LOGIC_VECTOR(3 downto 0);
            o_segment1_a, o_segment1_b, o_segment1_c, o_segment1_d, o_segment1_e,
            o_segment1_f, o_segment1_g : OUT STD_LOGIC;
            o_segment2_a, o_segment2_b, o_segment2_c, o_segment2_d, o_segment2_e,
            o_segment2_f, o_segment2_g : OUT STD_LOGIC);
    end component;

    constant period: time := 50 ns;

begin
    DUT : dec_7seg_decimal
            port map(i_hexDigit => i_hexDigit_tb,
                     o_segment1_a => segment1_a_tb,
                     o_segment1_b => segment1_b_tb,
                     o_segment1_c => segment1_c_tb,
                     o_segment1_d => segment1_d_tb,
                     o_segment1_e => segment1_e_tb,
                     o_segment1_f => segment1_f_tb,
                     o_segment1_g => segment1_g_tb,
                     o_segment2_a => segment2_a_tb,
                     o_segment2_b => segment2_b_tb,
                     o_segment2_c => segment2_c_tb,
                     o_segment2_d => segment2_d_tb,
                     o_segment2_e => segment2_e_tb,
                     o_segment2_f => segment2_f_tb,
                     o_segment2_g => segment2_g_tb);

    testbench_process : process
    begin

        i_hexDigit_tb <= "0000";
        wait for period;
        -- int_segment1_data <= "1111110";
        -- int_segment2_data <= "1111110";
        assert (segment1_a_tb = '0')
        report "Hex value of 0000 failed, segment1_a should be 0"
        severity error;
        assert (segment1_b_tb = '0')
        report "Hex value of 0000 failed, segment1_b should be 0"
        severity error;
        assert (segment1_c_tb = '0')
        report "Hex value of 0000 failed, segment1_c should be 0"
        severity error;
        assert (segment1_d_tb = '0')
        report "Hex value of 0000 failed, segment1_d should be 0"
        severity error;
        assert (segment1_e_tb = '0')
        report "Hex value of 0000 failed, segment1_e should be 0"
        severity error;
        assert (segment1_f_tb = '0')
        report "Hex value of 0000 failed, segment1_f should be 0"
        severity error;
        assert (segment1_g_tb = '1')
        report "Hex value of 0000 failed, segment1_g should be 1"
        severity error;

        assert (segment2_a_tb = '0')
        report "Hex value of 0000 failed, segment2_a should be 0"
        severity error;
        assert (segment2_b_tb = '0')
        report "Hex value of 0000 failed, segment2_b should be 0"
        severity error;
        assert (segment2_c_tb = '0')
        report "Hex value of 0000 failed, segment2_c should be 0"
        severity error;
        assert (segment2_d_tb = '0')
        report "Hex value of 0000 failed, segment2_d should be 0"
        severity error;
        assert (segment2_e_tb = '0')
        report "Hex value of 0000 failed, segment2_e should be 0"
        severity error;
        assert (segment2_f_tb = '0')
        report "Hex value of 0000 failed, segment2_f should be 0"
        severity error;
        assert (segment2_g_tb = '1')
        report "Hex value of 0000 failed, segment2_g should be 1"
        severity error;



        i_hexDigit_tb <= "1010";
        wait for period;
        -- int_segment1_data <= "0110000";
        -- int_segment2_data <= "1111110";
        assert (segment1_a_tb = '1')
        report "Hex value of 1010 failed, segment1_a should be 1"
        severity error;
        assert (segment1_b_tb = '0')
        report "Hex value of 1010 failed, segment1_b should be 0"
        severity error;
        assert (segment1_c_tb = '0')
        report "Hex value of 1010 failed, segment1_c should be 0"
        severity error;
        assert (segment1_d_tb = '1')
        report "Hex value of 1010 failed, segment1_d should be 1"
        severity error;
        assert (segment1_e_tb = '1')
        report "Hex value of 1010 failed, segment1_e should be 1"
        severity error;
        assert (segment1_f_tb = '1')
        report "Hex value of 1010 failed, segment1_f should be 1"
        severity error;
        assert (segment1_g_tb = '1')
        report "Hex value of 1010 failed, segment1_g should be 1"
        severity error;

        assert (segment2_a_tb = '0')
        report "Hex value of 1010 failed, segment2_a should be 0"
        severity error;
        assert (segment2_b_tb = '0')
        report "Hex value of 1010 failed, segment2_b should be 0"
        severity error;
        assert (segment2_c_tb = '0')
        report "Hex value of 1010 failed, segment2_c should be 0"
        severity error;
        assert (segment2_d_tb = '0')
        report "Hex value of 1010 failed, segment2_d should be 0"
        severity error;
        assert (segment2_e_tb = '0')
        report "Hex value of 1010 failed, segment2_e should be 0"
        severity error;
        assert (segment2_f_tb = '0')
        report "Hex value of 1010 failed, segment2_f should be 0"
        severity error;
        assert (segment2_g_tb = '1')
        report "Hex value of 1010 failed, segment2_g should be 1"
        severity error;



        i_hexDigit_tb <= "1110";
        wait for period;
        -- int_segment1_data <= "0110000";
        -- int_segment2_data <= "0110011";
        assert (segment1_a_tb = '1')
        report "Hex value of 1110 failed, segment1_a should be 1"
        severity error;
        assert (segment1_b_tb = '0')
        report "Hex value of 1110 failed, segment1_b should be 0"
        severity error;
        assert (segment1_c_tb = '0')
        report "Hex value of 1110 failed, segment1_c should be 0"
        severity error;
        assert (segment1_d_tb = '1')
        report "Hex value of 1110 failed, segment1_d should be 1"
        severity error;
        assert (segment1_e_tb = '1')
        report "Hex value of 1110 failed, segment1_e should be 1"
        severity error;
        assert (segment1_f_tb = '1')
        report "Hex value of 1110 failed, segment1_f should be 1"
        severity error;
        assert (segment1_g_tb = '1')
        report "Hex value of 1110 failed, segment1_g should be 1"
        severity error;

        assert (segment2_a_tb = '1')
        report "Hex value of 1110 failed, segment2_a should be 1"
        severity error;
        assert (segment2_b_tb = '0')
        report "Hex value of 1110 failed, segment2_b should be 0"
        severity error;
        assert (segment2_c_tb = '0')
        report "Hex value of 1110 failed, segment2_c should be 0"
        severity error;
        assert (segment2_d_tb = '1')
        report "Hex value of 1110 failed, segment2_d should be 1"
        severity error;
        assert (segment2_e_tb = '1')
        report "Hex value of 1110 failed, segment2_e should be 1"
        severity error;
        assert (segment2_f_tb = '0')
        report "Hex value of 1110 failed, segment2_f should be 0"
        severity error;
        assert (segment2_g_tb = '0')
        report "Hex value of 1110 failed, segment2_g should be 0"
        severity error;

    end process;

end sim_dec_7seg_decimal;