---------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 09/17/2020 02:25:55 PM
-- Design Name:
-- Module Name: mux_8 - Behavioral
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

entity mux_8 is
    Port ( sortie_mod_8 : in STD_LOGIC; --commande
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
end mux_8;

architecture Behavioral of mux_8 is

begin
process(sortie_mod_8,uni,diz)
    begin
        if sortie_mod_8='0' then  --AN0 unité
            sept_seg <= uni;
--            DP <= '1';
        else --AN1 diz
            sept_seg <= diz;
--            DP <= '1';
--        elsif sortie_mod_8="010" then  --AN2 cent
--           sept_seg <= cent;
--           DP <= '1';
--        elsif sortie_mod_8="011" then  --AN3 uni_vol
--           sept_seg <= nb_pommes;
--           DP <= '0';
--        elsif sortie_mod_8="100" then  --AN4 sortie 4 du transcodeur
--           sept_seg <= s_4;
--           DP <= '1';
--        elsif sortie_mod_8="101" then  --AN5 sortie 3 du transcodeur
--           sept_seg <= s_3;
--           DP <= '1';
--        elsif sortie_mod_8="110" then  --AN6 sortie 2 du transcodeur
--           sept_seg <= s_2;
--           DP <= '1';
--       else                            --AN7 sortie 1 du transcodeur
--           sept_seg <= s_1;
--           DP <= '1';
       end if;
   
   end process;

end Behavioral;

