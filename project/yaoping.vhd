library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity yaoping is
port(clr:in std_logic;
clk:in std_logic;
start:in std_logic;
outclr:out std_logic;
outclk:out std_logic;
outstart:out std_logic
);
end yaoping;

architecture func of yaoping is
begin
	outclr<=clr;
	outclk<=clk;
	outstart<=start;
end func;
		
			