library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FSM is
    Port ( clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           b_c : in STD_LOGIC;
           b_up : in STD_LOGIC;
           b_down : in STD_LOGIC;
           b_left : in STD_LOGIC;
           b_right : in STD_LOGIC;
           contact_snake : in STD_LOGIC;
           contact_poison : in STD_LOGIC;
           init : out STD_LOGIC;
           play_pause : out STD_LOGIC;
           lost : out STD_LOGIC);
end FSM;

architecture Behavioral of FSM is

TYPE  Etats is ( start, play, pause, game_over);

signal Etat_present, Etat_futur : Etats;

begin


Reg : process ( clock )
   
    begin
       
        if ( clock'event and clock = '1' ) then
           
            if ( reset = '1' ) then
               
                Etat_present <= start;
            else
                Etat_present <= Etat_futur;
            end if;
        end if;
     end process;


f : process ( Etat_present, b_c, b_left, b_right, b_down, b_up, reset, contact_snake, contact_poison )
   
    begin
   
        case Etat_present is
       
            when start => if  b_up = '1' or b_down ='1' or b_left='1' or b_right='1'then  
                              Etat_futur <= play;
                          else
                              Etat_futur <= start;
                          end if;
            when play => if  b_c = '1'  then
                              Etat_futur <= pause;
                         elsif  contact_snake = '1' or contact_poison='1'  then
                              Etat_futur <= game_over;                            
                         else
                              Etat_futur <= play;
                         end if;
            when pause => if b_up = '1' or b_down ='1' or b_left='1' or b_right='1'then  
                              Etat_futur <= play;
                          else
                              Etat_futur <= pause;
                          end if;
            when game_over => if  reset = '1'  then
                              Etat_futur <= start;
                         else
                              Etat_futur <= game_over;
                         end if;
        end case;
       
    end process;
   
   
sorties : process ( Etat_present )

    begin
   
        case Etat_present is
           
            when start => init <= '1';
                         play_pause <= '1';
                         lost <= '0';
            when play => init <= '0';
                         play_pause <= '0';
                         lost <= '0';
            when pause => init <= '0';
                         play_pause <= '1';
                         lost <= '0';
            when game_over => init <= '0';
                              play_pause <= '0';
                              lost <= '1';
        end case;
                                             
    end process;

end Behavioral;

