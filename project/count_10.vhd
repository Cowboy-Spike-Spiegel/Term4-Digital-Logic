library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity count_10 is
port(cp_t:in std_logic;
	cp_e: in std_logic;
	cp_0:in std_logic;
	qout:out std_logic_vector(3 downto 0);
	cout:out std_logic
	);
end count_10;

architecture func of count_10 is
signal temp:std_logic_vector(3 downto 0);
begin
process(cp_t,cp_e,cp_0)
begin
	if(cp_0='1')then 
		temp<="0000"; --异步清零
	elsif(cp_e='1')then --计数使能
		if (cp_t'event and cp_t='1')then
			if(temp="1001")then
				temp<="0000";
				cout<='1' ;--寄存的进位输出，给高一级提供计数时钟
			else
				temp<=temp+1;
				cout <= '0';
			end if;
		end if;
	end if;
	qout<=temp;
end process;
	
end func;
