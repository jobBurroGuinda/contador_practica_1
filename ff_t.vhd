library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ff_t is
    Port (
				clk : in  STD_LOGIC;
				Reset : in STD_LOGIC;
				T : in  STD_LOGIC;
				Q : out  STD_LOGIC;
				Q_N : out  STD_LOGIC
			 );
end ff_t;

architecture Behavioral of ff_t is
	signal q0 : std_logic;
begin
	
	process(clk, T)
	begin
		if clk'event and clk = '1' then
			if Reset = '1' then
				q0 <= '0';
			elsif Reset = '0' then
				if T = '1' then
					q0 <= not q0;
				elsif T = '0' then
					q0 <= q0;
				end if;
			end if;
		end if;
	end process;
	
	Q <= q0;
	Q_N <= not q0;

end Behavioral;
