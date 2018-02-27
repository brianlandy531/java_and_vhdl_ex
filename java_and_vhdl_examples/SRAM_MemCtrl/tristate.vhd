----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:17:16 05/03/2017 
-- Design Name: 
-- Module Name:    tristate - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tristate is
Port ( inputport    : in  STD_LOGIC_vector(3 downto 0);   
           enable   : in  STD_LOGIC;   
           outputport    : out STD_LOGIC_vector(3 downto 0)    
			  );
end tristate;

architecture Behavioral of tristate is

begin

outputport <= inputport when (enable = '0') else "ZZZZ";
end Behavioral;

