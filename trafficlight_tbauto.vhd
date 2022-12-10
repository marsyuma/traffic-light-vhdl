library ieee;
use ieee.std_logic_1164.all;

entity trafficlight_main_testbenchauto is
end entity trafficlight_main_testbenchauto;

architecture testbench of trafficlight_main_testbenchauto is
    component trafficlight_main is
        port(
            clr: in std_logic;
            clk: in std_logic;
            mode: in std_logic;
            condition : in integer range 0 to 4;
            green: out std_logic_vector(3 downto 0);
            yellow: out std_logic_vector(3 downto 0);
            red: out std_logic_vector(3 downto 0)
        );
    end component trafficlight_main;

    signal clr: std_logic;
    signal clk: std_logic;
    signal mode: std_logic;
    signal condition: integer range 0 to 4;
    signal green: std_logic_vector(3 downto 0);
    signal yellow: std_logic_vector(3 downto 0);
    signal red: std_logic_vector(3 downto 0);
    constant clk_period: time := 25 ps;
    

begin
    dut: trafficlight_main port map(
        clr => clr,
        clk => clk,
        mode => mode,
        condition => condition,
        green => green,
        yellow => yellow,
        red => red
    );

    CLOCK: process
    begin
     clk <= '0';
     wait for clk_period / 2;
     clk <= '1';
     wait for clk_period / 2;
    end process CLOCK;
    -- Testbench Manual
    test_stimuli: process
    begin
        -- Reset the design
        clr <= '0';
        mode <= '0';
        wait for 10 ns;

        -- Provide input stimuli and simulate the design for a sufficient
        -- amount of time to allow the outputs to settle
        -- Check the output responses to verify that they match the expected behavior

        -- Test case 1: Automatic mode with condition = 0
        condition <= 0;
        wait for 100 ns;
        assert (green = "1000") and (yellow = "0000") and (red = "0111") report "Test case 1 failed" severity error;
        -- Stop the testbench
        wait;
    end process;
end architecture testbench;