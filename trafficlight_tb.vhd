library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity testbench is
end testbench ; 

architecture test of testbench is
    --component dari trafficlight_main
    component trafficlight_main
        port (
            clr: in std_logic;
            clk: in std_logic;
            mode: in std_logic;
            switch: in std_logic_vector(3 downto 0);
            green: out std_logic_vector(3 downto 0);
            yellow: out std_logic_vector(3 downto 0);
            red: out std_logic_vector(3 downto 0)
        ) ;
    end component ;
begin

end architecture test ;