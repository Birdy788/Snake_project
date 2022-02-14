----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.09.2020 10:36:57
-- Design Name: 
-- Module Name: pwm - Behavioral
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

entity pwm is
    Port ( H : in STD_LOGIC;
           reset : in STD_LOGIC;
           i_data : in STD_LOGIC_VECTOR (10 downto 0);
           ce : in STD_LOGIC;
           o_data : out STD_LOGIC);
end pwm;

architecture Behavioral of pwm is
signal cpt : integer;
signal data : std_logic_vector(10 downto 0); --i_data + (2**15)
signal data_2  : integer;  --remplace le role de i_data

begin
data_2 <= to_integer(signed(i_data));

process(H)
begin
    if rising_edge(H) then
        if reset = '1' then
            cpt <= 2**16 - 1;
       else
            if ce = '1' then
                cpt <= 0;
            else
                cpt <= cpt +1;
            end if;
      end if;
  end if;
end process;


data <= std_logic_vector(to_unsigned(data_2+1024,11));


o_data <= '1' when cpt<to_integer(unsigned(data))
               else '0';
               
               
end Behavioral;
