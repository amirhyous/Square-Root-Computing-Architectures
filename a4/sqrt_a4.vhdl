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
end entity sqrt;

architecture a4 of sqrt is

    type R_array is array (n downto 0) of signed(n+1 downto 0);
    type D_array is array (n downto 0) of unsigned(2*n-1 downto 0);
    type Z_array is array (n downto 0) of unsigned(n-1 downto 0);
    type start_array is array (n downto 0) of std_logic;

    signal R_pipe : R_array;
    signal D_pipe : D_array;
    signal Z_pipe : Z_array;
    signal start_pipe : start_array;

begin

    process(clk, rst)
        variable R_temp : signed(n+1 downto 0);
        variable D_temp : unsigned(2*n-1 downto 0);
        variable Z_temp : unsigned(n-1 downto 0);
    begin
        if rst = '1' then
            R_pipe <= (others => (others => '0'));
            D_pipe <= (others => (others => '0'));
            Z_pipe <= (others => (others => '0'));
            start_pipe <= (others => '0');
            result <= (others => '0');
            finish <= '0';

        elsif rising_edge(clk) then
            
            D_pipe(n) <= unsigned(A);
            R_pipe(n) <= (others => '0');
            Z_pipe(n) <= (others => '0');
            start_pipe(n) <= start;

            for i in n-1 downto 0 loop
                
                R_temp := R_pipe(i+1);
                D_temp := D_pipe(i+1);
                Z_temp := Z_pipe(i+1);

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

                R_pipe(i) <= R_temp;
                D_pipe(i) <= D_temp;
                Z_pipe(i) <= Z_temp;
                
                start_pipe(i) <= start_pipe(i+1);

            end loop;

            result <= std_logic_vector(Z_pipe(0));
            finish <= start_pipe(0);

        end if;
    end process;

end architecture a4;