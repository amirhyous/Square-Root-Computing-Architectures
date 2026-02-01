library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity add_sub is
    Generic ( width : integer := 34 );
    Port ( 
        a      : in  std_logic_vector(width-1 downto 0);
        b      : in  std_logic_vector(width-1 downto 0);
        add_sub: in  std_logic;
        result : out std_logic_vector(width-1 downto 0)
    );
end add_sub;

architecture behavioral of add_sub is
begin
    process(a, b, add_sub)
    begin
        if add_sub = '1' then
            result <= std_logic_vector(signed(a) + signed(b));
        else
            result <= std_logic_vector(signed(a) - signed(b));
        end if;
    end process;
end behavioral;