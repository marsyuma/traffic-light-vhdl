library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity lightcounter is
    Port ( 
        clr : in std_logic;
        clk : in std_logic;
        switch : in std_logic_vector(1 downto 0);
        status: inout integer range 0 to 1
    );
end lightcounter;

architecture count_arch of lightcounter is
    signal waitingTime :integer := 10;
    signal yellowTime : integer := 5;
    signal seg1, seg2 : std_logic_vector(6 downto 0);
    signal count : integer := 0;
    begin
        timer: process(clr,clk)
        variable counter : integer := 0;
        begin
            if(rising_edge(clk)) then
                if(clr = '1') then
                    counter := 0;
                elsif(switch = "10") then
                    status <= 0;
                    if(counter < waitingTime) then
                        counter := counter + 1;
                        count <= counter;
                        case count is
                            when 0 => seg2 <= "0000110"; seg1 <= "0111111";
                            when 1 => seg2 <= "1011011"; seg1 <= "0111111";
                            when 2 => seg2 <= "1001111"; seg1 <= "0111111";
                            when 3 => seg2 <= "1100110"; seg1 <= "0111111";
                            when 4 => seg2 <= "1101101"; seg1 <= "0111111";
                            when 5 => seg2 <= "1111101"; seg1 <= "0111111";
                            when 6 => seg2 <= "0000111"; seg1 <= "0111111";
                            when 7 => seg2 <= "1111111"; seg1 <= "0111111";
                            when 8 => seg2 <= "1101111"; seg1 <= "0111111";
                            when 9 => seg2 <= "0000110"; seg1 <= "0111111";
                            when 10 => seg1 <= "0000110"; seg2 <= "0111111";
                            when 11 => seg1 <= "0000110"; seg2 <= "0000110";
                            when 12 => seg1 <= "0000110"; seg2 <= "1011011";
                            when 13 => seg1 <= "0000110"; seg2 <= "1001111";
                            when 14 => seg1 <= "0000110"; seg2 <= "1100110";
                            when 15 => seg1 <= "0000110"; seg2 <= "1101101";
                            when 16 => seg1 <= "0000110"; seg2 <= "1111101";
                            when 17 => seg1 <= "0000110"; seg2 <= "0000111";
                            when 18 => seg1 <= "0000110"; seg2 <= "1111111";
                            when 19 => seg1 <= "0000110"; seg2 <= "1101111";
                            when 20 => seg1 <= "1011011"; seg2 <= "0111111";                            
                            when others => seg1 <= "0111111"; seg2 <= "0111111";
                        end case;
                        if (counter = waitingTime) then
                            status <= 1;
                        end if;
                    else
                        counter := 0;
                    end if;
                elsif(switch = "01") then
                    status <= 0;
                    if(counter < yellowTime) then
                        count <= counter;
                        counter := counter + 1;
                        
                        case count is
                            when 0 => seg2 <= "0000110"; seg1 <= "0111111";
                            when 1 => seg2 <= "1011011"; seg1 <= "0111111";
                            when 2 => seg2 <= "1001111"; seg1 <= "0111111";
                            when 3 => seg2 <= "1100110"; seg1 <= "0111111";
                            when 4 => seg2 <= "1101101"; seg1 <= "0111111";
                            when 5 => seg2 <= "1111101"; seg1 <= "0111111";
                            when 6 => seg2 <= "0000111"; seg1 <= "0111111";
                            when 7 => seg2 <= "1111111"; seg1 <= "0111111";
                            when 8 => seg2 <= "1101111"; seg1 <= "0111111";
                            when 9 => seg2 <= "0000110"; seg1 <= "0111111";
                            when 10 => seg1 <= "0000110"; seg2 <= "0111111";
                            when 11 => seg1 <= "0000110"; seg2 <= "0000110";
                            when 12 => seg1 <= "0000110"; seg2 <= "1011011";
                            when 13 => seg1 <= "0000110"; seg2 <= "1001111";
                            when 14 => seg1 <= "0000110"; seg2 <= "1100110";
                            when 15 => seg1 <= "0000110"; seg2 <= "1101101";
                            when 16 => seg1 <= "0000110"; seg2 <= "1111101";
                            when 17 => seg1 <= "0000110"; seg2 <= "0000111";
                            when 18 => seg1 <= "0000110"; seg2 <= "1111111";
                            when 19 => seg1 <= "0000110"; seg2 <= "1101111";
                            when 20 => seg1 <= "1011011"; seg2 <= "0111111";                            
                            when others => seg1 <= "0111111"; seg2 <= "0111111";
                        end case;
                        if (counter = yellowTime) then
                            status <= 1;
                        end if;
                    else
                        counter := 0;
                    end if;
                end if;
            end if;
        end process;

        
        
end architecture;