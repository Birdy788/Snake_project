----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 27.10.2020 21:13:17
-- Design Name:
-- Module Name: contact - Behavioral
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

entity contact_snake_apple is
    Port ( x_s : in STD_LOGIC_VECTOR (9 downto 0);
           x_a : in STD_LOGIC_VECTOR (9 downto 0);
           y_s : in STD_LOGIC_VECTOR (9 downto 0);
           y_a : in STD_LOGIC_VECTOR (9 downto 0);
           clock : in std_logic;
           reset : in std_logic;
           cpt : out STD_LOGIC_VECTOR (6 downto 0); -- cpt du nombre de pommes
           enable_generate : out STD_LOGIC);
end contact_snake_apple;

architecture Behavioral of contact_snake_apple is
signal compt : integer range 0 to 101 :=0;
signal ca : integer range 0 to 101 :=0;  
SIGNAL mem : STD_LOGIC := '0';
SIGNAL output : STD_LOGIC := '0';
signal enable : std_logic;
begin



process( x_s, x_a, y_s, y_a )
begin
    --The snake is going up
    if to_integer(unsigned(x_a)) = to_integer(unsigned(x_s))+10  and ( (to_integer(unsigned(y_a))-10 <= to_integer(unsigned(y_s))) and (to_integer(unsigned(y_s)) <= to_integer(unsigned(y_a))+10))  then
--            enable_generate <= '1';
--            compt<=compt+1;
             enable <='1';
   
    --The snake is going down
    elsif  to_integer(unsigned(x_s))=to_integer(unsigned(x_a))+10 and ( (to_integer(unsigned(y_a))-10 <= to_integer(unsigned(y_s))) and (to_integer(unsigned(y_s)) <= to_integer(unsigned(y_a))+10))  then
--            enable_generate <= '1';
--            compt<=compt+1;
               enable <='1';

    --The snake is going right
    elsif  to_integer(unsigned(y_s))+10 =to_integer(unsigned(y_a)) and ( (to_integer(unsigned(x_a))-10 <= to_integer(unsigned(x_s))) and (to_integer(unsigned(x_s)) <= to_integer(unsigned(x_a))+10)) then
--            enable_generate <= '1';
--            compt<=compt+1;
             enable <='1';
           
    --The snake is going left
    elsif  to_integer(unsigned(y_s))=to_integer(unsigned(y_a))+10 and ( (to_integer(unsigned(x_a))-10 <= to_integer(unsigned(x_s))) and (to_integer(unsigned(x_s)) <= to_integer(unsigned(x_a))+10))  then
--            enable_generate <= '1';
--            compt<=compt+1;
                 enable <='1';
    else    
--            enable_generate <= '0';
--            compt<=compt;
            enable <='0';
    end if;
   
end process;



  PROCESS (CLOCK)
  BEGIN
    IF (CLOCK'EVENT AND CLOCK = '1') THEN
MEM    <= enable;
OUTPUT <= (MEM XOR enable) AND enable;
    END IF;
  END PROCESS;


     
process( clock)
begin
    if rising_edge(clock) then
        if reset='1' then 
            compt<= 0;
         elsif output ='1' then    
            if  compt =101 then
                compt <= 101;
            else
                compt <= compt +1;
            
            end if;
                   end if ;
         
       
    else
        compt <=compt;
    end if ;
end process;



 
   
cpt <= std_logic_vector(to_unsigned(compt, 7));
enable_generate <= output;
end Behavioral;

