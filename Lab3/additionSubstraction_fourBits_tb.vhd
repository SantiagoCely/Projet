library ieee;
use ieee.std_logic_1164.all;

entity additionSubstraction_fourBits_tb is
end additionSubstraction_fourBits_tb;

architecture sim_adder of additionSubstraction_fourBits_tb is
    signal i_Ai_TB, i_Bi_TB, o_Sum_TB		: STD_LOGIC_VECTOR(3 downto 0);
    signal i_Subtraction_TB, o_CarryOut_TB	: STD_LOGIC;

    component additionSubstraction_fourBits IS
        PORT(
            i_Subtraction   : IN    STD_LOGIC;
            i_Ai, i_Bi		: IN	STD_LOGIC_VECTOR(3 DOWNTO 0);
            o_CarryOut		: OUT	STD_LOGIC;
            o_Sum			: OUT	STD_LOGIC_VECTOR(3 DOWNTO 0));
    end component;

    constant period: time := 50 ns;

begin
    DUT : additionSubstraction_fourBits
            port map(i_Subtraction => i_Subtraction_TB,
                     i_Ai => i_Ai_TB,
                     i_Bi => i_Bi_TB,
                     o_CarryOut => o_CarryOut_TB,
                     o_Sum => o_Sum_TB);

    testbench_process : process
    begin

        i_Ai_TB <= "0000";
        i_Bi_TB <= "0000";
        i_Subtraction_TB <= '0';
        wait for period;
        -- here the first and the second number are 0
        -- we expect the carry out to be 0 and the sum to be 0000.
        assert (o_CarryOut_TB = '0')
        report "First test for A + B failed, carry out output should be 0"
        severity error;
        assert (o_Sum_TB = "0000")
        report "First test for A + B failed, sum output should be 0000"
        severity error;


        i_Ai_TB <= "0100";
        i_Bi_TB <= "0010";
        i_Subtraction_TB <= '0';
        wait for period;
        -- here the first and the second number are not 0000
        -- we expect the carry out to be 0 and the sum to be 0110.
        assert (o_CarryOut_TB = '0')
        report "Second test for A + B failed, carry out output should be 0"
        severity error;
        assert (o_Sum_TB = "0110")
        report "Second test for A + B failed, sum output should be 0110"
        severity error;


        i_Ai_TB <= "0100";
        i_Bi_TB <= "0010";
        i_Subtraction_TB <= '1';
        wait for period;
        -- here the first and the second number are not 0000
        -- we expect the carry out to be 0 and the sum to be 0010.
        assert (o_CarryOut_TB = '1')
        report "First test for A - B failed, carry out output should be 1"
        severity error;
        assert (o_Sum_TB = "0010")
        report "First test for A - B failed, sum output should be 0010"
        severity error;


        i_Ai_TB <= "1111";
        i_Bi_TB <= "1111";
        i_Subtraction_TB <= '1';
        wait for period;
        -- here the first and the second number are not 0000
        -- we expect the carry out to be 0 and the sum to be 0000.
        assert (o_CarryOut_TB = '1')
        report "Second test for A - B failed, carry out output should be 1"
        severity error;
        assert (o_Sum_TB = "0000")
        report "Second test for A - B failed, sum output should be 0000"
        severity error;


        i_Ai_TB <= "1111";
        i_Bi_TB <= "1111";
        i_Subtraction_TB <= '0';
        wait for period;
        -- here the first and the second number are not 0000
        -- we expect the carry out to be 1 and the sum to be 1110 indication an overflow
        assert (o_CarryOut_TB = '1')
        report "Third test for A + B failed, carry out output should be 1"
        severity error;
        assert (o_Sum_TB = "1110")
        report "Third test for A + B failed, sum output should be 1110"
        severity error;


        i_Ai_TB <= "1111";
        i_Bi_TB <= "0001";
        i_Subtraction_TB <= '1';
        wait for period;
        -- here the first and the second number are not 0000
        -- we expect the carry out to be 1 and the sum to be 1110.
        assert (o_CarryOut_TB = '1')
        report "Third test for A - B failed, carry out output should be 1"
        severity error;
        assert (o_Sum_TB = "1110")
        report "Third test for A - B failed, sum output should be 1110"
        severity error;

    end process;

end sim_adder;