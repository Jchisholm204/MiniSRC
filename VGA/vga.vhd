library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity top is
    port(
        -- VGA Output
        VGA_R        : out std_logic_vector(9 downto 0);
        VGA_G        : out std_logic_vector(9 downto 0);
        VGA_B        : out std_logic_vector(9 downto 0);
        VGA_CLK      : out std_logic;
        VGA_BLANK    : out std_logic;
        VGA_HS       : inout std_logic;
        VGA_VS       : inout std_logic;
        VGA_SYNC     : out std_logic;
        
		
        -- Clock Input (50 MHz)
		CLOCK_50     : in  std_logic;

        LEDG0        : out std_logic;
        LEDG1        : out std_logic

    );
end entity;

architecture rtl of top is

    type signal_state is (activeVideo, frontPorch, syncPulse, backPorch, blank);
    type vga_state    is (activeVideo, hSync, vSync);
    signal vidState : vga_state    := activeVideo;
    signal horState : signal_state := activeVideo;
    signal verState : signal_state := activeVideo;  

    signal vCount   : integer      := 0;
    signal hCount   : integer      := 0;

    signal CLOCK_25 : std_logic    := '0';
    signal clkCount : integer      := 0;

begin

    process(CLOCK_50) is
    begin
        if rising_edge(CLOCK_50) then
            if clkCount = 0 then
                CLOCK_25 <= '1';
            elsif clkCount = 1 then
                CLOCK_25 <= '0';
            end if;
            if clkCount = 1 then
                clkCount <= 0;
            else
                clkCount <= clkCount + 1;
            end if;
        end if;
    end process;

    process(CLOCK_25) is
    begin
        if rising_edge(CLOCK_25) then

            case vidState is
                when activeVideo =>
                    if hCount < 400 and hCount > 80 then
                        VGA_R       <= (others => '1');
                        VGA_G       <= (others => '0');
                        VGA_B       <= (others => '0');
                    else
                        VGA_R       <= (others => '0');
                        VGA_G       <= (others => '0');
                        VGA_B       <= (others => '1');
                    end if;
                    hCount      <= hCount + 1;
                    if hCount = 640 then
                        hCount   <= 0;
                        vCount   <= vCount + 1;
                        if vCount = 480 then
                            vCount   <= 0;
                            verState <= frontPorch;
                            horState <= blank;
                            vidState <= vSync;
                        else
                            vidState <= hSync;
                            verState <= activeVideo;
                            horState <= frontPorch;
                        end if;
                    else
                        vidState <= activeVideo;
                        horState <= activeVideo;
                        verState <= activeVideo;
                    end if;
                when hSync =>
                    VGA_R       <= (others => '0');
                    VGA_G       <= (others => '0');
                    VGA_B       <= (others => '0');
                    verState    <= activeVideo;
                    case horState is
                        when frontPorch =>
                            if hCount = 16 then
                                hCount      <= 0;
                                horState    <= syncPulse;
                            else
                                hCount      <= hCount + 1;
                                horState    <= frontPorch;
                            end if;
                            vidState    <= hSync;
                        when syncPulse =>
                            if hCount = 96 then
                                hCount      <= 0;
                                horState    <= backPorch;
                            else
                                hCount      <= hCount + 1;
                                horState    <= syncPulse;
                            end if;
                            vidState    <= hSync;
                        when backPorch =>
                            if hCount = 48 then
                                hCount      <= 0;
                                horState    <= activeVideo;
                                vidState    <= activeVideo;
                            else
                                hCount      <= hCount + 1;
                                horState    <= backPorch;
                                vidState    <= hSync;
                            end if;
                        when others =>
                            hCount   <= 0;
                            horState <= activeVideo;
                            vidState <= activeVideo;
                    end case; -- horState
                when vSync =>
                    VGA_R       <= (others => '0');
                    VGA_G       <= (others => '0');
                    VGA_B       <= (others => '0');
                    case verState is
                        when frontPorch =>
                            if vCount = 11 then
                                vCount      <= 0;
                                verState    <= syncPulse;
                            else
                                vCount      <= vCount + 1;
                                verState    <= frontPorch;
                            end if;
                            vidState    <= vSync;
                            horState    <= blank;
                        when syncPulse =>
                            if vCount = 2 then
                                vCount      <= 0;
                                verState    <= backPorch;
                            else
                                vCount      <= vCount + 1;
                                verState    <= syncPulse;
                            end if;
                            vidState    <= vSync;
                            horState    <= blank;
                        when backPorch =>
                            if vCount = 31 then
                                vCount      <= 0;
                                verState    <= activeVideo;
                                vidState    <= activeVideo;
                                horState    <= activeVideo;
                            else
                                vCount      <= vCount + 1;
                                verState    <= backPorch;
                                vidState    <= vSync;
                                horState    <= blank;
                            end if;
                        when others =>
                            vCount   <= 0;
                            verState <= activeVideo;
                            horState <= activeVideo;
                            vidState <= activeVideo;
                    end case; -- verState
            end case; -- vidState

            case verState is
                when activeVideo    => VGA_VS <= '1';
                                       LEDG0  <= '1';
                when frontPorch     => VGA_VS <= '1';
                                       LEDG0  <= '1';
                when syncPulse      => VGA_VS <= '0';
                                       LEDG0  <= '0';
                when backPorch      => VGA_VS <= '1';
                                       LEDG0  <= '1';
                when blank          => VGA_VS <= '0';
                                       LEDG0  <= '0';
                when others         => VGA_VS <= 'X';
                                       LEDG1  <= 'X';
            end case;

            case horState is
                when activeVideo    => VGA_HS <= '1';
                                       LEDG1  <= '1';
                when frontPorch     => VGA_HS <= '1';
                                       LEDG1  <= '1';
                when syncPulse      => VGA_HS <= '0';
                                       LEDG1  <= '0';
                when backPorch      => VGA_HS <= '1';
                                       LEDG1  <= '1';
                when blank          => VGA_HS <= '0';
                                       LEDG1  <= '0';
                when others         => VGA_HS <= 'X';
                                       LEDG1  <= 'X';
            end case;

        end if;
    end process;

    -- use sysclock for vga clk (800x600, 72Hz) => 50MHz pixel clock
    VGA_CLK      <= CLOCK_50;

    VGA_SYNC     <= VGA_HS;
    VGA_BLANK    <= VGA_HS and VGA_VS;
    

end architecture;

