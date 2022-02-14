----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 05.11.2020 02:10:36
-- Design Name:
-- Module Name: generate_poison - Behavioral
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

entity generate_poison is
    Port ( clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           b_c : in std_logic;
           x_p : out STD_LOGIC_VECTOR (9 downto 0);
           y_p : out STD_LOGIC_VECTOR (9 downto 0));
end generate_poison;

architecture Behavioral of generate_poison is
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
 signal h_aff: std_logic;
 signal cmpt : integer :=0;
 signal n,m : integer:=0;
 signal rdy : std_logic;
 signal x,y : std_logic_vector(9 downto 0);
 signal rand_val_y, rand_val_x :std_logic_vector(9 downto 0);
 begin
inst1: component random_gen_y
    Port map ( clk      =>clock,
           update => h_aff,
           reset    => reset,
           rdy      => rdy,
           rand_val => rand_val_y);
           
inst2: component random_gen_V1_x
              Port map ( clk      =>clock,
                     update => h_aff,
                     reset    => reset,
                     rdy      => rdy,
                     rand_val => rand_val_x) ;
                   
  process(b_c,H_aff,x,y)
      begin
         if b_c='1' then
              x<=x;
              y<=y;
         else
         if rising_edge(h_aff) then
                 x <= rand_val_x;
                 y <= rand_val_y;
         else
                 x<=x;
                 y<=y;
         end if;
         end if;
   end process;
                     
   process (clock)
       begin
           if rising_edge(clock) then
                 if cmpt = 10*10**8 then
                       cmpt <= 0;
                       h_aff <= '1';
                  else
                        cmpt <= cmpt + 1;
                        h_aff <= '0';
                   end if;
            end if;
   end process;
   n<=to_integer(unsigned(x))+45;
   m<=to_integer(unsigned(y))+45;

 x_p <= std_logic_vector(to_unsigned(n, 10));
 y_p <= std_logic_vector(to_unsigned(m, 10));

end Behavioral;


