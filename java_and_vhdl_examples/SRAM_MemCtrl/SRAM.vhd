----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:09:21 05/03/2017 
-- Design Name: 
-- Module Name:    SRAM - Behavioral 
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

entity SRAM is
    Port ( oe : in  STD_LOGIC;
           we : in  STD_LOGIC;
           addr : in  STD_LOGIC_VECTOR (2 downto 0);
           data_in : in  STD_LOGIC_VECTOR (3 downto 0);
			  bus_id : in std_logic;
           data_out : out  STD_LOGIC_VECTOR (3 downto 0));
end SRAM;

architecture Behavioral of SRAM is
--size (2^3)-1 = 8-1 
type mem_data_type is array (7 downto 0) of std_logic_vector(3 downto 0);

signal mem_data: mem_data_type;
signal oe_we: std_logic_vector(1 downto 0);
signal data_temp : std_logic_vector(3 downto 0);


begin

	oe_we<=oe & we;

	process(oe_we,mem_data,addr,data_in,data_temp,bus_id) is begin
	--if bus_id='0' then

		case(oe_we) is 
			when "10" => data_temp<=mem_data(to_integer(unsigned(addr)));
			when "01" => data_temp<=data_in;
			when others => data_temp<=data_temp;
		end case;
	--end if;
	end process;


	data_out<=data_temp;

	process(oe_we, addr,mem_data,data_in,bus_id) is begin
	--if bus_id='0' then
	if oe_we = "01" then
		mem_data(to_integer(unsigned(addr))) <= data_in;
	end if;
--end if;
	end process;






end Behavioral;

