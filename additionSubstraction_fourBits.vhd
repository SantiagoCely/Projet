--------------------------------------------------------------------------------
-- Title         : 4-bit Adder/substractor
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY additionSubstraction_fourBits IS
	PORT(
        i_Subtraction   : IN    STD_LOGIC;
		i_Ai, i_Bi		: IN	STD_LOGIC_VECTOR(3 DOWNTO 0);
		o_CarryOut		: OUT	STD_LOGIC;
		o_Sum			: OUT	STD_LOGIC_VECTOR(3 DOWNTO 0));
END additionSubstraction_fourBits;

ARCHITECTURE additionnerSubstractor OF additionSubstraction_fourBits IS
    SIGNAL int_Sum, int_CarryOut : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL complementedB         : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL numToAdd              : STD_LOGIC_VECTOR(3 DOWNTO 0);

	COMPONENT oneBitAdder
	PORT(
		i_CarryIn		    : IN	STD_LOGIC;
		i_Ai, i_Bi		    : IN	STD_LOGIC;
		o_Sum, o_CarryOut	: OUT	STD_LOGIC);
    END COMPONENT;

    COMPONENT multiplexer2x1_fourBits
        PORT(
            i_Ai, i_Bi    : IN	STD_LOGIC_VECTOR(3 downto 0);
            i_selLine     : IN  STD_LOGIC;
            o_Result	  : OUT	STD_LOGIC_VECTOR(3 downto 0));
    END COMPONENT;

BEGIN
    -- If i_Subtraction is 1, find 1's complement first of i_Bi before adding it to i_Ai
    complementedB <= not(i_Bi);
    Mux: multiplexer2x1_fourBits
        PORT MAP (i_Ai => i_Bi,
                  i_Bi => complementedB,
                  i_selLine => i_Subtraction,
                  o_Result => numToAdd);

    -- The carry in for the first adder is the bit from the flag subtraction
    -- if subtraction is 0, addition will go as usual with 0 carry in
    -- if subtraction is 1, the second number was already complemented and is
    -- only missing +1 to be the 2's complement of the orginal number
    add0: oneBitAdder
        PORT MAP (i_CarryIn => i_Subtraction,
                i_Ai => i_Ai(0),
                i_Bi => numToAdd(0),
                o_Sum => int_Sum(0),
                o_CarryOut => int_CarryOut(0));

    add1: oneBitAdder
        PORT MAP (i_CarryIn => int_CarryOut(0),
                i_Ai => i_Ai(1),
                i_Bi => numToAdd(1),
                o_Sum => int_Sum(1),
                o_CarryOut => int_CarryOut(1));

    add2: oneBitAdder
        PORT MAP (i_CarryIn => int_CarryOut(1),
                i_Ai => i_Ai(2),
                i_Bi => numToAdd(2),
                o_Sum => int_Sum(2),
                o_CarryOut => int_CarryOut(2));

    add3: oneBitAdder
        PORT MAP (i_CarryIn => int_CarryOut(2),
                i_Ai => i_Ai(3),
                i_Bi => numToAdd(3),
                o_Sum => int_Sum(3),
                o_CarryOut => int_CarryOut(3));

    -- Output Driver
    o_Sum <= int_Sum;
    o_CarryOut <= int_CarryOut(3);

END additionnerSubstractor;
