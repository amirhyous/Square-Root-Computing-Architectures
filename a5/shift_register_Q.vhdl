library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity shift_reg_Q is
    Generic ( n : integer := 32 );
    Port (
        clk      : in  std_logic;
        reset    : in  std_logic;
        enable   : in  std_logic;
        bit_in   : in  std_logic;
        data_out : out std_logic_vector(n-1 downto 0)
    );
end shift_reg_Q;

architecture behavioral of shift_reg_Q is
    signal reg : unsigned(n-1 downto 0);
begin
    process(clk, reset)
    begin
        if reset = '1' then
            reg <= (others => '0');
        elsif rising_edge(clk) then
            if enable = '1' then
                reg <= reg(n-2 downto 0) & bit_in;
            end if;
        end if;
    end process;
    data_out <= std_logic_vector(reg);
end behavioral;
