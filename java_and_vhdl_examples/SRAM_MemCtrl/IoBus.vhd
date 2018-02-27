----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:27:36 05/03/2017 
-- Design Name: 
-- Module Name:    IoBus - Behavioral 
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
USE work.bin_bcd.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IoBus is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           bus_id : in  STD_LOGIC;
           rw : in  STD_LOGIC;
           ready : in  STD_LOGIC;
           burst : in  STD_LOGIC;
           addr : in  STD_LOGIC_VECTOR (2 downto 0);
          
           
           data : in  STD_LOGIC_VECTOR (3 downto 0);
			  
			  data_out : out  STD_LOGIC_VECTOR (3 downto 0);
			  
			   unused_anode      : out STD_LOGIC; -- unused an3
			  hund_anode_out    : out STD_LOGIC; -- digilent an2 
			  tens_anode_out    : out STD_LOGIC; -- digilent an3
           ones_anode_out    : out STD_LOGIC; -- digilent an4
           CAn_out           : out STD_LOGIC;
			  CBn_out           : out STD_LOGIC;
			  CCn_out           : out STD_LOGIC;
		     CDn_out           : out STD_LOGIC;
			  CEn_out           : out STD_LOGIC;
			  CFn_out           : out STD_LOGIC;
			  CGn_out           : out STD_LOGIC);
end IoBus;

architecture Behavioral of IoBus is

component tristate is
Port ( inputport    : in  STD_LOGIC_vector(3 downto 0);   
           enable   : in  STD_LOGIC;   
           outputport    : out STD_LOGIC_vector(3 downto 0)    
			  );
end component;

component mux21 is
    Port ( A : in  STD_LOGIC_VECTOR(3 downto 0);
           B : in  STD_LOGIC_VECTOR(3 downto 0);
           Sel : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR(3 downto 0));
end component;

component SRAM is 
	Port ( oe : in  STD_LOGIC;
           we : in  STD_LOGIC;
           addr : in  STD_LOGIC_VECTOR (2 downto 0);
           data_in : in  STD_LOGIC_VECTOR (3 downto 0);
			   bus_id : in std_logic;
           data_out : out  STD_LOGIC_VECTOR (3 downto 0));
			 end component;
			 
component memController is
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
end component;

component seven_seg_disp is
    Port ( hund_disp_n  : in  STD_LOGIC_VECTOR (6 downto 0);
	        tens_disp_n  : in  STD_LOGIC_VECTOR (6 downto 0);
           ones_disp_n  : in  STD_LOGIC_VECTOR (6 downto 0);
	        clk          : in  STD_LOGIC; -- digilent board generated clock
			  reset_n      : in  STD_LOGIC; -- switch input
			  unused_anode : out STD_LOGIC; -- unused an3
			  hund_anode   : out STD_LOGIC; -- digilent an2
	        tens_anode   : out STD_LOGIC; -- digilent an3
	        ones_anode   : out STD_LOGIC; -- digilent an4
			  CAn,CBn,CCn,CDn,CEn,CFn,CGn : out STD_LOGIC); -- digilent cathode - used for all displays
end component;

component seven_segment_decoder is
    Port ( bcd_Vec : in  STD_LOGIC_VECTOR(11 downto 0);
           hund_disp_n : out STD_LOGIC_VECTOR (6 downto 0);
           tens_disp_n : out  STD_LOGIC_VECTOR (6 downto 0);
           ones_disp_n : out   STD_LOGIC_VECTOR (6 downto 0));
end component;

Signal displayvec : std_logic_vector(3 downto 0);

Signal ones_disp_n_wire : std_logic_vector(6 downto 0);

Signal tens_disp_n_wire : std_logic_vector(6 downto 0);

Signal hund_disp_n_wire : std_logic_vector(6 downto 0);

signal boi : std_logic_vector(11 downto 0);


signal tri_dat_in : std_logic_vector(3 downto 0);

signal tri_mem_dat_out : std_logic_vector(3 downto 0);

signal mem_oe,mem_we : std_logic;

signal offset_int : std_logic_vector(1 downto 0);

signal SRAM_out_int : std_logic_vector(3 downto 0);


signal SRAM_out_int2 : std_logic_vector(3 downto 0);

signal mux_data_out : std_logic_vector(3 downto 0);

--signal addrandoffset : std_logic_vector(2 downto 0);

begin

instance0_mem_cont : memController
port map(clk=>clk,reset=>reset,bus_id =>bus_id,rw=>rw,ready=>ready,burst=>burst,addr=>addr,oe=>mem_oe,we=>mem_we,offset=>offset_int);


--buss id 0 sram

instance0_sram : SRAM 
port map(oe => mem_oe, we=>mem_we, addr=>std_logic_vector( unsigned(addr) + unsigned(offset_int)),data_in=>tri_dat_in, bus_id=>bus_id, data_out=>SRAM_out_int);

--bus id 1 sram

--instance1_sram : SRAM 
--port map(oe => mem_oe, we=>mem_we, addr=>std_logic_vector( unsigned(addr) + unsigned(offset_int)),data_in=>tri_dat_in, bus_id=>NOT bus_id,data_out=>SRAM_out_int2);



--instanceselectbus_mux : mux21
--port map (A=>SRAM_out_int,B=>SRAM_out_int2,Sel=>bus_id,output=>mux_data_out);

instance0_tri : tristate 
port map (inputport=>data, enable=>rw,outputport=>tri_dat_in);

instance1_tri : tristate 
port map (inputport=>SRAM_out_int, enable=>mem_oe,outputport=>data_out);



instance0_mux : mux21
port map (A=>data,B=> data,Sel=>rw,output=>displayvec);

boi<="00000000"&displayvec; --displayvec is 4 bits - data out







seven_seg0 : seven_segment_decoder 
port map	( bcd_Vec => bin_to_bcd(boi),
           hund_disp_n =>hund_disp_n_wire,
           tens_disp_n =>tens_disp_n_wire, 
           ones_disp_n =>ones_disp_n_wire);  

instance0_seven_seg_dsip : seven_seg_disp
port map(  hund_disp_n       => hund_disp_n_wire,
   tens_disp_n       => tens_disp_n_wire,
   ones_disp_n       => ones_disp_n_wire,
   clk               => clk,
   reset_n           => reset,
   unused_anode      => unused_anode,
   hund_anode        => hund_anode_out,
   tens_anode        => tens_anode_out,
   ones_anode        => ones_anode_out,
   CAn               => CAn_out,
	CBn               => CBn_out,
	CCn               => CCn_out,
	CDn               => CDn_out,
	CEn               => CEn_out,
	CFn               => CFn_out,
	CGn               => CGn_out
	);

end Behavioral;

