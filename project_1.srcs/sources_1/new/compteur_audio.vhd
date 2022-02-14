

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity compteur_audio is
    Port ( H : in STD_LOGIC;
           reset : in STD_LOGIC;
           ce : in STD_LOGIC;
           hold :in STD_LOGIC;
           init : in std_logic;
           sortie_cpt_init : out STD_LOGIC_VECTOR(16 downto 0);
           sortie_cpt_eat : out STD_LOGIC_VECTOR(14 downto 0)
           ); --sotie pour lecture
end compteur_audio;

architecture Behavioral of compteur_audio is

signal cpt_init : integer;
signal cpt_eat : integer;

begin





process(H)
begin
    if rising_edge(H) then
        if init = '0' then
            cpt_init <= 0;
        else
            if ce = '1' then
                if cpt_init = 79260-1 then
                    cpt_init <= 0 ;
                else 
                    cpt_init <= cpt_init +1;
                
                end if;
           end if;
        end if;
      end if;   
end process;

process(H)
begin
    if rising_edge(H) then
        if reset = '1'  or hold = '0' then
            cpt_eat <= 0;
        else
            if ce = '1' then
                if cpt_eat = 19126-1 then
                    cpt_eat <= 19126 -1 ;
                else 
                    cpt_eat <= cpt_eat +1;
                
                end if;
           end if;
        end if;
      end if;   
end process;



sortie_cpt_eat <= std_logic_vector(to_unsigned(cpt_eat,15));
sortie_cpt_init <= std_logic_vector(to_unsigned(cpt_init,17));
end Behavioral;
