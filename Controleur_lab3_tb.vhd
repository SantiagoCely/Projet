library ieee;
use ieee.std_logic_1164.all;

entity Controleur_lab3_tb is
end Controleur_lab3_tb;

architecture sim_lab3 of Controleur_lab3_tb is
    signal i_resetBar_TB, i_clock_TB	                    : STD_LOGIC;
    signal i_MSC_TB, i_SSC_TB	                            : STD_LOGIC;
    signal i_SSCS_TB	                                    : STD_LOGIC;
    signal o_MSTL_GREEN_TB, o_MSTL_YELLOW_TB, o_MSTL_RED_TB	: STD_LOGIC;
    signal o_SSTL_GREEN_TB, o_SSTL_YELLOW_TB, o_SSTL_RED_TB	: STD_LOGIC;
    signal o_MSC_Seg1A_TB, o_MSC_Seg1B_TB, o_MSC_Seg1C_TB, o_MSC_Seg1D_TB : STD_LOGIC;
    signal o_MSC_Seg1E_TB, o_MSC_Seg1F_TB, o_MSC_Seg1G_TB	              : STD_LOGIC;
    signal o_MSC_Seg2A_TB, o_MSC_Seg2B_TB, o_MSC_Seg2C_TB, o_MSC_Seg2D_TB : STD_LOGIC;
    signal o_MSC_Seg2E_TB, o_MSC_Seg2F_TB, o_MSC_Seg2G_TB	              : STD_LOGIC;
    signal o_SSC_Seg1A_TB, o_SSC_Seg1B_TB, o_SSC_Seg1C_TB, o_SSC_Seg1D_TB : STD_LOGIC;
    signal o_SSC_Seg1E_TB, o_SSC_Seg1F_TB, o_SSC_Seg1G_TB	              : STD_LOGIC;
    signal o_SSC_Seg2A_TB, o_SSC_Seg2B_TB, o_SSC_Seg2C_TB, o_SSC_Seg2D_TB : STD_LOGIC;
    signal o_SSC_Seg2E_TB, o_SSC_Seg2F_TB, o_SSC_Seg2G_TB	              : STD_LOGIC;
    signal sim_end                                          : boolean := false;

    COMPONENT Controleur_lab3 IS
        PORT(
            i_reset, i_clock                        : IN    STD_LOGIC;
            i_MSC, i_SSC                            : IN	STD_LOGIC;
            i_SSCS                                  : IN	STD_LOGIC;
            o_MSTL_GREEN, o_MSTL_YELLOW, o_MSTL_RED : OUT	STD_LOGIC;
            o_SSTL_GREEN, o_SSTL_YELLOW, o_SSTL_RED : OUT	STD_LOGIC;
            o_MSC_Seg1A, o_MSC_Seg1B, o_MSC_Seg1C, o_MSC_Seg1D : OUT STD_LOGIC;
            o_MSC_Seg1E, o_MSC_Seg1F, o_MSC_Seg1G              : OUT STD_LOGIC;
            o_MSC_Seg2A, o_MSC_Seg2B, o_MSC_Seg2C, o_MSC_Seg2D : OUT STD_LOGIC;
            o_MSC_Seg2E, o_MSC_Seg2F, o_MSC_Seg2G              : OUT STD_LOGIC;
            o_SSC_Seg1A, o_SSC_Seg1B, o_SSC_Seg1C, o_SSC_Seg1D : OUT STD_LOGIC;
            o_SSC_Seg1E, o_SSC_Seg1F, o_SSC_Seg1G              : OUT STD_LOGIC;
            o_SSC_Seg2A, o_SSC_Seg2B, o_SSC_Seg2C, o_SSC_Seg2D : OUT STD_LOGIC;
            o_SSC_Seg2E, o_SSC_Seg2F, o_SSC_Seg2G              : OUT STD_LOGIC);
    END COMPONENT;

    constant period: time := 1000 ms;

begin

    DUT : Controleur_lab3
            PORT MAP (i_reset => i_resetBar_TB,
                      i_clock => i_clock_TB,
                      i_MSC => i_MSC_TB,
                      i_SSC => i_SSC_TB,
                      i_SSCS => i_SSCS_TB,
                      o_MSTL_GREEN => o_MSTL_GREEN_TB,
                      o_MSTL_YELLOW => o_MSTL_YELLOW_TB,
                      o_MSTL_RED => o_MSTL_RED_TB,
                      o_SSTL_GREEN => o_SSTL_GREEN_TB,
                      o_SSTL_YELLOW => o_SSTL_YELLOW_TB,
                      o_SSTL_RED => o_SSTL_RED_TB,
                      o_MSC_Seg1A => o_MSC_Seg1A_TB,
                      o_MSC_Seg1B => o_MSC_Seg1B_TB,
                      o_MSC_Seg1C => o_MSC_Seg1C_TB,
                      o_MSC_Seg1D => o_MSC_Seg1D_TB,
                      o_MSC_Seg1E => o_MSC_Seg1E_TB,
                      o_MSC_Seg1F => o_MSC_Seg1F_TB,
                      o_MSC_Seg1G => o_MSC_Seg1G_TB,
                      o_MSC_Seg2A => o_MSC_Seg2A_TB,
                      o_MSC_Seg2B => o_MSC_Seg2B_TB,
                      o_MSC_Seg2C => o_MSC_Seg2C_TB,
                      o_MSC_Seg2D => o_MSC_Seg2D_TB,
                      o_MSC_Seg2E => o_MSC_Seg2E_TB,
                      o_MSC_Seg2F => o_MSC_Seg2F_TB,
                      o_MSC_Seg2G => o_MSC_Seg2G_TB,
                      o_SSC_Seg1A => o_SSC_Seg1A_TB,
                      o_SSC_Seg1B => o_SSC_Seg1B_TB,
                      o_SSC_Seg1C => o_SSC_Seg1C_TB,
                      o_SSC_Seg1D => o_SSC_Seg1D_TB,
                      o_SSC_Seg1E => o_SSC_Seg1E_TB,
                      o_SSC_Seg1F => o_SSC_Seg1F_TB,
                      o_SSC_Seg1G => o_SSC_Seg1G_TB,
                      o_SSC_Seg2A => o_SSC_Seg2A_TB,
                      o_SSC_Seg2B => o_SSC_Seg2B_TB,
                      o_SSC_Seg2C => o_SSC_Seg2C_TB,
                      o_SSC_Seg2D => o_SSC_Seg2D_TB,
                      o_SSC_Seg2E => o_SSC_Seg2E_TB,
                      o_SSC_Seg2F => o_SSC_Seg2F_TB,
                      o_SSC_Seg2G => o_SSC_Seg2G_TB);

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
    -- Initial state after reset
        i_resetBar_TB <= '0', '1' after period;
        wait for period;

        i_MSC_TB <= '1';
        i_SSC_TB <= '1';
        i_SSCS_TB <= '1';
        wait for period;
        i_MSC_TB <= '1';
        i_SSC_TB <= '1';
        i_SSCS_TB <= '1';
        -- Here since the value for the two counters and the car detector is 0
        -- and the reset signal was just pressed. we expect only the MSTL green
        -- and the SSTL red to be 1 even though 3 clock cycles passed after the reset
        -- In addition, the value of the counters displayed should be 0
        assert (o_MSTL_GREEN_TB = '1')
        report "Test for initial state failed, MSTL green should be 1"
        severity error;
        assert (o_MSTL_YELLOW_TB = '0')
        report "Test for initial state failed, MSTL yellow should be 0"
        severity error;
        assert (o_MSTL_RED_TB = '0')
        report "Test for initial state failed, MSTL red should be 0"
        severity error;
        assert (o_SSTL_GREEN_TB = '0')
        report "Test for initial state failed, SSTL green should be 0"
        severity error;
        assert (o_SSTL_YELLOW_TB = '0')
        report "Test for initial state failed, SSTL yellow should be 0"
        severity error;
        assert (o_SSTL_RED_TB = '1')
        report "Test for initial state failed, SSTL red should be 1"
        severity error;


    -- Increase counters MSC and SSC
        i_MSC_TB <= '0';
        i_SSC_TB <= '0';
        i_SSCS_TB <= '1';
        wait for period;
        i_MSC_TB <= '0';
        i_SSC_TB <= '0';
        i_SSCS_TB <= '1';
        wait for period;
        i_MSC_TB <= '0';
        i_SSC_TB <= '1';
        i_SSCS_TB <= '1';
        wait for period;
        i_MSC_TB <= '1';
        i_SSC_TB <= '1';
        i_SSCS_TB <= '1';
        wait for period;
        -- Here the value for the main street counter and the side street counter have
        -- been increased to 3 and 2 respectively
        -- However, no car has been detected. Therefore, only MSTL green and SSTL red
        -- should be 1
        -- In addition, since the circuit is in its initial state and no car has been
        -- detected yet, the counter should not decrease, we expect the MSC BCD to display
        -- a value of 3 and the SSC BCD to display a value of 2
        assert (o_MSTL_GREEN_TB = '1')
        report "Test for increased counter and no car detected failed, MSTL green should be 1"
        severity error;
        assert (o_MSTL_YELLOW_TB = '0')
        report "Test for increased counter and no car detected failed, MSTL yellow should be 0"
        severity error;
        assert (o_MSTL_RED_TB = '0')
        report "Test for increased counter and no car detected failed, MSTL red should be 0"
        severity error;
        assert (o_SSTL_GREEN_TB = '0')
        report "Test for increased counter and no car detected failed, SSTL green should be 0"
        severity error;
        assert (o_SSTL_YELLOW_TB = '0')
        report "Test for increased counter and no car detected failed, SSTL yellow should be 0"
        severity error;
        assert (o_SSTL_RED_TB = '1')
        report "Test for increased counter and no car detected failed, SSTL red should be 1"
        severity error;


    -- Car detected (SSCS)
        i_MSC_TB <= '1';
        i_SSC_TB <= '1';
        i_SSCS_TB <= '0'; -- 1 clock cycle for i_SSCS_TB to be changed
        wait for period;
        i_MSC_TB <= '1';
        i_SSC_TB <= '1';
        i_SSCS_TB <= '1';
        wait for period;
        i_MSC_TB <= '1';
        i_SSC_TB <= '1';
        i_SSCS_TB <= '1';
       wait for period;
        -- Here the value for the main street counter and the side street counter are
        -- still 3 and 2 respectively
        -- A car has been detected and 2 clock cycles have passed. Then, while MSTL remains green,
        -- SSTL remains red and the value of the BCD assigned to SSC remains 2,
        -- the value of the BCD assigned to MSC should be 1 because 3-2=1
        assert (o_MSTL_GREEN_TB = '1')
        report "Test for car detected failed, MSTL green should be 1"
        severity error;
        assert (o_MSTL_YELLOW_TB = '0')
        report "Test for car detected failed, MSTL yellow should be 0"
        severity error;
        assert (o_MSTL_RED_TB = '0')
        report "Test for car detected failed, MSTL red should be 0"
        severity error;
        assert (o_SSTL_GREEN_TB = '0')
        report "Test for car detected failed, SSTL green should be 0"
        severity error;
        assert (o_SSTL_YELLOW_TB = '0')
        report "Test for car detected failed, SSTL yellow should be 0"
        severity error;
        assert (o_SSTL_RED_TB = '1')
        report "Test for car detected failed, SSTL red should be 1"
        severity error;


    -- MSC max value reached
        i_MSC_TB <= '1';
        i_SSC_TB <= '1';
        i_SSCS_TB <= '1';
        wait for period;
        -- Here the value for the main street counter and the side street counter are
        -- still 3 and 2 respectively
        -- A car has been detected and 3 clock cycles have passed. Then, MSTL should turn yellow,
        -- SSTL should remain red, the value of the BCD assigned to SSC should remain 2 and
        -- the value of the BCD assigned to MSC should go down to 0 because 3-3=0
        assert (o_MSTL_GREEN_TB = '0')
        report "Test for MSC max value reached failed, MSTL green should be 0"
        severity error;
        assert (o_MSTL_YELLOW_TB = '1')
        report "Test for MSC max value reached failed, MSTL yellow should be 1"
        severity error;
        assert (o_MSTL_RED_TB = '0')
        report "Test for MSC max value reached failed, MSTL red should be 0"
        severity error;
        assert (o_SSTL_GREEN_TB = '0')
        report "Test for MSC max value reached failed, SSTL green should be 0"
        severity error;
        assert (o_SSTL_YELLOW_TB = '0')
        report "Test for MSC max value reached failed, SSTL yellow should be 0"
        severity error;
        assert (o_SSTL_RED_TB = '1')
        report "Test for MSC max value reached failed, SSTL red should be 1"
        severity error;


    -- SSTL GREEN
        i_MSC_TB <= '1';
        i_SSC_TB <= '1';
        i_SSCS_TB <= '1';
        wait for period;
        i_MSC_TB <= '1';
        i_SSC_TB <= '1';
        i_SSCS_TB <= '1';
        wait for period;
        i_MSC_TB <= '1';
        i_SSC_TB <= '1';
        i_SSCS_TB <= '1';
        wait for period;
        i_MSC_TB <= '1';
        i_SSC_TB <= '1';
        i_SSCS_TB <= '1'; -- 4 cycles for MST
        wait for period;
        i_MSC_TB <= '1';
        i_SSC_TB <= '1';
        i_SSCS_TB <= '1'; -- 1 clock cycle for circuit to change states
        wait for period;
        -- Here the value for the main street counter and the side street counter are
        -- still 3 and 2 respectively
        -- A car has been detected and 4 clock cycles have passed
        -- since the MSTL went yellow. Then, since MST is 4, MSTL should turn red,
        -- SSTL should turn green, the value of the BCD assigned to SSC should remain 2 and
        -- the value of the BCD assigned to MSC should go back to 3 because MST and SST get reseted
        -- everytime SST or MST are done.
        assert (o_MSTL_GREEN_TB = '0')
        report "Test for SSTL green failed, MSTL green should be 0"
        severity error;
        assert (o_MSTL_YELLOW_TB = '0')
        report "Test for SSTL green failed, MSTL yellow should be 0"
        severity error;
        assert (o_MSTL_RED_TB = '1')
        report "Test for SSTL green failed, MSTL red should be 1"
        severity error;
        assert (o_SSTL_GREEN_TB = '1')
        report "Test for SSTL green failed, SSTL green should be 1"
        severity error;
        assert (o_SSTL_YELLOW_TB = '0')
        report "Test for SSTL green failed, SSTL yellow should be 0"
        severity error;
        assert (o_SSTL_RED_TB = '0')
        report "Test for SSTL green failed, SSTL red should be 0"
        severity error;


    -- SSTL YELLOW
        i_MSC_TB <= '1';
        i_SSC_TB <= '1';
        i_SSCS_TB <= '1';
        wait for period;
        i_MSC_TB <= '1';
        i_SSC_TB <= '1';
        i_SSCS_TB <= '1';
        wait for period;
        -- Here the value for the main street counter and the side street counter are
        -- still 3 and 2 respectively
        -- A car has been detected and 2 clock cycles have passed since the SSTL went green.
        -- Then, since SSC is 2, SSTL should turn yellow, MSTL should remain red,
        -- the value of the BCD assigned to SSC should go down to 0
        -- because 2-2=0. Also, the value of the BCD assigned to MSC should remain 3.
        assert (o_MSTL_GREEN_TB = '0')
        report "Test for SSTL yellow failed, MSTL green should be 0"
        severity error;
        assert (o_MSTL_YELLOW_TB = '0')
        report "Test for SSTL yellow failed, MSTL yellow should be 0"
        severity error;
        assert (o_MSTL_RED_TB = '1')
        report "Test for SSTL yellow failed, MSTL red should be 1"
        severity error;
        assert (o_SSTL_GREEN_TB = '0')
        report "Test for SSTL yellow failed, SSTL green should be 0"
        severity error;
        assert (o_SSTL_YELLOW_TB = '1')
        report "Test for SSTL yellow failed, SSTL yellow should be 1"
        severity error;
        assert (o_SSTL_RED_TB = '0')
        report "Test for SSTL yellow failed, SSTL red should be 0"
        severity error;


    -- SSTL RED
        i_MSC_TB <= '1';
        i_SSC_TB <= '1';
        i_SSCS_TB <= '1';
        wait for period;
        i_MSC_TB <= '1';
        i_SSC_TB <= '1';
        i_SSCS_TB <= '1';
        wait for period;
        i_MSC_TB <= '1';
        i_SSC_TB <= '1';
        i_SSCS_TB <= '1'; -- 3 clock cycles for SST
        wait for period;
        i_MSC_TB <= '1';
        i_SSC_TB <= '1';
        i_SSCS_TB <= '1'; -- 1 clock cycle for the circuit to change states
        wait for period;
        -- Here the value for the main street counter and the side street counter are
        -- still 3 and 2 respectively
        -- A car has been detected and 3 clock cycles have passed since the SSTL went yellow.
        -- Then, since SST is 3, SSTL should turn red, MSTL should turn green,
        -- the value of the BCD assigned to SSC should go up to 2 because when SST or MST are
        -- done, the value of the counters get reseted and 2-0=2. Also, the value of the
        -- BCD assigned to MSC should remain 3 because no car has been detected.
        assert (o_MSTL_GREEN_TB = '1')
        report "Test for SSTL red failed, MSTL green should be 1"
        severity error;
        assert (o_MSTL_YELLOW_TB = '0')
        report "Test for SSTL red failed, MSTL yellow should be 0"
        severity error;
        assert (o_MSTL_RED_TB = '0')
        report "Test for SSTL red failed, MSTL red should be 0"
        severity error;
        assert (o_SSTL_GREEN_TB = '0')
        report "Test for SSTL red failed, SSTL green should be 0"
        severity error;
        assert (o_SSTL_YELLOW_TB = '0')
        report "Test for SSTL red failed, SSTL yellow should be 0"
        severity error;
        assert (o_SSTL_RED_TB = '1')
        report "Test for SSTL red failed, SSTL red should be 1"
        severity error;


    -- RESET
        i_resetBar_TB <= '0';
        i_MSC_TB <= '1';
        i_SSC_TB <= '1';
        i_SSCS_TB <= '1';
        wait for period;
        i_resetBar_TB <= '1';
        i_MSC_TB <= '1';
        i_SSC_TB <= '1';
        i_SSCS_TB <= '1';
        wait for period;
        -- Here, since reset was activated, all values go back to its initial state
        -- Then, MSTL goes green, SSTL goes red, MSC BCD goes to 0 and SSC BCD goes to 0
        assert (o_MSTL_GREEN_TB = '1')
        report "Test for final reset failed, MSTL green should be 1"
        severity error;
        assert (o_MSTL_YELLOW_TB = '0')
        report "Test for final reset failed, MSTL yellow should be 0"
        severity error;
        assert (o_MSTL_RED_TB = '0')
        report "Test for final reset failed, MSTL red should be 0"
        severity error;
        assert (o_SSTL_GREEN_TB = '0')
        report "Test for final reset failed, SSTL green should be 0"
        severity error;
        assert (o_SSTL_YELLOW_TB = '0')
        report "Test for final reset failed, SSTL yellow should be 0"
        severity error;
        assert (o_SSTL_RED_TB = '1')
        report "Test for final reset failed, SSTL red should be 1"
        severity error;


        sim_end <= true; -- signal the end of the stimuli
        wait;
    end process;

end sim_lab3;