--------------------------------------------------------------------------------
-- Title         : BCD 7-segment Decoder Decimal for numbers between 0 and 15
--------------------------------------------------------------------------------
library ieee;
use  ieee.std_logic_1164.all;

ENTITY dec_7seg_decimal IS
	PORT(i_hexDigit	: IN STD_LOGIC_VECTOR(3 downto 0);
	     o_segment1_a, o_segment1_b, o_segment1_c, o_segment1_d, o_segment1_e,
         o_segment1_f, o_segment1_g : OUT STD_LOGIC;
         o_segment2_a, o_segment2_b, o_segment2_c, o_segment2_d, o_segment2_e,
	     o_segment2_f, o_segment2_g : OUT STD_LOGIC);
END dec_7seg_decimal;

ARCHITECTURE dec7segDec OF dec_7seg_decimal IS
	SIGNAL int_segment1_data, int_segment2_data : STD_LOGIC_VECTOR(6 DOWNTO 0);
BEGIN
	PROCESS  (i_hexDigit)
	BEGIN
		CASE i_hexDigit IS
		        WHEN "0000" =>
                    int_segment1_data <= "1111110";
                    int_segment2_data <= "1111110";
		        WHEN "0001" =>
                    int_segment1_data <= "1111110";
                    int_segment2_data <= "0110000";
		        WHEN "0010" =>
		            int_segment1_data <= "1111110";
                    int_segment2_data <= "1101101";
		        WHEN "0011" =>
		            int_segment1_data <= "1111110";
                    int_segment2_data <= "1111001";
		        WHEN "0100" =>
		            int_segment1_data <= "1111110";
                    int_segment2_data <= "0110011";
		        WHEN "0101" =>
		            int_segment1_data <= "1111110";
                    int_segment2_data <= "1011011";
		        WHEN "0110" =>
		            int_segment1_data <= "1111110";
                    int_segment2_data <= "1011111";
		        WHEN "0111" =>
		            int_segment1_data <= "1111110";
                    int_segment2_data <= "1110000";
		        WHEN "1000" =>
		            int_segment1_data <= "1111110";
                    int_segment2_data <= "1111111";
		        WHEN "1001" =>
		            int_segment1_data <= "1111110";
                    int_segment2_data <= "1110011";
		        WHEN "1010" =>
		            int_segment1_data <= "0110000";
                    int_segment2_data <= "1111110";
		        WHEN "1011" =>
		            int_segment1_data <= "0110000";
                    int_segment2_data <= "0110000";
		        WHEN "1100" =>
		            int_segment1_data <= "0110000";
                    int_segment2_data <= "1101101";
		        WHEN "1101" =>
		            int_segment1_data <= "0110000";
                    int_segment2_data <= "1111001";
		        WHEN "1110" =>
		            int_segment1_data <= "0110000";
                    int_segment2_data <= "0110011";
		        WHEN "1111" =>
		            int_segment1_data <= "0110000";
                    int_segment2_data <= "1011011";
			WHEN OTHERS =>
		            int_segment1_data <= "0000001";
		END CASE;
	END PROCESS;

-- LED driver is inverted
o_segment1_a <= NOT int_segment1_data(6);
o_segment1_b <= NOT int_segment1_data(5);
o_segment1_c <= NOT int_segment1_data(4);
o_segment1_d <= NOT int_segment1_data(3);
o_segment1_e <= NOT int_segment1_data(2);
o_segment1_f <= NOT int_segment1_data(1);
o_segment1_g <= NOT int_segment1_data(0);

o_segment2_a <= NOT int_segment2_data(6);
o_segment2_b <= NOT int_segment2_data(5);
o_segment2_c <= NOT int_segment2_data(4);
o_segment2_d <= NOT int_segment2_data(3);
o_segment2_e <= NOT int_segment2_data(2);
o_segment2_f <= NOT int_segment2_data(1);
o_segment2_g <= NOT int_segment2_data(0);

END dec7segDec;
