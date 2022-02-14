----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 04.11.2020 23:43:13
-- Design Name:
-- Module Name: vga - Behavioral
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
use work.fichier.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Library IEEE;
--use IEEE.STD_Logic_1164.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.ALL;


entity vgatest is
  port(clock       : in std_logic;
       x_s, y_s : in std_logic_vector(9 downto 0); -- snake
       x_a, y_a : in std_logic_vector(9 downto 0); -- apple
       x_p, y_p : in std_logic_vector(9 downto 0); -- poison
       play_pause : in std_logic;
       tabx: in tailx ;
       taby: in taily;
       H,V : out  std_logic;
       cpt : in std_logic_vector(6 downto 0);
       init,lost : in std_logic;
       R, G, B : out std_logic_vector(3 downto 0));
end entity;

architecture test of vgatest is


  component vgadrive is
    port( clock          : in std_logic;  -- 25.175 Mhz clock
          red, green, blue : in std_logic_vector( 3 downto 0);  -- input values for RGB signals
          Rout, Gout, Bout : out std_logic_vector( 3 downto 0);
          row, column      : out std_logic_vector(9 downto 0); -- for current pixel
          H, V : out std_logic); -- VGA drive signals
  end component;
 
  component clock_generator  is
  port ( clock : in STD_LOGIC;
         sig1 : out STD_LOGIC);
  end component;
 
 
 
  signal row, column : std_logic_vector(9 downto 0);
  signal red, green, blue : std_logic_vector( 3 downto 0);
  signal cmpt : integer :=0;
  signal h_aff : std_logic;
--  signal clock_25m : std_logic;
  signal clock_1 : std_logic;
 
 begin
  -- for debugging: to view the bit order
  VGA : component vgadrive
        port map ( clock => clock_1, red => red, green => green, blue => blue,
                   row => row, column => column,
                   Rout => R, Gout => G, Bout => B, H => H, V => V);
 
 clocks: component clock_generator
        port map ( clock => clock,
                   sig1 => clock_1);
                   

 
 
  RGB : process(row, column ,x_s,y_s,x_p,y_p,x_a,y_a, init,lost,cpt, tabx,taby)
  begin
    if  ((row >= 366 and row <= 450 and column >= 90 and column <= 190) or
        (row >= 30 and row <= 366  and column >= 90 and column <= 124) or
       
        (row >= 30 and row <= 114  and column >= 210 and column <= 310) or
        (row >= 366 and row <= 450 and column >= 210 and column <= 310) or
        (row >= 114 and row <= 366 and column >= 210 and column <= 243) or
        (row >= 114 and row <= 366 and column >= 277 and column <= 310) or
       
        (row >= 30 and row <= 114 and column >= 330 and column <= 430 )or
        (row >= 198 and row <= 282 and column >= 330 and column <= 430) or
        (row >= 366 and row <= 450 and column >= 330 and column <= 430) or
        (row >= 114 and row <= 198 and column >= 330 and column <= 355) or
        (row >= 282 and row <= 366 and column >= 405 and column <= 430) or
       
         (row >= 30 and row <= 114 and column >= 450 and column <= 550) or
        (row >= 114 and row <= 450 and column >= 483 and column <= 517)) and (lost ='1' ) then
       
         blue <= "0000";
         green <= "0000";
         red <= "1111";
    -- to generate the square that is supposed to be the snake
    elsif  ((row >= 100 and row <= 156 and column >= 40 and column <= 136) or
            (row >= 212 and row <= 268  and column >= 40 and column <= 136) or
            (row >= 324 and row <= 380  and column >= 40 and column <= 136) or
            (row >= 156 and row <= 212  and column >= 40 and column <= 64) or
            (row >= 268 and row <= 324  and column >= 112 and column <= 136) or
           
            (row >= 100 and row <= 156  and column >= 156 and column <= 252) or
            (row >= 156 and row <= 380 and column >= 188 and column <= 220) or
           
           
            (row >= 100 and row <= 380 and column >= 272 and column <= 304 )or
            (row >= 100 and row <= 380 and column >= 336 and column <= 368) or
            (row >= 100 and row <= 156 and column >= 304 and column <= 336) or
            (row >= 212 and row <= 268 and column >= 304 and column <= 336) or
           
            (row >= 100 and row <= 380  and column >= 388 and column <= 420) or
            (row >= 100 and row <= 156 and column >= 420 and column <= 484) or
            (row >= 156 and row <= 268 and column >= 452 and column <= 484 )or
            (row >= 212 and row <= 268 and column >= 420 and column <= 484) or
            (row >= 296 and row <= 324 and column >= 420 and column <= 452) or
            (row >= 296 and row <= 380 and column >= 452 and column <= 484) or
           
           
            (row >= 100 and row <= 156 and column >= 504 and column <= 600) or
            (row >= 156 and row <= 380 and column >= 536 and column <= 568)) and (init ='1' ) then
           
        blue <= "1111";
        green <= "1111";
        red <= "1111";
 elsif  ((row >= x_s and row <= x_s+10 and column >= y_s and column <= y_s+10 ) or
                   (row > tabx(0) and row < tabx(0)+10 and column >taby(0) and column < taby(0)+10 and cpt >0 ) or
                   (row > tabx(1) and row < tabx(1)+10 and column >taby(1) and column < taby(1)+10 and cpt >1 ) or
                   (row > tabx(2) and row < tabx(2)+10 and column >taby(2) and column < taby(2)+10 and cpt >2 ) or
                   (row > tabx(3) and row < tabx(3)+10 and column >taby(3) and column < taby(3)+10 and cpt >3 ) or
                   (row > tabx(4) and row < tabx(4)+10 and column >taby(4) and column < taby(4)+10 and cpt >4 ) or
                   (row > tabx(5) and row < tabx(5)+10 and column >taby(5) and column < taby(5)+10 and cpt >5 ) or
                   (row > tabx(6) and row < tabx(6)+10 and column >taby(6) and column < taby(6)+10 and cpt >6 ) or
                   (row > tabx(7) and row < tabx(7)+10 and column >taby(7) and column < taby(7)+10 and cpt >7 ) or
                   (row > tabx(8) and row < tabx(8)+10 and column >taby(8) and column < taby(8)+10 and cpt >8 ) or
                   (row > tabx(9) and row < tabx(9)+10 and column >taby(9) and column < taby(9)+10 and cpt >9 ) or
                   (row > tabx(10) and row < tabx(10)+10 and column >taby(10) and column < taby(10)+10 and cpt >10 ) or
                   (row > tabx(11) and row < tabx(11)+10 and column >taby(11) and column < taby(11)+10 and cpt >11 ) or
                   (row > tabx(12) and row < tabx(12)+10 and column >taby(12) and column < taby(12)+10 and cpt >12 ) or
                   (row > tabx(13) and row < tabx(13)+10 and column >taby(13) and column < taby(13)+10 and cpt >13 ) or
                   (row > tabx(14) and row < tabx(14)+10 and column >taby(14) and column < taby(14)+10 and cpt >14 ) or
                   (row > tabx(15) and row < tabx(15)+10 and column >taby(15) and column < taby(15)+10 and cpt >15 ) or
                   (row > tabx(16) and row < tabx(16)+10 and column >taby(16) and column < taby(16)+10 and cpt >16 ) or
                   (row > tabx(17) and row < tabx(17)+10 and column >taby(17) and column < taby(17)+10 and cpt >17 ) or
                   (row > tabx(18) and row < tabx(18)+10 and column >taby(18) and column < taby(18)+10 and cpt >18 ) or
                   (row > tabx(19) and row < tabx(19)+10 and column >taby(19) and column < taby(19)+10 and cpt > 19) or
                   (row > tabx(20) and row < tabx(20)+10 and column >taby(20) and column < taby(20)+10 and cpt >20 ) or
                   
                   (row > tabx(21) and row < tabx(21)+10 and column >taby(21) and column < taby(21)+10 and cpt >21 ) or
                   (row > tabx(22) and row < tabx(22)+10 and column >taby(22) and column < taby(22)+10 and cpt >22 ) or
                   (row > tabx(23) and row < tabx(23)+10 and column >taby(23) and column < taby(23)+10 and cpt >23 ) or
                   (row > tabx(24) and row < tabx(24)+10 and column >taby(24) and column < taby(24)+10 and cpt >24 ) or
                   (row > tabx(25) and row < tabx(25)+10 and column >taby(25) and column < taby(25)+10 and cpt >25 ) or
                   (row > tabx(26) and row < tabx(26)+10 and column >taby(26) and column < taby(26)+10 and cpt >26 ) or
                   (row > tabx(27) and row < tabx(27)+10 and column >taby(27) and column < taby(27)+10 and cpt >27 ) or
                   (row > tabx(28) and row < tabx(28)+10 and column >taby(28) and column < taby(28)+10 and cpt >28 ) or
                   (row > tabx(29) and row < tabx(29)+10 and column >taby(29) and column < taby(29)+10 and cpt > 29) or
                   (row > tabx(30) and row < tabx(30)+10 and column >taby(30) and column < taby(30)+10 and cpt >30 ) or
                   
                   (row > tabx(31) and row < tabx(31)+10 and column >taby(31) and column < taby(31)+10 and cpt >31 ) or
                   (row > tabx(32) and row < tabx(32)+10 and column >taby(32) and column < taby(32)+10 and cpt >32 ) or
                   (row > tabx(33) and row < tabx(33)+10 and column >taby(33) and column < taby(33)+10 and cpt >33 ) or
                   (row > tabx(34) and row < tabx(34)+10 and column >taby(34) and column < taby(34)+10 and cpt >34 ) or
                   (row > tabx(35) and row < tabx(35)+10 and column >taby(35) and column < taby(35)+10 and cpt >35 ) or
                   (row > tabx(36) and row < tabx(36)+10 and column >taby(36) and column < taby(36)+10 and cpt >36 ) or
                   (row > tabx(37) and row < tabx(37)+10 and column >taby(37) and column < taby(37)+10 and cpt >37 ) or
                   (row > tabx(38) and row < tabx(38)+10 and column >taby(38) and column < taby(38)+10 and cpt >38 ) or
                   (row > tabx(39) and row < tabx(39)+10 and column >taby(39) and column < taby(39)+10 and cpt >39) or
                   (row > tabx(40) and row < tabx(40)+10 and column >taby(40) and column < taby(40)+10 and cpt >40 ) or
                   
                   (row > tabx(41) and row < tabx(41)+10 and column >taby(41) and column < taby(41)+10 and cpt >41 ) or
                   (row > tabx(42) and row < tabx(42)+10 and column >taby(42) and column < taby(42)+10 and cpt >42 ) or
                   (row > tabx(43) and row < tabx(43)+10 and column >taby(43) and column < taby(43)+10 and cpt >43 ) or
                   (row > tabx(44) and row < tabx(44)+10 and column >taby(44) and column < taby(44)+10 and cpt >44 ) or
                   (row > tabx(45) and row < tabx(45)+10 and column >taby(45) and column < taby(45)+10 and cpt >45 ) or
                   (row > tabx(46) and row < tabx(46)+10 and column >taby(46) and column < taby(46)+10 and cpt >46 ) or
                   (row > tabx(47) and row < tabx(47)+10 and column >taby(47) and column < taby(47)+10 and cpt >47 ) or
                   (row > tabx(48) and row < tabx(48)+10 and column >taby(48) and column < taby(48)+10 and cpt >48 ) or
                   (row > tabx(49) and row < tabx(49)+10 and column >taby(49) and column < taby(49)+10 and cpt >49) or
                   (row > tabx(50) and row < tabx(50)+10 and column >taby(50) and column < taby(50)+10 and cpt >50 ) or
                   
                   (row > tabx(51) and row < tabx(51)+10 and column >taby(51) and column < taby(51)+10 and cpt >51 ) or
                   (row > tabx(52) and row < tabx(52)+10 and column >taby(52) and column < taby(52)+10 and cpt >52 ) or
                   (row > tabx(53) and row < tabx(53)+10 and column >taby(53) and column < taby(53)+10 and cpt >53 ) or
                   (row > tabx(54) and row < tabx(54)+10 and column >taby(54) and column < taby(54)+10 and cpt >54 ) or
                   (row > tabx(55) and row < tabx(55)+10 and column >taby(55) and column < taby(55)+10 and cpt >55 ) or
                   (row > tabx(56) and row < tabx(56)+10 and column >taby(56) and column < taby(56)+10 and cpt >56 ) or
                   (row > tabx(57) and row < tabx(57)+10 and column >taby(57) and column < taby(57)+10 and cpt >57 ) or
                   (row > tabx(58) and row < tabx(58)+10 and column >taby(58) and column < taby(58)+10 and cpt >58 ) or
                   (row > tabx(59) and row < tabx(59)+10 and column >taby(59) and column < taby(59)+10 and cpt >59) or
                   (row > tabx(60) and row < tabx(60)+10 and column >taby(60) and column < taby(60)+10 and cpt >60 ) or
                   
                   (row > tabx(61) and row < tabx(61)+10 and column >taby(61) and column < taby(61)+10 and cpt >61 ) or
                   (row > tabx(62) and row < tabx(62)+10 and column >taby(62) and column < taby(62)+10 and cpt >62 ) or
                   (row > tabx(63) and row < tabx(63)+10 and column >taby(63) and column < taby(63)+10 and cpt >63 ) or
                   (row > tabx(64) and row < tabx(64)+10 and column >taby(64) and column < taby(64)+10 and cpt >64 ) or
                   (row > tabx(65) and row < tabx(65)+10 and column >taby(65) and column < taby(65)+10 and cpt >65 ) or
                   (row > tabx(66) and row < tabx(66)+10 and column >taby(66) and column < taby(66)+10 and cpt >66 ) or
                   (row > tabx(67) and row < tabx(67)+10 and column >taby(67) and column < taby(67)+10 and cpt >67 ) or
                   (row > tabx(68) and row < tabx(68)+10 and column >taby(68) and column < taby(68)+10 and cpt >68 ) or
                   (row > tabx(69) and row < tabx(69)+10 and column >taby(69) and column < taby(69)+10 and cpt >69) or
                   (row > tabx(70) and row < tabx(70)+10 and column >taby(60) and column < taby(70)+10 and cpt >70 ) or
                   
                   (row > tabx(71) and row < tabx(71)+10 and column >taby(71) and column < taby(71)+10 and cpt >71 ) or
                   (row > tabx(72) and row < tabx(72)+10 and column >taby(72) and column < taby(72)+10 and cpt >72 ) or
                   (row > tabx(73) and row < tabx(73)+10 and column >taby(73) and column < taby(73)+10 and cpt >73 ) or
                   (row > tabx(74) and row < tabx(74)+10 and column >taby(74) and column < taby(74)+10 and cpt >74 ) or
                   (row > tabx(75) and row < tabx(75)+10 and column >taby(75) and column < taby(75)+10 and cpt >75 ) or
                   (row > tabx(76) and row < tabx(76)+10 and column >taby(76) and column < taby(76)+10 and cpt >76 ) or
                   (row > tabx(77) and row < tabx(77)+10 and column >taby(77) and column < taby(77)+10 and cpt >77 ) or
                   (row > tabx(78) and row < tabx(78)+10 and column >taby(78) and column < taby(78)+10 and cpt >78 ) or
                   (row > tabx(79) and row < tabx(79)+10 and column >taby(79) and column < taby(79)+10 and cpt >79) or
                   (row > tabx(80) and row < tabx(80)+10 and column >taby(80) and column < taby(80)+10 and cpt >80 ) or
                   
                   (row > tabx(81) and row < tabx(81)+10 and column >taby(81) and column < taby(81)+10 and cpt >81 ) or
                   (row > tabx(82) and row < tabx(82)+10 and column >taby(82) and column < taby(82)+10 and cpt >82 ) or
                   (row > tabx(83) and row < tabx(83)+10 and column >taby(83) and column < taby(83)+10 and cpt >83 ) or
                   (row > tabx(84) and row < tabx(84)+10 and column >taby(84) and column < taby(84)+10 and cpt >84 ) or
                   (row > tabx(85) and row < tabx(85)+10 and column >taby(85) and column < taby(85)+10 and cpt >85 ) or
                   (row > tabx(86) and row < tabx(86)+10 and column >taby(86) and column < taby(86)+10 and cpt >86 ) or
                   (row > tabx(87) and row < tabx(87)+10 and column >taby(87) and column < taby(87)+10 and cpt >87 ) or
                   (row > tabx(88) and row < tabx(88)+10 and column >taby(88) and column < taby(88)+10 and cpt >88 ) or
                   (row > tabx(89) and row < tabx(89)+10 and column >taby(89) and column < taby(89)+10 and cpt >89) or
                   (row > tabx(90) and row < tabx(90)+10 and column >taby(90) and column < taby(90)+10 and cpt >90 ) or
                   
                   (row > tabx(91) and row < tabx(91)+10 and column >taby(91) and column < taby(91)+10 and cpt >91 ) or
                   (row > tabx(92) and row < tabx(92)+10 and column >taby(92) and column < taby(92)+10 and cpt >92 ) or
                   (row > tabx(93) and row < tabx(93)+10 and column >taby(93) and column < taby(93)+10 and cpt >93 ) or
                   (row > tabx(94) and row < tabx(94)+10 and column >taby(94) and column < taby(94)+10 and cpt >94 ) or
                   (row > tabx(95) and row < tabx(95)+10 and column >taby(95) and column < taby(95)+10 and cpt >95 ) or
                   (row > tabx(96) and row < tabx(96)+10 and column >taby(96) and column < taby(96)+10 and cpt >96 ) or
                   (row > tabx(97) and row < tabx(97)+10 and column >taby(97) and column < taby(97)+10 and cpt >97 ) or
                   (row > tabx(98) and row < tabx(98)+10 and column >taby(98) and column < taby(98)+10 and cpt >98 ) or
                   (row > tabx(99) and row < tabx(99)+10 and column >taby(99) and column < taby(99)+10 and cpt >99) or
                   (row > tabx(100) and row < tabx(100)+10 and column >taby(100) and column < taby(100)+10 and cpt >100 ))


           and lost='0' and init ='0'  then
           
        blue <= "0000";
        green <= "1111";
        red <= "0000";
    elsif  row >= x_a and row <= x_a+10 and column >= y_a and column <= y_a+10 and lost='0' and init ='0' then
        blue <= "0000";
        green <= "0000";
        red <= "1111";
           
    elsif  row >= x_p and row <= x_p+10 and column >= y_p and column <= y_p+10 and lost='0' and init ='0' then
        blue <= "1111";
        green <= "0000";
        red <= "1111";
     elsif  row >= 0 and row <= 20 and column >0 and column <= 640 and lost='0' and init ='0' then 
             blue <= "1111";
            green <= "1111";
            red <= "1111";  
     elsif  row >= 0 and row <= 480 and column >0 and column <= 20 and lost='0' and init ='0' then 
                    blue <= "1111";
                   green <= "1111";
                   red <= "1111"; 
     elsif  row >= 460 and row <= 480 and column >0 and column <= 640 and lost='0' and init ='0' then 
            blue <= "1111";
            green <= "1111";
            red <= "1111";
     elsif  row >= 0 and row <= 480 and column >620 and column <= 640 and lost='0' and init ='0' then 
                           blue <= "1111";
                          green <= "1111";
                          red <= "1111"; 
    else
        blue <= "0000";
        green <= "0000";
        red <= "0000";      
    end if;
 
  end process;


end architecture;