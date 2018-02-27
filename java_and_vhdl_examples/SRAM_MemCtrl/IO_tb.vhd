--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:45:20 05/03/2017
-- Design Name:   
-- Module Name:   D:/lab6/L6/IO_tb.vhd
-- Project Name:  L6
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: IoBus
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY IO_tb IS
END IO_tb;
 
ARCHITECTURE behavior OF IO_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IoBus
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         bus_id : IN  std_logic;
         rw : IN  std_logic;
         ready : IN  std_logic;
         burst : IN  std_logic;
         addr : IN  std_logic_vector(2 downto 0);
         data : IN  std_logic_vector(3 downto 0);
         data_out : OUT  std_logic_vector(3 downto 0);
			unused_anode : OUT  std_logic;
         hund_anode_out : OUT  std_logic;
         tens_anode_out : OUT  std_logic;
         ones_anode_out : OUT  std_logic;
         CAn_out : OUT  std_logic;
         CBn_out : OUT  std_logic;
         CCn_out : OUT  std_logic;
         CDn_out : OUT  std_logic;
         CEn_out : OUT  std_logic;
         CFn_out : OUT  std_logic;
         CGn_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal bus_id : std_logic := '0';
   signal rw : std_logic := '0';
   signal ready : std_logic := '0';
   signal burst : std_logic := '0';
   signal addr : std_logic_vector(2 downto 0) := (others => '0');

	--BiDirs
   signal data : std_logic_vector(3 downto 0);
 signal data_out : std_logic_vector(3 downto 0);

 	--Outputs
   signal unused_anode : std_logic;
   signal hund_anode_out : std_logic;
   signal tens_anode_out : std_logic;
   signal ones_anode_out : std_logic;
   signal CAn_out : std_logic;
   signal CBn_out : std_logic;
   signal CCn_out : std_logic;
   signal CDn_out : std_logic;
   signal CEn_out : std_logic;
   signal CFn_out : std_logic;
   signal CGn_out : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IoBus PORT MAP (
          clk => clk,
          reset => reset,
          bus_id => bus_id,
          rw => rw,
          ready => ready,
          burst => burst,
          addr => addr,
          data => data,
			 
			 data_out=> data_out,
			 
          unused_anode => unused_anode,
          hund_anode_out => hund_anode_out,
          tens_anode_out => tens_anode_out,
          ones_anode_out => ones_anode_out,
          CAn_out => CAn_out,
          CBn_out => CBn_out,
          CCn_out => CCn_out,
          CDn_out => CDn_out,
          CEn_out => CEn_out,
          CFn_out => CFn_out,
          CGn_out => CGn_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;
		
		bus_id<='0';
		rw<='0';
		addr<="000";
		data<="1010";
		burst<='0';
		wait for 10ns;
		ready<='1';
		wait for 100ns;
		ready<='0';
		
		bus_id<='0';
		rw<='0';
		addr<="010";
		data<="1100";
		burst<='0';
		wait for 10ns;
		ready<='1';
		wait for 100ns;
		ready<='0';
		
		bus_id<='0';
		rw<='0';
		addr<="111";
		data<="0101";
		burst<='0';
		wait for 10ns;
		ready<='1';
		wait for 100ns;
		ready<='0';

		----------readding now

		bus_id<='0';
		rw<='1';
		addr<="111";
		data<="0000";
		burst<='0';
		wait for 10ns;
		ready<='1';
		wait for 100ns;
		ready<='0';

		bus_id<='0';
		rw<='1';
		addr<="010";
		data<="0000";
		burst<='0';
		wait for 10ns;
		ready<='1';
		wait for 100ns;
		ready<='0';
		
		bus_id<='0';
		rw<='1';
		addr<="000";
		data<="0000";
		burst<='0';
		wait for 10ns;
		ready<='1';
		wait for 100ns;
		ready<='0';
		-----------prep for burst by writing registers full
		bus_id<='0';
		rw<='0';
		addr<="000";
		data<="0001";
		burst<='0';
		wait for 10ns;
		ready<='1';
		wait for 100ns;
		ready<='0';
		
		bus_id<='0';
		rw<='0';
		addr<="001";
		data<="0010";
		burst<='0';
		wait for 10ns;
		ready<='1';
		wait for 100ns;
		ready<='0';
		
		bus_id<='0';
		rw<='0';
		addr<="010";
		data<="0011";
		burst<='0';
		wait for 10ns;
		ready<='1';
		wait for 100ns;
		ready<='0';
		
		bus_id<='0';
		rw<='0';
		addr<="011";
		data<="0100";
		burst<='0';
		wait for 10ns;
		ready<='1';
		wait for 100ns;
		ready<='0';
		
		------------test burst read from 0
		wait for 200ns;
		bus_id<='0';
		rw<='1';
		addr<="000";
		data<="1111";
		burst<='1';
		
		--read first
		wait for 100ns;
		ready<='1';

		wait for 100ns;
		ready<='0';
		
		
		--read second
		wait for 100ns;
		ready<='1';

		wait for 100ns;
		ready<='0';
		
		--read third
		wait for 100ns;
		ready<='1';

		wait for 100ns;
		ready<='0';
		
		--read 4th
		wait for 100ns;
		ready<='1';

		wait for 100ns;
		ready<='0';
		
		---------------done
		burst<='0';
		wait for 100ns;
		reset<='1';
		wait for 20ns;
		reset<='0';
		wait for 500ns;
		-------------------------------------------------------------------------------------------
		--write second sram
		bus_id<='1';
		rw<='0';
		addr<="000";
		data<="1010";
		burst<='0';
		wait for 10ns;
		ready<='1';
		wait for 100ns;
		ready<='0';
		
		bus_id<='1';
		rw<='0';
		addr<="010";
		data<="1100";
		burst<='0';
		wait for 10ns;
		ready<='1';
		wait for 100ns;
		ready<='0';
		
		bus_id<='1';
		rw<='0';
		addr<="111";
		data<="0101";
		burst<='0';
		wait for 10ns;
		ready<='1';
		wait for 100ns;
		ready<='0';
		
		--------read now
		bus_id<='1';
		rw<='1';
		addr<="111";
		data<="0000";
		burst<='0';
		wait for 10ns;
		ready<='1';
		wait for 100ns;
		ready<='0';

		bus_id<='1';
		rw<='1';
		addr<="010";
		data<="0000";
		burst<='0';
		wait for 10ns;
		ready<='1';
		wait for 100ns;
		ready<='0';
		
		bus_id<='1';
		rw<='1';
		addr<="000";
		data<="0000";
		burst<='0';
		wait for 10ns;
		ready<='1';
		wait for 100ns;
		ready<='0';
		-----------prep for burst by writing registers full
		bus_id<='1';
		wait for 100ns;
		rw<='0';
		addr<="000";
		data<="0001";
		burst<='0';
		wait for 10ns;
		ready<='1';
		wait for 100ns;
		ready<='0';
		
		bus_id<='1';
		rw<='0';
		addr<="001";
		data<="0010";
		burst<='0';
		wait for 10ns;
		ready<='1';
		wait for 100ns;
		ready<='0';
		
		bus_id<='1';
		rw<='0';
		addr<="010";
		data<="0011";
		burst<='0';
		wait for 10ns;
		ready<='1';
		wait for 100ns;
		ready<='0';
		
		bus_id<='1';
		rw<='0';
		addr<="011";
		data<="0100";
		burst<='0';
		wait for 10ns;
		ready<='1';
		wait for 100ns;
		ready<='0';
		
		------------test burst read from 0
		wait for 200ns;
		bus_id<='1';
		rw<='1';
		addr<="000";
		data<="1111";
		burst<='1';
		
		--read first
		wait for 100ns;
		ready<='1';

		wait for 100ns;
		ready<='0';
		
		
		--read second
		wait for 100ns;
		ready<='1';

		wait for 100ns;
		ready<='0';
		
		--read third
		wait for 100ns;
		ready<='1';

		wait for 100ns;
		ready<='0';
		
		--read 4th
		wait for 100ns;
		ready<='1';

		wait for 100ns;
		ready<='0';
		
		----------done
		burst<='0';
		
      -- insert stimulus here 

      wait;
   end process;

END;
