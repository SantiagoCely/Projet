library ieee;
use ieee.std_logic_1164.all;

entity fourBit_Counter_tb is
end fourBit_Counter_tb;

architecture sim_counter of fourBit_Counter_tb is
    signal i_resetBar_TB, i_load_TB, i_clock_TB	: STD_LOGIC;
    signal o_Value_TB			                : STD_LOGIC_VECTOR(3 downto 0);
    signal sim_end                              : boolean := false;

    component fourBit_Counter is
        port (i_resetBar, i_load, i_clock	 : IN	STD_LOGIC;
                o_Value         	         : OUT	STD_LOGIC_VECTOR(3 downto 0));
    end component;

    constant period: time := 50 ns;

begin
    DUT : fourBit_Counter
            port map(i_resetBar => i_resetBar_TB,
                     i_load => i_load_TB,
                     i_clock => i_clock_TB,
                     o_Value => o_Value_TB);

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


        i_load_TB <= '0';
        wait for period;
        -- here since the ENABLE is OFF and the reset signal was just pressed
        -- we expect a 0000 at the output.

        assert (o_Value_TB = "0000")
        report "Test for initial reset failed, output should be 0000"
        severity error;


        i_load_TB <= '0';
        wait for period;
        -- in this case, load is still 0 while there was another clock cycle,
        -- it should remain 0000
        assert (o_Value_TB = "0000")
        report "Test for initial load 0, output should be 0000"
        severity error;


        i_load_TB <= '1';
        wait for period;
        -- load is 1, and the clock reached another cycle
        -- should be 0001
        assert (o_Value_TB = "0001")
        report "Test for load 1 failed, output should be 0001"
        severity error;


        i_load_TB <= '1';
        wait for period;
        -- load is 1, therefore we expect the counter to increase
        -- shoud be 0010
        assert (o_Value_TB = "0010")
        report "Test for second load 1 failed, output should be 0010"
        severity error;


        i_load_TB <= '1';
        wait for period;
        -- load is 1 again, counter should increase again
        -- should be 0011
        assert (o_Value_TB = "0011")
        report "Test for third load 1 failed, output should be 0011"
        severity error;


        i_load_TB <= '0';
        wait for period;
        -- load is 0, counter should not increase
        -- should be 0011
        assert (o_Value_TB = "0011")
        report "Test for load 0 failed, output should be 0011"
        severity error;

        i_load_TB <= '1';
        wait for period;
        -- load is 1, counter should increase
        -- should be 0100
        assert (o_Value_TB = "0100")
        report "Test for fourth load 1 failed, output should be 0100"
        severity error;

        i_load_TB <= '1'; --0101
        wait for period;
        i_load_TB <= '1'; --0110
        wait for period;
        i_load_TB <= '1'; --0111
        wait for period;
        i_load_TB <= '1';
        wait for period;
        -- load was 1 four times, counter should increase 4 times
        -- should be 1000
        assert (o_Value_TB = "1000")
        report "Test for eigth load 1 failed, output should be 1000"
        severity error;

        i_load_TB <= '1'; --1001
        wait for period;
        i_load_TB <= '1'; --1010
        wait for period;
        i_load_TB <= '1'; --1011
        wait for period;
        i_load_TB <= '1'; --1100
        wait for period;
        i_load_TB <= '1'; --1101
        wait for period;
        i_load_TB <= '1'; --1110
        wait for period;
        i_load_TB <= '1'; --1111
        wait for period;
        i_load_TB <= '1';
        wait for period;
        -- load was 1 eight times, counter should increase 8 times
        -- and since we reached the end of the counter, it should be 0000
        assert (o_Value_TB = "0000")
        report "Test for last load 1 failed, output should be 0000"
        severity error;

        i_load_TB <= '1';
        wait for period;
        -- load is 1, counter should increase
        -- should be 0001
        assert (o_Value_TB = "0001")
        report "Test for load 1 during second pass failed, output should be 0001"
        severity error;

        i_resetBar_TB <= '0';
        wait for period;
        -- since reset was pushed, the output sould be 0000
        assert (o_Value_TB = "0000")
        report "Test for final reset failed, output should be 0000"
        severity error;


        sim_end <= true; -- signal the end of the stimuli
        wait;
    end process;

end sim_counter;