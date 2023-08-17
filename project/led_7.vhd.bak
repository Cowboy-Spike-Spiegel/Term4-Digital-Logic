library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity led_7 is
port(pin:in std_logic_vector(3 downto 0);
	pout:out std_logic_vector(6 downto 0) );
end led_7;

architecture func of led_7 is
begin
process(pin)
	begin
		case pin is
			when "0000" => pout<="0111111" ;
			when "0001" => pout<="0000110" ;
			when "0010" => pout<="1011011" ;
			when "0011" => pout<="1001111" ;
			when "0100" => pout<="1100110" ;
			when "0101" => pout<="1101101" ;
			when "0110" => pout<="1111101" ;
			when "0111" => pout<="0000111" ;
			when "1000" => pout<="1111111" ;
			when "1001" => pout<="1101111" ;
			when others => pout<="0000110";
		end case ;
end process ;
end func;