--------------------------------------------------------------------------------
-- Title         : 4-bit counter
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY fourBit_Counter IS
	PORT(
		i_resetBar, i_load	: IN	STD_LOGIC;
		i_clock			    : IN	STD_LOGIC;
		o_Value			    : OUT	STD_LOGIC_VECTOR(3 downto 0));
END fourBit_Counter;

ARCHITECTURE counter OF fourBit_Counter IS
    SIGNAL int_c, int_nc, int_d, int_nd : STD_LOGIC; --'d' is the msb and 'a' is the lsb
    SIGNAL int_a, int_na, int_b, int_nb : STD_LOGIC;
    SIGNAL int_notC, int_notD : STD_LOGIC;
    SIGNAL int_notA, int_notB : STD_LOGIC;


	COMPONENT enARdFF_2
		PORT(
			i_resetBar	: IN	STD_LOGIC;
			i_d		    : IN	STD_LOGIC;
			i_enable	: IN	STD_LOGIC;
			i_clock		: IN	STD_LOGIC;
			o_q, o_qBar	: OUT	STD_LOGIC);
	END COMPONENT;

BEGIN

	-- Concurrent Signal Assignment
    int_nd <= (int_d and (not(int_b) or not(int_a) or not(int_c))) or (not(int_d) and int_c and int_b and int_a);
    int_nc <= (int_c and (not(int_b) or not(int_a))) or (not(int_c) and int_b and int_a);
    int_nb <= int_a xor int_b;
	int_na <= not(int_a);

msb: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_nd,
			  i_enable => i_load,
			  i_clock => i_clock,
			  o_q => int_d,
              o_qBar => int_notD);

thirdbit: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_nc,
			  i_enable => i_load,
			  i_clock => i_clock,
			  o_q => int_c,
              o_qBar => int_notC);

secondbit: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_nb,
			  i_enable => i_load,
			  i_clock => i_clock,
			  o_q => int_b,
	          o_qBar => int_notB);

lsb: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_na,
			  i_enable => i_load,
			  i_clock => i_clock,
			  o_q => int_a,
	          o_qBar => int_notA);

	-- Output Driver
	o_Value		<= int_d & int_c & int_b & int_a;

END counter;
