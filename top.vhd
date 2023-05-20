----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:58:06 05/19/2023 
-- Design Name: 
-- Module Name:    top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is

generic (
	c_clkfreq	: integer := 50_000_000
);

port (
	clk		: in std_logic;
	switch		: in std_logic_vector (1 downto 0);
	led		: out std_logic_vector (3 downto 0)
);
end top;

architecture Behavioral of top is

constant c_timer2seclim		: integer := c_clkfreq*2;
constant c_timer1seclim		: integer := c_clkfreq;
constant c_timer500mslim	: integer := c_clkfreq/2;
constant c_timer250mslim	: integer := c_clkfreq/4;

signal timer			: integer range 0 to c_timer2seclim := 0;
signal timerlim			: integer range 0 to c_timer2seclim	:= 0;
signal counter_int		: std_logic_vector (3 downto 0) := (others => '0');

begin

-- combination logis assignment
timerlim	<= c_timer2seclim 	when switch = "11" else
		   c_timer1seclim	when switch = "10" else
		   c_timer500mslim	when switch = "01" else
		   c_timer250mslim;


process (clk) begin
if (rising_edge(clk)) then

	if (timer >= timerlim-1) then
		counter_int	<= counter_int + 1;
		timer		<= 0;
	else
		timer 		<= timer + 1;
	end if;

end if;

end process;

led <= counter_int;


end Behavioral;

