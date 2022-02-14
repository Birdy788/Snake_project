----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 10/26/2020 10:18:04 PM
-- Design Name:
-- Module Name: move - Behavioral
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

entity move_snake is
    Port (  clock : in STD_LOGIC;
            reset : in std_logic;
            up,down,left,right,centre : in STD_LOGIC;
            compteur : in std_logic_vector(6 downto 0);
            x_s, y_s: out std_logic_vector(9 downto 0);
            x_s_i, y_s_i: in std_logic_vector(9 downto 0));
           
end move_snake;

architecture Behavioral of move_snake is
TYPE vitesse IS ARRAY (0 TO 9) OF integer;
signal mok : vitesse := ( 2*10**6,1*10**6, 9*10**5,8*10**5, 7*10**5,6*10**5, 5*10**5,4*10**5, 3*10**5, 2*10**5);
signal x: integer := 100;
signal y: integer := 200;
signal x_i: integer := 100;
signal y_i: integer := 200;
signal vite: integer := 2*10**6;
signal cmpt : integer:=0;
signal cpt : integer :=0;
signal h_aff : std_logic;
 
begin
 
x_i <= to_integer(unsigned(x_s_i));
y_i <= to_integer(unsigned(y_s_i));
cpt <= to_integer(unsigned(compteur));
process( reset,x,y)
begin
    if reset='1' then
        x_s<=std_logic_vector(to_unsigned(100,10));
        y_s<=std_logic_vector(to_unsigned(200,10));
    else
        x_s<=std_logic_vector(to_unsigned(x,10));
        y_s<=std_logic_vector(to_unsigned(y,10));
     end if;
end process;
 
 process(cpt)
 begin
    if cpt <= 10 then 
        vite <= mok(0);
    elsif cpt<=20 and 10<cpt then 
        vite <= mok(1);
    elsif cpt<=30 and 20<cpt then 
        vite <= mok(2);     
    elsif cpt<=40 and 30<cpt then 
        vite <= mok(3);       
    elsif cpt<=50 and 40<cpt then 
        vite <= mok(4);
    elsif cpt<=60 and 50<cpt then 
        vite <= mok(5);
    elsif cpt<=70 and 60<cpt then 
        vite <= mok(6);
    elsif cpt<=80 and 70<cpt then 
        vite <= mok(7);
    elsif cpt<=90 and 80<cpt then 
         vite <= mok(8);
    elsif cpt<=100 and 90<cpt then 
         vite <= mok(9);
    else 
            vite <= vite; 
    end if;
end process;
                
 process (clock)
 
 begin
    if rising_edge(clock) then
     if cmpt = vite then
    -- if cmpt = 17000000 then
           cmpt <= 0;
           h_aff <= '1';
      else
            cmpt <= cmpt + 1;
            h_aff <= '0';
      end if;
    end if;
 end process;          
 
process(h_aff)
    begin
        if rising_edge(h_aff) then
                if up = '1' then
                    if x_i= 10 then
                        x <= 479;
                    else
                        x <= x_i-1 ;
                        y <= y_i ;
                    end if;
               
                elsif down = '1' then
                    if x_i=469 then
                        x <= 0;
                    else
                        x<= x_i+1 ;
                        y <= y_i ;
                    end if;
                   
                elsif left = '1' then
                    if y_i =10 then
                        y <= 639;    
                    else
                        x <= x_i;
                        y <= y_i-1 ;
                    end if;
                         
                elsif right = '1' then
                    if y_i =639 then
                        y <= 0;
                    else
                        x <= x_i ;
                        y <= y_i+1;
                    end if;
                elsif centre='1' then
                    x <= x_i ;
                    y <= y_i;
                end if;
         end if;
         

  end process;
 


   

               

end Behavioral;


