library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sqrt is
    generic (n : integer := 32);
    port (
        clk, rst, start : in std_logic;  
        A      : in std_logic_vector(2*n-1 downto 0);  
        result : out std_logic_vector(n-1 downto 0);
        finish : out std_logic
    );         
end sqrt;

architecture a1 of sqrt is

    signal x      : unsigned(n-1 downto 0) := (others => '0');

    type statetype is (idle, comp, done);
    signal state : statetype;

begin

    process(clk, rst)
        variable x_temp : unsigned(2*n-1 downto 0);
        variable x_next_temp   : unsigned(n-1 downto 0);
    begin
        if rst = '1' then
            x <= (others => '0');
            state <= idle;
            result <= (others => '0');
            finish <= '0';

        elsif rising_edge(clk) then 
            case state is 
                when idle =>
                    finish <= '0';
                    if start = '1' then 
                        x <= (others => '0');
                        x(n-1) <= '1';
                        state <= comp;
                    end if;

                when comp =>
                    x_temp := resize(x, 2*n);

                    if x_temp = 0 then
                        x_next_temp := (others => '0');
                    else
                        x_next_temp := resize(shift_right(x_temp + unsigned(A) / x_temp, 1), n);
                    end if;

                    if (x_next_temp = x) or (x_next_temp > x) then 
                        state <= done;
                    else
                        x <= x_next_temp;
                    end if;

                when done =>
                    result <= std_logic_vector(x);
                    finish <= '1';
                    
                    if start = '0' then 
                    --    finish <= '0';
                        state <= idle;
                    end if;
                
                when others =>
                    state <= idle;

            end case; 
        end if;
    end process;
end architecture a1;