library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sqrt is
    Generic ( n : integer := 32 );
    Port (
        clk    : in  std_logic;
        reset  : in  std_logic;
        start  : in  std_logic;
        A      : in  std_logic_vector(2*n-1 downto 0);
        result : out std_logic_vector(n-1 downto 0);
        finish : out std_logic
    );
end sqrt;

architecture a5 of sqrt is

    signal D_top2      : std_logic_vector(1 downto 0);
    signal R_current   : std_logic_vector(n+1 downto 0);
    signal R_is_neg    : std_logic;
    signal Q_current   : std_logic_vector(n-1 downto 0);
    signal adder_out   : std_logic_vector(n+1 downto 0);
    
    signal ALU_in_a    : std_logic_vector(n+1 downto 0);
    signal ALU_in_b    : std_logic_vector(n+1 downto 0);
    signal ALU_op      : std_logic;
    signal new_Q_bit   : std_logic;
    
    signal ctrl_load_D : std_logic;
    signal ctrl_en_D   : std_logic;
    signal ctrl_load_R : std_logic;
    signal ctrl_en_Q   : std_logic;
    
    signal R_reset_comb : std_logic;

begin

    CTRL: entity work.control_unit
        Generic map ( n => n )
        Port map (
            clk => clk, reset => reset, start => start,
            load_D => ctrl_load_D, en_D => ctrl_en_D,
            load_R => ctrl_load_R, en_Q => ctrl_en_Q,
            finish => finish
        );

    REG_D: entity work.shift_reg_D
        Generic map ( n => n )
        Port map (
            clk => clk, reset => reset, load => ctrl_load_D, enable => ctrl_en_D,
            data_in => A, top_2 => D_top2
        );

    R_reset_comb <= reset or ctrl_load_D; 

    REG_R: entity work.register_R
        Generic map ( width => n+2 )
        Port map (
            clk => clk, reset => R_reset_comb, load => ctrl_load_R,
            data_in => adder_out, data_out => R_current, is_neg => R_is_neg
        );

    REG_Q: entity work.shift_reg_Q
        Generic map ( n => n )
        Port map (
            clk => clk, 
            reset => R_reset_comb,
            enable => ctrl_en_Q,
            bit_in => new_Q_bit, 
            data_out => Q_current
        );

    ALU_op <= R_is_neg;

    ALU_in_a <= R_current(n-1 downto 0) & D_top2;

    ALU_in_b <= std_logic_vector(resize(unsigned(Q_current), n)) & ALU_op & '1';

    ALU: entity work.add_sub
        Generic map ( width => n+2 )
        Port map (
            a => ALU_in_a, b => ALU_in_b, add_sub => ALU_op,
            result => adder_out
        );

    new_Q_bit <= not adder_out(n+1); 

    result <= Q_current;

end a5;
