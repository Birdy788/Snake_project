----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 17.11.2020 15:15:39
-- Design Name:
-- Module Name: synch_boutons_from_jstk - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity synch_boutons_from_jstk is
    Port ( clock : in STD_LOGIC;
           jstk_x : in STD_LOGIC_VECTOR (9 downto 0);
           jstk_y : in STD_LOGIC_VECTOR (9 downto 0);
           --l_centre : in std_logic;
--           output_up : out STD_LOGIC;               
--           output_down : out STD_LOGIC; 
           l_up : out STD_LOGIC;
--           output_left : out STD_LOGIC; 
            l_down : out STD_LOGIC;
--           output_right : out STD_LOGIC;
           l_left : out STD_LOGIC;
--           output_centre : out STD_LOGIC);
           l_right : out STD_LOGIC);
--           output_centre : out STD_LOGIC);
end synch_boutons_from_jstk;
-- TO DO FIX THE SYNCH
-- IT WORKED WITH THE FIRST ONE

architecture Behavioral of synch_boutons_from_jstk is
signal x: integer :=0;
signal y: integer :=0;
--signal l_up, l_down,l_right, l_left : std_logic;
begin
x <= to_integer(unsigned(jstk_x));
y <= to_integer(unsigned(jstk_y));


   process(clock)
        begin
            if rising_edge(clock) then
               
                if (y > 800 and y<1000) and( x> 400 and  x < 600)  then
                    l_up <= '1' ;  l_down <= '0' ;  l_left <= '0' ;  l_right <= '0' ; 
                   
                elsif (y > 0 and y<200) and ( x> 400 and  x < 600) then
                    l_up <= '0' ;  l_down <= '1' ;  l_left <= '0' ;  l_right <= '0' ; 
                   
                elsif (x > 800 and x<1000) and ( y> 400 and  y < 600)  then
                     l_up <= '0' ;  l_down <= '0' ;  l_left <= '1' ;  l_right <= '0' ; 
                     
                elsif (x > 0 and x<200) and ( y> 400 and  y < 600) then
                     l_up <= '0' ;  l_down <= '0' ;  l_left <= '0' ;  l_right <= '1' ; 
                else 
                     l_up <= '0' ;  l_down <= '0' ;  l_left <= '0' ;  l_right <= '0' ;   
--                elsif (x > 500 and x<530) and ( y> 500 and  y < 530) then
--                       l_up <= '0' ;  l_down <= '0' ;  l_left <= '0' ;  l_right <= '0' ; l_centre <= '1';

                end if;
            end if;
   end process;
   

  
   
--       process(clock)
--           begin
--               if rising_edge(clock) then
                   
--                   if l_up ='1' and l_down ='0' and l_left ='0' and l_right ='0' and l_centre='0' then
--                       output_up <= '1' ;  output_down <= '0' ;  output_left <= '0' ;  output_right <= '0' ; output_centre <= '0';
                       
--                   elsif l_up ='0' and l_down ='1' and l_left ='0' and l_right ='0' and l_centre='0' then
--                       output_up <= '0' ;  output_down <= '1' ;  output_left <= '0' ;  output_right <= '0' ; output_centre <= '0';
                       
--                   elsif l_up ='0' and l_down ='0' and l_left ='1' and l_right ='0' and l_centre='0' then
--                        output_up <= '0' ;  output_down <= '0' ;  output_left <= '1' ;  output_right <= '0' ; output_centre <= '0';
                       
--                   elsif l_up ='0' and l_down ='0' and l_left ='0' and l_right='1' and l_centre='0' then
--                        output_up <= '0' ;  output_down <= '0' ;  output_left <= '0' ;  output_right <= '1' ; output_centre <= '0';
                       
--                   elsif l_up ='0' and l_down ='0' and l_left ='0' and l_right='0' and l_centre='1' then
--                             output_up <= '0' ;  output_down <= '0' ;  output_left <= '0' ;  output_right <= '0' ; output_centre <= '1';
   
--                   end if;
--               end if;
--      end process;


end Behavioral;
