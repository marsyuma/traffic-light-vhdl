library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity trafficlight is
    port(
        clr: in std_logic;
        clk: in std_logic;
        mode: in std_logic;
        condition : in integer range 0 to 4;
        green: out std_logic_vector(3 downto 0);
        yellow: out std_logic_vector(3 downto 0);
        red: out std_logic_vector(3 downto 0)
    );
end entity trafficlight;

architecture behavior of trafficlight is
    component lightcounter is
        port(
            clr: in std_logic;
            clk: in std_logic;
            switch: in std_logic_vector(1 downto 0);
            status: out std_logic
        );
    end component lightcounter;
    
    signal state, nextState: integer range 0 to 8 := 0;
    -- state lampu;
    signal status: std_logic;
    signal switch : std_logic_vector(1 downto 0) := "00";  -- sinyal untuk menentukan durasi waktu tunggu

begin
    UUT: lightcounter port map(
        clr => clr,
        clk => clk,
        switch => switch,
        status => status
    );

    seq: process (clr, mode, clk)
    begin
        if mode = '0' then
            if clr = '1' then
                state <= 0;
            elsif rising_edge(clk) then
                state <= nextState;
            end if;

        -- manual mode
        elsif mode = '1' then
            if condition = 0 then
                state <= 8;
            elsif condition = 1 then
                state <= 0;
            elsif condition = 2 then
                state <= 2;
            elsif condition = 3 then
                state <= 4;
            elsif condition = 4 then
                state <= 6;
            end if;
        end if;
    end process;

    -- Mode otomatis
    comb: process (state, status)
    begin
        switch <= "00";
        case state is
            when 0 =>
                -- Timur hijau, sisanya merah, kuning mati semua
                green <= "1000"; 
                red <= "0111"; 
                yellow<= "0000";

                -- start timer
                switch <= "10";
                if(status = '1') then
                    nextState <= (state + 1) mod 8;
                else 
                    nextState <= state;
                end if;

            when 1 =>
                -- Transisi
                -- Hijau mati semua, Timur dan Utara Kuning
                -- Barat dan Selatan Merah
                yellow <= "1100";
                red <= "0011";
                green <= "0000";

                -- start timer
                switch <= "01";
                if(status = '1') then
                    nextState <= (state + 1) mod 8;
                else 
                    nextState <= state;
                end if;
            
            when 2 =>
                -- Utara hijau, sisanya merah, kuning mati semua
                green <= "0100"; 
                red <= "1011"; 
                yellow<= "0000";

                --start timer
                switch <= "10";
                if(status = '1') then
                    nextState <= (state + 1) mod 8;
                else 
                    nextState <= state;
                end if;
            
            when 3 =>
                -- Transisi
                -- Hijau mati semua, Utara dan Barat Kuning
                -- Timur dan Selatan Merah
                yellow <= "0110";
                red <= "1001";
                green <= "0000";

                --start timer
                switch <= "01";
                if(status = '1') then
                    nextState <= (state + 1) mod 8;
                else 
                    nextState <= state;
                end if;

            when 4 =>
                -- Barat hijau, sisanya merah, kuning mati semua
                green <= "0010"; 
                red <= "1101";
                yellow<= "0000";

                --start timer
                switch <= "10";
                if(status = '1') then
                    nextState <= (state + 1) mod 8;
                else 
                    nextState <= state;
                end if;
            
            when 5 =>
                -- Transisi
                -- Hijau mati semua, Barat dan Selatan Kuning
                -- Timur dan Utara Merah
                yellow <= "0011";
                red <= "1100";
                green <= "0000";

                --start timer
                switch <= "01";
                if(status = '1') then
                    nextState <= (state + 1) mod 8;
                else 
                    nextState <= state;
                end if;

            when 6 =>
                -- Selatan hijau, sisanya merah, kuning mati semua
                green <= "0001";
                red <= "1110";
                yellow<= "0000";

                --start timer
                switch <= "10";
                if(status = '1') then
                    nextState <= (state + 1) mod 8;
                else 
                    nextState <= state;
                end if;
            
            when 7 =>
                -- Transisi
                -- Hijau mati semua, Selatan dan Timur Kuning
                yellow <= "1001";
                red <= "0110";
                green <= "0000";

                --start timer
                switch <= "01";
                if(status = '1') then
                    nextState <= 0;
                else 
                    nextState <= state;
                end if;
            
            when 8 =>
                -- Merah semua
                red <= "1111";
                green <= "0000";
                yellow <= "0000";
                nextState <= 0;
        end case;
    end process;

end architecture;

