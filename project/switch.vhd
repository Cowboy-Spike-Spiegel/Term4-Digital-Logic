library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity switch is
port(clk:in std_logic;
	clr:in std_logic;
	mode:in std_logic_vector(1 downto 0);
	t_h:in std_logic_vector(3 downto 0);
	t_l:in std_logic_vector(3 downto 0);
	tt_h:in std_logic_vector(3 downto 0);
	tt_m:in std_logic_vector(3 downto 0);
	tt_l:in std_logic_vector(3 downto 0);
	b_h:in std_logic_vector(3 downto 0);
	b_l:in std_logic_vector(3 downto 0);
	led3:out std_logic_vector(3 downto 0);
	led2:out std_logic_vector(3 downto 0);
	led1:out std_logic_vector(3 downto 0)
	);
end switch;

architecture func of switch is
begin
process(clk)
begin
	if(clr='1')then
		led3<="0000";
		led2<="0000";
		led1<="0000";
	elsif(clk'event and clk='1')then
		case (mode) is
		when "00" =>
		led3<="0000";
		led2<=t_h;
		led1<=t_l;
		when "01"=>
		led3<=tt_h;
		led2<=tt_m;
		led1<=tt_l;
		when "10"=>
		led3<="0000";
		led2<=b_h;
		led1<=b_l;
		when others => NULL;	
		end case;
	end if;
end process;
end func;