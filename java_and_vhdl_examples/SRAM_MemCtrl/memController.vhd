----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:19:13 05/03/2017 
-- Design Name: 
-- Module Name:    memController - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memController is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           bus_id : in  STD_LOGIC;
           rw : in  STD_LOGIC;
           ready : in  STD_LOGIC;
           burst : in  STD_LOGIC;
           addr : in  STD_LOGIC_VECTOR (2 downto 0);
           oe : out  STD_LOGIC;
           we : out  STD_LOGIC;
           offset : out  STD_LOGIC_VECTOR (1 downto 0));
end memController;

architecture Behavioral of memController is
type state_type is (idle, writing, readystate, reading, burstnotdone,burstwait);
	--make state type 
	signal state, next_state : state_type;
	
	signal burstcnt : Integer range 0 to 3;
	signal offset_internal : Integer range 0 to 3;
	--std_logic_vector(1 downto 0);
begin
--upon not resetting, state will assume the next state
	SYNC_PROC : process(clk, reset)
	begin
		if(clk'event and clk='1') then
			if (reset = '1') then
				state<=idle;
			else
				state<= next_state;
			end if;
		end if;
	end process;


--move between states based on conditions
next_state_decode : process(clk, reset, state, next_state, bus_id, rw, ready, burst, addr,burstcnt)
begin
	
		--next_state<=state;
		case (state) is
			
			when (idle) =>
			if ready='1' then
				if rw='0' then
					next_state<=writing;
					
				elsif rw='1' then
					next_state<=reading;
				end if;
			end if;
			when (writing) =>
				if ready = '1' then 
					next_state<=readystate;
				elsif ready ='0' then
					next_state<=writing;
				end if;
				
			when (reading)=>
				if burst ='0' then 
				--normal read
					if ready = '1' then 
						next_state<=readystate;
					elsif ready ='0' then
						next_state<=reading;
					end if;
				
				elsif burst='1' then 
					if ready = '1' AND burstcnt=0 then 
						next_state<=readystate;
					elsif ready ='1' AND burstcnt>0 then
						next_state<=burstwait;
					elsif ready='0' then
						next_state<=reading;
						end if;
				end if;
			
				when(burstwait)=>
					if ready='0' then 
					
					--next_state<=burstwait;   else
					
					next_state<=burstnotdone;
					end if;
					
			
				when(burstnotdone) =>
					next_state<=reading;
					
				when(readystate) =>
				if ready = '0' then
					next_state<=idle;
					end if;
			
			
			when others =>
			--should not reach this case, but if it goes here unexpectedly, ill edit this to diagnose.
			next_state<=idle;
			end case;


end process;

oe_proc : process(clk,reset) begin
if(clk'event and clk='1') then
	if reset ='0' then
		case (state) is
			when (reading) => 
			oe<='1';
			when others =>
			oe<='0';
			end case;
			end if;
			end if;

end process;

we_proc : process(clk,reset) begin
if(clk'event and clk='1') then
	if reset ='0' then
		case (state) is
			when (writing) => 
			we<='1';
			when others =>
			we<='0';
			end case;
			end if;
			end if;

end process;

offset_proc : process(clk,reset) begin
if(clk'event and clk='1') then
	if reset ='0' then
		case (state) is
			when (burstnotdone) => 
			
			offset_internal<=offset_internal+1;
			
			when (idle)=>
			offset_internal<=0;
			
			when others =>
			
			
			end case;
			end if;
			end if;

end process;

burstcntproc_proc : process(clk,reset) begin
if(clk'event and clk='1') then
	if reset ='0' then
		case (state) is
			when (burstnotdone) => 
			burstcnt<=burstcnt-1;
			
			when (idle) =>
			burstcnt<=3;
			
			
			when others =>
			
			end case;
			end if;
			end if;

end process;

offset<=std_logic_vector(to_unsigned(offset_internal,2));



end Behavioral;


