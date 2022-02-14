----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 27.10.2020 20:02:08
-- Design Name:
-- Module Name: clock_generator - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_generator is
    Port ( clock : in STD_LOGIC;
           sig1 : out STD_LOGIC);
end clock_generator;

architecture Behavioral of clock_generator is
signal cpt : integer range 0 to 3 :=0;

begin
process(clock)
    begin
        if rising_edge(clock) then
            if cpt = 3  then    
                sig1 <= '1';
                cpt <= 0;
            else
                sig1<= '0';
                cpt <= cpt +1;
            end if;
        end if ;
end process;



end Behavioral;

