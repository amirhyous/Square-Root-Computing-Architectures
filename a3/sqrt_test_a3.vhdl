library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_sqrt_a3 is
end entity tb_sqrt_a3;

architecture behavior of tb_sqrt_a3 is

    constant n_tb       : integer := 32;
    constant CLK_PERIOD : time := 10 ns;

    component sqrt
        generic (n : integer := 32);
        port (
            A      : in std_logic_vector(2*n_tb-1 downto 0);  
            result : out std_logic_vector(n_tb-1 downto 0)  
        );         
    end component;

    signal A_tb      : std_logic_vector(2*n_tb-1 downto 0) := (others => '0');
    signal result_tb : std_logic_vector(n_tb-1 downto 0);

begin

    uut: sqrt
        generic map (n => n_tb)
        port map (
            A      => A_tb,
            result => result_tb
        );


    stim_process : process
    begin

        wait for CLK_PERIOD ;

        --------------------------------------------------------
        -- TEST CASE 4: A = 5499030 
        ---------------------------------------------------------
        A_tb <= X"000000000053E896";
        wait for CLK_PERIOD ; 

        ---------------------------------------------------------
        -- TEST CASE 5: A = 1194877489 
        ---------------------------------------------------------
        A_tb <= X"0000000047386231";
        wait for CLK_PERIOD ; 

        ---------------------------------------------------------
        -- TEST CASE 6: A = 3
        ---------------------------------------------------------
        A_tb <= X"0000000000000003";
        wait for CLK_PERIOD ;

        ---------------------------------------------------------
        -- TEST CASE 7: A = 7 
        ---------------------------------------------------------
        A_tb <= X"0000000000000007";  
        wait for CLK_PERIOD ;

            ---------------------------------------------------------
        -- TEST CASE 1: A = 0 
        ---------------------------------------------------------
        A_tb <= X"0000000000000000";  
        wait for CLK_PERIOD ; 

        ---------------------------------------------------------
        -- TEST CASE 2: A = 1 
        ---------------------------------------------------------
        A_tb <= X"0000000000000001";
        wait for CLK_PERIOD ; 

        ---------------------------------------------------------
        -- TEST CASE 3: A = 512 
        ---------------------------------------------------------
        A_tb <= X"0000000000000200"; 
        wait for CLK_PERIOD ; 

        ---------------------------------------------------------
        -- TEST CASE 8: A = 15 
        ---------------------------------------------------------
        A_tb <= X"000000000000000F";   
        wait for CLK_PERIOD ;

        ---------------------------------------------------------
        -- TEST CASE 9: A = 2^32 - 1 
        ---------------------------------------------------------
        A_tb <= X"00000000FFFFFFFF";  
        wait for CLK_PERIOD ;

        wait; 
    end process;

end architecture behavior;
