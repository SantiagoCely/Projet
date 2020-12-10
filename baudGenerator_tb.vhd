library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity baudGenerator_tb is
end baudGenerator_tb;

architecture testbench of baudGenerator_tb is
signal clock_25Mhz_tb, reset_tb: std_logic; 
signal selector_tb: std_logic_vector(2 downto 0); 
signal BclkX8_tb: std_logic; 
signal Bclk_tb: std_logic;
signal sim_end: boolean:= false;
constant period:time:= 50 ns;

component baudGenerator is
port(clock_25Mhz, reset: IN std_logic; selector: IN std_logic_vector(2 downto 0); BclkX8: buffer std_logic; Bclk: out std_logic);
end component;

begin
DUT: baudGenerator port map(clock_25Mhz=>clock_25Mhz_tb, reset=>reset_tb, selector=>selector_tb,BclkX8=>BclkX8_tb, Bclk=>Bclk_tb);

clock_process:process
begin

	while(not sim_end) loop
		clock_25Mhz_tb <='1';
		wait for period/2;
		clock_25Mhz_tb <='0';
		wait for period/2;
	end loop;
end process;

testbench_process: process
begin
	--clock_25Mhz_tb <='1';
	selector_tb <="000";
	reset_tb <='0';
	wait for period;

	--clock_25Mhz_tb <='1';
	selector_tb <="001";
	reset_tb <='0';
	wait for period;
sim_end <=true;
end process;
end testbench;