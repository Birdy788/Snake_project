----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/26/2020 10:34:47 PM
-- Design Name: 
-- Module Name: entite_global - Behavioral
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
use work.fichier.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_level is
    Port ( clock : in STD_LOGIC;
    bouton_up : in STD_LOGIC;
    bouton_down : in STD_LOGIC;
    bouton_left : in STD_LOGIC;
    bouton_right : in STD_LOGIC;
    bouton_centre : in STD_LOGIC;
    LED : out std_logic_vector( 13 downto 0);
--    LED : out std_logic_vector (4 downto 0);
    SW: in std_logic;
   SW1: in std_logic;
    reset :in std_logic;
   sept_seg : out STD_LOGIC_VECTOR (6 downto 0);
--    DP : out std_logic;
   AN : out STD_LOGIC_VECTOR (7 downto 0);
  
  odata : out STD_LOGIC;
           sd : out STD_LOGIC;
  
    MISO : in  STD_LOGIC;
    SS : out  STD_LOGIC;
    SCLK : out  STD_LOGIC;
    MOSI : out  STD_LOGIC;
--    LED : out std_logic_vector (9 downto 0);
     H,V        : out  std_logic;
     R, G, B : out std_logic_vector(3 downto 0));
end top_level;

-- To do :add the sound
-- To do :change the speed of the snake when the score is high enough
-- To do :change the parametres of the transcodeur, mux,mod8 pour affichage 

-- To improve : add another snake that can be controlled with a keyboard or a pmodjoystick

architecture Behavioral of top_level is

signal b_up,b_down,b_left,b_right,b_centre : std_logic;
signal b_up1,b_down1,b_left1,b_right1,b_centre1: std_logic;
signal b_up0,b_down0,b_left0,b_right0,b_centre0: std_logic;
signal enable_generate: std_logic :='1';
signal init, play_pause,lost : std_logic;
signal cpt : std_logic_vector( 6 downto 0);
signal contact_snake, contact_poison :std_logic;
signal tableaux : tailx;
signal tableauy : taily;
signal jstk_x, jstk_y :  std_logic_vector(9 downto 0);
--signal contact_snake: std_logic;
signal x_s, y_s :  std_logic_vector(9 downto 0);
signal x_a, y_a :  std_logic_vector(9 downto 0);
signal x_p, y_p :  std_logic_vector(9 downto 0);
signal nb_pommes :  std_logic_vector(6 downto 0);
--signal x,y : integer range 0 to 640 :=0;
--signal score :  std_logic_vector(9 downto 0);
--signal s_cent : std_logic_vector(6 downto 0);
signal s_diz :  std_logic_vector(6 downto 0);
signal s_uni : std_logic_vector(6 downto 0);
signal sndRec : std_logic;
signal dout : std_logic_vector(39 downto 0);
--signal s_pommes : std_logic_vector(6 downto 0);
--signal sortie1 :  std_logic_vector(6 downto 0); 
--signal sortie2 :std_logic_vector(6 downto 0);
--signal sortie3: std_logic_vector(6 downto 0); 
--signal sortie4 : std_logic_vector(6 downto 0);
signal sortie_mod :  STD_LOGIC;
signal contact_wall : STD_LOGIC;

component Audio is
    Port ( clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable_generate : in STD_LOGIC;
           init : in STD_LOGIC;
           odata : out STD_LOGIC;
           sd : out STD_LOGIC);
end component;

component contact_snake_poison
    Port ( x_s : in STD_LOGIC_VECTOR (9 downto 0);
           x_p : in STD_LOGIC_VECTOR (9 downto 0);
           y_p : in STD_LOGIC_VECTOR (9 downto 0);
           y_s : in STD_LOGIC_VECTOR (9 downto 0);
           contact_poison : out STD_LOGIC);
end component;

component ClkDiv_5Hz is
    Port ( CLK : in  STD_LOGIC;				-- 100MHz onboard clock
           RST : in  STD_LOGIC;				-- Reset
           CLKOUT : inout  STD_LOGIC);		-- New clock output
end component;

--component synch_boutons
--     Port ( bouton_up : in STD_LOGIC;
--            bouton_down : in STD_LOGIC;
--            bouton_left : in STD_LOGIC;
--            bouton_right : in STD_LOGIC;
--            bouton_centre : in STD_LOGIC;
--            clock : in STD_LOGIC;
--             output_up,output_down,output_left,output_right,output_centre : out STD_LOGIC);
--end component;

component FSM
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
end component;

--component compteur_decompteur is  
--    Port ( 
--           clock : in std_logic;
--           reset : in std_logic;
--           generate_score : in std_logic;
--           score_time : in std_logic_vector( 4 downto 0);
--           nb_pommes : out std_logic_vector (3 downto 0);
--           score : out std_logic_vector(9 downto 0));
--end component;

component mod8 is
    Port ( 
           clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           sortie_mod : out STD_LOGIC);
end component;

component transcodeur is
Port ( 
--        sortie_compteur : in std_logic_vector(9 downto 0);
        nb_pommes : in std_logic_vector(6 downto 0);
--        s_cent : out std_logic_vector(6 downto 0);
        s_diz : out std_logic_vector(6 downto 0);
        s_uni : out std_logic_vector(6 downto 0));
--        s_pommes : out std_logic_vector(6 downto 0);
--        sortie1 : out std_logic_vector(6 downto 0); 
--        sortie2 : out std_logic_vector(6 downto 0);
--        sortie3: out std_logic_vector(6 downto 0); 
--        sortie4 : out std_logic_vector(6 downto 0));
end component;

component mux_8 is
    Port ( 
           sortie_mod_8 : in STD_LOGIC; --commande
--           nb_pommes : in STD_LOGIC_VECTOR (6 downto 0);
           uni : in STD_LOGIC_VECTOR (6 downto 0);
           diz : in STD_LOGIC_VECTOR (6 downto 0);
--           cent : in STD_LOGIC_VECTOR (6 downto 0);
--           s_1 : in STD_LOGIC_VECTOR (6 downto 0);
--           s_2 : in STD_LOGIC_VECTOR (6 downto 0);
--           s_3 : in STD_LOGIC_VECTOR (6 downto 0);
--           s_4 : in STD_LOGIC_VECTOR (6 downto 0);
           sept_seg : out STD_LOGIC_VECTOR (6 downto 0));
--           DP : out STD_LOGIC);
end component;


component move_snake
    Port (  clock : in STD_LOGIC;
        reset : in std_logic; 
        up,down,left,right,centre : in STD_LOGIC;
        compteur : in std_logic_vector(6 downto 0);
        x_s_i, y_s_i: in std_logic_vector(9 downto 0);
        x_s, y_s: out std_logic_vector(9 downto 0));
           
end component;

component generate_apple is 
    Port ( clock : in STD_LOGIC;
       reset : in STD_LOGIC;
       enable : in STD_LOGIC;
       x_a : out STD_LOGIC_VECTOR (9 downto 0);
       y_a : out STD_LOGIC_VECTOR (9 downto 0));
   end component;
   

    
   
component vgatest 
  port(clock       : in std_logic;
     x_s, y_s : in std_logic_vector(9 downto 0); -- snake
     x_a, y_a : in std_logic_vector(9 downto 0); -- apple
     x_p, y_p : in std_logic_vector(9 downto 0); -- poison
     H,V : out  std_logic;
     tabx: in tailx ;
     taby: in taily;
     play_pause : in std_logic;
     cpt : in std_logic_vector( 6 downto 0);
     init,lost : in std_logic;
     R, G, B : out std_logic_vector(3 downto 0));
end component;

component tail 
    Port ( clock : in STD_LOGIC;
--           reset : in STD_LOGIC;
           x_s,y_s : in Std_logic_vector (9 downto 0);
           play_pause : in std_logic;
           compteur : in std_logic_vector ( 6 downto 0);
           contact_snake: out std_logic;
          tableaux : out tailx;
          taba: out taily);
end component;

component contact_snake_apple
    Port ( x_s : in STD_LOGIC_VECTOR (9 downto 0);
           x_a : in STD_LOGIC_VECTOR (9 downto 0);
           clock : in std_logic;
           reset : in std_logic;
           y_s : in STD_LOGIC_VECTOR (9 downto 0);
           y_a : in STD_LOGIC_VECTOR (9 downto 0);
           cpt : out STD_LOGIC_VECTOR (6 downto 0); -- cpt du nombre de pommes
           enable_generate : out STD_LOGIC);
end component;

component generate_poison 
    Port ( clock : in STD_LOGIC;
       reset : in STD_LOGIC;
       b_c : in std_logic;
       x_p : out STD_LOGIC_VECTOR (9 downto 0);
       y_p : out STD_LOGIC_VECTOR (9 downto 0));
end component;

component PmodJSTK 
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           sndRec : in  STD_LOGIC;
           DIN : in  STD_LOGIC_VECTOR (7 downto 0);
           MISO : in  STD_LOGIC;
           SS : out  STD_LOGIC;
           SCLK : out  STD_LOGIC;
           MOSI : out  STD_LOGIC;
           DOUT : inout  STD_LOGIC_VECTOR (39 downto 0));
end component;

--component synch_boutons_from_jstk 
--    Port ( clock : in STD_LOGIC;
--           jstk_x : in STD_LOGIC_VECTOR (9 downto 0);
--           jstk_y : in STD_LOGIC_VECTOR (9 downto 0);
--          l_centre : in std_logic;
--           output_up : out STD_LOGIC;
--           output_down : out STD_LOGIC;
--           output_left : out STD_LOGIC;
--           output_right : out STD_LOGIC;
--           output_centre : out STD_LOGIC);
--end component;
component synch_boutons_from_jstk 
  Port ( clock : in STD_LOGIC;
         jstk_x : in STD_LOGIC_VECTOR (9 downto 0);
         jstk_y : in STD_LOGIC_VECTOR (9 downto 0);
         --l_centre : in std_logic;
--           output_up : out STD_LOGIC;               
--           output_down : out STD_LOGIC; 
         l_up : out STD_LOGIC;
--           output_left : out STD_LOGIC; 
          l_down : out STD_LOGIC;
--           output_right : out STD_LOGIC;
         l_left : out STD_LOGIC;
--           output_centre : out STD_LOGIC);
         l_right : out STD_LOGIC);
  end component;
component type_mov 
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
end component;

component contact_s_wall 
    Port ( x_s : in STD_LOGIC_VECTOR (9 downto 0);
          -- x_p : in STD_LOGIC_VECTOR (9 downto 0);
           --y_p : in STD_LOGIC_VECTOR (9 downto 0);
           y_s : in STD_LOGIC_VECTOR (9 downto 0);
           contact_wall : out STD_LOGIC);
end component;

begin

inst1: Audio 
    Port map ( clock =>clock,
           reset =>reset,
           enable_generate =>enable_generate,
           init =>init,
           odata =>odata,
           sd =>sd);

            
--inst1: component synch_boutons
--    Port map ( bouton_up => bouton_up,
--               bouton_down => bouton_down,
--               bouton_left => bouton_left,
--               bouton_right => bouton_right,
--               bouton_centre => bouton_centre,
--               clock => clock,
--               output_up => b_up1,
--               output_down=> b_down1,
--               output_left => b_left1,
--               output_centre => b_centre1,
--               output_right => b_right1);
           


inst2: component move_snake
    Port map ( clock => clock,
               reset => reset,
               up => b_up,
               down => b_down,
               left => b_left,
               compteur => cpt,
               right => b_right,
               centre => play_pause,
               x_s_i => x_s,
               y_s_i => y_s,
               x_s => x_s,
               y_s => y_s);

inst3: component vgatest 
    port map ( clock  => clock,
               x_s => x_s,
               y_s => y_s,
               x_a => x_a,
               y_a => y_a, 
               x_p => x_p,
               y_p => y_p,
               cpt => cpt,
               init => init,
               tabx  =>tableaux,
               taby => tableauy,
               lost => lost,
               play_pause => play_pause,           
               H => H,
               V => V,  
               R => R, 
               G => G, 
               B  => B);
               

     
        
inst4: component generate_apple 
    port map ( enable => enable_generate,
                clock  => clock,
                reset =>reset,
                x_a => x_a,
                y_a => y_a);

                
inst5: component contact_snake_apple 
     Port map ( x_s =>x_s,
                x_a =>x_a,
                y_s =>y_s,
                reset => reset,
                y_a =>y_a,
                clock =>clock,
                cpt => cpt,
                enable_generate =>enable_generate);
                
inst6: component mux_8 
       Port Map ( sortie_mod_8 => sortie_mod,
--              nb_pommes => s_pommes,
              uni =>s_uni,
              diz =>s_diz,
--              cent =>s_cent,
--              s_1  =>sortie1,
--              s_2 =>sortie2,
--              s_3 =>sortie3,
--              s_4 =>sortie4,
              sept_seg => sept_seg);
--              DP => DP  );

inst7: component transcodeur 
       Port map (  
--                     sortie_compteur =>score,
                   nb_pommes => cpt,
--                   s_cent => s_cent,
                   s_diz =>s_diz,
                   s_uni =>s_uni);
--                   s_pommes =>s_pommes,
--                   sortie1 =>sortie1,
--                   sortie2 =>sortie2,
--                   sortie3 => sortie3,
--                   sortie4 => sortie4  );
                   
inst8: component mod8 
       Port map ( clock => clock ,
                  reset => reset, 
                  AN => AN,
                  sortie_mod =>sortie_mod    );
                  
--inst9: component compteur_decompteur 
--       Port map (clock => clock ,
--                 reset => reset,
--                 generate_score => enable_score,
--                  score_time : in std_logic_vector( 4 downto 0);
--                 nb_pommes => nb_pommes,
--                 score =>score );
                 
inst10: component generate_poison 
        Port map ( clock => clock,
                   reset => reset,
                   x_p => x_p,
                   y_p => y_p,
                   b_c => play_pause);
                   
inst11: component FSM
    Port map ( clock =>clock,
       reset =>reset,
       b_c =>b_centre,
       b_up=> b_up,
       b_down =>b_up,
       b_left =>b_left,
       b_right =>b_right,
       contact_snake =>contact_snake,-- a definir ce bloc
       contact_poison =>contact_poison or contact_wall, -- a definir ce bloc
       init => init ,
       play_pause =>play_pause,
       lost => lost);
       
inst12: component   contact_snake_poison 
           Port map  ( x_s => x_s,
                       x_p => x_p,
                       y_p => y_p,
                       y_s => y_s,
                       contact_poison=>contact_poison);
                       
inst13: component tail 
        Port map ( clock => clock,
                   contact_snake =>contact_snake,
                   compteur => cpt,
      --           reset : in STD_LOGIC;
                   x_s => x_s,
                   y_s => y_s,
                   play_pause => play_pause,
                   tableaux  =>tableaux,
                   taba => tableauy);
                 
                 
inst14: component PmodJSTK 
        Port map( CLK => clock,
                  RST => reset ,
                  sndRec => sndRec,
                  DIN => "10000000",
                  MISO => MISO,
                  SS => SS,
                  SCLK => SCLK,
                  MOSI => MOSI,
                  DOUT => dout );
                  
inst15: component  synch_boutons_from_jstk 
        Port map ( clock => clock,
                   jstk_x => jstk_x,
                   jstk_y => jstk_y,
--                   l_centre => bouton_centre,
                   l_up => b_up0,
                   l_down => b_down0,
                   l_left => b_left0,
                   l_right => b_right0);
--                   output_centre => b_centre0);
                   
inst16: ClkDiv_5Hz 
        Port map ( CLK => clock,               -- 100MHz onboard clock
                   RST => reset,                -- Reset
                   CLKOUT => sndRec);        -- New clock output
inst17:  type_mov
                       Port map ( clock => clock,
                              r_joy => b_right0,
                              r_bot => bouton_right,
                              l_joy => b_left0,
                              l_bot => bouton_left,
--                              c_joy => b_centre0,
                              c_bot => bouton_centre,
                              up_joy => b_up0,
                              up_bot => bouton_up,
                              down_joy => b_down0,
                              down_bot => bouton_down,
                              output_up => b_up,
                              output_down => b_down,
                              output_left => b_left,
                              output_right=> b_right,
                              output_centre=> b_centre);
inst18: contact_s_wall 
                                  Port map ( x_s => x_s,
                                        -- x_p : in STD_LOGIC_VECTOR (9 downto 0);
                                         --y_p : in STD_LOGIC_VECTOR (9 downto 0);
                                         y_s => y_s,
                                         contact_wall=>contact_wall);
                              
                   
       
            
jstk_y <= DOUT( 25 downto 24)& DOUT( 39 downto 32);  
jstk_x <= DOUT( 9 downto 8)& DOUT( 23 downto 16);                
 
           
   

        
--process(SW,x_a,y_a)
--begin
--    if SW='1' then 
--        LED <= x_a;
--    else
--        LED <= y_a;
--    end if;
--end process;
LED(0)<=bouton_up;
LED(1)<=bouton_down;
LED(2)<=bouton_left;
LED(3)<=bouton_right;
LED(4)<=bouton_centre;
LED(5)<=b_up0;
LED(6)<=b_down0;
LED(7)<=b_left0;
LED(8)<=b_right0;
LED(9)<=b_up;
LED(10)<=b_down;
LED(11)<=b_left;
LED(12)<=b_right;
LED(13)<=b_centre;
--process(SW1)
--begin 
--    if SW1='1' then 
--    b_up <= b_up0;
--    b_down <= b_down0;
--    b_left <= b_left0;
--    b_right <= b_right0;
--    b_centre <= b_centre0;
--else
--     b_up <= b_up1;
--     b_down <= b_down1;
--     b_left <= b_left1;
--     b_right <= b_right1;
--     b_centre <= b_centre1;
--end if;
--end process;

 -- TO DO FIX THE RIGHT AND LEFT THINGY 
 -- Look for MIDI 
 
--    b_up <= b_up0 or b_up1;
--    b_down <= b_down0 or b_down1 ;
--    b_left <= b_left0 or b_left1;
--    b_right <= b_right0 or b_right1;
--    b_centre <= b_centre0 or b_centre1;
end Behavioral;
