library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity synch_boutons is
    Port ( bouton_up : in STD_LOGIC;
    bouton_down : in STD_LOGIC;
    bouton_left : in STD_LOGIC;
    bouton_right : in STD_LOGIC;
    bouton_centre : in STD_LOGIC;
    clock : in STD_LOGIC;
    output_up,output_down,output_left,output_right,output_centre : out STD_LOGIC);
end synch_boutons;

architecture Behavioral of synch_boutons is


begin

    process(clock)
        begin
            if rising_edge(clock) then
               
                if bouton_up ='1' and bouton_down ='0' and bouton_left ='0' and bouton_right ='0' and bouton_centre='0' then
                    output_up <= '1' ;  output_down <= '0' ;  output_left <= '0' ;  output_right <= '0' ; output_centre <= '0';
                   
                elsif bouton_up ='0' and bouton_down ='1' and bouton_left ='0' and bouton_right ='0' and bouton_centre='0' then
                    output_up <= '0' ;  output_down <= '1' ;  output_left <= '0' ;  output_right <= '0' ; output_centre <= '0';
                   
                elsif bouton_up ='0' and bouton_down ='0' and bouton_left ='1' and bouton_right ='0' and bouton_centre='0' then
                     output_up <= '0' ;  output_down <= '0' ;  output_left <= '1' ;  output_right <= '0' ; output_centre <= '0';
                     
                elsif bouton_up ='0' and bouton_down ='0' and bouton_left ='0' and bouton_right='1' and bouton_centre='0' then
                     output_up <= '0' ;  output_down <= '0' ;  output_left <= '0' ;  output_right <= '1' ; output_centre <= '0';
                     
                elsif bouton_up ='0' and bouton_down ='0' and bouton_left ='0' and bouton_right='0' and bouton_centre='1' then
                          output_up <= '0' ;  output_down <= '0' ;  output_left <= '0' ;  output_right <= '0' ; output_centre <= '1';

                end if;
            end if;
   end process;


end Behavioral;

