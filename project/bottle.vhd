library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity bottle is
	port(
		start:		in 	std_logic;
		clk:		in 	std_logic;
		clr:		in 	std_logic;
		tablets_h:	in 	std_logic_vector(3 downto 0);
		tablets_l:	in 	std_logic_vector(3 downto 0);
		full:		in std_logic;
		led_h:		out	std_logic_vector(3 downto 0);
		led_l:		out	std_logic_vector(3 downto 0);
		co:			out	std_logic;
		light_red:	out	std_logic;
		light_green:out	std_logic
	);
end bottle;

architecture func of bottle is
	signal t_h:		std_logic_vector(3 downto 0)	:= "0000";
	signal t_l:		std_logic_vector(3 downto 0)	:= "0000";
	signal temp_h:	std_logic_vector(3 downto 0)	:= "0000";
	signal temp_l:	std_logic_vector(3 downto 0)	:= "0000";
	signal s_full:std_logic:='0';
	SIGNAL signal_state	: STD_LOGIC		:= '0' ;
begin
	process(clk,clr,start,full)
		begin
			-- clr
			if(clr='1')then
				signal_state <= '0';	-- switch state
				temp_h<="0000"; --异步清零
				temp_l<="0000";
				-- output
				co<='0';
				light_red <= '1';
				light_green <= '0';
			
			-- start = 1
			elsif(start='1')then
				if (clk'event and clk='1')then --计数使能
					-- stop -> work(with light switch) ------------
					if (s_full='0')then
						if(signal_state='0')then
				
							--	input upper bound -> 50
							if(tablets_h>="0101")then
								t_h<="0101";
								t_l<="0000";
								light_red <= '1';	-- red light for wrong
							elsif(tablets_l>"1001")then
								t_h<=tablets_h;
								t_l<="1001";
								light_red <= '1';	-- red light for wrong
							elsif(tablets_h="0000" and tablets_l="0000")then
								t_h<="0000";
								t_l<="0001";
								light_red <= '1';	-- red light for wrong
							else
								t_h<=tablets_h;
								t_l<=tablets_l;
								light_red <= '0';
							end if;
							signal_state <= '1';	-- switch state
							temp_h<="0000";
							temp_l<="0000";
							-- output
							co <= '0';
							light_green <= '0';
						
						-- work ---------------------------------------
						elsif(signal_state='1')then
							-- clk:+1 with output
							if(temp_l="1001")then
								temp_l<="0000";
								temp_h<=temp_h+1;	-- carry
							else
								temp_l<=temp_l+1;
							end if;
							co<='0';
							light_red <= '0';
							light_green <= '1';

							-- FULL! switch state with light switched(the signal isn't +1)
							if(t_l="0000")then	-- 末位为0判断
								if(t_h=temp_h+1 and temp_l="1001")then
									signal_state <= '0';	-- switch state
									co<='1';
									light_red <= '1';
								end if;
							else	-- 末位不为0判断
								if(t_h=temp_h and t_l=temp_l+1)then
									signal_state <= '0';	-- switch state
									co<='1';
									light_red <= '1';
								end if;
							end if;
						end if; -- end state stop and work
						s_full<=full;
					else
						light_red<='1';
					end if;-- end full
				end if;	-- end clk
			end if; -- end clr
		-- output ---------------------------------------------------
		led_h<=temp_h;
		led_l<=temp_l;
		-- end ------------------------------------------------------
	end process;
end func;
