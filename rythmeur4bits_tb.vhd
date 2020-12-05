library ieee;
use ieee.std_logic_1164.all;

entity rythmeur4bits_tb is
end rythmeur4bits_tb;

architecture sim_timer of rythmeur4bits_tb is
    signal i_resetBar_TB, i_enable_TB, i_clock_TB	: STD_LOGIC;
    signal MST_OR_SST_TB			                : STD_LOGIC;
    signal o_countDone_TB                           : STD_LOGIC;
    signal sim_end                                  : boolean := false;

    COMPONENT rythmeur4bits IS
        PORT(
            i_resetBar   : IN	STD_LOGIC;
            i_clock		 : IN	STD_LOGIC;
            i_enable	 : IN	STD_LOGIC;
            MST_OR_SST   : IN   STD_LOGIC;
            o_countDone	 : OUT	STD_LOGIC);
    END COMPONENT;

    constant period: time := 50 ns;

begin
    DUT : rythmeur4bits
            PORT MAP (i_resetBar => i_resetBar_TB,
                    i_clock => i_clock_TB,
                    i_enable => i_enable_TB,
                    MST_OR_SST => MST_OR_SST_TB,
                    o_countDone => o_countDone_TB);

    clock_process : process
    begin
        while (not sim_end) loop
            i_clock_TB <= '1';
            wait for period/2;
            i_clock_TB <= '0';
            wait for period/2;
        end loop;
        wait;
    end process;

    testbench_process : process
    begin
        i_resetBar_TB <= '0', '1' after period;
        wait for period;


        i_enable_TB <= '0';
        MST_OR_SST_TB <= '1';
        wait for period;
        -- here since the ENABLE is OFF and the reset signal was just pressed
        -- we expect a 0 at the output.

        assert (o_countDone_TB = '0')
        report "Test for initial reset failed, output should be 0"
        severity error;


        i_enable_TB <= '0';
        MST_OR_SST_TB <= '1';
        wait for period;
        i_enable_TB <= '0';
        MST_OR_SST_TB <= '1';
        wait for period;
        -- in this case, load is still 0 while there was two clock cycles,
        -- 3 clock cycles is the value of the current SST but it should remain 0 because enable was 0
        assert (o_countDone_TB = '0')
        report "Test for third clock cycle failed, output should be 0"
        severity error;


        i_enable_TB <= '1';
        MST_OR_SST_TB <= '1';
        wait for period;
        -- load is 1, and the clock reached another cycle
        -- However, the lower count value is 3 therefore we expect a 0
        assert (o_countDone_TB = '0')
        report "Test for enable 1 failed, output should be 0"
        severity error;


        i_enable_TB <= '1';
        MST_OR_SST_TB <= '1';
        wait for period;
        i_enable_TB <= '1';
        MST_OR_SST_TB <= '1';
        wait for period;
        -- load is 1, and two clock cycles passed therefore we expect the counter value
        -- to be equal to SST which is defined to 3. Output shoud be 1
        assert (o_countDone_TB = '1')
        report "Test for counter = SST failed, output should be 1"
        severity error;


        i_enable_TB <= '0';
        MST_OR_SST_TB <= '1';
        wait for period;
        -- load is 0, counter should not increase
        -- the equality should remain true
        assert (o_countDone_TB = '1')
        report "Test for load 0 after counter = SST failed, output should be 1"
        severity error;


        i_enable_TB <= '1';
        MST_OR_SST_TB <= '1';
        wait for period;
        -- load is 1 again but the counter value is not equal to SST anymore
        -- output should be 0
        assert (o_countDone_TB = '0')
        report "Test for counter != SST failed, output should be 0"
        severity error;


        i_enable_TB <= '0';
        MST_OR_SST_TB <= '0';
        wait for period;
        -- load is 0 but now the MST_OR_SST_TB variable is pointing to MST
        -- since MST = 4 and we are in the 4 clock cycle with enable activated,
        -- we expect an output of 1
        assert (o_countDone_TB = '1')
        report "Test for counter = MST failed, output should be 1"
        severity error;


        i_resetBar_TB <= '0', '1' after period;
        wait for period;
        -- since reset was pushed, the output sould be 0
        assert (o_countDone_TB = '0')
        report "Test for reset failed, output should be 0"
        severity error;


        i_enable_TB <= '1';
        MST_OR_SST_TB <= '0';
        wait for period;
        i_enable_TB <= '1';
        MST_OR_SST_TB <= '0';
        wait for period;
        i_enable_TB <= '1';
        MST_OR_SST_TB <= '0';
        wait for period;
        -- Three clock cycles have passed but MST value is chosen
        -- Output should be '0'
        assert (o_countDone_TB = '0')
        report "Test for second reset and counter < MST failed, output should be 0"
        severity error;


        i_enable_TB <= '1';
        MST_OR_SST_TB <= '0';
        wait for period;
        -- another clock cycle passed, making it to 4 clock cycles after the second reset was pressed
        -- and the MST value is still chosen. Since MST = 4, output should be '1'
        assert (o_countDone_TB = '1')
        report "Test for second reset and counter = MST failed, output should be 1"
        severity error;


        i_enable_TB <= '1';
        MST_OR_SST_TB <= '0';
        wait for period;
        -- another clock cycle passed, making it to 5 clock cycles after the second reset was pressed
        -- and the MST value is still chosen. Since MST = 4, output should be '0'
        assert (o_countDone_TB = '0')
        report "Test for second reset and counter > MST failed, output should be 0"
        severity error;


        i_resetBar_TB <= '0';
        wait for period;
        -- since reset was pushed, the output sould be 0
        assert (o_countDone_TB = '0')
        report "Test for final reset failed, output should be 0"
        severity error;


        sim_end <= true; -- signal the end of the stimuli
        wait;
    end process;

end sim_timer;