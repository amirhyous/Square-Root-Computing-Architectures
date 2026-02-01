library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sqrt is
    generic(
        n : integer := 32
    );
    port(
        clk, reset : in std_logic;
        in1 : in std_logic_vector(2*n-1 downto 0);
        out1 : out std_logic_vector(n-1 downto 0)
    );
end sqrt;

architecture sqrt_arch of sqrt is

    signal sqrt_in   : std_logic_vector(2*n-1 downto 0);
    signal sqrt_out  : std_logic_vector(n-1 downto 0);

begin

    REG_IN: entity work.registerr
    generic map( width => 2*n )
    port map (
        clk => clk,
        reset => reset,
        data_in => in1,
        data_out => sqrt_in
    );

    SQRTT: entity work.sqrt3
    generic map( n => n )
    port map (
        A => sqrt_in,
        result => sqrt_out
    );

    REG_OUT: entity work.registerr
    generic map( width => n )
    port map (
        clk => clk,
        reset => reset,
        data_in => sqrt_out,
        data_out => out1
    );

end architecture sqrt_arch;
