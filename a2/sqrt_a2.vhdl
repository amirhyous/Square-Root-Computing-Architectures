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

architecture a2 of sqrt is

    type statetype is (idle, comp, done);
    signal state : statetype;

    
    signal bit_counter : integer range 0 to n; 

    signal R : signed(n+1 downto 0); 
    signal D : unsigned(2*n-1 downto 0);
    signal Z : unsigned(n-1 downto 0);

begin

    process(clk, rst)
        variable R_temp : signed(n+1 downto 0);
        variable D_temp : unsigned(2*n-1 downto 0);
        variable Z_temp : unsigned(n-1 downto 0);
    begin
        if rst = '1' then
            state <= idle;
            result <= (others => '0');
            finish <= '0';
            R <= (others => '0');
            D <= (others => '0');
            Z <= (others => '0');
            bit_counter <= n-1;

        elsif rising_edge(clk) then
            
            case state is
                
                when idle =>
                    finish <= '0';
                    if start = '1' then
                        D <= unsigned(A);
                        R <= (others => '0');
                        Z <= (others => '0');
                        bit_counter <= n-1;
                        state <= comp;
                    end if;

                when comp =>
                    R_temp := R;
                    D_temp := D;
                    Z_temp := Z;

                    if R_temp >= 0 then
                        R_temp := shift_left(R_temp, 2) + signed(resize(shift_right(D_temp, 2*n-2), R_temp'length)) - signed(resize((shift_left(Z_temp, 2) + 1), R_temp'length));
                    else
                        R_temp := shift_left(R_temp, 2) + signed(resize(shift_right(D_temp, 2*n-2), R_temp'length)) + signed(resize((shift_left(Z_temp, 2) + 3), R_temp'length));
                    end if;

                    if R_temp >= 0 then
                        Z_temp := shift_left(Z_temp, 1) + 1;
                    else
                        Z_temp := shift_left(Z_temp, 1);
                    end if;

                    D_temp := shift_left(D_temp, 2);

                    R <= R_temp;
                    D <= D_temp;
                    Z <= Z_temp;

                    if bit_counter = 0 then
                        state <= done;
                    else
                        bit_counter <= bit_counter - 1;
                    end if;

                when done =>
                    result <= std_logic_vector(Z);
                    finish <= '1';
                    
                    if start = '0' then
                        finish <= '0';
                        state <= idle;
                    end if;
                
                when others =>
                    state <= idle;

            end case;
        end if;
    end process;

end architecture a2;