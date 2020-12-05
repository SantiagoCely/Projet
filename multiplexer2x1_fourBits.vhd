--------------------------------------------------------------------------------
-- Title         : 2x1 Mux 8-bits
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY multiplexer2x1_fourBits IS
	PORT(
        i_Ai, i_Bi    : IN	STD_LOGIC_VECTOR(3 downto 0);
        i_selLine     : IN    STD_LOGIC;
		o_Result	  : OUT	STD_LOGIC_VECTOR(3 downto 0));
END multiplexer2x1_fourBits;

ARCHITECTURE mux2x1 OF multiplexer2x1_fourBits IS
    SIGNAL comparison : STD_LOGIC_VECTOR(3 downto 0);
BEGIN
    comparison(3) <= ((not(i_selLine) and i_Ai(3)) or (i_selLine and i_Bi(3)));
    comparison(2) <= ((not(i_selLine) and i_Ai(2)) or (i_selLine and i_Bi(2)));
    comparison(1) <= ((not(i_selLine) and i_Ai(1)) or (i_selLine and i_Bi(1)));
    comparison(0) <= ((not(i_selLine) and i_Ai(0)) or (i_selLine and i_Bi(0)));

    -- Output driver
    o_Result <= comparison;

end mux2x1;