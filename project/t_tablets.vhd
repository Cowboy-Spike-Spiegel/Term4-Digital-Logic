library ieee; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity t_tablets is
port(clk:in std_logic;
clr:in std_logic;
start:in std_logic;
count:in std_logic;
led_l:out std_logic_vector(3 downto 0);
 led_m:out std_logic_vector(3 downto 0);
 led_h: out std_logic_vector(3 downto 0)
);
end t_tablets;

architecture func of t_tablets is
	signal temp_h:std_logic_vector(3 downto 0);
	signal temp_m:std_logic_vector(3 downto 0);
	signal temp_l:std_logic_vector(3 downto 0);
begin
process(clk,start,clr)
begin 
	if(clr='1')then
		temp_h<="0000"; --Òì²½ÇåÁã
		temp_m<="0000";
		temp_l<="0000";
	elsif(start='1')then
		if(clk'event and clk='1')then
			if(count='1')then
				if(temp_l="1001" and temp_m="1001")then
					temp_l<="0000";
					temp_m<="0000";
					temp_h<=temp_h+1;
				elsif(temp_l="1001") then
					temp_l<="0000";
					temp_m<=temp_m+1;
				else
					temp_l<=temp_l+1;
				end if;
				
			end if;	
		end if;
	end if;
	led_h<=temp_h;
	led_m<=temp_m;
	led_l<=temp_l;
end process;
end func;
