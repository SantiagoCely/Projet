library ieee;
USE ieee.std_logic_1164.all;

ENTITY multiplexer2x1_fourBits_tb IS
END multiplexer2x1_fourBits_tb;

ARCHITECTURE sim_mux2x1 of multiplexer2x1_fourBits_tb IS
    SIGNAL i_AValue_TB, i_BValue_TB : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL i_selLine_TB			    : STD_LOGIC;
    SIGNAL o_Result_TB              : STD_LOGIC_VECTOR(3 DOWNTO 0);

    COMPONENT multiplexer2x1_fourBits IS
        PORT (i_Ai, i_Bi : IN	STD_LOGIC_VECTOR(3 DOWNTO 0);
            i_selLine    : IN    STD_LOGIC;
		    o_Result	 : OUT	STD_LOGIC_VECTOR(3 DOWNTO 0));
    END COMPONENT;

    CONSTANT period: time := 50 ns;

BEGIN
    DUT : multiplexer2x1_fourBits
            PORT MAP(i_Ai => i_AValue_TB,
                    i_Bi => i_BValue_TB,
                    i_selLine => i_selLine_TB,
                    o_Result => o_Result_TB);

    testbench_process : PROCESS
    BEGIN

        i_AValue_TB <= "1000";
        i_BValue_TB <= "0001";
        i_selLine_TB <= '0';
        WAIT FOR period;
        -- here the select line is choosing the A value
        -- we expect a 1000 at the output.
        ASSERT (o_Result_TB = "1000")
        REPORT "Test for select line 0 failed, output should be 1000"
        SEVERITY error;

        i_AValue_TB <= "1000";
        i_BValue_TB <= "0001";
        i_selLine_TB <= '1';
        WAIT FOR period;
        -- here the select line is choosing the B value
        -- we expect a 0001 at the output.
        ASSERT (o_Result_TB = "0001")
        REPORT "Test for select line 1 failed, output should be 0001"
        SEVERITY error;

        i_AValue_TB <= "0100";
        i_BValue_TB <= "0010";
        i_selLine_TB <= '1';
        WAIT FOR period;
        -- here the select line is choosing the B value again
        -- we expect a 0010 at the output.
        ASSERT (o_Result_TB = "0010")
        REPORT "Test for select line 1 failed, output should be 0010"
        SEVERITY error;

    END PROCESS;

END sim_mux2x1;