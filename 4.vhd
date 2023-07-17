--https://iverilog.fandom.com/wiki/Using_VHDL_Code_Generator
-- This VHDL was converted from Verilog using the
-- Icarus Verilog VHDL Code Generator 12.0 (devel) (s20150603-1110-g18392a46)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Generated from Verilog module proc4_tb (4.v:525)
entity proc4_tb is
end entity; 

-- Generated from Verilog module proc4_tb (4.v:525)
architecture from_verilog of proc4_tb is
  signal clk : std_logic := '1';  -- Declared at 4.v:526
  signal reset : std_logic := '0';  -- Declared at 4.v:526
  signal zeroflag : std_logic;  -- Declared at 4.v:527
  
  component datapath is
    port (
      clk : in std_logic;
      reset : in std_logic;
      zeroflag_stage2 : out std_logic
    );
  end component;
begin
  
  -- Generated from instantiation at 4.v:528
  d2: datapath
    port map (
      clk => clk,
      reset => reset,
      zeroflag_stage2 => zeroflag
    );
  
  -- Generated from initial process in proc4_tb (4.v:530)
  process is
  begin
    loop
      wait for 50 ms;
      clk <= not clk;
    end loop;
    wait;
  end process;
  
  -- Generated from initial process in proc4_tb (4.v:537)
  process is
  begin
    wait for 100 ms;
    reset <= '1';
    wait;
  end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Generated from Verilog module datapath (4.v:490)
entity datapath is
  port (
    clk : in std_logic;
    reset : in std_logic;
    zeroflag_stage2 : out std_logic
  );
end entity; 

-- Generated from Verilog module datapath (4.v:490)
architecture from_verilog of datapath is
  signal ALUopDRR : unsigned(2 downto 0);  -- Declared at 4.v:497
  signal ALUopEM : unsigned(2 downto 0);  -- Declared at 4.v:497
  signal ALUopFDD : unsigned(2 downto 0);  -- Declared at 4.v:497
  signal ALUopMWB : unsigned(2 downto 0);  -- Declared at 4.v:497
  signal ALUopRRE : unsigned(2 downto 0);  -- Declared at 4.v:497
  signal ALUopRRE2 : unsigned(2 downto 0);  -- Declared at 4.v:497
  signal ALUsrcDRR : std_logic;  -- Declared at 4.v:499
  signal ALUsrcEM : std_logic;  -- Declared at 4.v:499
  signal ALUsrcFDD : std_logic;  -- Declared at 4.v:499
  signal ALUsrcMWB : std_logic;  -- Declared at 4.v:499
  signal ALUsrcRRE : std_logic;  -- Declared at 4.v:499
  signal ALUsrcRRE2 : std_logic;  -- Declared at 4.v:499
  signal Forwardrs : unsigned(1 downto 0);  -- Declared at 4.v:498
  signal Forwardrt : unsigned(1 downto 0);  -- Declared at 4.v:498
  signal MemReadDRR : std_logic;  -- Declared at 4.v:499
  signal MemReadEM : std_logic;  -- Declared at 4.v:499
  signal MemReadFDD : std_logic;  -- Declared at 4.v:499
  signal MemReadMWB : std_logic;  -- Declared at 4.v:499
  signal MemReadRRE : std_logic;  -- Declared at 4.v:499
  signal MemReadRRE2 : std_logic;  -- Declared at 4.v:499
  signal MemWriteDRR : std_logic;  -- Declared at 4.v:499
  signal MemWriteEM : std_logic;  -- Declared at 4.v:499
  signal MemWriteFDD : std_logic;  -- Declared at 4.v:499
  signal MemWriteMWB : std_logic;  -- Declared at 4.v:499
  signal MemWriteRRE : std_logic;  -- Declared at 4.v:499
  signal MemWriteRRE2 : std_logic;  -- Declared at 4.v:499
  signal MemtoRegDRR : std_logic;  -- Declared at 4.v:499
  signal MemtoRegEM : std_logic;  -- Declared at 4.v:499
  signal MemtoRegFDD : std_logic;  -- Declared at 4.v:499
  signal MemtoRegMWB : std_logic;  -- Declared at 4.v:499
  signal MemtoRegRRE : std_logic;  -- Declared at 4.v:499
  signal MemtoRegRRE2 : std_logic;  -- Declared at 4.v:499
  signal PCsrcDRR : std_logic;  -- Declared at 4.v:499
  signal PCsrcEM : std_logic;  -- Declared at 4.v:499
  signal PCsrcFDD : std_logic;  -- Declared at 4.v:499
  signal PCsrcMWB : std_logic;  -- Declared at 4.v:499
  signal PCsrcRRE : std_logic;  -- Declared at 4.v:499
  signal PCsrcRRE2 : std_logic;  -- Declared at 4.v:499
  signal Read_Data1 : unsigned(31 downto 0);  -- Declared at 4.v:495
  signal Read_Data1DRR : unsigned(31 downto 0);  -- Declared at 4.v:494
  signal Read_Data1DRR_muxed : unsigned(31 downto 0);  -- Declared at 4.v:494
  signal Read_Data1MWB : unsigned(31 downto 0);  -- Declared at 4.v:495
  signal Read_Data2DRR : unsigned(31 downto 0);  -- Declared at 4.v:494
  signal Read_Data2DRR_muxed : unsigned(31 downto 0);  -- Declared at 4.v:494
  signal Read_Data2DRRm : unsigned(31 downto 0);  -- Declared at 4.v:494
  signal Read_DataEM : unsigned(31 downto 0);  -- Declared at 4.v:495
  signal Read_Reg_Num_1 : unsigned(4 downto 0);  -- Declared at 4.v:496
  signal Read_Reg_Num_1DRR : unsigned(4 downto 0);  -- Declared at 4.v:496
  signal Read_Reg_Num_1EM : unsigned(4 downto 0);  -- Declared at 4.v:496
  signal Read_Reg_Num_1RRE : unsigned(4 downto 0);  -- Declared at 4.v:496
  signal Read_Reg_Num_1RRE2 : unsigned(4 downto 0);  -- Declared at 4.v:496
  signal Read_Reg_Num_2 : unsigned(4 downto 0);  -- Declared at 4.v:496
  signal Read_Reg_Num_2DRR : unsigned(4 downto 0);  -- Declared at 4.v:496
  signal Read_Reg_Num_2EM : unsigned(4 downto 0);  -- Declared at 4.v:496
  signal Read_Reg_Num_2RRE : unsigned(4 downto 0);  -- Declared at 4.v:496
  signal Read_Reg_Num_2RRE2 : unsigned(4 downto 0);  -- Declared at 4.v:496
  signal RegWriteDRR : std_logic;  -- Declared at 4.v:499
  signal RegWriteEM : std_logic;  -- Declared at 4.v:499
  signal RegWriteFDD : std_logic;  -- Declared at 4.v:499
  signal RegWriteMWB : std_logic;  -- Declared at 4.v:499
  signal RegWriteRRE : std_logic;  -- Declared at 4.v:499
  signal RegWriteRRE2 : std_logic;  -- Declared at 4.v:499
  signal RegdstDRR : std_logic;  -- Declared at 4.v:499
  signal RegdstEM : std_logic;  -- Declared at 4.v:499
  signal RegdstFDD : std_logic;  -- Declared at 4.v:499
  signal RegdstMWB : std_logic;  -- Declared at 4.v:499
  signal RegdstRRE : std_logic;  -- Declared at 4.v:499
  signal RegdstRRE2 : std_logic;  -- Declared at 4.v:499
  signal Write_Data : unsigned(31 downto 0);  -- Declared at 4.v:495
  signal Write_DataRRE : unsigned(31 downto 0);  -- Declared at 4.v:495
  signal Write_DataRRE2 : unsigned(31 downto 0);  -- Declared at 4.v:495
  signal Write_Reg_Num : unsigned(4 downto 0);  -- Declared at 4.v:496
  signal Write_Reg_Num_DRR : unsigned(4 downto 0);  -- Declared at 4.v:496
  signal Write_Reg_Num_EM : unsigned(4 downto 0);  -- Declared at 4.v:496
  signal Write_Reg_Num_MWB : unsigned(4 downto 0);  -- Declared at 4.v:496
  signal Write_Reg_Num_RRE : unsigned(4 downto 0);  -- Declared at 4.v:496
  signal Write_Reg_Num_RRE2 : unsigned(4 downto 0);  -- Declared at 4.v:496
  signal address : unsigned(31 downto 0);  -- Declared at 4.v:495
  signal addressMWB : unsigned(31 downto 0);  -- Declared at 4.v:495
  signal instCode : unsigned(31 downto 0);  -- Declared at 4.v:494
  signal instCodeFD : unsigned(31 downto 0);  -- Declared at 4.v:494
  signal jumpInp : unsigned(31 downto 0);  -- Declared at 4.v:494
  signal jumpPCEM : unsigned(31 downto 0);  -- Declared at 4.v:495
  signal jumpPCRRE : unsigned(31 downto 0);  -- Declared at 4.v:494
  signal offset : unsigned(31 downto 0);  -- Declared at 4.v:494
  signal offsetDRR : unsigned(31 downto 0);  -- Declared at 4.v:494
  signal offsetRRE : unsigned(31 downto 0);  -- Declared at 4.v:495
  signal offsetRRE2 : unsigned(31 downto 0);  -- Declared at 4.v:495
  signal pcDRRstage : unsigned(31 downto 0);  -- Declared at 4.v:494
  signal pcFDstage : unsigned(31 downto 0);  -- Declared at 4.v:494
  signal pcRREstage : unsigned(31 downto 0);  -- Declared at 4.v:495
  signal pcRREstage2 : unsigned(31 downto 0);  -- Declared at 4.v:495
  signal pcout : unsigned(31 downto 0);  -- Declared at 4.v:494
  signal rdDRR : unsigned(4 downto 0);  -- Declared at 4.v:496
  signal rdEM : unsigned(4 downto 0);  -- Declared at 4.v:496
  signal rdFD : unsigned(4 downto 0);  -- Declared at 4.v:496
  signal rdMWB : unsigned(4 downto 0);  -- Declared at 4.v:496
  signal rdRRE : unsigned(4 downto 0);  -- Declared at 4.v:496
  signal rdRRE2 : unsigned(4 downto 0);  -- Declared at 4.v:496
  signal result : unsigned(31 downto 0);  -- Declared at 4.v:495
  signal result_stage2 : unsigned(31 downto 0);  -- Declared at 4.v:495
  signal zeroflag : std_logic;  -- Declared at 4.v:499
  signal zeroflag2 : std_logic;  -- Declared at 4.v:499
  signal LPM_q_ivl_2 : std_logic;
  signal LPM_q_ivl_4 : std_logic;
  signal LPM_q_ivl_8 : std_logic;
  signal LPM_q_ivl_10 : std_logic;
  
  component RegFile is
    port (
      Read_Data1 : out unsigned(31 downto 0);
      Read_Reg_Num_1 : in unsigned(4 downto 0);
      WriteEn : in std_logic;
      Write_Data : in unsigned(31 downto 0);
      Write_Reg_Num : in unsigned(4 downto 0);
      clk : in std_logic;
      reset : in std_logic
    );
  end component;
  
  component ALU is
    port (
      ALUop : in unsigned(2 downto 0);
      a : in unsigned(31 downto 0);
      b : in unsigned(31 downto 0);
      clk : in std_logic;
      result : out unsigned(31 downto 0);
      zeroflag : out std_logic
    );
  end component;
  
  component jumpblock is
    port (
      clk : in std_logic;
      instCode : in unsigned(31 downto 0);
      jumpPC : out unsigned(31 downto 0);
      offset : in unsigned(31 downto 0);
      pc : in unsigned(31 downto 0);
      reset : in std_logic
    );
  end component;
  
  component DataMem is
    port (
      MemRead : in std_logic;
      MemWrite : in std_logic;
      Read_Data : out unsigned(31 downto 0);
      Write_Data : in unsigned(31 downto 0);
      address : in unsigned(31 downto 0);
      clk : in std_logic;
      reset : in std_logic
    );
  end component;
  
  component InstFetch is
    port (
      clk : in std_logic;
      instCode : out unsigned(31 downto 0);
      newpc : in unsigned(31 downto 0);
      pcout : out unsigned(31 downto 0);
      reset : in std_logic
    );
  end component;
  
  component fetch_decode is
    port (
      ALUopFDD : out unsigned(2 downto 0);
      ALUsrcFDD : out std_logic;
      MemReadFDD : out std_logic;
      MemWriteFDD : out std_logic;
      MemtoRegFDD : out std_logic;
      PCsrcFDD : out std_logic;
      Read_Reg_Num_1 : out unsigned(4 downto 0);
      Read_Reg_Num_2 : out unsigned(4 downto 0);
      RegWriteFDD : out std_logic;
      RegdstFDD : out std_logic;
      Write_Reg_Num : out unsigned(4 downto 0);
      clk : in std_logic;
      instCode : in unsigned(31 downto 0);
      instCodeFD : out unsigned(31 downto 0);
      offset : out unsigned(31 downto 0);
      pc : in unsigned(31 downto 0);
      pcFDstage : out unsigned(31 downto 0);
      rdFD : out unsigned(4 downto 0);
      reset : in std_logic
    );
  end component;
  
  component decode_regread is
    port (
      ALUopDRR : out unsigned(2 downto 0);
      ALUopFDD : in unsigned(2 downto 0);
      ALUsrcDRR : out std_logic;
      ALUsrcFDD : in std_logic;
      MemReadDRR : out std_logic;
      MemReadFDD : in std_logic;
      MemWriteDRR : out std_logic;
      MemWriteFDD : in std_logic;
      MemtoRegDRR : out std_logic;
      MemtoRegFDD : in std_logic;
      PCsrcDRR : out std_logic;
      PCsrcFDD : in std_logic;
      Read_Data1DRR : out unsigned(31 downto 0);
      Read_Data2DRR : out unsigned(31 downto 0);
      Read_Reg_Num_1 : in unsigned(4 downto 0);
      Read_Reg_Num_1DRR : out unsigned(4 downto 0);
      Read_Reg_Num_2 : in unsigned(4 downto 0);
      Read_Reg_Num_2DRR : out unsigned(4 downto 0);
      RegWriteDRR : out std_logic;
      RegWriteFDD : in std_logic;
      RegdstDRR : out std_logic;
      RegdstFDD : in std_logic;
      Write_Reg_Num : in unsigned(4 downto 0);
      Write_Reg_Num_DRR : out unsigned(4 downto 0);
      clk : in std_logic;
      offset : in unsigned(31 downto 0);
      offsetDRR : out unsigned(31 downto 0);
      pc : in unsigned(31 downto 0);
      pcDRRstage : out unsigned(31 downto 0);
      rdDRR : out unsigned(4 downto 0);
      rdFD : in unsigned(4 downto 0);
      reset : in std_logic
    );
  end component;
  
  component regread_execute is
    port (
      ALUopDRR : in unsigned(2 downto 0);
      ALUopRRE : out unsigned(2 downto 0);
      ALUsrcDRR : in std_logic;
      ALUsrcRRE : out std_logic;
      MemReadDRR : in std_logic;
      MemReadRRE : out std_logic;
      MemWriteDRR : in std_logic;
      MemWriteRRE : out std_logic;
      MemtoRegDRR : in std_logic;
      MemtoRegRRE : out std_logic;
      PCsrcDRR : in std_logic;
      PCsrcRRE : out std_logic;
      Read_Data1DRR : in unsigned(31 downto 0);
      Read_Data2DRR : in unsigned(31 downto 0);
      Read_Reg_Num_1DRR : in unsigned(4 downto 0);
      Read_Reg_Num_1RRE : out unsigned(4 downto 0);
      Read_Reg_Num_2DRR : in unsigned(4 downto 0);
      Read_Reg_Num_2RRE : out unsigned(4 downto 0);
      RegWriteDRR : in std_logic;
      RegWriteRRE : out std_logic;
      RegdstDRR : in std_logic;
      RegdstRRE : out std_logic;
      Write_DataRRE : out unsigned(31 downto 0);
      Write_Reg_Num_DRR : in unsigned(4 downto 0);
      Write_Reg_Num_RRE : out unsigned(4 downto 0);
      clk : in std_logic;
      offsetDRR : in unsigned(31 downto 0);
      offsetRRE : out unsigned(31 downto 0);
      pcDRRstage : in unsigned(31 downto 0);
      pcRREstage : out unsigned(31 downto 0);
      rdDRR : in unsigned(4 downto 0);
      rdRRE : out unsigned(4 downto 0);
      reset : in std_logic;
      zeroflag : out std_logic
    );
  end component;
  
  component execute_mem is
    port (
      ALUopEM : out unsigned(2 downto 0);
      ALUopRRE : in unsigned(2 downto 0);
      ALUsrcEM : out std_logic;
      ALUsrcRRE : in std_logic;
      MemReadEM : out std_logic;
      MemReadRRE : in std_logic;
      MemWriteEM : out std_logic;
      MemWriteRRE : in std_logic;
      MemtoRegEM : out std_logic;
      MemtoRegRRE : in std_logic;
      PCsrcEM : out std_logic;
      PCsrcRRE : in std_logic;
      Read_Reg_Num_1EM : out unsigned(4 downto 0);
      Read_Reg_Num_1RRE : in unsigned(4 downto 0);
      Read_Reg_Num_2EM : out unsigned(4 downto 0);
      Read_Reg_Num_2RRE : in unsigned(4 downto 0);
      RegWriteEM : out std_logic;
      RegWriteRRE : in std_logic;
      RegdstEM : out std_logic;
      RegdstRRE : in std_logic;
      Write_DataRRE : in unsigned(31 downto 0);
      Write_Reg_Num_EM : out unsigned(4 downto 0);
      Write_Reg_Num_RRE : in unsigned(4 downto 0);
      address : out unsigned(31 downto 0);
      aluresultRRE : in unsigned(31 downto 0);
      clk : in std_logic;
      jumpPCEM : out unsigned(31 downto 0);
      jumpPCRRE : in unsigned(31 downto 0);
      rdEM : out unsigned(4 downto 0);
      rdRRE : in unsigned(4 downto 0);
      reset : in std_logic;
      zeroflag : in std_logic
    );
  end component;
  
  component mem_writeback is
    port (
      ALUopEM : in unsigned(2 downto 0);
      ALUopMWB : out unsigned(2 downto 0);
      ALUsrcEM : in std_logic;
      ALUsrcMWB : out std_logic;
      MemReadEM : in std_logic;
      MemReadMWB : out std_logic;
      MemWriteEM : in std_logic;
      MemWriteMWB : out std_logic;
      MemtoRegEM : in std_logic;
      MemtoRegMWB : out std_logic;
      PCsrcEM : in std_logic;
      PCsrcMWB : out std_logic;
      Read_Data1MWB : out unsigned(31 downto 0);
      Read_DataEM : in unsigned(31 downto 0);
      RegWriteEM : in std_logic;
      RegWriteMWB : out std_logic;
      RegdstEM : in std_logic;
      RegdstMWB : out std_logic;
      Write_Reg_Num_EM : in unsigned(4 downto 0);
      Write_Reg_Num_MWB : out unsigned(4 downto 0);
      address : in unsigned(31 downto 0);
      addressMWB : out unsigned(31 downto 0);
      clk : in std_logic;
      rdEM : in unsigned(4 downto 0);
      rdMWB : out unsigned(4 downto 0);
      reset : in std_logic
    );
  end component;
  
  component regread_execute2 is
    port (
      ALUopRRE : in unsigned(2 downto 0);
      ALUopRRE2 : out unsigned(2 downto 0);
      ALUsrcRRE : in std_logic;
      ALUsrcRRE2 : out std_logic;
      MemReadRRE : in std_logic;
      MemReadRRE2 : out std_logic;
      MemWriteRRE : in std_logic;
      MemWriteRRE2 : out std_logic;
      MemtoRegRRE : in std_logic;
      MemtoRegRRE2 : out std_logic;
      PCsrcRRE : in std_logic;
      PCsrcRRE2 : out std_logic;
      Read_Reg_Num_1RRE : in unsigned(4 downto 0);
      Read_Reg_Num_1RRE2 : out unsigned(4 downto 0);
      Read_Reg_Num_2RRE : in unsigned(4 downto 0);
      Read_Reg_Num_2RRE2 : out unsigned(4 downto 0);
      RegWriteRRE : in std_logic;
      RegWriteRRE2 : out std_logic;
      RegdstRRE : in std_logic;
      RegdstRRE2 : out std_logic;
      Write_DataRRE : in unsigned(31 downto 0);
      Write_DataRRE2 : out unsigned(31 downto 0);
      Write_Reg_Num_RRE : in unsigned(4 downto 0);
      Write_Reg_Num_RRE2 : out unsigned(4 downto 0);
      clk : in std_logic;
      offsetRRE : in unsigned(31 downto 0);
      offsetRRE2 : out unsigned(31 downto 0);
      pcRREstage : in unsigned(31 downto 0);
      pcRREstage2 : out unsigned(31 downto 0);
      rdRRE : in unsigned(4 downto 0);
      rdRRE2 : out unsigned(4 downto 0);
      zeroflag : in std_logic;
      zeroflag2 : out std_logic
    );
  end component;
  
  component alu_stage2 is
    port (
      clk : in std_logic;
      result : in unsigned(31 downto 0);
      result_stage2 : out unsigned(31 downto 0);
      zeroflag : in std_logic;
      zeroflag_stage2 : out std_logic
    );
  end component;
  signal zeroflag_stage2_Readable : std_logic;  -- Needed to connect outputs
  
  component forwarding_unit is
    port (
      DEXrs : in unsigned(4 downto 0);
      DEXrt : in unsigned(4 downto 0);
      EMRegWrite : in std_logic;
      EMrd : in unsigned(4 downto 0);
      Forwardrs : out unsigned(1 downto 0);
      Forwardrt : out unsigned(1 downto 0);
      MWBrd : in unsigned(4 downto 0);
      RegWriteMWB : in std_logic
    );
  end component;
  
  component mux1 is
    port (
      in1 : in unsigned(31 downto 0);
      in2 : in unsigned(31 downto 0);
      out_sig : out unsigned(31 downto 0);
      select_sig : in std_logic
    );
  end component;
  
  component mux2 is
    port (
      a : in unsigned(31 downto 0);
      b : in unsigned(31 downto 0);
      c : in unsigned(31 downto 0);
      d : in unsigned(31 downto 0);
      out_sig : out unsigned(31 downto 0);
      s0 : in std_logic;
      s1 : in std_logic
    );
  end component;
begin
  LPM_q_ivl_2 <= Forwardrs(0);
  LPM_q_ivl_4 <= Forwardrs(1);
  LPM_q_ivl_8 <= Forwardrt(0);
  LPM_q_ivl_10 <= Forwardrt(1);
  
  -- Generated from instantiation at 4.v:504
  a2: RegFile
    port map (
      Read_Data1 => Read_Data1DRR,
      Read_Reg_Num_1 => Read_Reg_Num_1,
      WriteEn => RegWriteMWB,
      Write_Data => Write_Data,
      Write_Reg_Num => Write_Reg_Num_EM,
      clk => clk,
      reset => reset
    );
  
  -- Generated from instantiation at 4.v:505
  a3: RegFile
    port map (
      Read_Data1 => Read_Data2DRR,
      Read_Reg_Num_1 => Read_Reg_Num_2,
      WriteEn => RegWriteMWB,
      Write_Data => Write_Data,
      Write_Reg_Num => Write_Reg_Num_EM,
      clk => clk,
      reset => reset
    );
  
  -- Generated from instantiation at 4.v:511
  a5: ALU
    port map (
      ALUop => ALUopRRE,
      a => Read_Data1DRR_muxed,
      b => Read_Data2DRR_muxed,
      clk => clk,
      result => result,
      zeroflag => zeroflag2
    );
  
  -- Generated from instantiation at 4.v:510
  a6: jumpblock
    port map (
      clk => clk,
      instCode => instCode,
      jumpPC => jumpPCRRE,
      offset => offsetDRR,
      pc => pcDRRstage,
      reset => reset
    );
  
  -- Generated from instantiation at 4.v:514
  a7: DataMem
    port map (
      MemRead => MemReadEM,
      MemWrite => MemWriteEM,
      Read_Data => Read_DataEM,
      Write_Data => Write_DataRRE2,
      address => address,
      clk => clk,
      reset => reset
    );
  
  -- Generated from instantiation at 4.v:502
  b1: InstFetch
    port map (
      clk => clk,
      instCode => instCode,
      newpc => jumpInp,
      pcout => pcout,
      reset => reset
    );
  
  -- Generated from instantiation at 4.v:503
  b2: fetch_decode
    port map (
      ALUopFDD => ALUopFDD,
      ALUsrcFDD => ALUsrcFDD,
      MemReadFDD => MemReadFDD,
      MemWriteFDD => MemWriteFDD,
      MemtoRegFDD => MemtoRegFDD,
      PCsrcFDD => PCsrcFDD,
      Read_Reg_Num_1 => Read_Reg_Num_1,
      Read_Reg_Num_2 => Read_Reg_Num_2,
      RegWriteFDD => RegWriteFDD,
      RegdstFDD => RegdstFDD,
      Write_Reg_Num => Write_Reg_Num,
      clk => clk,
      instCode => instCode,
      instCodeFD => instCodeFD,
      offset => offset,
      pc => pcout,
      pcFDstage => pcFDstage,
      rdFD => rdFD,
      reset => reset
    );
  
  -- Generated from instantiation at 4.v:506
  b3: decode_regread
    port map (
      ALUopDRR => ALUopDRR,
      ALUopFDD => ALUopFDD,
      ALUsrcDRR => ALUsrcDRR,
      ALUsrcFDD => ALUsrcFDD,
      MemReadDRR => MemReadDRR,
      MemReadFDD => MemReadFDD,
      MemWriteDRR => MemWriteDRR,
      MemWriteFDD => MemWriteFDD,
      MemtoRegDRR => MemtoRegDRR,
      MemtoRegFDD => MemtoRegFDD,
      PCsrcDRR => PCsrcDRR,
      PCsrcFDD => PCsrcFDD,
      Read_Data1DRR => Read_Data1DRR,
      Read_Data2DRR => Read_Data2DRR,
      Read_Reg_Num_1 => Read_Reg_Num_1,
      Read_Reg_Num_1DRR => Read_Reg_Num_1DRR,
      Read_Reg_Num_2 => Read_Reg_Num_2,
      Read_Reg_Num_2DRR => Read_Reg_Num_2DRR,
      RegWriteDRR => RegWriteDRR,
      RegWriteFDD => RegWriteFDD,
      RegdstDRR => RegdstDRR,
      RegdstFDD => RegdstFDD,
      Write_Reg_Num => Write_Reg_Num,
      Write_Reg_Num_DRR => Write_Reg_Num_DRR,
      clk => clk,
      offset => offset,
      offsetDRR => offsetDRR,
      pc => pcFDstage,
      pcDRRstage => pcDRRstage,
      rdDRR => rdDRR,
      rdFD => rdFD,
      reset => reset
    );
  
  -- Generated from instantiation at 4.v:508
  b4: regread_execute
    port map (
      ALUopDRR => ALUopDRR,
      ALUopRRE => ALUopRRE,
      ALUsrcDRR => ALUsrcDRR,
      ALUsrcRRE => ALUsrcRRE,
      MemReadDRR => MemReadDRR,
      MemReadRRE => MemReadRRE,
      MemWriteDRR => MemWriteDRR,
      MemWriteRRE => MemWriteRRE,
      MemtoRegDRR => MemtoRegDRR,
      MemtoRegRRE => MemtoRegRRE,
      PCsrcDRR => PCsrcDRR,
      PCsrcRRE => PCsrcRRE,
      Read_Data1DRR => Read_Data1DRR_muxed,
      Read_Data2DRR => Read_Data2DRR_muxed,
      Read_Reg_Num_1DRR => Read_Reg_Num_1DRR,
      Read_Reg_Num_1RRE => Read_Reg_Num_1RRE,
      Read_Reg_Num_2DRR => Read_Reg_Num_2DRR,
      Read_Reg_Num_2RRE => Read_Reg_Num_2RRE,
      RegWriteDRR => RegWriteDRR,
      RegWriteRRE => RegWriteRRE,
      RegdstDRR => RegdstDRR,
      RegdstRRE => RegdstRRE,
      Write_DataRRE => Write_DataRRE,
      Write_Reg_Num_DRR => Write_Reg_Num_DRR,
      Write_Reg_Num_RRE => Write_Reg_Num_RRE,
      clk => clk,
      offsetDRR => offsetDRR,
      offsetRRE => offsetRRE,
      pcDRRstage => pcDRRstage,
      pcRREstage => pcRREstage,
      rdDRR => rdDRR,
      rdRRE => rdRRE,
      reset => reset,
      zeroflag => zeroflag
    );
  
  -- Generated from instantiation at 4.v:513
  b5: execute_mem
    port map (
      ALUopEM => ALUopEM,
      ALUopRRE => ALUopRRE2,
      ALUsrcEM => ALUsrcEM,
      ALUsrcRRE => ALUsrcRRE2,
      MemReadEM => MemReadEM,
      MemReadRRE => MemReadRRE2,
      MemWriteEM => MemWriteEM,
      MemWriteRRE => MemWriteRRE2,
      MemtoRegEM => MemtoRegEM,
      MemtoRegRRE => MemtoRegRRE2,
      PCsrcEM => PCsrcEM,
      PCsrcRRE => PCsrcRRE2,
      Read_Reg_Num_1EM => Read_Reg_Num_1EM,
      Read_Reg_Num_1RRE => Read_Reg_Num_1RRE2,
      Read_Reg_Num_2EM => Read_Reg_Num_2EM,
      Read_Reg_Num_2RRE => Read_Reg_Num_2RRE2,
      RegWriteEM => RegWriteEM,
      RegWriteRRE => RegWriteRRE2,
      RegdstEM => RegdstEM,
      RegdstRRE => RegdstRRE2,
      Write_DataRRE => Write_DataRRE2,
      Write_Reg_Num_EM => Write_Reg_Num_EM,
      Write_Reg_Num_RRE => Write_Reg_Num_RRE2,
      address => address,
      aluresultRRE => result_stage2,
      clk => clk,
      jumpPCEM => jumpPCEM,
      jumpPCRRE => jumpPCRRE,
      rdEM => rdEM,
      rdRRE => rdRRE2,
      reset => reset,
      zeroflag => zeroflag2
    );
  
  -- Generated from instantiation at 4.v:515
  b6: mem_writeback
    port map (
      ALUopEM => ALUopEM,
      ALUopMWB => ALUopMWB,
      ALUsrcEM => ALUsrcEM,
      ALUsrcMWB => ALUsrcMWB,
      MemReadEM => MemReadEM,
      MemReadMWB => MemReadMWB,
      MemWriteEM => MemWriteEM,
      MemWriteMWB => MemWriteMWB,
      MemtoRegEM => MemtoRegEM,
      MemtoRegMWB => MemtoRegMWB,
      PCsrcEM => PCsrcEM,
      PCsrcMWB => PCsrcMWB,
      Read_Data1MWB => Read_Data1MWB,
      Read_DataEM => Read_DataEM,
      RegWriteEM => RegWriteEM,
      RegWriteMWB => RegWriteMWB,
      RegdstEM => RegdstEM,
      RegdstMWB => RegdstMWB,
      Write_Reg_Num_EM => Write_Reg_Num_EM,
      Write_Reg_Num_MWB => Write_Reg_Num_MWB,
      address => address,
      addressMWB => addressMWB,
      clk => clk,
      rdEM => rdEM,
      rdMWB => rdMWB,
      reset => reset
    );
  
  -- Generated from instantiation at 4.v:517
  b7: RegFile
    port map (
      Read_Data1 => Read_Data1,
      Read_Reg_Num_1 => Read_Reg_Num_1EM,
      WriteEn => RegWriteMWB,
      Write_Data => Write_Data,
      Write_Reg_Num => Write_Reg_Num_EM,
      clk => clk,
      reset => reset
    );
  
  -- Generated from instantiation at 4.v:509
  c4: regread_execute2
    port map (
      ALUopRRE => ALUopRRE,
      ALUopRRE2 => ALUopRRE2,
      ALUsrcRRE => ALUsrcRRE,
      ALUsrcRRE2 => ALUsrcRRE2,
      MemReadRRE => MemReadRRE,
      MemReadRRE2 => MemReadRRE2,
      MemWriteRRE => MemWriteRRE,
      MemWriteRRE2 => MemWriteRRE2,
      MemtoRegRRE => MemtoRegRRE,
      MemtoRegRRE2 => MemtoRegRRE2,
      PCsrcRRE => PCsrcRRE,
      PCsrcRRE2 => PCsrcRRE2,
      Read_Reg_Num_1RRE => Read_Reg_Num_1RRE,
      Read_Reg_Num_1RRE2 => Read_Reg_Num_1RRE2,
      Read_Reg_Num_2RRE => Read_Reg_Num_2RRE,
      Read_Reg_Num_2RRE2 => Read_Reg_Num_2RRE2,
      RegWriteRRE => RegWriteRRE,
      RegWriteRRE2 => RegWriteRRE2,
      RegdstRRE => RegdstRRE,
      RegdstRRE2 => RegdstRRE2,
      Write_DataRRE => Write_DataRRE,
      Write_DataRRE2 => Write_DataRRE2,
      Write_Reg_Num_RRE => Write_Reg_Num_RRE,
      Write_Reg_Num_RRE2 => Write_Reg_Num_RRE2,
      clk => clk,
      offsetRRE => offsetRRE,
      offsetRRE2 => offsetRRE2,
      pcRREstage => pcRREstage,
      pcRREstage2 => pcRREstage2,
      rdRRE => rdRRE,
      rdRRE2 => rdRRE2,
      zeroflag => zeroflag,
      zeroflag2 => zeroflag2
    );
  zeroflag_stage2 <= zeroflag_stage2_Readable;
  
  -- Generated from instantiation at 4.v:512
  c6: alu_stage2
    port map (
      clk => clk,
      result => result,
      result_stage2 => result_stage2,
      zeroflag => zeroflag2,
      zeroflag_stage2 => zeroflag_stage2_Readable
    );
  
  -- Generated from instantiation at 4.v:520
  f1: forwarding_unit
    port map (
      DEXrs => Read_Reg_Num_1DRR,
      DEXrt => Read_Reg_Num_2DRR,
      EMRegWrite => RegWriteEM,
      EMrd => rdEM,
      Forwardrs => Forwardrs,
      Forwardrt => Forwardrt,
      MWBrd => rdMWB,
      RegWriteMWB => RegWriteMWB
    );
  
  -- Generated from instantiation at 4.v:516
  m1: mux1
    port map (
      in1 => addressMWB,
      in2 => Read_DataEM,
      out_sig => Write_Data,
      select_sig => MemtoRegMWB
    );
  
  -- Generated from instantiation at 4.v:501
  m2: mux1
    port map (
      in1 => pcout,
      in2 => jumpPCRRE,
      out_sig => jumpInp,
      select_sig => PCsrcDRR
    );
  
  -- Generated from instantiation at 4.v:507
  m3: mux1
    port map (
      in1 => Read_Data2DRRm,
      in2 => offsetDRR,
      out_sig => Read_Data2DRR_muxed,
      select_sig => ALUsrcRRE
    );
  
  -- Generated from instantiation at 4.v:518
  m4: mux2
    port map (
      a => Read_Data1DRR,
      b => Write_Data,
      c => addressMWB,
      d => X"00000000",
      out_sig => Read_Data1DRR_muxed,
      s0 => LPM_q_ivl_2,
      s1 => LPM_q_ivl_4
    );
  
  -- Generated from instantiation at 4.v:519
  m5: mux2
    port map (
      a => Read_Data2DRR,
      b => Write_Data,
      c => addressMWB,
      d => X"00000000",
      out_sig => Read_Data2DRRm,
      s0 => LPM_q_ivl_8,
      s1 => LPM_q_ivl_10
    );
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Generated from Verilog module RegFile (4.v:60)
entity RegFile is
  port (
    Read_Data1 : out unsigned(31 downto 0);
    Read_Reg_Num_1 : in unsigned(4 downto 0);
    WriteEn : in std_logic;
    Write_Data : in unsigned(31 downto 0);
    Write_Reg_Num : in unsigned(4 downto 0);
    clk : in std_logic;
    reset : in std_logic
  );
end entity; 

-- Generated from Verilog module RegFile (4.v:60)
architecture from_verilog of RegFile is
  signal Read_Data1_Reg : unsigned(31 downto 0);
  type RegFileContent_Type is array (31 downto 0) of unsigned(7 downto 0);
  signal RegFileContent : RegFileContent_Type;  -- Declared at 4.v:67
begin
  Read_Data1 <= Read_Data1_Reg;
  
  -- Generated from always process in RegFile (4.v:69)
  process (reset) is
  begin
    if (unsigned'("0000000000000000000000000000000") & reset) = X"00000000" then
      RegFileContent(0) <= X"00";
    end if;
    RegFileContent(1) <= X"00";
    RegFileContent(2) <= X"00";
    RegFileContent(3) <= X"00";
    RegFileContent(4) <= X"00";
    RegFileContent(5) <= X"00";
    RegFileContent(6) <= X"00";
    RegFileContent(7) <= X"00";
    RegFileContent(8) <= X"00";
    RegFileContent(9) <= X"00";
    RegFileContent(10) <= X"00";
    RegFileContent(11) <= X"00";
    RegFileContent(12) <= X"00";
    RegFileContent(13) <= X"00";
    RegFileContent(14) <= X"00";
    RegFileContent(15) <= X"00";
    RegFileContent(16) <= X"00";
    RegFileContent(17) <= X"00";
    RegFileContent(18) <= X"00";
    RegFileContent(19) <= X"00";
    RegFileContent(20) <= X"00";
    RegFileContent(21) <= X"00";
    RegFileContent(22) <= X"00";
    RegFileContent(23) <= X"00";
    RegFileContent(24) <= X"00";
    RegFileContent(25) <= X"00";
    RegFileContent(26) <= X"00";
    RegFileContent(27) <= X"00";
    RegFileContent(28) <= X"00";
    RegFileContent(29) <= X"00";
    RegFileContent(30) <= X"04";
    RegFileContent(31) <= X"07";
  end process;
  
  -- Generated from always process in RegFile (4.v:86)
  process (clk) is
  begin
    if falling_edge(clk) then
      Read_Data1_Reg <= Resize(RegFileContent(To_Integer(Resize(Read_Reg_Num_1, 7))), 32);
    end if;
  end process;
  
  -- Generated from always process in RegFile (4.v:90)
  process (clk) is
  begin
    if rising_edge(clk) then
      if ((unsigned'("0000000000000000000000000000000") & WriteEn) = X"00000001") and ((Resize(Write_Reg_Num, 32) /= X"0000001e") or (Resize(Write_Reg_Num, 32) /= X"0000001f")) then
        RegFileContent(To_Integer(Resize(Write_Reg_Num, 7))) <= Resize(Write_Data, 8);
      end if;
    end if;
  end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Generated from Verilog module ALU (4.v:223)
entity ALU is
  port (
    ALUop : in unsigned(2 downto 0);
    a : in unsigned(31 downto 0);
    b : in unsigned(31 downto 0);
    clk : in std_logic;
    result : out unsigned(31 downto 0);
    zeroflag : out std_logic
  );
end entity; 

-- Generated from Verilog module ALU (4.v:223)
architecture from_verilog of ALU is
  signal result_Reg : unsigned(31 downto 0);
  signal zeroflag_Reg : std_logic;
begin
  result <= result_Reg;
  zeroflag <= zeroflag_Reg;
  
  -- Generated from always process in ALU (4.v:229)
  process (clk) is
  begin
    if falling_edge(clk) then
      case ALUop is
        when "000" =>
          result_Reg <= a + b;
        when "001" =>
          result_Reg <= a + b;
        when "010" =>
          result_Reg <= a - b;
        when "011" =>
          result_Reg <= a xor b;
        when "101" =>
          result_Reg <= Resize((a * b) + Resize(b, 64), 32);
        when "100" =>
          result_Reg <= X"00000000";
        when others =>
          null;
      end case;
    end if;
  end process;
  
  -- Generated from always process in ALU (4.v:240)
  process (result_Reg) is
  begin
    if result_Reg = X"00000000" then
      zeroflag_Reg <= '1';
    else
      zeroflag_Reg <= '0';
    end if;
  end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Generated from Verilog module jumpblock (4.v:250)
entity jumpblock is
  port (
    clk : in std_logic;
    instCode : in unsigned(31 downto 0);
    jumpPC : out unsigned(31 downto 0);
    offset : in unsigned(31 downto 0);
    pc : in unsigned(31 downto 0);
    reset : in std_logic
  );
end entity; 

-- Generated from Verilog module jumpblock (4.v:250)
architecture from_verilog of jumpblock is
  signal jumpPC_Reg : unsigned(31 downto 0);
begin
  jumpPC <= jumpPC_Reg;
  
  -- Generated from always process in jumpblock (4.v:254)
  process (reset, clk) is
  begin
    if falling_edge(reset) or rising_edge(clk) then
      if (unsigned'("0000000000000000000000000000000") & reset) = X"00000000" then
        jumpPC_Reg <= X"00000000";
      else
        jumpPC_Reg <= Resize((pc(28 + 3 downto 28) & instCode(0 + 26 downto 0) & "00") - "000000000000000000000000000000100", 32);
      end if;
    end if;
  end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Generated from Verilog module DataMem (4.v:98)
entity DataMem is
  port (
    MemRead : in std_logic;
    MemWrite : in std_logic;
    Read_Data : out unsigned(31 downto 0);
    Write_Data : in unsigned(31 downto 0);
    address : in unsigned(31 downto 0);
    clk : in std_logic;
    reset : in std_logic
  );
end entity; 

-- Generated from Verilog module DataMem (4.v:98)
architecture from_verilog of DataMem is
  signal Read_Data_Reg : unsigned(31 downto 0);
  type DataMem_sig_Type is array (100 downto 0) of unsigned(31 downto 0);
  signal DataMem_sig : DataMem_sig_Type;  -- Declared at 4.v:102
begin
  Read_Data <= Read_Data_Reg;
  
  -- Generated from always process in DataMem (4.v:104)
  process (reset) is
  begin
    if (unsigned'("0000000000000000000000000000000") & reset) = X"00000000" then
      DataMem_sig(0) <= X"96969696";
    end if;
    DataMem_sig(1) <= X"00000001";
    DataMem_sig(2) <= X"00000002";
    DataMem_sig(3) <= X"00000003";
    DataMem_sig(4) <= X"00000004";
    DataMem_sig(5) <= X"00000005";
    DataMem_sig(6) <= X"00000006";
    DataMem_sig(7) <= X"00000007";
    DataMem_sig(8) <= X"00000008";
    DataMem_sig(9) <= X"00000009";
    DataMem_sig(10) <= X"0000000a";
    DataMem_sig(11) <= X"0000000b";
    DataMem_sig(12) <= X"0000000c";
  end process;
  
  -- Generated from always process in DataMem (4.v:116)
  process (clk) is
  begin
    if rising_edge(clk) then
      if MemWrite = '1' then
        DataMem_sig(To_Integer(address)) <= Write_Data;
      end if;
    end if;
  end process;
  
  -- Generated from always process in DataMem (4.v:120)
  process (clk) is
  begin
    if falling_edge(clk) then
      if MemRead = '1' then
        Read_Data_Reg <= DataMem_sig(To_Integer(address));
      end if;
    end if;
  end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Generated from Verilog module InstFetch (4.v:37)
entity InstFetch is
  port (
    clk : in std_logic;
    instCode : out unsigned(31 downto 0);
    newpc : in unsigned(31 downto 0);
    pcout : out unsigned(31 downto 0);
    reset : in std_logic
  );
end entity; 

-- Generated from Verilog module InstFetch (4.v:37)
architecture from_verilog of InstFetch is
  signal pcout_Reg : unsigned(31 downto 0);
  signal pc : unsigned(31 downto 0);  -- Declared at 4.v:41
  signal pco : unsigned(31 downto 0);  -- Declared at 4.v:42
  
  component InstMem is
    port (
      instCode : out unsigned(31 downto 0);
      pc : in unsigned(31 downto 0);
      pcout : out unsigned(31 downto 0);
      reset : in std_logic
    );
  end component;
  signal instCode_Readable : unsigned(31 downto 0);  -- Needed to connect outputs
begin
  pcout <= pcout_Reg;
  instCode <= instCode_Readable;
  
  -- Generated from instantiation at 4.v:43
  M0: InstMem
    port map (
      instCode => instCode_Readable,
      pc => pc,
      pcout => pco,
      reset => reset
    );
  
  -- Generated from always process in InstFetch (4.v:45)
  process (reset, clk) is
  begin
    if falling_edge(reset) or rising_edge(clk) then
      if (unsigned'("0000000000000000000000000000000") & reset) = X"00000000" then
        pc <= X"00000000";
      else
        pc <= newpc + X"00000004";
      end if;
    end if;
  end process;
  
  -- Generated from always process in InstFetch (4.v:52)
  process (pc) is
  begin
    pcout_Reg <= pc;
  end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Generated from Verilog module InstMem (4.v:12)
entity InstMem is
  port (
    instCode : out unsigned(31 downto 0);
    pc : in unsigned(31 downto 0);
    pcout : out unsigned(31 downto 0);
    reset : in std_logic
  );
end entity; 

-- Generated from Verilog module InstMem (4.v:12)
architecture from_verilog of InstMem is
  signal pcout_Reg : unsigned(31 downto 0);
  signal tmp_ivl_0 : unsigned(7 downto 0);  -- Temporary created at 4.v:17
  signal tmp_ivl_10 : unsigned(32 downto 0);  -- Temporary created at 4.v:17
  signal tmp_ivl_12 : unsigned(7 downto 0);  -- Temporary created at 4.v:17
  signal tmp_ivl_14 : unsigned(32 downto 0);  -- Temporary created at 4.v:17
  signal tmp_ivl_17 : std_logic;  -- Temporary created at 4.v:17
  signal tmp_ivl_18 : unsigned(32 downto 0);  -- Temporary created at 4.v:17
  signal tmp_ivl_2 : unsigned(7 downto 0);  -- Temporary created at 4.v:17
  signal tmp_ivl_20 : unsigned(32 downto 0);  -- Temporary created at 4.v:17
  signal tmp_ivl_22 : unsigned(7 downto 0);  -- Temporary created at 4.v:17
  signal tmp_ivl_24 : unsigned(32 downto 0);  -- Temporary created at 4.v:17
  signal tmp_ivl_27 : std_logic;  -- Temporary created at 4.v:17
  signal tmp_ivl_28 : unsigned(32 downto 0);  -- Temporary created at 4.v:17
  signal tmp_ivl_30 : unsigned(32 downto 0);  -- Temporary created at 4.v:17
  signal tmp_ivl_4 : unsigned(32 downto 0);  -- Temporary created at 4.v:17
  signal tmp_ivl_7 : std_logic;  -- Temporary created at 4.v:17
  signal tmp_ivl_8 : unsigned(32 downto 0);  -- Temporary created at 4.v:17
  type mem_Type is array (100 downto 0) of unsigned(7 downto 0);
  signal mem : mem_Type;  -- Declared at 4.v:15
begin
  pcout <= pcout_Reg;
  tmp_ivl_0 <= mem(To_Integer(pc));
  tmp_ivl_2 <= mem(To_Integer(tmp_ivl_10));
  tmp_ivl_4 <= tmp_ivl_7 & pc;
  tmp_ivl_10 <= tmp_ivl_4 + tmp_ivl_8;
  tmp_ivl_12 <= mem(To_Integer(tmp_ivl_20));
  tmp_ivl_14 <= tmp_ivl_17 & pc;
  tmp_ivl_20 <= tmp_ivl_14 + tmp_ivl_18;
  tmp_ivl_22 <= mem(To_Integer(tmp_ivl_30));
  tmp_ivl_24 <= tmp_ivl_27 & pc;
  tmp_ivl_30 <= tmp_ivl_24 + tmp_ivl_28;
  instCode <= tmp_ivl_0 & tmp_ivl_2 & tmp_ivl_12 & tmp_ivl_22;
  tmp_ivl_17 <= '0';
  tmp_ivl_18 <= "000000000000000000000000000000010";
  tmp_ivl_27 <= '0';
  tmp_ivl_28 <= "000000000000000000000000000000011";
  tmp_ivl_7 <= '0';
  tmp_ivl_8 <= "000000000000000000000000000000001";
  
  -- Generated from always process in InstMem (4.v:19)
  process (reset) is
  begin
    if (unsigned'("0000000000000000000000000000000") & reset) = X"00000000" then
      mem(0) <= X"00";
      mem(1) <= X"7f";
      mem(2) <= X"f0";
      mem(3) <= X"3f";
      mem(4) <= X"00";
      mem(5) <= X"00";
      mem(6) <= X"00";
      mem(7) <= X"3f";
      mem(8) <= X"00";
      mem(9) <= X"00";
      mem(10) <= X"00";
      mem(11) <= X"3f";
      mem(12) <= X"00";
      mem(13) <= X"00";
      mem(14) <= X"00";
      mem(15) <= X"3f";
      mem(16) <= X"8c";
      mem(17) <= X"01";
      mem(18) <= X"00";
      mem(19) <= X"00";
      mem(20) <= X"ac";
      mem(21) <= X"61";
      mem(22) <= X"00";
      mem(23) <= X"00";
    end if;
  end process;
  
  -- Generated from always process in InstMem (4.v:31)
  process (pc) is
  begin
    pcout_Reg <= pc;
  end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Generated from Verilog module fetch_decode (4.v:264)
entity fetch_decode is
  port (
    ALUopFDD : out unsigned(2 downto 0);
    ALUsrcFDD : out std_logic;
    MemReadFDD : out std_logic;
    MemWriteFDD : out std_logic;
    MemtoRegFDD : out std_logic;
    PCsrcFDD : out std_logic;
    Read_Reg_Num_1 : out unsigned(4 downto 0);
    Read_Reg_Num_2 : out unsigned(4 downto 0);
    RegWriteFDD : out std_logic;
    RegdstFDD : out std_logic;
    Write_Reg_Num : out unsigned(4 downto 0);
    clk : in std_logic;
    instCode : in unsigned(31 downto 0);
    instCodeFD : out unsigned(31 downto 0);
    offset : out unsigned(31 downto 0);
    pc : in unsigned(31 downto 0);
    pcFDstage : out unsigned(31 downto 0);
    rdFD : out unsigned(4 downto 0);
    reset : in std_logic
  );
end entity; 

-- Generated from Verilog module fetch_decode (4.v:264)
architecture from_verilog of fetch_decode is
  signal Read_Reg_Num_1_Reg : unsigned(4 downto 0);
  signal Read_Reg_Num_2_Reg : unsigned(4 downto 0);
  signal Write_Reg_Num_Reg : unsigned(4 downto 0);
  signal instCodeFD_Reg : unsigned(31 downto 0);
  signal offset_Reg : unsigned(31 downto 0);
  signal pcFDstage_Reg : unsigned(31 downto 0);
  signal rdFD_Reg : unsigned(4 downto 0);
  
  component mainControlUnit is
    port (
      ALUop : out unsigned(2 downto 0);
      ALUsrc : out std_logic;
      MemRead : out std_logic;
      MemWrite : out std_logic;
      MemtoReg : out std_logic;
      PCsrc : out std_logic;
      RegWrite : out std_logic;
      Regdst : out std_logic;
      clk : in std_logic;
      instCode : in unsigned(31 downto 0);
      instCodeFD : in unsigned(31 downto 0);
      reset : in std_logic
    );
  end component;
  signal ALUop_Readable : unsigned(2 downto 0);  -- Needed to connect outputs
  signal ALUsrc_Readable : std_logic;  -- Needed to connect outputs
  signal MemRead_Readable : std_logic;  -- Needed to connect outputs
  signal MemWrite_Readable : std_logic;  -- Needed to connect outputs
  signal MemtoReg_Readable : std_logic;  -- Needed to connect outputs
  signal PCsrc_Readable : std_logic;  -- Needed to connect outputs
  signal RegWrite_Readable : std_logic;  -- Needed to connect outputs
  signal Regdst_Readable : std_logic;  -- Needed to connect outputs
begin
  Read_Reg_Num_1 <= Read_Reg_Num_1_Reg;
  Read_Reg_Num_2 <= Read_Reg_Num_2_Reg;
  Write_Reg_Num <= Write_Reg_Num_Reg;
  instCodeFD <= instCodeFD_Reg;
  offset <= offset_Reg;
  pcFDstage <= pcFDstage_Reg;
  rdFD <= rdFD_Reg;
  ALUopFDD <= ALUop_Readable;
  ALUsrcFDD <= ALUsrc_Readable;
  MemReadFDD <= MemRead_Readable;
  MemWriteFDD <= MemWrite_Readable;
  MemtoRegFDD <= MemtoReg_Readable;
  PCsrcFDD <= PCsrc_Readable;
  RegWriteFDD <= RegWrite_Readable;
  RegdstFDD <= Regdst_Readable;
  
  -- Generated from instantiation at 4.v:271
  c1: mainControlUnit
    port map (
      ALUop => ALUop_Readable,
      ALUsrc => ALUsrc_Readable,
      MemRead => MemRead_Readable,
      MemWrite => MemWrite_Readable,
      MemtoReg => MemtoReg_Readable,
      PCsrc => PCsrc_Readable,
      RegWrite => RegWrite_Readable,
      Regdst => Regdst_Readable,
      clk => clk,
      instCode => instCode,
      instCodeFD => instCodeFD_Reg,
      reset => reset
    );
  
  -- Generated from always process in fetch_decode (4.v:272)
  process (clk) is
  begin
    if rising_edge(clk) then
      Read_Reg_Num_2_Reg <= instCode(11 + 4 downto 11);
      offset_Reg <= (instCode(15) & instCode(15) & instCode(15) & instCode(15) & instCode(15) & instCode(15) & instCode(15) & instCode(15) & instCode(15) & instCode(15) & instCode(15) & instCode(15) & instCode(15) & instCode(15) & instCode(15) & instCode(15)) & instCode(0 + 15 downto 0);
      pcFDstage_Reg <= pc;
      if instCode(26 + 5 downto 26) = "000000" then
        rdFD_Reg <= instCode(11 + 4 downto 11);
      else
        rdFD_Reg <= instCode(16 + 4 downto 16);
      end if;
      instCodeFD_Reg <= instCode;
    end if;
  end process;
  
  -- Generated from always process in fetch_decode (4.v:283)
  process (clk) is
  begin
    if rising_edge(clk) then
      if (instCode(26 + 5 downto 26) = "100011") or (instCode(26 + 5 downto 26) = "101011") then
        Read_Reg_Num_1_Reg <= Resize(instCode(20 + 5 downto 20), 5);
        Write_Reg_Num_Reg <= instCode(16 + 4 downto 16);
      else
        Read_Reg_Num_1_Reg <= instCode(16 + 4 downto 16);
        Write_Reg_Num_Reg <= instCode(21 + 4 downto 21);
      end if;
    end if;
  end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Generated from Verilog module mainControlUnit (4.v:128)
entity mainControlUnit is
  port (
    ALUop : out unsigned(2 downto 0);
    ALUsrc : out std_logic;
    MemRead : out std_logic;
    MemWrite : out std_logic;
    MemtoReg : out std_logic;
    PCsrc : out std_logic;
    RegWrite : out std_logic;
    Regdst : out std_logic;
    clk : in std_logic;
    instCode : in unsigned(31 downto 0);
    instCodeFD : in unsigned(31 downto 0);
    reset : in std_logic
  );
end entity; 

-- Generated from Verilog module mainControlUnit (4.v:128)
architecture from_verilog of mainControlUnit is
  signal ALUop_Reg : unsigned(2 downto 0);
  signal ALUsrc_Reg : std_logic;
  signal MemRead_Reg : std_logic;
  signal MemWrite_Reg : std_logic;
  signal MemtoReg_Reg : std_logic;
  signal PCsrc_Reg : std_logic;
  signal RegWrite_Reg : std_logic;
  signal Regdst_Reg : std_logic;
begin
  ALUop <= ALUop_Reg;
  ALUsrc <= ALUsrc_Reg;
  MemRead <= MemRead_Reg;
  MemWrite <= MemWrite_Reg;
  MemtoReg <= MemtoReg_Reg;
  PCsrc <= PCsrc_Reg;
  RegWrite <= RegWrite_Reg;
  Regdst <= Regdst_Reg;
  
  -- Generated from always process in mainControlUnit (4.v:132)
  process (instCode) is
  begin
    case instCode(26 + 5 downto 26) is
      when "100011" =>
        ALUsrc_Reg <= '1';
      when "101011" =>
        ALUsrc_Reg <= '1';
      when "000000" =>
        ALUsrc_Reg <= '0';
      when "001110" =>
        ALUsrc_Reg <= '1';
      when "000010" =>
        ALUsrc_Reg <= '0';
      when others =>
        null;
    end case;
  end process;
  
  -- Generated from always process in mainControlUnit (4.v:141)
  process (instCode) is
  begin
    case instCode(26 + 5 downto 26) is
      when "100011" =>
        Regdst_Reg <= '0';
      when "101011" =>
        Regdst_Reg <= 'U';
      when "000000" =>
        Regdst_Reg <= '1';
      when "001110" =>
        Regdst_Reg <= '1';
      when "000010" =>
        Regdst_Reg <= 'U';
      when others =>
        null;
    end case;
  end process;
  
  -- Generated from always process in mainControlUnit (4.v:159)
  process (instCode) is
    variable Verilog_Case_Ex : unsigned(11 downto 0);
  begin
    Verilog_Case_Ex := instCode(26 + 5 downto 26) & instCode(0 + 5 downto 0);
    case Verilog_Case_Ex is
      when X"8c0" =>
        ALUop_Reg <= "000";
      when "101011UUUUUU" =>
        ALUop_Reg <= "001";
      when X"022" =>
        ALUop_Reg <= "010";
      when X"03f" =>
        ALUop_Reg <= "101";
      when "001110UUUUUU" =>
        ALUop_Reg <= "011";
      when "000010UUUUUU" =>
        ALUop_Reg <= "100";
      when others =>
        null;
    end case;
  end process;
  
  -- Generated from always process in mainControlUnit (4.v:169)
  process (instCode) is
  begin
    case instCode(26 + 5 downto 26) is
      when "100011" =>
        MemRead_Reg <= '1';
      when "101011" =>
        MemRead_Reg <= '0';
      when "000000" =>
        MemRead_Reg <= '0';
      when "001110" =>
        MemRead_Reg <= '0';
      when "000010" =>
        MemRead_Reg <= '0';
      when others =>
        null;
    end case;
  end process;
  
  -- Generated from always process in mainControlUnit (4.v:178)
  process (instCode) is
  begin
    case instCode(26 + 5 downto 26) is
      when "100011" =>
        MemWrite_Reg <= '0';
      when "101011" =>
        MemWrite_Reg <= '1';
      when "000000" =>
        MemWrite_Reg <= '0';
      when "001110" =>
        MemWrite_Reg <= '0';
      when "000010" =>
        MemWrite_Reg <= '0';
      when others =>
        null;
    end case;
  end process;
  
  -- Generated from always process in mainControlUnit (4.v:187)
  process (instCode) is
  begin
    case instCode(26 + 5 downto 26) is
      when "100011" =>
        MemtoReg_Reg <= '1';
      when "101011" =>
        MemtoReg_Reg <= '0';
      when "000000" =>
        MemtoReg_Reg <= '0';
      when "001110" =>
        MemtoReg_Reg <= '0';
      when "000010" =>
        MemtoReg_Reg <= '0';
      when others =>
        null;
    end case;
  end process;
  
  -- Generated from always process in mainControlUnit (4.v:196)
  process (instCode) is
  begin
    case instCode(26 + 5 downto 26) is
      when "100011" =>
        PCsrc_Reg <= '0';
      when "101011" =>
        PCsrc_Reg <= '0';
      when "000000" =>
        PCsrc_Reg <= '0';
      when "001110" =>
        PCsrc_Reg <= '0';
      when "000010" =>
        PCsrc_Reg <= '1';
      when "UUUUUU" =>
        PCsrc_Reg <= '0';
      when others =>
        null;
    end case;
  end process;
  
  -- Generated from always process in mainControlUnit (4.v:207)
  process (instCode, instCodeFD) is
  begin
    if (instCode(26 + 5 downto 26) = "000010") or (instCodeFD(26 + 5 downto 26) = "000010") then
      RegWrite_Reg <= '0';
    else
      if instCode(26 + 5 downto 26) = "101011" then
        RegWrite_Reg <= '0';
      else
        RegWrite_Reg <= '1';
      end if;
    end if;
  end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Generated from Verilog module decode_regread (4.v:298)
entity decode_regread is
  port (
    ALUopDRR : out unsigned(2 downto 0);
    ALUopFDD : in unsigned(2 downto 0);
    ALUsrcDRR : out std_logic;
    ALUsrcFDD : in std_logic;
    MemReadDRR : out std_logic;
    MemReadFDD : in std_logic;
    MemWriteDRR : out std_logic;
    MemWriteFDD : in std_logic;
    MemtoRegDRR : out std_logic;
    MemtoRegFDD : in std_logic;
    PCsrcDRR : out std_logic;
    PCsrcFDD : in std_logic;
    Read_Data1DRR : out unsigned(31 downto 0);
    Read_Data2DRR : out unsigned(31 downto 0);
    Read_Reg_Num_1 : in unsigned(4 downto 0);
    Read_Reg_Num_1DRR : out unsigned(4 downto 0);
    Read_Reg_Num_2 : in unsigned(4 downto 0);
    Read_Reg_Num_2DRR : out unsigned(4 downto 0);
    RegWriteDRR : out std_logic;
    RegWriteFDD : in std_logic;
    RegdstDRR : out std_logic;
    RegdstFDD : in std_logic;
    Write_Reg_Num : in unsigned(4 downto 0);
    Write_Reg_Num_DRR : out unsigned(4 downto 0);
    clk : in std_logic;
    offset : in unsigned(31 downto 0);
    offsetDRR : out unsigned(31 downto 0);
    pc : in unsigned(31 downto 0);
    pcDRRstage : out unsigned(31 downto 0);
    rdDRR : out unsigned(4 downto 0);
    rdFD : in unsigned(4 downto 0);
    reset : in std_logic
  );
end entity; 

-- Generated from Verilog module decode_regread (4.v:298)
architecture from_verilog of decode_regread is
  signal ALUopDRR_Reg : unsigned(2 downto 0);
  signal ALUsrcDRR_Reg : std_logic;
  signal MemReadDRR_Reg : std_logic;
  signal MemWriteDRR_Reg : std_logic;
  signal MemtoRegDRR_Reg : std_logic;
  signal PCsrcDRR_Reg : std_logic;
  signal Read_Reg_Num_1DRR_Reg : unsigned(4 downto 0);
  signal Read_Reg_Num_2DRR_Reg : unsigned(4 downto 0);
  signal RegWriteDRR_Reg : std_logic;
  signal RegdstDRR_Reg : std_logic;
  signal Write_Reg_Num_DRR_Reg : unsigned(4 downto 0);
  signal offsetDRR_Reg : unsigned(31 downto 0);
  signal pcDRRstage_Reg : unsigned(31 downto 0);
  signal rdDRR_Reg : unsigned(4 downto 0);
begin
  ALUopDRR <= ALUopDRR_Reg;
  ALUsrcDRR <= ALUsrcDRR_Reg;
  MemReadDRR <= MemReadDRR_Reg;
  MemWriteDRR <= MemWriteDRR_Reg;
  MemtoRegDRR <= MemtoRegDRR_Reg;
  PCsrcDRR <= PCsrcDRR_Reg;
  Read_Reg_Num_1DRR <= Read_Reg_Num_1DRR_Reg;
  Read_Reg_Num_2DRR <= Read_Reg_Num_2DRR_Reg;
  RegWriteDRR <= RegWriteDRR_Reg;
  RegdstDRR <= RegdstDRR_Reg;
  Write_Reg_Num_DRR <= Write_Reg_Num_DRR_Reg;
  offsetDRR <= offsetDRR_Reg;
  pcDRRstage <= pcDRRstage_Reg;
  rdDRR <= rdDRR_Reg;
  
  -- Generated from always process in decode_regread (4.v:310)
  process (clk) is
  begin
    if rising_edge(clk) then
      Write_Reg_Num_DRR_Reg <= Write_Reg_Num;
      offsetDRR_Reg <= offset;
      pcDRRstage_Reg <= pc;
      rdDRR_Reg <= rdFD;
      Read_Reg_Num_1DRR_Reg <= Read_Reg_Num_1;
      Read_Reg_Num_2DRR_Reg <= Read_Reg_Num_2;
    end if;
  end process;
  
  -- Generated from always process in decode_regread (4.v:319)
  process (clk) is
  begin
    if rising_edge(clk) then
      RegdstDRR_Reg <= RegdstFDD;
      RegWriteDRR_Reg <= RegWriteFDD;
      ALUsrcDRR_Reg <= ALUsrcFDD;
      MemReadDRR_Reg <= MemReadFDD;
      MemWriteDRR_Reg <= MemWriteFDD;
      PCsrcDRR_Reg <= PCsrcFDD;
      MemtoRegDRR_Reg <= MemtoRegFDD;
      ALUopDRR_Reg <= ALUopFDD;
    end if;
  end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Generated from Verilog module regread_execute (4.v:334)
entity regread_execute is
  port (
    ALUopDRR : in unsigned(2 downto 0);
    ALUopRRE : out unsigned(2 downto 0);
    ALUsrcDRR : in std_logic;
    ALUsrcRRE : out std_logic;
    MemReadDRR : in std_logic;
    MemReadRRE : out std_logic;
    MemWriteDRR : in std_logic;
    MemWriteRRE : out std_logic;
    MemtoRegDRR : in std_logic;
    MemtoRegRRE : out std_logic;
    PCsrcDRR : in std_logic;
    PCsrcRRE : out std_logic;
    Read_Data1DRR : in unsigned(31 downto 0);
    Read_Data2DRR : in unsigned(31 downto 0);
    Read_Reg_Num_1DRR : in unsigned(4 downto 0);
    Read_Reg_Num_1RRE : out unsigned(4 downto 0);
    Read_Reg_Num_2DRR : in unsigned(4 downto 0);
    Read_Reg_Num_2RRE : out unsigned(4 downto 0);
    RegWriteDRR : in std_logic;
    RegWriteRRE : out std_logic;
    RegdstDRR : in std_logic;
    RegdstRRE : out std_logic;
    Write_DataRRE : out unsigned(31 downto 0);
    Write_Reg_Num_DRR : in unsigned(4 downto 0);
    Write_Reg_Num_RRE : out unsigned(4 downto 0);
    clk : in std_logic;
    offsetDRR : in unsigned(31 downto 0);
    offsetRRE : out unsigned(31 downto 0);
    pcDRRstage : in unsigned(31 downto 0);
    pcRREstage : out unsigned(31 downto 0);
    rdDRR : in unsigned(4 downto 0);
    rdRRE : out unsigned(4 downto 0);
    reset : in std_logic;
    zeroflag : out std_logic
  );
end entity; 

-- Generated from Verilog module regread_execute (4.v:334)
architecture from_verilog of regread_execute is
  signal ALUopRRE_Reg : unsigned(2 downto 0);
  signal ALUsrcRRE_Reg : std_logic;
  signal MemReadRRE_Reg : std_logic;
  signal MemWriteRRE_Reg : std_logic;
  signal MemtoRegRRE_Reg : std_logic;
  signal PCsrcRRE_Reg : std_logic;
  signal Read_Reg_Num_1RRE_Reg : unsigned(4 downto 0);
  signal Read_Reg_Num_2RRE_Reg : unsigned(4 downto 0);
  signal RegWriteRRE_Reg : std_logic;
  signal RegdstRRE_Reg : std_logic;
  signal Write_DataRRE_Reg : unsigned(31 downto 0);
  signal Write_Reg_Num_RRE_Reg : unsigned(4 downto 0);
  signal offsetRRE_Reg : unsigned(31 downto 0);
  signal pcRREstage_Reg : unsigned(31 downto 0);
  signal rdRRE_Reg : unsigned(4 downto 0);
begin
  ALUopRRE <= ALUopRRE_Reg;
  ALUsrcRRE <= ALUsrcRRE_Reg;
  MemReadRRE <= MemReadRRE_Reg;
  MemWriteRRE <= MemWriteRRE_Reg;
  MemtoRegRRE <= MemtoRegRRE_Reg;
  PCsrcRRE <= PCsrcRRE_Reg;
  Read_Reg_Num_1RRE <= Read_Reg_Num_1RRE_Reg;
  Read_Reg_Num_2RRE <= Read_Reg_Num_2RRE_Reg;
  RegWriteRRE <= RegWriteRRE_Reg;
  RegdstRRE <= RegdstRRE_Reg;
  Write_DataRRE <= Write_DataRRE_Reg;
  Write_Reg_Num_RRE <= Write_Reg_Num_RRE_Reg;
  offsetRRE <= offsetRRE_Reg;
  pcRREstage <= pcRREstage_Reg;
  rdRRE <= rdRRE_Reg;
  zeroflag <= 'Z';
  
  -- Generated from always process in regread_execute (4.v:340)
  process (clk) is
  begin
    if rising_edge(clk) then
      offsetRRE_Reg <= offsetDRR;
      pcRREstage_Reg <= pcDRRstage;
      Write_DataRRE_Reg <= Read_Data2DRR;
      Write_Reg_Num_RRE_Reg <= Write_Reg_Num_DRR;
      rdRRE_Reg <= rdDRR;
      Read_Reg_Num_1RRE_Reg <= Read_Reg_Num_1DRR;
      Read_Reg_Num_2RRE_Reg <= Read_Reg_Num_2DRR;
    end if;
  end process;
  
  -- Generated from always process in regread_execute (4.v:350)
  process (clk) is
  begin
    if rising_edge(clk) then
      RegdstRRE_Reg <= RegdstDRR;
      RegWriteRRE_Reg <= RegWriteDRR;
      ALUsrcRRE_Reg <= ALUsrcDRR;
      MemReadRRE_Reg <= MemReadDRR;
      MemWriteRRE_Reg <= MemWriteDRR;
      PCsrcRRE_Reg <= PCsrcDRR;
      MemtoRegRRE_Reg <= MemtoRegDRR;
      ALUopRRE_Reg <= ALUopDRR;
    end if;
  end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Generated from Verilog module execute_mem (4.v:394)
entity execute_mem is
  port (
    ALUopEM : out unsigned(2 downto 0);
    ALUopRRE : in unsigned(2 downto 0);
    ALUsrcEM : out std_logic;
    ALUsrcRRE : in std_logic;
    MemReadEM : out std_logic;
    MemReadRRE : in std_logic;
    MemWriteEM : out std_logic;
    MemWriteRRE : in std_logic;
    MemtoRegEM : out std_logic;
    MemtoRegRRE : in std_logic;
    PCsrcEM : out std_logic;
    PCsrcRRE : in std_logic;
    Read_Reg_Num_1EM : out unsigned(4 downto 0);
    Read_Reg_Num_1RRE : in unsigned(4 downto 0);
    Read_Reg_Num_2EM : out unsigned(4 downto 0);
    Read_Reg_Num_2RRE : in unsigned(4 downto 0);
    RegWriteEM : out std_logic;
    RegWriteRRE : in std_logic;
    RegdstEM : out std_logic;
    RegdstRRE : in std_logic;
    Write_DataRRE : in unsigned(31 downto 0);
    Write_Reg_Num_EM : out unsigned(4 downto 0);
    Write_Reg_Num_RRE : in unsigned(4 downto 0);
    address : out unsigned(31 downto 0);
    aluresultRRE : in unsigned(31 downto 0);
    clk : in std_logic;
    jumpPCEM : out unsigned(31 downto 0);
    jumpPCRRE : in unsigned(31 downto 0);
    rdEM : out unsigned(4 downto 0);
    rdRRE : in unsigned(4 downto 0);
    reset : in std_logic;
    zeroflag : in std_logic
  );
end entity; 

-- Generated from Verilog module execute_mem (4.v:394)
architecture from_verilog of execute_mem is
  signal ALUopEM_Reg : unsigned(2 downto 0);
  signal ALUsrcEM_Reg : std_logic;
  signal MemReadEM_Reg : std_logic;
  signal MemWriteEM_Reg : std_logic;
  signal MemtoRegEM_Reg : std_logic;
  signal PCsrcEM_Reg : std_logic;
  signal Read_Reg_Num_1EM_Reg : unsigned(4 downto 0);
  signal Read_Reg_Num_2EM_Reg : unsigned(4 downto 0);
  signal RegWriteEM_Reg : std_logic;
  signal RegdstEM_Reg : std_logic;
  signal Write_Reg_Num_EM_Reg : unsigned(4 downto 0);
  signal address_Reg : unsigned(31 downto 0);
  signal jumpPCEM_Reg : unsigned(31 downto 0);
  signal rdEM_Reg : unsigned(4 downto 0);
begin
  ALUopEM <= ALUopEM_Reg;
  ALUsrcEM <= ALUsrcEM_Reg;
  MemReadEM <= MemReadEM_Reg;
  MemWriteEM <= MemWriteEM_Reg;
  MemtoRegEM <= MemtoRegEM_Reg;
  PCsrcEM <= PCsrcEM_Reg;
  Read_Reg_Num_1EM <= Read_Reg_Num_1EM_Reg;
  Read_Reg_Num_2EM <= Read_Reg_Num_2EM_Reg;
  RegWriteEM <= RegWriteEM_Reg;
  RegdstEM <= RegdstEM_Reg;
  Write_Reg_Num_EM <= Write_Reg_Num_EM_Reg;
  address <= address_Reg;
  jumpPCEM <= jumpPCEM_Reg;
  rdEM <= rdEM_Reg;
  
  -- Generated from always process in execute_mem (4.v:401)
  process (clk) is
  begin
    if rising_edge(clk) then
      Write_Reg_Num_EM_Reg <= Write_Reg_Num_RRE;
      address_Reg <= aluresultRRE;
      jumpPCEM_Reg <= jumpPCRRE;
      rdEM_Reg <= rdRRE;
      Read_Reg_Num_1EM_Reg <= Read_Reg_Num_1RRE;
      Read_Reg_Num_2EM_Reg <= Read_Reg_Num_2RRE;
    end if;
  end process;
  
  -- Generated from always process in execute_mem (4.v:410)
  process (clk) is
  begin
    if rising_edge(clk) then
      RegdstEM_Reg <= RegdstRRE;
      RegWriteEM_Reg <= RegWriteRRE;
      ALUsrcEM_Reg <= ALUsrcRRE;
      MemReadEM_Reg <= MemReadRRE;
      MemWriteEM_Reg <= MemWriteRRE;
      PCsrcEM_Reg <= PCsrcRRE;
      MemtoRegEM_Reg <= MemtoRegRRE;
      ALUopEM_Reg <= ALUopRRE;
    end if;
  end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Generated from Verilog module mem_writeback (4.v:425)
entity mem_writeback is
  port (
    ALUopEM : in unsigned(2 downto 0);
    ALUopMWB : out unsigned(2 downto 0);
    ALUsrcEM : in std_logic;
    ALUsrcMWB : out std_logic;
    MemReadEM : in std_logic;
    MemReadMWB : out std_logic;
    MemWriteEM : in std_logic;
    MemWriteMWB : out std_logic;
    MemtoRegEM : in std_logic;
    MemtoRegMWB : out std_logic;
    PCsrcEM : in std_logic;
    PCsrcMWB : out std_logic;
    Read_Data1MWB : out unsigned(31 downto 0);
    Read_DataEM : in unsigned(31 downto 0);
    RegWriteEM : in std_logic;
    RegWriteMWB : out std_logic;
    RegdstEM : in std_logic;
    RegdstMWB : out std_logic;
    Write_Reg_Num_EM : in unsigned(4 downto 0);
    Write_Reg_Num_MWB : out unsigned(4 downto 0);
    address : in unsigned(31 downto 0);
    addressMWB : out unsigned(31 downto 0);
    clk : in std_logic;
    rdEM : in unsigned(4 downto 0);
    rdMWB : out unsigned(4 downto 0);
    reset : in std_logic
  );
end entity; 

-- Generated from Verilog module mem_writeback (4.v:425)
architecture from_verilog of mem_writeback is
  signal ALUopMWB_Reg : unsigned(2 downto 0);
  signal ALUsrcMWB_Reg : std_logic;
  signal MemReadMWB_Reg : std_logic;
  signal MemWriteMWB_Reg : std_logic;
  signal MemtoRegMWB_Reg : std_logic;
  signal PCsrcMWB_Reg : std_logic;
  signal Read_Data1MWB_Reg : unsigned(31 downto 0);
  signal RegWriteMWB_Reg : std_logic;
  signal RegdstMWB_Reg : std_logic;
  signal Write_Reg_Num_MWB_Reg : unsigned(4 downto 0);
  signal addressMWB_Reg : unsigned(31 downto 0);
  signal rdMWB_Reg : unsigned(4 downto 0);
begin
  ALUopMWB <= ALUopMWB_Reg;
  ALUsrcMWB <= ALUsrcMWB_Reg;
  MemReadMWB <= MemReadMWB_Reg;
  MemWriteMWB <= MemWriteMWB_Reg;
  MemtoRegMWB <= MemtoRegMWB_Reg;
  PCsrcMWB <= PCsrcMWB_Reg;
  Read_Data1MWB <= Read_Data1MWB_Reg;
  RegWriteMWB <= RegWriteMWB_Reg;
  RegdstMWB <= RegdstMWB_Reg;
  Write_Reg_Num_MWB <= Write_Reg_Num_MWB_Reg;
  addressMWB <= addressMWB_Reg;
  rdMWB <= rdMWB_Reg;
  
  -- Generated from always process in mem_writeback (4.v:432)
  process (clk) is
  begin
    if rising_edge(clk) then
      Read_Data1MWB_Reg <= Read_DataEM;
      Write_Reg_Num_MWB_Reg <= Write_Reg_Num_EM;
      addressMWB_Reg <= address;
      rdMWB_Reg <= rdEM;
    end if;
  end process;
  
  -- Generated from always process in mem_writeback (4.v:439)
  process (clk) is
  begin
    if rising_edge(clk) then
      RegdstMWB_Reg <= RegdstEM;
      RegWriteMWB_Reg <= RegWriteEM;
      ALUsrcMWB_Reg <= ALUsrcEM;
      MemReadMWB_Reg <= MemReadEM;
      MemWriteMWB_Reg <= MemWriteEM;
      PCsrcMWB_Reg <= PCsrcEM;
      MemtoRegMWB_Reg <= MemtoRegEM;
      ALUopMWB_Reg <= ALUopEM;
    end if;
  end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Generated from Verilog module regread_execute2 (4.v:363)
entity regread_execute2 is
  port (
    ALUopRRE : in unsigned(2 downto 0);
    ALUopRRE2 : out unsigned(2 downto 0);
    ALUsrcRRE : in std_logic;
    ALUsrcRRE2 : out std_logic;
    MemReadRRE : in std_logic;
    MemReadRRE2 : out std_logic;
    MemWriteRRE : in std_logic;
    MemWriteRRE2 : out std_logic;
    MemtoRegRRE : in std_logic;
    MemtoRegRRE2 : out std_logic;
    PCsrcRRE : in std_logic;
    PCsrcRRE2 : out std_logic;
    Read_Reg_Num_1RRE : in unsigned(4 downto 0);
    Read_Reg_Num_1RRE2 : out unsigned(4 downto 0);
    Read_Reg_Num_2RRE : in unsigned(4 downto 0);
    Read_Reg_Num_2RRE2 : out unsigned(4 downto 0);
    RegWriteRRE : in std_logic;
    RegWriteRRE2 : out std_logic;
    RegdstRRE : in std_logic;
    RegdstRRE2 : out std_logic;
    Write_DataRRE : in unsigned(31 downto 0);
    Write_DataRRE2 : out unsigned(31 downto 0);
    Write_Reg_Num_RRE : in unsigned(4 downto 0);
    Write_Reg_Num_RRE2 : out unsigned(4 downto 0);
    clk : in std_logic;
    offsetRRE : in unsigned(31 downto 0);
    offsetRRE2 : out unsigned(31 downto 0);
    pcRREstage : in unsigned(31 downto 0);
    pcRREstage2 : out unsigned(31 downto 0);
    rdRRE : in unsigned(4 downto 0);
    rdRRE2 : out unsigned(4 downto 0);
    zeroflag : in std_logic;
    zeroflag2 : out std_logic
  );
end entity; 

-- Generated from Verilog module regread_execute2 (4.v:363)
architecture from_verilog of regread_execute2 is
  signal ALUopRRE2_Reg : unsigned(2 downto 0);
  signal ALUsrcRRE2_Reg : std_logic;
  signal MemReadRRE2_Reg : std_logic;
  signal MemWriteRRE2_Reg : std_logic;
  signal MemtoRegRRE2_Reg : std_logic;
  signal PCsrcRRE2_Reg : std_logic;
  signal Read_Reg_Num_1RRE2_Reg : unsigned(4 downto 0);
  signal Read_Reg_Num_2RRE2_Reg : unsigned(4 downto 0);
  signal RegWriteRRE2_Reg : std_logic;
  signal RegdstRRE2_Reg : std_logic;
  signal Write_DataRRE2_Reg : unsigned(31 downto 0);
  signal Write_Reg_Num_RRE2_Reg : unsigned(4 downto 0);
  signal offsetRRE2_Reg : unsigned(31 downto 0);
  signal pcRREstage2_Reg : unsigned(31 downto 0);
  signal rdRRE2_Reg : unsigned(4 downto 0);
begin
  ALUopRRE2 <= ALUopRRE2_Reg;
  ALUsrcRRE2 <= ALUsrcRRE2_Reg;
  MemReadRRE2 <= MemReadRRE2_Reg;
  MemWriteRRE2 <= MemWriteRRE2_Reg;
  MemtoRegRRE2 <= MemtoRegRRE2_Reg;
  PCsrcRRE2 <= PCsrcRRE2_Reg;
  Read_Reg_Num_1RRE2 <= Read_Reg_Num_1RRE2_Reg;
  Read_Reg_Num_2RRE2 <= Read_Reg_Num_2RRE2_Reg;
  RegWriteRRE2 <= RegWriteRRE2_Reg;
  RegdstRRE2 <= RegdstRRE2_Reg;
  Write_DataRRE2 <= Write_DataRRE2_Reg;
  Write_Reg_Num_RRE2 <= Write_Reg_Num_RRE2_Reg;
  offsetRRE2 <= offsetRRE2_Reg;
  pcRREstage2 <= pcRREstage2_Reg;
  rdRRE2 <= rdRRE2_Reg;
  
  -- Generated from always process in regread_execute2 (4.v:370)
  process (clk) is
  begin
    if rising_edge(clk) then
      offsetRRE2_Reg <= offsetRRE;
      pcRREstage2_Reg <= pcRREstage;
      Write_DataRRE2_Reg <= Write_DataRRE;
      Write_Reg_Num_RRE2_Reg <= Write_Reg_Num_RRE;
      rdRRE2_Reg <= rdRRE;
      Read_Reg_Num_1RRE2_Reg <= Read_Reg_Num_1RRE;
      Read_Reg_Num_2RRE2_Reg <= Read_Reg_Num_2RRE;
    end if;
  end process;
  
  -- Generated from always process in regread_execute2 (4.v:380)
  process (clk) is
  begin
    if rising_edge(clk) then
      RegdstRRE2_Reg <= RegdstRRE;
      RegWriteRRE2_Reg <= RegWriteRRE;
      ALUsrcRRE2_Reg <= ALUsrcRRE;
      MemReadRRE2_Reg <= MemReadRRE;
      MemWriteRRE2_Reg <= MemWriteRRE;
      PCsrcRRE2_Reg <= PCsrcRRE;
      MemtoRegRRE2_Reg <= MemtoRegRRE;
      ALUopRRE2_Reg <= ALUopRRE;
    end if;
  end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Generated from Verilog module alu_stage2 (4.v:452)
entity alu_stage2 is
  port (
    clk : in std_logic;
    result : in unsigned(31 downto 0);
    result_stage2 : out unsigned(31 downto 0);
    zeroflag : in std_logic;
    zeroflag_stage2 : out std_logic
  );
end entity; 

-- Generated from Verilog module alu_stage2 (4.v:452)
architecture from_verilog of alu_stage2 is
  signal result_stage2_Reg : unsigned(31 downto 0);
  signal zeroflag_stage2_Reg : std_logic;
begin
  result_stage2 <= result_stage2_Reg;
  zeroflag_stage2 <= zeroflag_stage2_Reg;
  
  -- Generated from always process in alu_stage2 (4.v:456)
  process (clk) is
  begin
    if rising_edge(clk) then
      result_stage2_Reg <= result;
      zeroflag_stage2_Reg <= zeroflag;
    end if;
  end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Generated from Verilog module forwarding_unit (4.v:465)
entity forwarding_unit is
  port (
    DEXrs : in unsigned(4 downto 0);
    DEXrt : in unsigned(4 downto 0);
    EMRegWrite : in std_logic;
    EMrd : in unsigned(4 downto 0);
    Forwardrs : out unsigned(1 downto 0);
    Forwardrt : out unsigned(1 downto 0);
    MWBrd : in unsigned(4 downto 0);
    RegWriteMWB : in std_logic
  );
end entity; 

-- Generated from Verilog module forwarding_unit (4.v:465)
architecture from_verilog of forwarding_unit is
  signal Forwardrs_Reg : unsigned(1 downto 0);
  signal Forwardrt_Reg : unsigned(1 downto 0);
begin
  Forwardrs <= Forwardrs_Reg;
  Forwardrt <= Forwardrt_Reg;
  
  -- Generated from always process in forwarding_unit (4.v:469)
  process (EMRegWrite, EMrd, DEXrs, RegWriteMWB, MWBrd, DEXrt) is
  begin
    if (((unsigned'("0000000000000000000000000000000") & EMRegWrite) = X"00000001") and (Resize(EMrd, 32) /= X"00000000")) and (EMrd = DEXrs) then
      Forwardrs_Reg <= "10";
    else
      if (((unsigned'("0000000000000000000000000000000") & RegWriteMWB) = X"00000001") and (Resize(MWBrd, 32) /= X"00000000")) and (MWBrd = DEXrs) then
        Forwardrs_Reg <= "01";
      else
        Forwardrs_Reg <= "00";
      end if;
    end if;
    if (((unsigned'("0000000000000000000000000000000") & EMRegWrite) = X"00000001") and (Resize(EMrd, 32) /= X"00000000")) and (EMrd = DEXrt) then
      Forwardrt_Reg <= "10";
    else
      if (((unsigned'("0000000000000000000000000000000") & RegWriteMWB) = X"00000001") and (Resize(MWBrd, 32) /= X"00000000")) and (MWBrd = DEXrt) then
        Forwardrt_Reg <= "01";
      else
        Forwardrt_Reg <= "00";
      end if;
    end if;
  end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Generated from Verilog module mux1 (4.v:2)
entity mux1 is
  port (
    in1 : in unsigned(31 downto 0);
    in2 : in unsigned(31 downto 0);
    out_sig : out unsigned(31 downto 0);
    select_sig : in std_logic
  );
end entity; 

-- Generated from Verilog module mux1 (4.v:2)
architecture from_verilog of mux1 is
  signal LPM_q_ivl_1 : unsigned(31 downto 0);
  signal LPM_d1_ivl_1 : unsigned(31 downto 0);
  signal LPM_d0_ivl_1 : unsigned(31 downto 0);
  signal LPM_ivl_1 : std_logic;
begin
  out_sig <= in2 when select_sig = '1' else in1;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Generated from Verilog module mux2 (4.v:6)
entity mux2 is
  port (
    a : in unsigned(31 downto 0);
    b : in unsigned(31 downto 0);
    c : in unsigned(31 downto 0);
    d : in unsigned(31 downto 0);
    out_sig : out unsigned(31 downto 0);
    s0 : in std_logic;
    s1 : in std_logic
  );
end entity; 

-- Generated from Verilog module mux2 (4.v:6)
architecture from_verilog of mux2 is
  signal tmp_ivl_0 : unsigned(31 downto 0);  -- Temporary created at 4.v:7
  signal tmp_ivl_2 : unsigned(31 downto 0);  -- Temporary created at 4.v:7
  signal LPM_ivl_1 : std_logic;
  signal LPM_ivl_5 : std_logic;
  signal LPM_d0_ivl_3 : unsigned(31 downto 0);
  signal LPM_q_ivl_5 : unsigned(31 downto 0);
  signal LPM_d1_ivl_1 : unsigned(31 downto 0);
begin
  tmp_ivl_0 <= d when s0 = '1' else c;
  tmp_ivl_2 <= b when s0 = '1' else a;
  out_sig <= tmp_ivl_0 when s1 = '1' else tmp_ivl_2;
end architecture;

