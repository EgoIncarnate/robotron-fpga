-----------------------------------------------------------------------
--
-- Copyright 2009-2011 ShareBrained Technology, Inc.
--
-- This file is part of robotron-fpga.
--
-- robotron-fpga is free software: you can redistribute
-- it and/or modify it under the terms of the GNU General
-- Public License as published by the Free Software
-- Foundation, either version 3 of the License, or (at your
-- option) any later version.
--
-- robotron-fpga is distributed in the hope that it will
-- be useful, but WITHOUT ANY WARRANTY; without even the
-- implied warranty of MERCHANTABILITY or FITNESS FOR A
-- PARTICULAR PURPOSE. See the GNU General Public License
-- for more details.
--
-- You should have received a copy of the GNU General
-- Public License along with robotron-fpga. If not, see
-- <http://www.gnu.org/licenses/>.
--
-----------------------------------------------------------------------

library IEEE;
   use IEEE.STD_LOGIC_1164.ALL;
   use IEEE.STD_LOGIC_ARITH.ALL;
   use IEEE.STD_LOGIC_UNSIGNED.ALL;

library UNISIM;
   use UNISIM.VComponents.all;

entity m6810 is
    Port ( clk       : in     std_logic;
           rst       : in     std_logic;
           address   : in     std_logic_vector (6 downto 0);
           cs        : in     std_logic;
           rw        : in     std_logic;
           data_in   : in     std_logic_vector (7 downto 0);
           data_out  : out    std_logic_vector (7 downto 0));
end m6810;

architecture rtl of m6810 is
   signal we : std_logic;
begin
   
  ROM: RAMB16_S9
    port map ( do                => data_out,
               addr(6 downto 0)  => address,
               addr(10 downto 7) => "0000",
               clk               => clk,
               di                => data_in,
               dip(0)            => '0',
               en                => cs,
               ssr               => rst,
               we                => we
               );

   m6810 : process ( rw )
   begin
      we <= not rw;
   end process;
   
end architecture rtl;

