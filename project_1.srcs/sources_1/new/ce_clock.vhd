


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ce_clock is
    Port ( h : in STD_LOGIC;
           reset : in STD_LOGIC;
           ce : out STD_LOGIC
           );
end ce_clock;

architecture Behavioral of ce_clock is

signal cpt : integer;

begin


process(H)
begin
    if rising_edge(h) then
        if reset = '1' then
            cpt <= 0;
        else
            if cpt = 2083-1 then
                cpt <= 0;
                ce <= '1';
            else
                cpt <= cpt + 1;
                ce <= '0';
            end if;
       end if;
  end if;
end process;

end Behavioral;

