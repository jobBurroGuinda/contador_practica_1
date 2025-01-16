library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity contador is
		Port ( T : in  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (3 downto 0);
			  Clk50Mhz : in  STD_LOGIC;
           led : out  STD_LOGIC;
           Reset : in  STD_LOGIC
		);
end contador;

architecture Behavioral of contador is
	signal q_s : STD_LOGIC_VECTOR (3 downto 0);
	signal q_n : STD_LOGIC_VECTOR (3 downto 0);
	constant max_count: integer := 5;
	signal count: INTEGER range 0 to max_count;
	signal clk_state: std_logic := '0';
begin

	DivisorFrec: process(Clk50Mhz, clk_state, count)
	begin
		if Clk50Mhz'event and Clk50Mhz = '1' then
			if count < max_count then
				count <= count+1;
			else
				clk_state <= not clk_state;
				count <= 0;
			end if;
		end if;
	end process;

	ff_0: work.ff_t PORT MAP(
		clk => clk_state,
		Reset => Reset,
		T => T,
		Q => q_s(0),
		Q_N => q_n(0)
	);

	ff_1: work.ff_t PORT MAP(
		clk => q_s(0),
		Reset => Reset,
		T => q_s(0),
		Q => q_s(1),
		Q_N => q_n(1)
	);

	ff_2: work.ff_t PORT MAP(
		clk => q_s(1),
		Reset => Reset,
		T => q_s(1),
		Q => q_s(2),
		Q_N => q_n(2)
	);

	ff_3: work.ff_t PORT MAP(
		clk => q_s(2),
		Reset => Reset,
		T => q_s(2),
		Q => q_s(3),
		Q_N => q_n(3)
	);
	
	led <= clk_state;
	Q <= q_s;

end Behavioral;

