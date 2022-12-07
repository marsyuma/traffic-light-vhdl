library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity trafficlight_main is
    port(
        clr: in std_logic;
        clk: in std_logic;
        mode: in std_logic;
        button: in integer range 0 to 4 := 0;
        green: out std_logic_vector(3 downto 0);
        yellow: out std_logic_vector(3 downto 0);
        red: out std_logic_vector(3 downto 0)
    );
end entity trafficlight_main;

architecture behavior of trafficlight_main is
    component SevSeg0 is
        port (
            in_sv0: in std_logic_vector(3 downto 0);
            out_sv0: out std_logic_vector(6 downto 0)
        );
    end component SevSeg0;

    component SevSeg1 is
        port (
            in_sv1: in std_logic_vector(3 downto 0);
            out_sv1: out std_logic_vector(6 downto 0)
        );
    end component SevSeg1;
    
    -- type arrayCounter is array (0 to 8) of integer;
    -- signal counter: arrayCounter := (0, 0, 0, 0, 0, 0, 0, 0, 0);
    signal state, nextState: integer range 0 to 8 := 0;
    signal counter: integer := 0;
    signal in_sv0: std_logic_vector(3 downto 0);
    signal out_sv0: std_logic_vector(6 downto 0);
    signal in_sv1: std_logic_vector(3 downto 0);
    signal out_sv1: std_logic_vector(6 downto 0);
begin
    SevSegment_Digit0 : SevSeg0 port map(
        in_sv0 => in_sv0,
        out_sv0 => out_sv0
    ); 

    SevSegment_Digit1 : SevSeg1 port map(
        in_sv1 => in_sv1,
        out_sv1 => out_sv1
    ); 
    
    -- Proses Sinkronius
    seq: process (clr, clk)
    begin
        if mode = '0' then
            if clr = '1' then
                state <= 0;
            elsif rising_edge(clk) then
                state <= nextState;
            end if;
        
        -- Mode Manual
        elsif mode = '1' then
            case button is
                when 0 => state <= 8;
                when 1 => state <= 0;
                when 2 => state <= 2;
                when 3 => state <= 4;
                when 4 => state <= 6;
                when others => null;
            end case;
        end if;
    end process;

    -- Mosde Otomatis
    comb: process (state)
        variable count: integer := 0;
    begin    
        case state is
            -- Merah (15 sekon), Hijau (15 sekon), Kuning (5 sekon)
            when 0 =>
                -- Timur hijau, sisanya merah, kuning mati semua
                green <= "1000"; yellow <= "0000"; red <= "0111";
                in_sv1 <= "0001"; in_sv0 <= "0101"; -- SvSeg = 15 sekon
                for i in 1 to 15 loop
                    count := count + 1;
                end loop;
                counter <= count;
                nextState <= 1;

            when 1 =>
                -- Transisi
                -- Hijau mati semua, Timur dan Utara Kuning
                -- Barat dan Selatan Merah
                green <= "0000"; yellow <= "1100"; red <= "0011";
                in_sv0 <= "0000"; in_sv1 <= "0101"; -- SvSeg = 5 sekon
                count := 0;
                for i in 1 to 5 loop
                    count := count + 1;
                end loop;
                counter <= count;
                nextState <= 2;

            when 2 =>
                -- Utara hijau, sisanya merah, kuning mati semua
                green <= "0100"; yellow <= "0000"; red <= "1011";
                -- Display = 15 sekon
                in_sv1 <= "0001"; in_sv0 <= "0101"; -- SvSeg = 15 sekon
                count := 0;
                for i in 1 to 15 loop
                    count := count + 1;
                end loop;
                counter <= count;
                nextState <= 3;

            when 3 =>
                -- Transisi
                -- Hijau mati semua, Utara dan Barat Kuning
                -- Timur dan Selatan Merah
                green <= "0000"; yellow <= "0110"; red <= "1001";
                in_sv0 <= "0000"; in_sv1 <= "0101"; -- SvSeg = 5 sekon
                count := 0;
                for i in 1 to 5 loop
                    count := count + 1;
                end loop;
                counter <= count;
                nextState <= 4;

            when 4 =>
                -- Barat hijau, sisanya merah, kuning mati semua
                green <= "0010"; red <= "1101"; yellow <= "0000";
                in_sv0 <= "0000"; in_sv1 <= "0101"; -- SvSeg = 5 sekon
                count := 0;
                for i in 1 to 5 loop
                    count := count + 1;
                end loop;
                counter <= count;
                nextState <= 5;

            when 5 =>
                -- Transisi
                -- Hijau mati semua, Barat dan Selatan Kuning
                -- Timur dan Utara Merah
                green <= "0000"; yellow <= "0011"; red <= "1100";
                in_sv0 <= "0000"; in_sv1 <= "0101"; -- SvSeg = 5 sekon
                count := 0;
                for i in 1 to 5 loop
                    count := count + 1;
                end loop;
                counter <= count;
                nextState <= 6;

            when 6 =>
                -- Selatan hijau, sisanya merah, kuning mati semua
                green <= "0001"; yellow <= "0000"; red <= "1110";
                in_sv1 <= "0001"; in_sv0 <= "0101"; -- SvSeg = 15 sekon
                count := 0;
                for i in 1 to 15 loop
                    count := count + 1;
                end loop;
                counter <= count;
                nextState <= 7;
            
            when 7 =>
                -- Transisi
                -- Hijau mati semua, Selatan dan Timur Kuning
                green <= "0000"; yellow <= "1001"; red <= "0110";
                in_sv1 <= "0001"; in_sv0 <= "0101"; -- SvSeg = 15 sekon
                count := 0;
                for i in 1 to 15 loop
                    count := count + 1;
                end loop;
                counter <= count;
                nextState <= 8;

            when 8 =>
                -- Merah semua
                green <= "0000"; yellow <= "0000"; red <= "1111";
                in_sv1 <= "0001"; in_sv0 <= "0101"; -- SvSeg = 15 sekon
                count := 0;
                for i in 1 to 15 loop
                    count := count + 1;
                end loop;
                counter <= count;
                nextState <= 0;
        end case;
    end process;
end architecture;
