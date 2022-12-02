library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all ;

entity testbench is
end testbench ; 

architecture test of testbench is
    --Component dari trafficlight_main
    component trafficlight_main
        port (
            clr: in std_logic;
            clk: in std_logic;
            mode: in std_logic;
            button: in integer range 0 to 5 := 0;
            green: out std_logic_vector(3 downto 0);
            yellow: out std_logic_vector(3 downto 0);
            red: out std_logic_vector(3 downto 0)
        );
    end component ;
    -- Intermediate Signal
    signal clk, clr, mode: std_logic;
    signal button: integer range 0 to 5 := 0;
    signal green: std_logic_vector(3 downto 0);
    signal yellow: std_logic_vector(3 downto 0);
    signal red: std_logic_vector(3 downto 0);
    constant period: time := 10 ns;
begin
    --Inisialisasi
    UUT: trafficlight_main port map (
        clr => clr,
        clk => clk,
        mode => mode,
        button => button,
        green => green,
        yellow => yellow,
        red => red
    );

    -- Testbench Manual
    tb_manual: process
    begin
        clr <= '0';
        mode <= '1';
        for i in 0 to 4 loop
            button <= i;
            wait for period;
            assert((
                (green = "0000" and yellow = "0000" and red = "1111") or -- State 8
                (green = "1000" and yellow = "0000" and red = "0111") or -- State 0
                (green = "0100" and yellow = "0000" and red = "1011") or -- State 2
                (green = "0010" and yellow = "0000" and red = "1101") or -- State 4
                (green = "0001" and yellow = "0000" and red = "1110") -- State 6 
            ));
            report "State salah pada button ke-" & integer'image(i) severity error;
        end loop;
        wait;
    end process;

    -- Testbench Auto
    tb_auto: process
    begin
        for i in 0 to 8 loop
            clr <= '0';
            mode <= '0';
            wait for period;
            assert((
                (green = "1000" and yellow = "0000" and red = "0111") or -- State 0
                (green = "0000" and yellow = "1100" and red = "0011") or -- State 1
                (green = "0100" and yellow = "0000" and red = "1011") or -- State 2
                (green = "0000" and yellow = "1100" and red = "0011") or -- State 3
                (green = "0010" and yellow = "0000" and red = "1101") or -- State 4
                (green = "0000" and yellow = "1100" and red = "0011") or -- State 5
                (green = "0001" and yellow = "0000" and red = "1110") or -- State 6
                (green = "0000" and yellow = "1100" and red = "0011") or -- State 7
                (green = "0000" and yellow = "0000" and red = "1111") -- State 8
            ));
            report "State salah pada looping ke-" & integer'image(i) severity error;
        end loop;
        wait;
    end process;
end architecture test;