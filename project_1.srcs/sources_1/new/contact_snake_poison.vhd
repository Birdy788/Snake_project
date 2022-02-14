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

entity contact_snake_poison is
    Port ( x_s : in STD_LOGIC_VECTOR (9 downto 0);
           x_p : in STD_LOGIC_VECTOR (9 downto 0);
           y_p : in STD_LOGIC_VECTOR (9 downto 0);
           y_s : in STD_LOGIC_VECTOR (9 downto 0);
           contact_poison : out STD_LOGIC);
end contact_snake_poison;

architecture Behavioral of contact_snake_poison is

begin



process( x_s, x_p, y_s, y_p )
begin
    --The snake is going up
 if to_integer(unsigned(x_p)) = to_integer(unsigned(x_s))+10  and ( (to_integer(unsigned(y_p))-10 <= to_integer(unsigned(y_s))) and (to_integer(unsigned(y_s)) <= to_integer(unsigned(y_p))+10))  then
              contact_poison<='1';
     
       --The snake is going down
       elsif  to_integer(unsigned(x_s))=to_integer(unsigned(x_p))+10 and ( (to_integer(unsigned(y_p))-10 <= to_integer(unsigned(y_s))) and (to_integer(unsigned(y_s)) <= to_integer(unsigned(y_p))+10))  then
               contact_poison<='1';
   
       --The snake is going right
       elsif  to_integer(unsigned(y_s))+10 =to_integer(unsigned(y_p)) and ( (to_integer(unsigned(x_p))-10 <= to_integer(unsigned(x_s))) and (to_integer(unsigned(x_s)) <= to_integer(unsigned(x_p))+10)) then
               contact_poison<='1';
               
       --The snake is going left
       elsif  to_integer(unsigned(y_s))=to_integer(unsigned(y_p))+10 and ( (to_integer(unsigned(x_p))-10 <= to_integer(unsigned(x_s))) and (to_integer(unsigned(x_s)) <= to_integer(unsigned(x_p))+10))  then
               contact_poison<='1';
   
       else    
               contact_poison<='0';

    end if;
   
end process;


end Behavioral;
