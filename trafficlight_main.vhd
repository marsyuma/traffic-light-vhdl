library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity trafficlight is
    port(
        clr: in std_logic;
        clk: in std_logic;
        mode: in std_logic;
        switch: in std_logic_vector(3 downto 0);
        green: out std_logic_vector(3 downto 0);
        yellow: out std_logic_vector(3 downto 0);
        red: out std_logic_vector(3 downto 0)
    );
end entity trafficlight;

architecture behavior of trafficlight is
    signal state: integer range 0 to 11;
    -- variable pre_status: integer := 0;
    signal timeout: std_logic := '0'; -- flag : '1' if timeout in any state
    signal Tl, Ts: std_logic := '0';  -- signals to trigger timer function : Tl - long time, Ts - short time

    begin

end architecture;

