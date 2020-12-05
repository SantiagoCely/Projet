library ieee;
use ieee.std_logic_1164.all;

entity fourBitComparator_tb is
end fourBitComparator_tb;

architecture sim_comparateur of fourBitComparator_tb is
    signal i_ValueA_TB, i_ValueB_TB			        : STD_LOGIC_VECTOR(3 downto 0);
    signal o_ValueGT_TB, o_ValueLT_TB, o_ValueEQ_TB	: STD_LOGIC;

    component fourBitComparator is
        PORT(i_Ai, i_Bi		    : IN	STD_LOGIC_VECTOR(3 downto 0);
            o_GT, o_LT, o_EQ    : OUT	STD_LOGIC);
    end component;

    constant period: time := 50 ns;

begin
    DUT : fourBitComparator
            port map(i_Ai => i_ValueA_TB,
                     i_Bi => i_ValueB_TB,
                     o_GT => o_ValueGT_TB,
                     o_LT => o_ValueLT_TB,
                     o_EQ => o_ValueEQ_TB);

    testbench_process : process
    begin

        i_ValueA_TB <= "0000";
        i_ValueB_TB <= "0001";
        wait for period;
        -- here the first number is smaller than the second one
        -- we expect GT to be 0, LT to be 1 and EQ to be 0.
        assert (o_ValueGT_TB = '0')
        report "First test for A < B failed, GT output should be 0"
        severity error;
        assert (o_ValueLT_TB = '1')
        report "First test for A < B failed, LT output should be 1"
        severity error;
        assert (o_ValueEQ_TB = '0')
        report "First test for A < B failed, EQ output should be 0"
        severity error;

        i_ValueA_TB <= "0010";
        i_ValueB_TB <= "0001";
        wait for period;
        -- here the first number is bigger than the second one
        -- we expect GT to be 1, LT to be 0 and EQ to be 0.
        assert (o_ValueGT_TB = '1')
        report "First test for A > B failed, GT output should be 1"
        severity error;
        assert (o_ValueLT_TB = '0')
        report "First test for A > B failed, LT output should be 0"
        severity error;
        assert (o_ValueEQ_TB = '0')
        report "First test for A > B failed, EQ output should be 0"
        severity error;

        i_ValueA_TB <= "0100";
        i_ValueB_TB <= "0100";
        wait for period;
        -- here the first number is equal to the second one
        -- we expect GT to be 0, LT to be 0 and EQ to be 1.
        assert (o_ValueGT_TB = '0')
        report "First test for A = B failed, GT output should be 0"
        severity error;
        assert (o_ValueLT_TB = '0')
        report "First test for A = B failed, LT output should be 0"
        severity error;
        assert (o_ValueEQ_TB = '1')
        report "First test for A = B failed, EQ output should be 1"
        severity error;

        i_ValueA_TB <= "0010";
        i_ValueB_TB <= "1001";
        wait for period;
        -- here the first number is smaller than the second one
        -- we expect GT to be 0, LT to be 1 and EQ to be 0.
        assert (o_ValueGT_TB = '0')
        report "Second test for A < B failed, GT output should be 0"
        severity error;
        assert (o_ValueLT_TB = '1')
        report "Second test for A < B failed, LT output should be 1"
        severity error;
        assert (o_ValueEQ_TB = '0')
        report "Second test for A < B failed, EQ output should be 0"
        severity error;

        i_ValueA_TB <= "1010";
        i_ValueB_TB <= "0101";
        wait for period;
        -- here the first number is bigger than the second one
        -- we expect GT to be 1, LT to be 0 and EQ to be 0.
        assert (o_ValueGT_TB = '1')
        report "Second test for A > B failed, GT output should be 1"
        severity error;
        assert (o_ValueLT_TB = '0')
        report "Second test for A > B failed, LT output should be 0"
        severity error;
        assert (o_ValueEQ_TB = '0')
        report "Second test for A > B failed, EQ output should be 0"
        severity error;

        i_ValueA_TB <= "1111";
        i_ValueB_TB <= "1111";
        wait for period;
        -- here the first number is equal to the second one
        -- we expect GT to be 0, LT to be 0 and EQ to be 1.
        assert (o_ValueGT_TB = '0')
        report "Second test for A = B failed, GT output should be 0"
        severity error;
        assert (o_ValueLT_TB = '0')
        report "Second test for A = B failed, LT output should be 0"
        severity error;
        assert (o_ValueEQ_TB = '1')
        report "Second test for A = B failed, EQ output should be 1"
        severity error;

    end process;

end sim_comparateur;