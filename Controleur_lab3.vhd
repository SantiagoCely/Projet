--------------------------------------------------------------------------------
-- Title         : Controleur Lab3
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Controleur_lab3 IS
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
END Controleur_lab3;

ARCHITECTURE lab3 OF Controleur_lab3 IS
    SIGNAL clock_div_25Mhz, clock_div_1Mhz   : STD_LOGIC;
    SIGNAL clock_div_100Khz, clock_div_10Khz : STD_LOGIC;
    SIGNAL clock_div_1Khz, clock_div_100hz   : STD_LOGIC;
    SIGNAL clock_div_10Hz, clock_div_1Hz     : STD_LOGIC;
    SIGNAL MSC_MAX_input_value               : STD_LOGIC;
    SIGNAL SSC_MAX_input_value               : STD_LOGIC;
    SIGNAL SSCS_input_value, carDetected     : STD_LOGIC;
    SIGNAL MSC_MAX, SSC_MAX                  : STD_LOGIC_VECTOR(3 downto 0);
    SIGNAL MSC_enable, SSC_enable            : STD_LOGIC;
    SIGNAL MSC_SSC_reset, NOT_MSC_SSC_reset  : STD_LOGIC;
    SIGNAL MSC_SSC_reset_new                 : STD_LOGIC;
    SIGNAL MSC_current, SSC_current          : STD_LOGIC_VECTOR(3 downto 0);
    SIGNAL SSTL, NOT_SSTL, SSTL_NEW          : STD_LOGIC;
    SIGNAL currentCounterValToCompare        : STD_LOGIC_VECTOR(3 downto 0);
    SIGNAL maxCounterValToCompare            : STD_LOGIC_VECTOR(3 downto 0);
    SIGNAL BCDvalue_MSC, BCDvalue_SSC        : STD_LOGIC_VECTOR(3 downto 0);
    SIGNAL carryOut,biggerA,biggerB,equalAB  : STD_LOGIC;
    SIGNAL zeroComparison, rythmeurEnable    : STD_LOGIC;
    SIGNAL MST_OR_SST_countDone              : STD_LOGIC;
    SIGNAL MSTL_green, SSTL_green            : STD_LOGIC;

    COMPONENT clk_div
        PORT(
            clock_50Mhz		: IN	STD_LOGIC;
            clock_25Mhz		: OUT	STD_LOGIC;
            clock_1MHz		: OUT	STD_LOGIC;
            clock_100KHz	: OUT	STD_LOGIC;
            clock_10KHz		: OUT	STD_LOGIC;
            clock_1KHz		: OUT	STD_LOGIC;
            clock_100Hz		: OUT	STD_LOGIC;
            clock_10Hz		: OUT	STD_LOGIC;
            clock_1Hz		: OUT	STD_LOGIC);
    END COMPONENT;

    COMPONENT fourBit_Counter
        PORT(
            i_resetBar, i_load	: IN	STD_LOGIC;
            i_clock			    : IN	STD_LOGIC;
            o_Value			    : OUT	STD_LOGIC_VECTOR(3 downto 0));
    END COMPONENT;

    COMPONENT fourBitComparator
        PORT(
            i_Ai, i_Bi			: IN	STD_LOGIC_VECTOR(3 downto 0);
            o_GT, o_LT, o_EQ	: OUT	STD_LOGIC);
    END COMPONENT;

    COMPONENT multiplexer2x1_fourBits
        PORT(
            i_Ai, i_Bi   : IN	STD_LOGIC_VECTOR(3 downto 0);
            i_selLine    : IN    STD_LOGIC;
            o_Result     : OUT	STD_LOGIC_VECTOR(3 downto 0));
    END COMPONENT;

    COMPONENT rythmeur4bits
        PORT(
		    i_resetBar    : IN	STD_LOGIC;
            i_clock		  : IN	STD_LOGIC;
            i_enable	  : IN	STD_LOGIC;
            MST_OR_SST    : IN  STD_LOGIC;
            o_countDone	  : OUT	STD_LOGIC);
    END COMPONENT;

    COMPONENT enARdFF_2
        PORT(
            i_resetBar	: IN	STD_LOGIC;
            i_d		    : IN	STD_LOGIC;
            i_enable	: IN	STD_LOGIC;
            i_clock		: IN	STD_LOGIC;
            o_q, o_qBar	: OUT	STD_LOGIC);
    END COMPONENT;

    COMPONENT additionSubstraction_fourBits
        PORT(
            i_Subtraction   : IN    STD_LOGIC;
            i_Ai, i_Bi		: IN	STD_LOGIC_VECTOR(3 DOWNTO 0);
            o_CarryOut		: OUT	STD_LOGIC;
            o_Sum			: OUT	STD_LOGIC_VECTOR(3 DOWNTO 0));
    END COMPONENT;

    COMPONENT dec_7seg_decimal
        PORT(
            i_hexDigit	: IN STD_LOGIC_VECTOR(3 downto 0);
            o_segment1_a, o_segment1_b, o_segment1_c, o_segment1_d, o_segment1_e,
            o_segment1_f, o_segment1_g : OUT STD_LOGIC;
            o_segment2_a, o_segment2_b, o_segment2_c, o_segment2_d, o_segment2_e,
            o_segment2_f, o_segment2_g : OUT STD_LOGIC);
    END COMPONENT;

BEGIN
    -- Use clock divider to get frequencies for different process
    clock: clk_div
	PORT MAP (clock_50Mhz => i_clock,
	          clock_25Mhz => clock_div_25Mhz,
			  clock_1MHz => clock_div_1Mhz,
			  clock_100KHz => clock_div_100Khz,
			  clock_10KHz => clock_div_10Khz,
              clock_1KHz => clock_div_1Khz,
              clock_100Hz => clock_div_100hz,
              clock_10Hz => clock_div_10Hz,
              clock_1Hz => clock_div_1Hz);

    -- Since the carte Altera 2 uses already a debouncer mechanism for its push buttons as
    -- stated in the manual, there is no need to implement another one
    MSC_MAX_input_value <= NOT i_MSC;
    MSC_MAX_Value: fourBit_Counter
    PORT MAP (i_resetBar => i_reset,
	          i_load => MSC_MAX_input_value,
			  i_clock => clock_div_1Hz,
              o_Value => MSC_MAX);

    SSC_MAX_input_value <= NOT i_SSC;
    SSC_MAX_Value: fourBit_Counter
    PORT MAP (i_resetBar => i_reset,
	          i_load => SSC_MAX_input_value,
			  i_clock => clock_div_1Hz,
              o_Value => SSC_MAX);

    MSC_SSC_reset_new <= i_reset AND NOT MST_OR_SST_countDone;
    MSC_SSC_reset_FF: enARdFF_2
    PORT MAP (i_resetBar => i_reset,
	          i_d => MSC_SSC_reset_new,
			  i_enable => '1',
              i_clock => clock_div_1Hz,
              o_q => MSC_SSC_reset,
              o_qBar => NOT_MSC_SSC_reset);

    carDetected <= (carDetected OR NOT i_SSCS) AND MSC_SSC_reset;
    MSC_enable <= MSTL_green AND NOT rythmeurEnable AND carDetected;
    MSC: fourBit_Counter
    PORT MAP (i_resetBar => MSC_SSC_reset,
	          i_load => MSC_enable,
			  i_clock => clock_div_1Hz,
              o_Value => MSC_current);

    SSC_enable <= SSTL_green AND NOT rythmeurEnable;
    SSC: fourBit_Counter
    PORT MAP (i_resetBar => MSC_SSC_reset,
	          i_load => SSC_enable,
			  i_clock => clock_div_1Hz,
              o_Value => SSC_current);

    -- Multiplexer to choose between MSC and SSC
    MSC_OR_SSC: multiplexer2x1_fourBits
    PORT MAP (i_Ai => MSC_current,
	          i_Bi => SSC_current,
			  i_selLine => SSTL,
              o_Result => currentCounterValToCompare);

    -- Multiplexer to choose between MSC_MAX and SSC_MAX
    MSC_MAX_OR_SSC_MAX: multiplexer2x1_fourBits
    PORT MAP (i_Ai => MSC_MAX,
	          i_Bi => SSC_MAX,
			  i_selLine => SSTL,
              o_Result => maxCounterValToCompare);

    -- To output to BCD first substract current counter value from max counter value
    Substractor_MSC: additionSubstraction_fourBits
    PORT MAP (i_Subtraction => '1',
	          i_Ai => MSC_MAX,
			  i_Bi => MSC_current,
              o_CarryOut => carryOut,
              o_Sum => BCDvalue_MSC);
    -- Output the susbtraction
    BCD_MSC: dec_7seg_decimal
    PORT MAP (i_hexDigit => BCDvalue_MSC,
              o_segment1_a => o_MSC_Seg1A,
              o_segment1_b => o_MSC_Seg1B,
              o_segment1_c => o_MSC_Seg1C,
              o_segment1_d => o_MSC_Seg1D,
              o_segment1_e => o_MSC_Seg1E,
              o_segment1_f => o_MSC_Seg1F,
              o_segment1_g => o_MSC_Seg1G,
              o_segment2_a => o_MSC_Seg2A,
              o_segment2_b => o_MSC_Seg2B,
              o_segment2_c => o_MSC_Seg2C,
              o_segment2_d => o_MSC_Seg2D,
              o_segment2_e => o_MSC_Seg2E,
              o_segment2_f => o_MSC_Seg2F,
              o_segment2_g => o_MSC_Seg2G);

    Substractor_SSC: additionSubstraction_fourBits
    PORT MAP (i_Subtraction => '1',
	          i_Ai => SSC_MAX,
			  i_Bi => SSC_current,
              o_CarryOut => carryOut,
              o_Sum => BCDvalue_SSC);
    -- Output the susbtraction
    BCD_SSC: dec_7seg_decimal
    PORT MAP (i_hexDigit => BCDvalue_SSC,
              o_segment1_a => o_SSC_Seg1A,
              o_segment1_b => o_SSC_Seg1B,
              o_segment1_c => o_SSC_Seg1C,
              o_segment1_d => o_SSC_Seg1D,
              o_segment1_e => o_SSC_Seg1E,
              o_segment1_f => o_SSC_Seg1F,
              o_segment1_g => o_SSC_Seg1G,
              o_segment2_a => o_SSC_Seg2A,
              o_segment2_b => o_SSC_Seg2B,
              o_segment2_c => o_SSC_Seg2C,
              o_segment2_d => o_SSC_Seg2D,
              o_segment2_e => o_SSC_Seg2E,
              o_segment2_f => o_SSC_Seg2F,
              o_segment2_g => o_SSC_Seg2G);

    -- Compare values of counters with its respective max value
    Comparateur: fourBitComparator
    PORT MAP (i_Ai => currentCounterValToCompare,
	          i_Bi => maxCounterValToCompare,
			  o_GT => biggerA,
              o_LT => biggerB,
              o_EQ => equalAB);
    zeroComparison <= NOT(currentCounterValToCompare(0) OR currentCounterValToCompare(1)
                        OR currentCounterValToCompare(2) OR currentCounterValToCompare(3)
                        OR maxCounterValToCompare(0) OR maxCounterValToCompare(1)
                        OR maxCounterValToCompare(2) OR maxCounterValToCompare(3));

    rythmeurEnable <= equalAB AND NOT zeroComparison;
    Rythmeur: rythmeur4bits
    PORT MAP (i_resetBar => MSC_SSC_reset,
	          i_clock => clock_div_1Hz,
			  i_enable => rythmeurEnable,
              MST_OR_SST => SSTL,
              o_countDone => MST_OR_SST_countDone);

    -- Update state variable SSTL
    SSTL_NEW <= SSTL XOR MST_OR_SST_countDone;
    SSTL_state: enARdFF_2
    PORT MAP (i_resetBar => i_reset,
	          i_d => SSTL_NEW,
			  i_enable => '1',
              i_clock => clock_div_1Hz,
              o_q => SSTL,
              o_qBar => NOT_SSTL);

    -- Update traffic lights
    MSTL_green <= NOT SSTL AND (NOT equalAB OR zeroComparison);
    SSTL_green <= SSTL AND NOT equalAB;

    -- Output driver
    o_MSTL_GREEN <= MSTL_green;
    o_MSTL_YELLOW <= NOT SSTL AND NOT MSTL_green;
    o_MSTL_RED <= SSTL;
    o_SSTL_GREEN <= SSTL_green;
    o_SSTL_YELLOW <= SSTL AND NOT SSTL_green;
    o_SSTL_RED <= NOT SSTL;

END lab3;