
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity mux_rom is
    Port ( DATA_OUT_eat : in STD_LOGIC_VECTOR (10 downto 0);
           DATA_OUT_init : in STD_LOGIC_VECTOR (10 downto 0);
           hold : in std_logic;
           init : in STD_LOGIC;
           Sortie_mux : out STD_LOGIC_VECTOR (10 downto 0)
          );
end mux_rom;

architecture Behavioral of mux_rom is

begin

process(hold, init, DATA_OUT_init,DATA_OUT_eat)
begin

    if (hold='1') then
        Sortie_mux <= DATA_OUT_eat;    
        
    elsif (init='1') then
        Sortie_mux <= DATA_OUT_init;

        
    end if;  
end process;  

end Behavioral;
