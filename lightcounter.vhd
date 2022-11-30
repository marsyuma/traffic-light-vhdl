library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity lightcounter is
    Port ( 
        clr : in std_logic;
        clk : in std_logic;
        switch : in std_logic_vector(1 downto 0);
        status: out std_logic
    );
end lightcounter;

architecture count_arch of lightcounter is
    signal waitingTime :integer := 10;
    signal yellowTime : integer := 5;
    begin
        process(clr,clk)
            variable counter : integer := 0;
        begin
            if(rising_edge(clk)) then
                if(clr = '1') then
                    counter := 0;
                    status <= '0';
                elsif(switch = "10") then
                    if(counter < waitingTime) then
                        counter := counter + 1;
                        if (counter = waitingTime) then
                            status <= '1';
                        end if;
                    else
                        counter := 0;
                    end if;
                elsif(switch = "01") then
                    if(counter < yellowTime) then
                        counter := counter + 1;
                        if (counter = yellowTime) then
                            status <= '1';
                        end if;
                    else
                        counter := 0;
                    end if;
                end if;
            end if;
        end process;
end architecture;