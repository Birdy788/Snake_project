----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.12.2020 14:31:51
-- Design Name: 
-- Module Name: type_mov - Behavioral
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

entity type_mov is
    Port ( clock : in STD_LOGIC;
           r_joy : in STD_LOGIC;
           r_bot : in STD_LOGIC;
           l_joy : in STD_LOGIC;
           l_bot : in STD_LOGIC;
--           c_joy : in STD_LOGIC;
           c_bot : in STD_LOGIC;
           up_joy : in STD_LOGIC;
           up_bot : in STD_LOGIC;
           down_joy : in STD_LOGIC;
           down_bot : in STD_LOGIC;
           output_up : out STD_LOGIC;
           output_down : out STD_LOGIC;
           output_left : out STD_LOGIC;
          output_right : out STD_LOGIC;
           output_centre : out STD_LOGIC);
end type_mov;

architecture Behavioral of type_mov is
signal b_up,b_down,b_right,b_left,b_center, j_up,j_down,j_right,j_left,j_center : std_logic;
begin
--b_up <= up_bot;
--j_up <= up_joy;
--b_down <= down_bot;
--j_down <= down_joy;
--b_right <= r_bot;
--j_right <= r_joy;
--b_left <= l_bot;
--j_left <= l_joy;
--j_center <= c_joy;
--b_center <= c_bot;


  process(clock)
         begin
             if rising_edge(clock) then
                 
                 if (up_bot ='1' or up_joy='1' )then
                     b_down <='0' ; b_left <='0'; b_right <='0' ;b_center<='0'; j_down <='0' ; j_left <='0' ; j_right <='0' ; j_center<='0'; b_up<='1';j_up<='1';
          
                     
                 elsif (down_bot ='1' or down_joy='1' )then
                         b_up <='0' ; b_left <='0'; b_right <='0' ;b_center<='0'; j_up <='0' ; j_left <='0' ; j_right <='0' ; j_center<='0';b_down<='1';j_down<='1';
               
                     
                 elsif (l_bot ='1' or l_joy='1' )then
                         b_down <='0' ; b_up <='0'; b_right <='0' ;b_center<='0'; j_down <='0' ; j_up <='0' ; j_right <='0' ; j_center<='0';b_left<='1';j_left<='1';
                     
                     
                 elsif (r_bot ='1' or r_joy='1' )then
                      b_down <='0' ; b_up <='0'; b_left <='0' ;b_center<='0'; j_down <='0' ; j_up <='0' ; j_left <='0' ; j_center<='0';b_right<='1';j_right<='1';
                     
                     
                 elsif (c_bot ='1'  )then
                      b_down <='0' ; b_up <='0'; b_right <='0' ;b_left<='0'; j_down <='0' ; j_up <='0' ; j_right <='0' ; j_left<='0';b_center<='1';j_center<='1';
                    
 
                 end if;
             end if;
    end process;
    
     process(clock)
        begin
            if rising_edge(clock) then
               
                if( b_up ='1' or j_up='1') and b_down ='0' and j_down ='0' and b_left ='0' and j_left ='0' and b_right ='0' and j_right ='0' and b_center='0' and j_center='0' then
                    output_up <= '1' ;  output_down <= '0' ;  output_left <= '0' ;  output_right <= '0' ; output_centre <= '0';
                   
                elsif b_up ='0' and j_up ='0' and (b_down ='1' or j_down='1') and b_left ='0' and j_left ='0' and b_right ='0' and j_right ='0' and b_center='0' and j_center='0' then
                    output_up <= '0' ;  output_down <= '1' ;  output_left <= '0' ;  output_right <= '0' ; output_centre <= '0';
                   
                elsif b_up ='0' and j_up ='0' and b_down ='0' and j_down ='0' and (b_left ='1' or j_left='1') and b_right ='0' and j_right ='0' and b_center='0' and j_center='0' then
                     output_up <= '0' ;  output_down <= '0' ;  output_left <= '1' ;  output_right <= '0' ; output_centre <= '0';
                     
                elsif b_up ='0' and j_up ='0' and b_down ='0' and j_down ='0' and b_left ='0' and j_left ='0' and (b_right='1' or j_right='1') and b_center='0' and j_center='0' then
                     output_up <= '0' ;  output_down <= '0' ;  output_left <= '0' ;  output_right <= '1' ; output_centre <= '0';
                     
                elsif b_up ='0' and j_up ='0' and b_down ='0' and j_down ='0' and b_left ='0' and j_left ='0' and b_right='0' and j_right ='0' and (b_center='1' or j_center='1') then
                          output_up <= '0' ;  output_down <= '0' ;  output_left <= '0' ;  output_right <= '0' ; output_centre <= '1';

                end if;
            end if;
   end process;
end Behavioral;
