--------------------------------------------------------------------------------
-- Title         : Rythmeur 4-bits
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

ENTITY rythmeur4bits IS
  -- Values for MST and SST in seconds (between 0 and 15)
    GENERIC (MST_VALUE_INT  : INTEGER := 3;
            SST_VALUE_INT   : INTEGER := 2);

	PORT(
		i_resetBar   : IN	STD_LOGIC;
        i_clock		 : IN	STD_LOGIC;
        i_enable	 : IN	STD_LOGIC;
        MST_OR_SST   : IN   STD_LOGIC;
        o_countDone	 : OUT	STD_LOGIC);
END rythmeur4bits;

ARCHITECTURE timer OF rythmeur4bits IS
    SIGNAL counterVal, chosen_value : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL MST_VALUE, SST_VALUE : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL biggerA, biggerB, equalAB : STD_LOGIC;

    COMPONENT fourBit_Counter
        PORT(
            i_resetBar, i_load	: IN	STD_LOGIC;
            i_clock			    : IN	STD_LOGIC;
            o_Value			    : OUT	STD_LOGIC_VECTOR(3 downto 0));
    END COMPONENT;

    COMPONENT multiplexer2x1_fourBits
        PORT(
            i_Ai, i_Bi  : IN	STD_LOGIC_VECTOR(3 downto 0);
            i_selLine   : IN    STD_LOGIC;
            o_Result	: OUT	STD_LOGIC_VECTOR(3 downto 0));
    END COMPONENT;

    COMPONENT fourBitComparator
        PORT(
            i_Ai, i_Bi		    : IN	STD_LOGIC_VECTOR(3 downto 0);
            o_GT, o_LT, o_EQ	: OUT	STD_LOGIC);
    END COMPONENT;
BEGIN
    counter: fourBit_Counter
        PORT MAP (i_resetBar => i_resetBar,
                  i_load => i_enable,
                  i_clock => i_clock,
                  o_Value => counterVal);

    MST_VALUE <= std_logic_vector(to_unsigned(MST_VALUE_INT, 4));
    SST_VALUE <= std_logic_vector(to_unsigned(SST_VALUE_INT, 4));
    chosenValue: multiplexer2x1_fourBits
    PORT MAP (i_Ai => MST_VALUE,
	          i_Bi => SST_VALUE,
			  i_selLine => MST_OR_SST,
              o_Result => chosen_value);

    Comparateur: fourBitComparator
    PORT MAP (i_Ai => chosen_value,
	          i_Bi => counterVal,
			  o_GT => biggerA,
              o_LT => biggerB,
              o_EQ => equalAB);

    -- Output driver
    o_countDone <= equalAB;
END timer;
