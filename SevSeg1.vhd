library ieee;
use ieee.std_logic_1164.all;

entity SevSeg1 is
    port (
        in_sv1: in std_logic_vector(3 downto 0);
        out_sv1: out std_logic_vector(6 downto 0)
    );
end SevSeg1;

architecture behavioral of SevSeg1 is
begin
    proc: process (in_sv1)
    begin
        case in_sv1 is
            when "0000" => out_sv1 <= "0111111"; -- 0
            when "0001" => out_sv1 <= "0000110"; -- 1
            when "0010" => out_sv1 <= "1011011"; -- 2
            when "0011" => out_sv1 <= "1001111"; -- 3
            when "0100" => out_sv1 <= "1100110"; -- 4
            when "0101" => out_sv1 <= "1101101"; -- 5
            when "0110" => out_sv1 <= "1111101"; -- 6
            when "0111" => out_sv1 <= "0000111"; -- 7
            when "1000" => out_sv1 <= "1111111"; -- 8
            when "1001" => out_sv1 <= "1101111"; -- 9
            when others => out_sv1 <= "0000000"; -- OFF
        end case;
    end process proc;
end behavioral;
