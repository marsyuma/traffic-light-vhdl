library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SevSeg is 
    port (
        INPUT : in std_logic_vector(3 downto 0);
        OUTPUT: out std_logic_vector(6 downto 0)

    );
end entity SevSeg;

architecture sevensegment of SevSeg is

    begin
		  segment : process(INPUT) is
		  begin
        case (INPUT) is
        when "0000" => OUTPUT <= "0111111";
        when "0001" => OUTPUT <= "0000110";
        when "0010" => OUTPUT <= "1011011";
        when "0011" => OUTPUT <= "1001111";
        when "0100" => OUTPUT <= "1100110";
        when "0101" => OUTPUT <= "1101101";
        when "0110" => OUTPUT <= "1111101";
        when "0111" => OUTPUT <= "0000111";
        when "1000" => OUTPUT <= "1111111";
        when "1001" => OUTPUT <= "1101111";
        when "1010" => OUTPUT <= "1110111";
        when "1011" => OUTPUT <= "1111100";
        when "1100" => OUTPUT <= "0111001";
        when "1101" => OUTPUT <= "1011110";
        when "1110" => OUTPUT <= "1111001";
        when "1111" => OUTPUT <= "1110001";
        when others => OUTPUT <= "0000000";
        end case;
    end process segment;
end architecture sevensegment;
