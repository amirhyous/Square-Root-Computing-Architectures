library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity shift_reg_D is
    Generic ( n : integer := 32 );
    Port (
        clk     : in  std_logic;
        reset   : in  std_logic;
        load    : in  std_logic;
        enable  : in  std_logic;
        data_in : in  std_logic_vector(2*n-1 downto 0);
        top_2   : out std_logic_vector(1 downto 0)
    );
end shift_reg_D;

architecture behavioral of shift_reg_D is
    signal reg : unsigned(2*n-1 downto 0);
begin
    process(clk, reset)
    begin
        if reset = '1' then
            reg <= (others => '0');
        elsif rising_edge(clk) then
            if load = '1' then
                reg <= unsigned(data_in);
            elsif enable = '1' then
                reg <= shift_left(reg, 2);
            end if;
        end if;
    end process;
    
    top_2 <= std_logic_vector(reg(2*n-1 downto 2*n-2));
end behavioral;
