library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity trafficlight_main is
    port(
        clr: in std_logic;
        clk: in std_logic;
        mode: in std_logic;
        condition : in integer range 0 to 4;
        green: out std_logic_vector(3 downto 0);
        yellow: out std_logic_vector(3 downto 0);
        red: out std_logic_vector(3 downto 0)
    );
end entity trafficlight_main;

architecture behavior of trafficlight_main is
    component lightcounter is
        port(
            clr: in std_logic;
            clk: in std_logic;
            switch: in std_logic_vector(1 downto 0);
            status: inout integer range 0 to 1
        );
    end component lightcounter;
    
    type stateType is (S0, S1, S2, S3, S4, S5, S6, S7, S8);
    signal state, nextState: stateType;
    -- state lampu;
    signal status: integer range 0 to 1 := 0;
    signal switch : std_logic_vector(1 downto 0) := "00";  -- sinyal untuk menentukan durasi waktu tunggu
    signal waitingTime :integer := 10;
    signal yellowTime : integer := 5;

begin
    timer: lightcounter port map(
        clr => clr,
        clk => clk,
       switch => switch,
        status => status
  );

    seq: process (clr, mode, clk, condition, state)
    begin
        if mode = '0' then
            if clr = '1' then
                state <= S0;
            else if rising_edge(clk) and status = 1 then
                state <= nextState;
            end if;
        end if;

        -- manual mode
        elsif mode = '1' then
            if condition = 0 then
                state <= S8;
            elsif condition = 1 then
                state <= S0;
            elsif condition = 2 then
                state <= S2;
            elsif condition = 3 then
                state <= S4;
            elsif condition = 4 then
                state <= S6;
            end if;
        end if;
    end process;

    -- Mode otomatis
    comb: process (state, status)
    begin
        switch <= "00";
        case state is
            when S0 =>
                -- Timur hijau, sisanya merah, kuning mati semua
                green <= "1000"; 
                red <= "0111"; 
                yellow<= "0000";

                -- start timer
                switch <= "10";
                nextState <= S1;
            

            when S1 =>
                -- Transisi
                -- Hijau mati semua, Timur dan Utara Kuning
                -- Barat dan Selatan Merah
                yellow <= "1100";
                red <= "0011";
                green <= "0000";

                -- start timer
                switch <= "01";
                nextState <= S2;
                
            
            when S2 =>
                -- Utara hijau, sisanya merah, kuning mati semua
                green <= "0100"; 
                red <= "1011"; 
                yellow<= "0000";

                --start timer
                switch <= "10";
                nextState <= S3;
            
            when S3 =>
                -- Transisi
                -- Hijau mati semua, Utara dan Barat Kuning
                -- Timur dan Selatan Merah
                yellow <= "0110";
                red <= "1001";
                green <= "0000";

                --start timer
                switch <= "01";
                nextState <= S4;

            when S4 =>
                -- Barat hijau, sisanya merah, kuning mati semua
                green <= "0010"; 
                red <= "1101";
                yellow<= "0000";

                --start timer
                switch <= "10";
                nextState <= S5;
            
            when S5 =>
                -- Transisi
                -- Hijau mati semua, Barat dan Selatan Kuning
                -- Timur dan Utara Merah
                yellow <= "0011";
                red <= "1100";
                green <= "0000";

                --start timer
                switch <= "01";
                nextState <= S6;

            when S6 =>
                -- Selatan hijau, sisanya merah, kuning mati semua
                green <= "0001";
                red <= "1110";
                yellow<= "0000";

                --start timer
                switch <= "10";
                nextState <= S7;
            
            when S7 =>
                -- Transisi
                -- Hijau mati semua, Selatan dan Timur Kuning
                yellow <= "1001";
                red <= "0110";
                green <= "0000";

                --start timer
                switch <= "01";
                nextState <= S0;
            
            when S8 =>
                -- Merah semua
                red <= "1111";
                green <= "0000";
                yellow <= "0000";
                
        end case;
    end process;

end architecture;
