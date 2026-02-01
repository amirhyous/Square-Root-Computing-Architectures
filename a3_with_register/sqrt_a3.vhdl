library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sqrt3 is
    generic (n : integer := 32);
    port (
        A      : in std_logic_vector(2*n-1 downto 0);  
        result : out std_logic_vector(n-1 downto 0)
    );         
end sqrt3;

architecture a3 of sqrt3 is

begin
    process(A)
        variable R_temp : signed(n+1 downto 0);
        variable D_temp : unsigned(2*n-1 downto 0);
        variable Z_temp : unsigned(n-1 downto 0);

    begin
        D_temp := unsigned(A);
        R_temp := (others => '0');
        Z_temp := (others => '0');

        for i in n-1 downto 0 loop

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

        end loop;
                    
        result <= std_logic_vector(Z_temp);

    end process;
end architecture a3;