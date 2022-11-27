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

    constant waitingTime : integer := 10; --Waktu tunggu lampu hijau dan merah
    constant yellowTime : integer := 5; --Waktu tunggu lampu kuning
    
    signal state, nextState: integer range 0 to 8 := 0;
    -- state lampu;

    signal timeout : std_logic := '0'; --condition untuk mengatur mode lampu
    signal Tl, Ts: std_logic := '0';  -- sinyal untuk menentukan durasi waktu tunggu

begin
    seq: process (clr, mode, timeout, clk)
    begin
        if mode = '0' then
            if clr = '1' then
                state <= 0;
            elsif timeout = '1' and rising_edge(clk) then
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
    comb: process (state)
    begin
        Tl <= '0'; Ts <= '0';
        case state is
            when 0 =>
                -- Timur hijau, sisanya merah, kuning mati semua
                green <= "1000"; 
                red <= "0111"; 
                yellow<= "0000";

                -- start timer
                Tl <= '1';
            
            when 1 =>
                -- Transisi
                -- Hijau mati semua, Timur dan Utara Kuning
                -- Barat dan Selatan Merah
                yellow <= "1100";
                red <= "0011";
                green <= "0000";

                -- start timer
                Ts <= '1';
            
            when 2 =>
                -- Utara hijau, sisanya merah, kuning mati semua
                green <= "0100"; 
                red <= "1011"; 
                yellow<= "0000";

                --start timer
                Tl <= '1';
            
            when 3 =>
                -- Transisi
                -- Hijau mati semua, Utara dan Barat Kuning
                -- Timur dan Selatan Merah
                yellow <= "0110";
                red <= "1001";
                green <= "0000";

                --start timer
                Ts <= '1';

            when 4 =>
                -- Barat hijau, sisanya merah, kuning mati semua
                green <= "0010"; 
                red <= "1101";
                yellow<= "0000";

                --start timer
                Tl <= '1';
            
            when 5 =>
                -- Transisi
                -- Hijau mati semua, Barat dan Selatan Kuning
                -- Timur dan Utara Merah
                yellow <= "0011";
                red <= "1100";
                green <= "0000";

                --start timer
                Ts <= '1';

            when 6 =>
                -- Selatan hijau, sisanya merah, kuning mati semua
                green <= "0001";
                red <= "1110";
                yellow<= "0000";

                --start timer
                Tl <= '1';
            
            when 7 =>
                -- Transisi
                -- Hijau mati semua, Selatan dan Timur Kuning
                yellow <= "1001";
                red <= "0110";
                green <= "0000";

                --start timer
                Ts <= '1';

            when 8 =>
                -- Semua merah
                green <= "0000";
                red <= "1111";
                yellow<= "0000";

                --start timer
                Tl <= '1';

        end case;
    end process;

    -- timer process
    timer: process(Tl, Ts, clk)
    variable count : integer;
    begin
        timeout <= '0';
        count := 0;
        if Tl = '1' then
            for i in 1 to waitingTime loop
                if rising_edge(clk) and count <= waitingTime then
                    count := count + 1;
                end if;
                if count = waitingTime then
                    nextState <= (state + 1) mod 8;
                end if;
                timeout <= '1';
        end loop;
        -- Tl <= '0';

        elsif Ts = '1' then
            -- timeout <= '0';
            -- count := 0;
            for i in 1 to yellowTime loop
                if rising_edge(clk) and count <= yellowTime then
                    count := count +1;
                end if;
                if count = yellowTime then
                    nextState <= (state + 1) mod 8;
                end if;
        end loop;
        timeout <= '1';
		
        -- Ts <= '0';
        end if;
    end process;
end architecture;

