----------------------------------------------------------------------------------
--File: seven_segment_decoder.vhd
--Entity: Seven_segment_decoder
--Architechure: behavioral
--Author: Brian Landy
--Created: 4/10/17
--Modified: 4/10/17
--VHDL'93
--Description: This is the seven_segment_decoder and it controls the output to the seven segment display 
--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:51:03 04/05/2017 
-- Design Name: 
-- Module Name:    seven_segment_decoder - Behavioral 
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

entity seven_segment_decoder is
    Port ( bcd_Vec : in  STD_LOGIC_VECTOR(11 downto 0);
           hund_disp_n : out STD_LOGIC_VECTOR (6 downto 0);
           tens_disp_n : out  STD_LOGIC_VECTOR (6 downto 0);
           ones_disp_n : out   STD_LOGIC_VECTOR (6 downto 0));
end seven_segment_decoder;

architecture Behavioral of seven_segment_decoder is
signal topThree : STD_LOGIC_VECTOR(3 downto 0);
signal midThree : STD_LOGIC_VECTOR(3 downto 0);
signal botThree : STD_LOGIC_VECTOR(3 downto 0);



begin


topThree<=bcd_Vec(11 downto 8);
midThree <= bcd_Vec(7 downto 4);
botThree<=bcd_Vec(3 downto 0);



process (topThree)
BEGIN

case  topThree is
when "0000"=> hund_disp_n <="0000001";  -- '0'
when "0001"=> hund_disp_n <="1001111";  -- '1'
when "0010"=> hund_disp_n <="0010010";  -- '2'
when "0011"=> hund_disp_n <="0000110";  -- '3'
when "0100"=> hund_disp_n <="1001100";  -- '4' 
when "0101"=> hund_disp_n <="0100100";  -- '5'
when "0110"=> hund_disp_n <="0100000";  -- '6'
when "0111"=> hund_disp_n <="0001111";  -- '7'
when "1000"=> hund_disp_n <="0000000";  -- '8'
when "1001"=> hund_disp_n <="0000100";  -- '9'
 --nothing is displayed when a number more than 9 is given as input. 
when others=> hund_disp_n <="1111111"; 
end case;


end process;






process (midThree)
BEGIN

case  midThree is
when "0000"=> tens_disp_n <="0000001";  -- '0'
when "0001"=> tens_disp_n <="1001111";  -- '1'
when "0010"=> tens_disp_n <="0010010";  -- '2'
when "0011"=> tens_disp_n <="0000110";  -- '3'
when "0100"=> tens_disp_n <="1001100";  -- '4' 
when "0101"=> tens_disp_n <="0100100";  -- '5'
when "0110"=> tens_disp_n <="0100000";  -- '6'
when "0111"=> tens_disp_n <="0001111";  -- '7'
when "1000"=> tens_disp_n <="0000000";  -- '8'
when "1001"=> tens_disp_n <="0000100";  -- '9'
 --nothing is displayed when a number more than 9 is given as input. 
when others=> tens_disp_n <="1111111"; 
end case;


end process;



process (botThree)
BEGIN

case  botThree is
when "0000"=> ones_disp_n <="0000001";  -- '0'
when "0001"=> ones_disp_n <="1001111";  -- '1'
when "0010"=> ones_disp_n <="0010010";  -- '2'
when "0011"=> ones_disp_n <="0000110";  -- '3'
when "0100"=> ones_disp_n <="1001100";  -- '4' 
when "0101"=> ones_disp_n <="0100100";  -- '5'
when "0110"=> ones_disp_n <="0100000";  -- '6'
when "0111"=> ones_disp_n <="0001111";  -- '7'
when "1000"=> ones_disp_n <="0000000";  -- '8'
when "1001"=> ones_disp_n <="0000100";  -- '9'
 --nothing is displayed when a number more than 9 is given as input. 
when others=> ones_disp_n <="1111111"; 
end case;


end process;












end Behavioral;

