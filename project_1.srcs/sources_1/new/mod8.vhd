----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 09/17/2020 12:31:49 PM
-- Design Name:
-- Module Name: mod8 - Behavioral
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

entity mod8 is
    Port (
           clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           sortie_mod : out STD_LOGIC);
end mod8;

architecture Behavioral of mod8 is
signal cmpt_8 : integer range 0 to 2:=0;
signal cpt_perception : natural range 0 to 33333-1;
signal ce_perception :std_logic;
begin

cpt_perception1: process (clock)
       begin  
    if (clock' event and clock='1') then
        if reset = '1' then
            ce_perception <='0';
            cpt_perception <= 0;
       else
            if cpt_perception=33333-1 then --3KHZ
                cpt_perception <= 0;
                ce_perception <= '1';
           
            else
                cpt_perception <= cpt_perception+1;
                ce_perception <= '0';
            end if;
        end if;
    end if;
end process;

compt_modulo_8: process(clock)
    begin
        if rising_edge(clock) then
            if reset = '1' then
                cmpt_8 <= 0;
            else
                if ce_perception = '1' then
                    if cmpt_8 = 1 then --7 maxi
                        cmpt_8 <= 0;
                        sortie_mod <= '0';
                    else
                        cmpt_8 <= cmpt_8 + 1;
                        sortie_mod <='1';
                    end if;
                end if;
           end if;
       end if;
end process;
--sortie_mod <= std_logic(to_unsigned(cmpt_8));

decodeur_anode: process(cmpt_8)
begin
    if cmpt_8 = 0 then
        AN <= "11111110"; --AN0
    else
        AN <= "11111101" ;--AN1
--    elsif cmpt_8 = "010" then
--        AN <= "11111011"; --AN2
--    elsif cmpt_8 = "011" then
--        AN <= "11110111"; --AN3
--    elsif cmpt_8 = "100" then
--        AN <= "11101111";--AN4
--    elsif cmpt_8 = "101" then
--        AN <= "11011111"; --AN5
--    elsif cmpt_8 = "110" then
--        AN <= "10111111"; --AN6
--    else
--        AN <= "01111111"; --AN7
    end if;
         
end process;


end Behavioral;
