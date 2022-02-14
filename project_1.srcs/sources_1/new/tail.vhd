---------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 07.11.2020 11:42:18
-- Design Name:
-- Module Name: tail - Behavioral
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
---------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
use work.fichier.all;
entity tail is
   Port ( clock : in STD_LOGIC;
--           reset : in STD_LOGIC;
          x_s,y_s : in Std_logic_vector (9 downto 0);  
          compteur : in std_logic_vector ( 6 downto 0);
         tableaux : out tailx;
         taba : out taily;
         contact_snake : out std_logic;
         play_pause : in std_logic);
end tail;

architecture Behavioral of tail is
TYPE vitesse IS ARRAY (0 TO 9) OF integer;
signal mok : vitesse := ( 2*10**7,1*10**7, 9*10**6,8*10**6, 7*10**6,6*10**6, 5*10**6,4*10**6, 3*10**6,2*10**6);
signal cmpt : integer :=0;
signal cpt : integer :=0;
signal h_aff : std_logic;
signal cmpte : integer :=0;
signal h : std_logic;
signal x,y : integer :=0;
signal vite : integer :=2*10**7;
SIGNAL tabx : tailx := ( 0 , 0 , 0 , 0 , 0  , 0 , 0 ,0 , 0 , 0 , 0 , 0 , 0 ,  0, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0,0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,  0, 0 , 0 , 0 , 0 , 0 , 0 , 0,0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,  0, 0 , 0 , 0 , 0 , 0 , 0 , 0,0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,  0, 0 , 0 , 0 , 0 , 0 , 0 , 0,0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,  0, 0 , 0 , 0 , 0 , 0 , 0 );
SIGNAL taby : taily := ( 0 , 0 , 0 , 0 , 0  , 0 , 0 ,0 , 0 , 0 , 0 , 0 , 0 ,  0, 0 , 0 , 0 , 0 , 0 , 0 , 0 ,0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,  0, 0 , 0 , 0 , 0 , 0 , 0 , 0,0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,  0, 0 , 0 , 0 , 0 , 0 , 0 , 0,0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,  0, 0 , 0 , 0 , 0 , 0 , 0 , 0,0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,  0, 0 , 0 , 0 , 0 , 0 , 0 , 0);

begin

x<=to_integer(unsigned(x_s));
y<=to_integer(unsigned(y_s));
cpt<=to_integer(unsigned(compteur));


-- TO DO FIX THE CASE WHEN THE SNAKE IS HOING UP OR GOING LEFT
-- LOST IS WRITTEN

--To do : find a way to detect the snake contact
--process (clock)
--   begin
--     if rising_edge(clock) then
--       if cmpte = 2*10**6 -1 then
--        if cmpt = 10000 then
--             cmpte <= 0;
--             h <= '1';
--        else
--              cmpte <= cmpte + 1;
--              h <= '0';
--        end if;
--      end if;
--end process;

process( clock,x,tabx,y,taby,cpt)
begin
       if (  ( x<= tabx(3)  and x>= tabx(4)  and y<=taby(3)  and y>=taby(4)  and cpt>4)  or
             ( x<= tabx(4)  and x>= tabx(5)  and y<=taby(4)  and y>=taby(5)  and cpt>5)  or  
             ( x<= tabx(5)  and x>= tabx(6)  and y<=taby(5)  and y>=taby(6)  and cpt>6)  or
             ( x<= tabx(6)  and x>= tabx(7)  and y<=taby(6)  and y>=taby(7)  and cpt>7)  or
             ( x<= tabx(7)  and x>= tabx(8)  and y<=taby(7)  and y>=taby(8)  and cpt>8)  or
             ( x<= tabx(8)  and x>= tabx(9)  and y<=taby(8)  and y>=taby(9)  and cpt>9)  or
             ( x<= tabx(9) and x>= tabx(10)  and y<=taby(9) and y>=taby(10)  and cpt>10) or
             
             ( x<= tabx(10) and x>= tabx(11) and y<=taby(10) and y>=taby(11) and cpt>11) or
             ( x<= tabx(11) and x>= tabx(12) and y<=taby(11) and y>=taby(12) and cpt>12) or
             ( x<= tabx(12) and x>= tabx(13) and y<=taby(12) and y>=taby(13) and cpt>13) or
             ( x<= tabx(13) and x>= tabx(14) and y<=taby(13) and y>=taby(14) and cpt>14) or
             ( x<= tabx(14) and x>= tabx(15) and y<=taby(14) and y>=taby(15) and cpt>15) or
             ( x<= tabx(15) and x>= tabx(16) and y<=taby(15) and y>=taby(16) and cpt>16) or
             ( x<= tabx(16) and x>= tabx(17) and y<=taby(16) and y>=taby(17) and cpt>17) or
             ( x<= tabx(17) and x>= tabx(18) and y<=taby(17) and y>=taby(18) and cpt>18) or
             ( x<= tabx(18) and x>= tabx(19) and y<=taby(18) and y>=taby(19) and cpt>19) or
             ( x<= tabx(19) and x>= tabx(20) and y<=taby(19) and y>=taby(20) and cpt>20) or
             
             ( x<= tabx(20) and x>= tabx(21) and y<=taby(20) and y>=taby(21) and cpt>21) or
             ( x<= tabx(21) and x>= tabx(22) and y<=taby(21) and y>=taby(22) and cpt>22) or
             ( x<= tabx(22) and x>= tabx(23) and y<=taby(22) and y>=taby(23) and cpt>23) or
             ( x<= tabx(23) and x>= tabx(24) and y<=taby(23) and y>=taby(24) and cpt>24) or
             ( x<= tabx(24) and x>= tabx(25) and y<=taby(24) and y>=taby(25) and cpt>25) or
             ( x<= tabx(25) and x>= tabx(26) and y<=taby(25) and y>=taby(26) and cpt>26) or
             ( x<= tabx(26) and x>= tabx(27) and y<=taby(26) and y>=taby(27) and cpt>27) or
             ( x<= tabx(27) and x>= tabx(28) and y<=taby(27) and y>=taby(28) and cpt>28) or
             ( x<= tabx(28) and x>= tabx(29) and y<=taby(28) and y>=taby(29) and cpt>29) or     
             ( x<= tabx(29) and x>= tabx(30) and y<=taby(29) and y>=taby(30) and cpt>30) or
             
             ( x<= tabx(30) and x>= tabx(31) and y<=taby(30) and y>=taby(31) and cpt>31) or
             ( x<= tabx(31) and x>= tabx(32) and y<=taby(31) and y>=taby(32) and cpt>32) or
             ( x<= tabx(32) and x>= tabx(33) and y<=taby(32) and y>=taby(33) and cpt>33) or
             ( x<= tabx(33) and x>= tabx(34) and y<=taby(33) and y>=taby(34) and cpt>34) or
             ( x<= tabx(34) and x>= tabx(35) and y<=taby(34) and y>=taby(35) and cpt>35) or
             ( x<= tabx(35) and x>= tabx(36) and y<=taby(35) and y>=taby(36) and cpt>36) or
             ( x<= tabx(36) and x>= tabx(37) and y<=taby(36) and y>=taby(37) and cpt>37) or
             ( x<= tabx(37) and x>= tabx(38) and y<=taby(37) and y>=taby(38) and cpt>38) or
             ( x<= tabx(38) and x>= tabx(39) and y<=taby(38) and y>=taby(39) and cpt>39) or
             ( x<= tabx(39) and x>= tabx(40) and y<=taby(39) and y>=taby(40) and cpt>40) or
             
             ( x<= tabx(40) and x>= tabx(41) and y<=taby(40) and y>=taby(41) and cpt>41) or
             ( x<= tabx(41) and x>= tabx(42) and y<=taby(41) and y>=taby(42) and cpt>42) or
             ( x<= tabx(42) and x>= tabx(43) and y<=taby(42) and y>=taby(43) and cpt>43) or
             ( x<= tabx(43) and x>= tabx(44) and y<=taby(43) and y>=taby(44) and cpt>44) or
             ( x<= tabx(44) and x>= tabx(45) and y<=taby(44) and y>=taby(45) and cpt>45) or
             ( x<= tabx(45) and x>= tabx(46) and y<=taby(45) and y>=taby(46) and cpt>46) or
             ( x<= tabx(46) and x>= tabx(47) and y<=taby(46) and y>=taby(47) and cpt>47) or
             ( x<= tabx(47) and x>= tabx(48) and y<=taby(47) and y>=taby(48) and cpt>48) or
             ( x<= tabx(48) and x>= tabx(49) and y<=taby(48) and y>=taby(49) and cpt>49) or
             ( x<= tabx(49) and x>= tabx(50) and y<=taby(49) and y>=taby(50) and cpt>50) or
             
             ( x<= tabx(50) and x>= tabx(51) and y<=taby(50) and y>=taby(51) and cpt>51) or
             ( x<= tabx(51) and x>= tabx(52) and y<=taby(51) and y>=taby(52) and cpt>52) or
             ( x<= tabx(52) and x>= tabx(53) and y<=taby(52) and y>=taby(53) and cpt>53) or
             ( x<= tabx(53) and x>= tabx(54) and y<=taby(53) and y>=taby(54) and cpt>54) or
             ( x<= tabx(54) and x>= tabx(55) and y<=taby(54) and y>=taby(55) and cpt>55) or
             ( x<= tabx(55) and x>= tabx(56) and y<=taby(55) and y>=taby(56) and cpt>56) or
             ( x<= tabx(56) and x>= tabx(57) and y<=taby(56) and y>=taby(57) and cpt>57) or
             ( x<= tabx(57) and x>= tabx(58) and y<=taby(57) and y>=taby(58) and cpt>58) or
             ( x<= tabx(58) and x>= tabx(59) and y<=taby(58) and y>=taby(59) and cpt>59) or
             ( x<= tabx(59) and x>= tabx(60) and y<=taby(59) and y>=taby(60) and cpt>60) or  
             
             ( x<= tabx(60) and x>= tabx(61) and y<=taby(60) and y>=taby(61) and cpt>61) or
             ( x<= tabx(61) and x>= tabx(62) and y<=taby(61) and y>=taby(62) and cpt>62) or
             ( x<= tabx(62) and x>= tabx(63) and y<=taby(62) and y>=taby(63) and cpt>63) or
             ( x<= tabx(63) and x>= tabx(64) and y<=taby(63) and y>=taby(64) and cpt>64) or
             ( x<= tabx(64) and x>= tabx(65) and y<=taby(64) and y>=taby(65) and cpt>65) or
             ( x<= tabx(65) and x>= tabx(66) and y<=taby(65) and y>=taby(66) and cpt>66) or
             ( x<= tabx(66) and x>= tabx(67) and y<=taby(66) and y>=taby(67) and cpt>67) or
             ( x<= tabx(67) and x>= tabx(68) and y<=taby(67) and y>=taby(68) and cpt>68) or
             ( x<= tabx(68) and x>= tabx(69) and y<=taby(68) and y>=taby(69) and cpt>69) or
             ( x<= tabx(69) and x>= tabx(70) and y<=taby(69) and y>=taby(70) and cpt>70) or 
             
             ( x<= tabx(70) and x>= tabx(71) and y<=taby(70) and y>=taby(71) and cpt>71) or
             ( x<= tabx(71) and x>= tabx(72) and y<=taby(71) and y>=taby(72) and cpt>72) or
             ( x<= tabx(72) and x>= tabx(73) and y<=taby(72) and y>=taby(73) and cpt>73) or
             ( x<= tabx(73) and x>= tabx(74) and y<=taby(73) and y>=taby(74) and cpt>74) or
             ( x<= tabx(74) and x>= tabx(75) and y<=taby(74) and y>=taby(75) and cpt>75) or
             ( x<= tabx(75) and x>= tabx(76) and y<=taby(75) and y>=taby(76) and cpt>76) or
             ( x<= tabx(76) and x>= tabx(77) and y<=taby(76) and y>=taby(77) and cpt>77) or
             ( x<= tabx(77) and x>= tabx(78) and y<=taby(77) and y>=taby(78) and cpt>78) or
             ( x<= tabx(78) and x>= tabx(79) and y<=taby(78) and y>=taby(79) and cpt>79) or
             ( x<= tabx(79) and x>= tabx(80) and y<=taby(79) and y>=taby(80) and cpt>80) or 
             
             ( x<= tabx(80) and x>= tabx(81) and y<=taby(80) and y>=taby(81) and cpt>81) or
             ( x<= tabx(81) and x>= tabx(82) and y<=taby(81) and y>=taby(82) and cpt>82) or
             ( x<= tabx(82) and x>= tabx(83) and y<=taby(82) and y>=taby(83) and cpt>83) or
             ( x<= tabx(83) and x>= tabx(84) and y<=taby(83) and y>=taby(84) and cpt>84) or
             ( x<= tabx(84) and x>= tabx(85) and y<=taby(84) and y>=taby(85) and cpt>85) or
             ( x<= tabx(85) and x>= tabx(86) and y<=taby(85) and y>=taby(86) and cpt>86) or
             ( x<= tabx(86) and x>= tabx(87) and y<=taby(86) and y>=taby(87) and cpt>87) or
             ( x<= tabx(87) and x>= tabx(88) and y<=taby(87) and y>=taby(88) and cpt>88) or
             ( x<= tabx(88) and x>= tabx(89) and y<=taby(88) and y>=taby(89) and cpt>89) or
             ( x<= tabx(89) and x>= tabx(90) and y<=taby(89) and y>=taby(90) and cpt>90) or 
            
             ( x<= tabx(90) and x>= tabx(91) and y<=taby(90) and y>=taby(91) and cpt>91) or
             ( x<= tabx(91) and x>= tabx(92) and y<=taby(91) and y>=taby(92) and cpt>92) or
             ( x<= tabx(92) and x>= tabx(93) and y<=taby(92) and y>=taby(93) and cpt>93) or
             ( x<= tabx(93) and x>= tabx(94) and y<=taby(93) and y>=taby(94) and cpt>94) or
             ( x<= tabx(94) and x>= tabx(95) and y<=taby(94) and y>=taby(95) and cpt>95) or
             ( x<= tabx(95) and x>= tabx(96) and y<=taby(95) and y>=taby(96) and cpt>96) or
             ( x<= tabx(96) and x>= tabx(97) and y<=taby(96) and y>=taby(97) and cpt>97) or
             ( x<= tabx(97) and x>= tabx(98) and y<=taby(97) and y>=taby(98) and cpt>98) or
             ( x<= tabx(98) and x>= tabx(99) and y<=taby(98) and y>=taby(99) and cpt>99) or
             ( x<= tabx(99) and x>= tabx(100) and y<=taby(99) and y>=taby(100) and cpt>100)  )then
            
           contact_snake <='1';
       else
           contact_snake <='0';
       end if;

  
 end process;
  
process(cpt)
   begin
      if cpt <= 10 then 
          vite <= mok(0);
      elsif cpt<=20 and 10<cpt then 
          vite <= mok(1);
      elsif cpt<=30 and 20<cpt then 
          vite <= mok(2);     
      elsif cpt<=40 and 30<cpt then 
          vite <= mok(3);       
      elsif cpt<=50 and 40<cpt then 
          vite <= mok(4);
      elsif cpt<=60 and 50<cpt then 
          vite <= mok(5);
      elsif cpt<=70 and 60<cpt then 
          vite <= mok(6);
      elsif cpt<=80 and 70<cpt then 
          vite <= mok(7);
      elsif cpt<=90 and 80<cpt then 
           vite <= mok(8);
      elsif cpt<=100 and 90<cpt then 
           vite <= mok(9);
      else 
              vite <= vite; 
      end if;
  end process;

process (clock)
  begin
     if rising_edge(clock) then
      if cmpt > vite then
 --     if cmpt = 1000 then
            cmpt <= 0;
            h_aff <= '1';
       else
             cmpt <= cmpt + 1;
             h_aff <= '0';
       end if;
     end if;
end process;


process(clock,h_aff,play_pause,tabx)
 begin
   if rising_edge(clock)  then 
     if play_pause='1' then
           tabx<= tabx;
     else
         if h_aff='1' then
             tabx(0)<= to_integer(unsigned(x_s));
             for item in 1 to 100  loop 
               tabx(item)<= tabx(item-1);
             end loop;
--             tabx(1)<= tabx(0);
--              tabx(2)<= tabx(1);
--              tabx(3)<= tabx(2);
--              tabx(4)<= tabx(3);
--              tabx(5)<= tabx(4);
--              tabx(6)<= tabx(5);
--              tabx(7)<= tabx(6);
--              tabx(8)<= tabx(7);
--              tabx(9)<= tabx(8);
--              tabx(10)<= tabx(9);
--              tabx(11)<= tabx(10);
--              tabx(12)<= tabx(11);
--              tabx(13)<= tabx(12);
--              tabx(14)<= tabx(13);
--              tabx(15)<= tabx(14);
--              tabx(16)<= tabx(15);
--              tabx(17)<= tabx(16);
--              tabx(18)<= tabx(17);
--              tabx(19)<= tabx(18);
--              tabx(20)<= tabx(19);
--              tabx(21)<= tabx(20);
--              tabx(22)<= tabx(21);
--              tabx(23)<= tabx(22);
--              tabx(24)<= tabx(23);
--              tabx(25)<= tabx(24);
--              tabx(26)<= tabx(25);
--              tabx(27)<= tabx(26);
--              tabx(28)<= tabx(27);
--              tabx(29)<= tabx(28);
--              tabx(30)<= tabx(29);
--              tabx(31)<= tabx(30);
--              tabx(32)<= tabx(31);
--              tabx(33)<= tabx(32);
--              tabx(34)<= tabx(33);
--              tabx(35)<= tabx(34);
--              tabx(36)<= tabx(35);
--              tabx(37)<= tabx(36);
--              tabx(38)<= tabx(37);
--              tabx(39)<= tabx(38);
--              tabx(40)<= tabx(39);
--              tabx(41)<= tabx(40);
--              tabx(42)<= tabx(41);
--              tabx(43)<= tabx(42);
--              tabx(44)<= tabx(43);
--              tabx(45)<= tabx(44);
--              tabx(46)<= tabx(45);
--              tabx(47)<= tabx(46);
--              tabx(48)<= tabx(47);
--              tabx(49)<= tabx(48);
--              tabx(50)<= tabx(49);
--              tabx(51)<= tabx(50);
--              tabx(52)<= tabx(51);
--              tabx(53)<= tabx(52);
--              tabx(54)<= tabx(53);
--              tabx(55)<= tabx(54);
--              tabx(56)<= tabx(55);
--              tabx(57)<= tabx(56);
--              tabx(58)<= tabx(57);
--              tabx(59)<= tabx(58);
--              tabx(60)<= tabx(59);
--              tabx(61)<= tabx(60);
--              tabx(62)<= tabx(61);
--              tabx(63)<= tabx(62);
--              tabx(64)<= tabx(63);
--              tabx(65)<= tabx(64);
--              tabx(66)<= tabx(65);
--              tabx(67)<= tabx(66);
--              tabx(68)<= tabx(67);
--              tabx(69)<= tabx(68);
--              tabx(70)<= tabx(69);
--              tabx(71)<= tabx(70);
--              tabx(72)<= tabx(71);
--              tabx(73)<= tabx(72);
--              tabx(74)<= tabx(73);
--              tabx(75)<= tabx(74);
--              tabx(76)<= tabx(75);
--              tabx(77)<= tabx(76);
--              tabx(78)<= tabx(77);
--              tabx(79)<= tabx(78);
--              tabx(80)<= tabx(79);
--              tabx(81)<= tabx(80);
--              tabx(82)<= tabx(81);
--              tabx(83)<= tabx(82);
--              tabx(84)<= tabx(83);
--              tabx(85)<= tabx(84);
--              tabx(86)<= tabx(85);
--              tabx(87)<= tabx(86);
--              tabx(88)<= tabx(87);
--              tabx(89)<= tabx(88);
--              tabx(90)<= tabx(89);
--              tabx(91)<= tabx(90);
--              tabx(92)<= tabx(91);
--              tabx(93)<= tabx(92);
--              tabx(94)<= tabx(93);
--              tabx(95)<= tabx(94);
--              tabx(96)<= tabx(95);
--              tabx(97)<= tabx(96);
--              tabx(98)<= tabx(97);
--              tabx(99)<= tabx(98);
--              tabx(100)<= tabx(99);
             
             
          end if;
       end if;
       end if;
 end process;
    
    
 --pour les x
 process(clock,h_aff,play_pause,taby)
 begin
       
     if rising_edge(clock)  then 
     
     if play_pause='1' then
       taby <= taby;
     else
         if h_aff='1' then
             taby(0)<= to_integer(unsigned(y_s));
             for item in 1 to 100  loop 
                  taby(item)<= taby(item-1);
             end loop;
---              taby(1)<= taby(0);
---              taby(2)<= taby(1);
---              taby(3)<= taby(2);
---              taby(4)<= taby(3);
---              taby(5)<= taby(4);
---              taby(6)<= taby(5);
---              taby(7)<= taby(6);
---              taby(8)<= taby(7);
---              taby(9)<= taby(8);
---              taby(10)<= taby(9);
---              taby(11)<= taby(10);
---              taby(12)<= taby(11);
---              taby(13)<= taby(12);
---              taby(14)<= taby(13);
---              taby(15)<= taby(14);
---              taby(16)<= taby(15);
---              taby(17)<= taby(16);
---              taby(18)<= taby(17);
---              taby(19)<= taby(18);
---              taby(20)<= taby(19);
---              taby(21)<= taby(20);
---              taby(22)<= taby(21);
---              taby(23)<= taby(22);
---              taby(24)<= taby(23);
---              taby(25)<= taby(24);
---              taby(26)<= taby(25);
---              taby(27)<= taby(26);
---              taby(28)<= taby(27);
---              taby(29)<= taby(28);
---              taby(30)<= taby(29);
---              taby(31)<= taby(30);
---              taby(32)<= taby(31);
---              taby(33)<= taby(32);
---              taby(34)<= taby(33);
---              taby(35)<= taby(34);
---              taby(36)<= taby(35);
---              taby(37)<= taby(36);
---              taby(38)<= taby(37);
---              taby(39)<= taby(38);
---              taby(40)<= taby(39);
---              taby(41)<= taby(40);
---              taby(42)<= taby(41);
---              taby(43)<= taby(42);
---              taby(44)<= taby(43);
---              taby(45)<= taby(44);
---              taby(46)<= taby(45);
---              taby(47)<= taby(46);
---              taby(48)<= taby(47);
---              taby(49)<= taby(48);
---              taby(50)<= taby(49);
---              taby(51)<= taby(50);
---              taby(52)<= taby(51);
---              taby(53)<= taby(52);
---              taby(54)<= taby(53);
---              taby(55)<= taby(54);
---              taby(56)<= taby(55);
---              taby(57)<= taby(56);
---              taby(58)<= taby(57);
---              taby(59)<= taby(58);
---              taby(60)<= taby(59);
---              taby(61)<= taby(60);
---              taby(62)<= taby(61);
---              taby(63)<= taby(62);
---              taby(64)<= taby(63);
---              taby(65)<= taby(64);
---              taby(66)<= taby(65);
---              taby(67)<= taby(66);
---              taby(68)<= taby(67);
---              taby(69)<= taby(68);
---              taby(70)<= taby(69);
---              taby(71)<= taby(70);
---              taby(72)<= taby(71);
---              taby(73)<= taby(72);
---              taby(74)<= taby(73);
---              taby(75)<= taby(74);
---              taby(76)<= taby(75);
---              taby(77)<= taby(76);
---              taby(78)<= taby(77);
---              taby(79)<= taby(78);
---              taby(80)<= taby(79);
---              taby(81)<= taby(80);
---              taby(82)<= taby(81);
---              taby(83)<= taby(82);
---              taby(84)<= taby(83);
---              taby(85)<= taby(84);
---              taby(86)<= taby(85);
---              taby(87)<= taby(86);
---              taby(88)<= taby(87);
---              taby(89)<= taby(88);
---              taby(90)<= taby(89);
---              taby(91)<= taby(90);
---              taby(92)<= taby(91);
---              taby(93)<= taby(92);
---              taby(94)<= taby(93);
---              taby(95)<= taby(94);
---              taby(96)<= taby(95);
---              taby(97)<= taby(96);
---              taby(98)<= taby(97);
---              taby(99)<= taby(98);
---              taby(100)<= taby(99);
          end if;
       end if;
       end if;
 end process;

  
 tableaux <= tabx;
 taba <= taby;



  end Behavioral;

