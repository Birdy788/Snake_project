----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/10/2021 01:44:53 AM
-- Design Name: 
-- Module Name: Audio - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Audio is
    Port ( clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable_generate : in STD_LOGIC;
           init : in STD_LOGIC;
           odata : out STD_LOGIC;
           sd : out STD_LOGIC);
end Audio;

architecture Behavioral of Audio is

component ce_clock is
    Port ( h : in STD_LOGIC;
           reset : in STD_LOGIC;
           ce : out STD_LOGIC
           );
end component;


component compteur_audio is
    Port ( H : in STD_LOGIC;
           reset : in STD_LOGIC;
           ce : in STD_LOGIC;
           hold :in STD_LOGIC;
           init : in std_logic;
           sortie_cpt_init : out STD_LOGIC_VECTOR(16 downto 0);
           sortie_cpt_eat : out STD_LOGIC_VECTOR(14 downto 0)
           ); --sotie pour lecture
end component;

component hold_imp is
    Port ( H : in STD_LOGIC;
           reset : in STD_LOGIC;
           generate_apple : in STD_LOGIC;
           hold : out STD_LOGIC);
end component;

component rom_init IS
PORT (
      CLOCK          : IN  STD_LOGIC;
      ADDR_R         : IN  STD_LOGIC_VECTOR(16 DOWNTO 0);
      DATA_OUT       : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
      );
END component;


component rom_eat IS
PORT (
      CLOCK          : IN  STD_LOGIC;
      ADDR_R         : IN  STD_LOGIC_VECTOR(14 DOWNTO 0);
      DATA_OUT       : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
      );
END component;



component mux_rom is
    Port ( DATA_OUT_eat : in STD_LOGIC_VECTOR (10 downto 0);
           DATA_OUT_init : in STD_LOGIC_VECTOR (10 downto 0);
           hold : in std_logic;
           init : in STD_LOGIC;
           Sortie_mux : out STD_LOGIC_VECTOR (10 downto 0)
          );
end component;

component pwm 
    Port ( H : in STD_LOGIC;
           reset : in STD_LOGIC;
           i_data : in STD_LOGIC_VECTOR (10 downto 0);
           ce : in STD_LOGIC;
           o_data : out STD_LOGIC);
end component;



signal sortie_cpt_init : std_logic_vector(16 downto 0);
signal sortie_cpt_eat : std_logic_vector(14 downto 0);
signal   i_data: std_logic_vector(10 downto 0);

signal  i_data_init , i_data_eat: std_logic_vector(10 downto 0);
signal hold : std_logic;
signal ce : std_logic;
begin

sd <= '1';

 
inst1: compteur_audio 
    Port  map( H =>clock,
           reset => reset,
           ce => ce,
           hold => hold,
           init => init,
           sortie_cpt_init =>sortie_cpt_init,
           sortie_cpt_eat =>sortie_cpt_eat
           ); --sotie pour lecture

inst2: hold_imp 
    Port map ( H =>clock,
           reset => reset,
           generate_apple => enable_generate,
           hold => hold);


inst3: rom_init 
PORT map (
      CLOCK          =>clock,
      ADDR_R          =>sortie_cpt_init,
      DATA_OUT       =>i_data_init
      );


inst4: rom_eat 
PORT map (
      CLOCK          =>clock,
      ADDR_R        => sortie_cpt_eat,
      DATA_OUT    =>   i_data_eat
      );




inst5: mux_rom 
    Port map ( DATA_OUT_eat  =>   i_data_eat,
           DATA_OUT_init  =>   i_data_init,
           hold  =>   hold,
           init  => init,
           Sortie_mux => i_data
           
          );

inst6: pwm 
    Port map ( H  =>clock,
           reset => reset,
           i_data => i_data,
           ce => ce,
           o_data => odata);
           
inst7: ce_clock 
    Port map ( h =>clock,
           reset => reset,
           ce => ce
           );

end Behavioral;
