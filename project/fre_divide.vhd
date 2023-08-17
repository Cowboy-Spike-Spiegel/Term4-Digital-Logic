library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity fre_divide is 
port(
	clk:	in 	std_logic; 
	clk_0: 	out std_logic;	--1Hz方波
	clk_125:out std_logic;	--1Hz方波，延时0.125s
	clk_25: out std_logic	--1Hz方波，延时0.25s
);
end fre_divide;

architecture func of fre_divide is 
signal tcount: integer range 0 to 10000; 
signal divide_0:	std_logic; --1Hz方波
signal divide_125:	std_logic; --1Hz方波, 延时0.125s
signal divide_25:	std_logic; --1Hz方波，延时0.25s

begin

p1:process(clk) --10k分频 
begin 
	if(clk 'event and clk='1')then 
		if tcount=10000 then 
			tcount <= 0; 
		else 
			tcount <= tcount+1; 
		end if; 
	end if; 
end process;

p2:process(clk,tcount)
begin
	if(clk'event and clk='1')then
		-- clk_0
		if( tcount<5000 ) then 
			divide_0 <= '1' ;
		else 
			divide_0 <= '0'; 
		end if;
		-- clk_125
		if( tcount > 1249 and tcount < 6250 ) then 
			divide_125 <= '1' ;
		else 
			divide_125 <= '0'; 
		end if;
		-- clk_25
		if( tcount > 2499 and tcount < 7500 ) then
			divide_25 <= '1' ;
		else 
			divide_25 <= '0'; 
		end if;	
	end if;
	-- output
	clk_0 <= divide_0;
	clk_125 <= divide_125;
	clk_25 <= divide_25;
end process;
end func;
		
			