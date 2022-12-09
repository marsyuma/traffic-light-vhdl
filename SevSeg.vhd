library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SevSeg is 
    port (
        segIn : in std_logic_vector(3 downto 0);
        segOut: out std_logic_vector(6 downto 0)

    );
end entity SevSeg;

architecture sevensegment of SevSeg is

    begin
		segment : process(segIn) is
		begin
            case (segIn) is
            when "0000" => segOut <= "0111111";
            when "0001" => segOut <= "0000110";
            when "0010" => segOut <= "1011011";
            when "0011" => segOut <= "1001111";
            when "0100" => segOut <= "1100110";
            when "0101" => segOut <= "1101101";
            when "0110" => segOut <= "1111101";
            when "0111" => segOut <= "0000111";
            when "1000" => segOut <= "1111111";
            when "1001" => segOut <= "1101111";
            when "1010" => segOut <= "1110111";
            when "1011" => segOut <= "1111100";
            when "1100" => segOut <= "0111001";
            when "1101" => segOut <= "1011110";
            when "1110" => segOut <= "1111001";
            when "1111" => segOut <= "1110001";
            when others => segOut <= "0000000";
            end case;
    end process segment;
end architecture sevensegment;
