library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity control_unit is
    Generic ( n : integer := 32 );
    Port (
        clk        : in  std_logic;
        reset      : in  std_logic;
        start      : in  std_logic;
        load_D     : out std_logic;
        en_D       : out std_logic;
        load_R     : out std_logic;
        en_Q       : out std_logic;
        finish     : out std_logic
    );
end control_unit;

architecture behavioral of control_unit is
    type state_type is (IDLE, COMP, DONE);
    signal current_state : state_type;
    signal bit_counter : integer range 0 to n;
begin
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= IDLE;
            bit_counter <= n;
            load_D <= '0';
            en_D <= '0'; 
            load_R <= '0'; 
            en_Q <= '0'; 
            finish <= '0';
        elsif rising_edge(clk) then
            
            load_D <= '0'; 
            en_D <= '0'; 
            load_R <= '0'; 
            en_Q <= '0'; 
            finish <= '0';
            
            case current_state is
                when IDLE =>
                    if start = '1' then
                        load_D <= '1';
                        load_R <= '1';
                        bit_counter <= n;
                        current_state <= COMP;
                    end if;
                    
                when COMP =>
                    if bit_counter > 0 then
                        en_D <= '1';
                        en_Q <= '1';
                        load_R <= '1';
                        bit_counter <= bit_counter - 1;
                    else
                        current_state <= DONE;
                        finish <= '1';
                    end if;
                    
                when DONE =>
                    finish <= '1';
                    if start = '0' then
                        current_state <= IDLE;
                    end if;
            end case;
        end if;
    end process;
end behavioral;
