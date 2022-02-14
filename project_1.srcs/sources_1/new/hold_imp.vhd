

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity hold_imp is
    Port ( H : in STD_LOGIC;
           reset : in STD_LOGIC;
           generate_apple : in STD_LOGIC;
           hold : out STD_LOGIC);
end hold_imp;

architecture Behavioral of hold_imp is

signal col : std_logic := '0';
signal cpt : integer := 0;


begin

process(H)
begin
    if rising_edge(H) then
        if reset = '1' then
            cpt <= 0;
        else
            if (generate_apple = '1') then
                col <= '1';
                cpt <= 0;
            end if;
            if cpt = 50000000-1 then
                cpt <= 0;
                col <= '0';
            elsif col = '1' then
                  cpt <= cpt + 1;
            end if;
       end if;
  end if;
end process;


hold <= col ;

end Behavioral;
