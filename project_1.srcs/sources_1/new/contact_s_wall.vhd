----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.12.2020 14:55:10
-- Design Name: 
-- Module Name: contact_s_wall - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;----------------------------------------------------------------------------------
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

entity contact_s_wall is
    Port ( x_s : in STD_LOGIC_VECTOR (9 downto 0);
          -- x_p : in STD_LOGIC_VECTOR (9 downto 0);
           --y_p : in STD_LOGIC_VECTOR (9 downto 0);
           y_s : in STD_LOGIC_VECTOR (9 downto 0);
           contact_wall : out STD_LOGIC);
end contact_s_wall ;

architecture Behavioral of contact_s_wall  is

begin



process( x_s, y_s )
begin
    --The snake is going up
 if ((0<to_integer(unsigned(x_s)) and  to_integer(unsigned(x_s))<=20) or  (460<to_integer(unsigned(x_s)) and to_integer(unsigned(x_s))<=480) or ( 0<to_integer(unsigned(y_s)) and to_integer(unsigned(y_s))<=20) or ( 620<to_integer(unsigned(y_s))and to_integer(unsigned(y_s))<=640)) then
              contact_wall<='1';
       else    
               contact_wall<='0';

    end if;
   
end process;


end Behavioral;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

