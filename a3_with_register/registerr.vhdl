library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity registerr is
    Generic ( width : integer := 34 );
    Port (
        clk      : in  std_logic;
        reset    : in  std_logic;
        data_in  : in  std_logic_vector(width-1 downto 0);
        data_out : out std_logic_vector(width-1 downto 0)
    );
end registerr;

architecture behavioral of registerr is
    signal reg : signed(width-1 downto 0);
begin
    process(clk, reset)
    begin
        if reset = '1' then
            reg <= (others => '0');
        elsif rising_edge(clk) then
            reg <= signed(data_in);
        end if;
    end process;
    
    data_out <= std_logic_vector(reg);
end behavioral;
