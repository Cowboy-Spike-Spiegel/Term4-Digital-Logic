library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity t_bottles is
port(clk:in std_logic;
clr:in std_logic;
co:in std_logic;
bottle_h:in std_logic_vector(3 downto 0);
bottle_l:in std_logic_vector(3 downto 0);
led_h:out std_logic_vector(3 downto 0);
led_l:out std_logic_vector(3 downto 0);
full:out std_logic
);
end t_bottles ;

architecture func of t_bottles is
signal b_h:std_logic_vector( 3 downto 0);
signal b_l:std_logic_vector( 3 downto 0);
signal cur_h: std_logic_vector( 3 downto 0);
signal cur_l:std_logic_vector (3 downto 0);
signal s_full:std_logic:='1';
begin
process(clk,clr)
begin
	if(bottle_h>"0001")then
		b_h<="0001";
		b_l<="1000";
		--s_full<='0';
	elsif(bottle_h="0001" and bottle_l>"1000") then
		b_h<=bottle_h;
		b_l<="1000";
		--s_full<='0';
	elsif(bottle_l>"1001")then
		b_h<=bottle_h;
		b_l<="1001";
		--s_full<='0';
	elsif(bottle_h="0000" and bottle_l="0000")then
		b_h<="0000";
		b_l<="0001";
		--s_full<='1';
	else
		b_h<=bottle_h;
		b_l<=bottle_l;
		--s_full<='0';
	end if;
	
	if(clr='1')then
		cur_h<="0000";
		cur_l<="0000";
		s_full<='0';
	elsif(clk'event and clk='1')then
		if(co='1')then
			if(cur_l="1001")then
				cur_l<="0000";
				cur_h<=cur_h+1;
			else
				cur_l<=cur_l+1;
			end if;
			
			-- 
			if(b_h = "0001" and b_l = "0000")then
				if(cur_h = "0000" and cur_l = "1001")then
					s_full <= '1';
				else
					s_full <= '0';
				end if;
			else	
				if(cur_h = b_h and cur_l+1 = b_l)then
					s_full <= '1';
				else
					s_full <= '0';
				end if;
			end if;
		end if;	-- end co
	end if;	-- end clk
	full<=s_full;
	led_l<=cur_l;
	led_h<=cur_h;
end process;
end func;