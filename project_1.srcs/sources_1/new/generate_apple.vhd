----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 05.11.2020 02:14:13
-- Design Name:
-- Module Name: generate_apple - Behavioral
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

entity generate_apple is
    Port ( clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable : in STD_LOGIC;
           x_a : out STD_LOGIC_VECTOR (9 downto 0);
           y_a : out STD_LOGIC_VECTOR (9 downto 0));
end generate_apple;

architecture Behavioral of generate_apple is

component random_gen_V1_x
   Port ( clk      : in  STD_LOGIC;
            reset    : in  STD_LOGIC;
            update : in std_logic;
            rdy      : out STD_LOGIC;
            rand_val : out STD_LOGIC_VECTOR (9 downto 0));
   end component;
   
  component random_gen_y
   Port ( clk      : in  STD_LOGIC;
            reset    : in  STD_LOGIC;
            update : in std_logic;
            rdy      : out STD_LOGIC;
            rand_val : out STD_LOGIC_VECTOR (9 downto 0));
 end component;
 signal rdy : std_logic;
  signal x,y : std_logic_vector(9 downto 0);
  signal rand_val_y, rand_val_x :std_logic_vector(9 downto 0);
 begin
inst1: component random_gen_y
    Port map ( clk      =>clock,
           update =>enable,
           reset    => reset,
           rdy      => rdy,
           rand_val => rand_val_y) ;
           
 inst2: component random_gen_V1_x
              Port map ( clk      =>clock,
                     update => enable,
                     reset    => reset,
                     rdy      => rdy,
                     rand_val => rand_val_x) ;
                     
  process(enable)
      begin
         if rising_edge(enable) then
                 x <= rand_val_x;
                 y <= rand_val_y;
         else
                 x<=x;
                 y<=y;
         end if;
   end process;
               
 x_a <=std_logic_vector(to_unsigned(to_integer(unsigned(x))+35,10));
 y_a <= std_logic_vector(to_unsigned(to_integer(unsigned(y))+35,10));


end Behavioral;

