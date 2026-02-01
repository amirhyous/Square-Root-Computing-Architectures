library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_sqrt is
end entity tb_sqrt;

architecture behavior of tb_sqrt is

    constant n_tb       : integer := 32;
    constant CLK_PERIOD : time := 10 ns;

    component sqrt
        generic (n : integer := 32);
        port (
            clk, reset, start : in std_logic;  
            A      : in std_logic_vector(2*n_tb-1 downto 0);  
            result : out std_logic_vector(n_tb-1 downto 0);  
            finish : out std_logic
        );         
    end component;

    signal clk_tb    : std_logic := '0';
    signal reset_tb    : std_logic := '1'; 
    signal start_tb  : std_logic := '0';
    signal A_tb      : std_logic_vector(2*n_tb-1 downto 0) := (others => '0');
    signal result_tb : std_logic_vector(n_tb-1 downto 0);
    signal finish_tb : std_logic;

begin

    uut: sqrt
        generic map (n => n_tb)
        port map (
            clk    => clk_tb,
            reset  => reset_tb,
            start  => start_tb,
            A      => A_tb,
            result => result_tb,
            finish => finish_tb
        );

    clk_process : process
    begin
        loop
            clk_tb <= '0';
            wait for CLK_PERIOD / 2;
            clk_tb <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    stim_process : process
    begin
        
        reset_tb <= '1';
        wait for CLK_PERIOD * 4;
        reset_tb <= '0';
        wait for CLK_PERIOD * 4.5;
        
        ---------------------------------------------------------
        -- TEST CASE 4: A = 5499030 
        ---------------------------------------------------------
        A_tb <= X"000000000053E896";
        start_tb <= '1';
        wait until finish_tb = '1'; 
        start_tb <= '0'; 
        wait for CLK_PERIOD * 4; 

        ---------------------------------------------------------
        -- TEST CASE 5: A = 1194877489 
        ---------------------------------------------------------
        A_tb <= X"0000000047386231";
        start_tb <= '1';
        wait until finish_tb = '1'; 
        start_tb <= '0'; 
        wait for CLK_PERIOD * 4; 

        ---------------------------------------------------------
        -- TEST CASE 6: A = 3
        ---------------------------------------------------------
        A_tb <= X"0000000000000003";
        start_tb <= '1';
        wait until finish_tb = '1'; 
        start_tb <= '0'; 
        wait for CLK_PERIOD * 4;

        ---------------------------------------------------------
        -- TEST CASE 7: A = 7 
        ---------------------------------------------------------
        A_tb <= X"0000000000000007";
        start_tb <= '1';
        wait until finish_tb = '1'; 
        start_tb <= '0'; 
        wait for CLK_PERIOD * 4;

            ---------------------------------------------------------
        -- TEST CASE 1: A = 0 
        ---------------------------------------------------------
        A_tb <= X"0000000000000000";
        start_tb <= '1';
        wait until finish_tb = '1'; 
        start_tb <= '0'; 
        wait for CLK_PERIOD * 4; 

        ---------------------------------------------------------
        -- TEST CASE 2: A = 1 
        ---------------------------------------------------------
        A_tb <= X"0000000000000001";
        start_tb <= '1';
        wait until finish_tb = '1'; 
        start_tb <= '0'; 
        wait for CLK_PERIOD * 4; 

        ---------------------------------------------------------
        -- TEST CASE 3: A = 512 
        ---------------------------------------------------------
        A_tb <= X"0000000000000200";
        start_tb <= '1';
        wait until finish_tb = '1'; 
        start_tb <= '0'; 
        wait for CLK_PERIOD * 4; 

        ---------------------------------------------------------
        -- TEST CASE 8: A = 15 
        ---------------------------------------------------------
        A_tb <= X"000000000000000F";
        start_tb <= '1';
        wait until finish_tb = '1'; 
        start_tb <= '0'; 
        wait for CLK_PERIOD * 4;

        ---------------------------------------------------------
        -- TEST CASE 9: A = 2^32 - 1 
        ---------------------------------------------------------
        A_tb <= X"00000000FFFFFFFF";
        start_tb <= '1';
        wait until finish_tb = '1'; 
        start_tb <= '0'; 
        wait for CLK_PERIOD * 4;

        wait; 
    end process;

end architecture behavior;