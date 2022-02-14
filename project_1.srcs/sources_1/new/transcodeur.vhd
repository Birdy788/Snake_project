----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 09/16/2020 11:19:33 PM
-- Design Name:
-- Module Name: transcodeur - Behavioral
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

entity transcodeur is
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
end transcodeur;

architecture Behavioral of transcodeur is
signal unite,dizaine,centaine: std_logic_vector(3 downto 0);
signal nb : integer range 0 to 100 := 0;
signal d,u : integer range 0 to 9 :=0;
--signal valeur_dec: integer;  --valeur binaire convertie en base 10
--signal unite1,dizaine1,centaine1: integer;
 begin
 nb <= to_integer(unsigned(nb_pommes));
 
  process( nb,d)
  begin
    d<= nb/10;
    u<= nb-d*10;
  end process;
   
    unite <= STD_LOGIC_VECTOR(to_unsigned(u,4));
    dizaine <= STD_LOGIC_VECTOR(to_unsigned(d,4));
           

transcodeur_BCD_7segments: process(unite) --valeur_afficheur(abcdefg) mais codé en bar
     begin
         case unite is
             when "0000"=> s_uni<="0000001";
             when "0001"=> s_uni<="1001111";
             when "0010"=> s_uni<="0010010";
             when "0011"=> s_uni<="0000110";
             when "0100"=> s_uni<="1001100";
             when "0101"=> s_uni<="0100100";
             when "0110"=> s_uni<="0100000";
             when "0111"=> s_uni<="0001101";
             when "1000"=> s_uni<="0000000";
             when "1001"=> s_uni<="0000100";
             when others => s_uni <= "1111111";
         end case;
      end process;

transcodeur_BCD_7segments2: process(dizaine) --valeur_afficheur(abcdefg) mais codé en bar
     begin
         case dizaine is
             when "0000"=> s_diz<="0000001";
             when "0001"=> s_diz<="1001111";
             when "0010"=> s_diz<="0010010";
             when "0011"=> s_diz<="0000110";
             when "0100"=> s_diz<="1001100";
             when "0101"=> s_diz<="0100100";
             when "0110"=> s_diz<="0100000";
             when "0111"=> s_diz<="0001101";
             when "1000"=> s_diz<="0000000";
             when "1001"=> s_diz<="0000100";
             when others => s_diz <= "1111111";
         end case;
      end process;
     
--transcodeur_BCD_7segments3: process(centaine) --valeur_afficheur(abcdefg) mais codé en bar
--           begin
--               case centaine is
--                   when "0000"=> s_cent<="0000001";
--                   when "0001"=> s_cent<="1001111";
--                   when "0010"=> s_cent<="0010010";
--                   when "0011"=> s_cent<="0000110";
--                   when "0100"=> s_cent<="1001100";
--                   when "0101"=> s_cent<="0100100";
--                   when "0110"=> s_cent<="0100000";
--                   when "0111"=> s_cent<="0001101";
--                   when "1000"=> s_cent<="0000000";
--                   when "1001"=> s_cent<="0000100";
--                   when others => s_cent <= "1111111";
--               end case;
--            end process;
--transcodeur_BCD_7segment4: process(nb_pommes) --valeur_afficheur(abcdefg) mais codé en bar
--                       begin
--                           case nb_pommes is
--                               when "0000"=> s_pommes<="0000001";
--                               when "0001"=> s_pommes<="1001111";
--                               when "0010"=> s_pommes<="0010010";
--                               when "0011"=> s_pommes<="0000110";
--                               when "0100"=> s_pommes<="1001100";
--                               when "0101"=> s_pommes<="0100100";
--                               when "0110"=> s_pommes<="0100000";
--                               when "0111"=> s_pommes<="0001101";
--                               when "1000"=> s_pommes<="0000000";
--                               when "1001"=> s_pommes<="0000100";
--                               when others => s_pommes <= "1111111";
--                           end case;
--                        end process;

--                    sortie1 <= "0110001"; --[ (AN7)
--                    sortie2 <= "1111110"; --  (AN6)
--                    sortie3 <= "1111110"; --   (AN5)
--                    sortie4 <= "0000111"; --]  (AN4)
     
           
         


end Behavioral;


