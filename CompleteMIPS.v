module mux2x1(
   input [31:0] in1, in2,input select,output [31:0] out);
   assign out = select ? in2 : in1;
 endmodule

module mux2x1_2(
   input [4:0] in1, in2,input select,output [4:0] out);
   assign out = select ? in2 : in1;
 endmodule

module mux2x1_3(
   input [31:0] in1, in2,in3,input [1:0]select,output [31:0] out
 ); 
    assign out = (select == 'd2) ? in3 : (select == 'd1) ? in2 : in1;
     
 endmodule

module InstMem (
    input [31:0] pc, input reset, output [31:0] instCode
 );
 reg [7:0] mem [100:0];

 assign instCode = {mem[pc],mem[pc+1],mem[pc+2],mem[pc+3]};

 always @(reset) begin
    if(reset == 0)
    begin
        mem[0] = 8'h8D; mem[1] = 8'h61; mem[2] = 8'h00; mem[3] = 8'h0C;  // 8D61000C lw R1(rt),R11(rs),12  ---   12 + (content of R11) -> store in R1. So R1 should have 23
        mem[4] = 8'h39; mem[5] = 8'h03; mem[6] = 8'h00; mem[7] = 8'h08;  // 39030008 xori R3(rt),R8(rs),8 ----   8 xor (content of R8) -> store in R3. So here R3 should update to 0.
        mem[8] = 8'h00; mem[9] = 8'h27; mem[10] = 8'h10; mem[11] = 8'h22; // 00271022 sub R2(rd),R1(rs),R7(rt)  --- forwarding needed -> 
        mem[12] = 8'h08; mem[13] = 8'h00; mem[14] = 8'h00; mem[15] = 8'h14; // 08000014 J L1  --- Stalling for 2 cycles needed
        mem[16] = 8'h00; mem[17] = 8'hC6; mem[18] = 8'h30; mem[19] = 8'h22; // 00C63022 Sub r6,r6,r6  
        mem[80] = 8'h00; mem[81] = 8'h65; mem[82] = 8'h20; mem[83] = 8'h22; // 00652022 sub r4(rd),r3(rs),r5(rt)
    end
 end
 endmodule

module RegFile ( 
    input clk,reset, WriteEn,
    input [4:0] Read_Reg_Num_1,Read_Reg_Num_2,Write_Reg_Num,
    input [31:0] Write_Data,
    output reg [31:0] Read_Data1,Read_Data2
 );

 reg [7:0] RegFileContent [31:0];
 integer i = 0;
 always @(reset) begin
    if(reset == 0)
    begin
        for(i = 0;i<101;i = i+1)begin
            RegFileContent[i] = i;
        end
    end
 end

 always @(negedge clk) begin
    Read_Data1 <= RegFileContent[Read_Reg_Num_1];
    Read_Data2 <= RegFileContent[Read_Reg_Num_2];
 end

 always @(posedge clk) begin
    if((WriteEn == 1) && (Write_Reg_Num != 0))
      RegFileContent[Write_Reg_Num] <= Write_Data;
 end
 endmodule

module DataMem (
    input clk,reset,input [31:0] address, Write_Data,input MemWrite,MemRead,output reg [31:0] Read_Data
 );
 integer i = 0;
 reg [31:0] DataMem [100:0];

 always @(reset) begin
    if(reset == 0)
    begin
        for(i = 0;i<101;i = i+1)begin
            DataMem[i] = i;
        end
    end
 end

 always @(posedge clk) begin
    if(MemWrite)
       DataMem[address] <= Write_Data;
 end
 always @(negedge clk) begin
    if(MemRead)
       Read_Data <= DataMem[address];
 end    
 endmodule

module mainControlUnit (
    input  clk,reset,input [31:26] instCode,output reg  noop,Regdst,RegWrite,ALUsrc,MemRead,MemWrite,PCsrc,MemtoReg,output reg [2:0] ALUop
 );
  
 always @(*) begin
    case (instCode[31:26])
        6'b100011: ALUsrc = 1'b1;      // lw
        6'b101011: ALUsrc = 1'b1;      //sw
        6'b000000: ALUsrc = 1'b0;      //sub
        6'b001110: ALUsrc = 1'b1;      //xori
        6'b000010: ALUsrc = 1'b0;      //j
    endcase
 end
 always @(*) begin
    case (instCode[31:26])
        6'b100011: Regdst = 1'b0;      // lw
        6'b101011: Regdst = 1'b0;      //sw
        6'b000000: Regdst = 1'b1;      //sub
        6'b001110: Regdst = 1'b0;       //xori
        6'b000010: Regdst = 1'bx;      //j
    endcase
 end
 always @(*) begin
    case (instCode[31:26])
        6'b100011:  RegWrite = 1;       // lw
        6'b101011:  RegWrite = 0;      //sw
        6'b000000:  RegWrite = 1;      //sub
        6'b001110:  RegWrite = 1;        //xori
        6'b000010:  RegWrite = 0;       //j
    endcase
 end
 always @(*) begin
    case (instCode[31:26])
        6'b100011: ALUop = 3'b000;       // lw
        6'b101011: ALUop = 3'b001;      //sw
        6'b000000: ALUop = 3'b010;   //sub
        6'b001110: ALUop = 3'b011;      //xori
        6'b000010: ALUop = 3'b100;       //j
    endcase
 end
 always @(*) begin
    case (instCode[31:26])
        6'b100011: MemRead = 1'b1;     // lw
        6'b101011: MemRead = 1'b0;    //sw
        6'b000000: MemRead = 1'b0;     //sub
        6'b001110: MemRead = 1'b0;    //xori
        6'b000010: MemRead = 1'b0;       //j
    endcase
 end
 always @(*) begin
    case (instCode[31:26])
        6'b100011: MemWrite = 1'b0;       // lw
        6'b101011: MemWrite = 1'b1;       //sw
        6'b000000: MemWrite = 1'b0;     //sub
        6'b001110: MemWrite = 1'b0;      //xori
        6'b000010: MemWrite = 1'b0;    //j
    endcase
 end
 always @(*) begin
    case (instCode[31:26])
        6'b100011:  MemtoReg = 1'b1;     // lw
        6'b101011:  MemtoReg = 1'b0;      //sw
        6'b000000:  MemtoReg = 1'b0;     //sub
        6'b001110:  MemtoReg = 1'b0;     //xori
        6'b000010:  MemtoReg = 1'b0;     //j
    endcase
 end
 always @(*) begin
    case (instCode[31:26])
        6'b100011:  PCsrc = 1'b0;      // lw
        6'b101011:  PCsrc = 1'b0;      //sw
        6'b000000:  PCsrc = 1'b0;      //sub
        6'b001110:  PCsrc = 1'b0;       //xori
        6'b000010:  PCsrc = 1'b1;       //j
    endcase
 end

 always @(*)begin
    case (instCode[31:26])
        6'b100011:  noop = 1'b0;     // lw
        6'b101011:  noop = 1'b0;      //sw
        6'b000000:  noop = 1'b0;     //sub
        6'b001110:  noop = 1'b0;     //xori
        6'b000010:  noop = 1'b1;     //j
    endcase
 end
 endmodule

module stall(
   input clk,reset,noop, output reg noop_out, output y
  );
 always @(posedge clk) begin
      if(!reset) begin
       noop_out <= 0;
      end 
      else 
        noop_out <= noop;   
 end
 /*always @(negedge noop ) begin
     noop_out <= noop;
 end*/
 assign y = noop | noop_out;
  
 endmodule

module ALU (
    input [31:0] a,b,
    input [2:0] ALUop,
    output reg [31:0] result, output reg zeroflag
 );

 always @(*) begin
                case (ALUop)
                    3'b000: result = a + b;    //lw
                    3'b001: result = a + b;    //sw
                    3'b010: result = a - b;    //sub
                    3'b011: result = a ^ b;    //xori
                    3'b100: result = 0;        //j
                    endcase
 end

 always @(*) begin
    if(result == 0)
      zeroflag <= 1;
    else
     zeroflag <= 0;
 end
 endmodule

module PCevaluate(
   input clk,reset,noop,input [31:0] PC, output reg [31:0] PCnew);
   

   always @(posedge clk or negedge reset) begin
        if(!reset)
           PCnew <=0;
        else if(noop)
          PCnew <= PC - 'd4;
         else 
          PCnew <= PC;
   end

 endmodule


module stage1(
  input clk,noop,input [31:0] nextPC,instCode,output reg [5:0] instOp,
  output reg [4:0] reg1,reg2,wreg,output reg [27:0] wad2,output reg [31:0] wad1,nextPC_out);

  //assign instOp = (noop == 0) ? instCode[31:26] : 0; 
  always @(posedge clk) begin
   if(noop == 0)begin
      instOp <= instCode[31:26];
      reg1 <= instCode[25:21];   // rs
      reg2 <= instCode[20:16];   //rt
      wreg <= instCode[15:11];   //rd
      wad1 <= {16'b0000000000000000,instCode[15:0]};
      wad2 <= {instCode[25:0],2'b00};
      nextPC_out <= nextPC;
   end
   else begin
     instOp <= 0;
      reg1 <= 0;
      reg2 <= 0;
      wreg <= 0;
      wad1 <= 0;
      wad2 <= 0;
      nextPC_out <= nextPC;
   end
  end 

 endmodule

module stage2(
   input clk, input [31:0] read_d1,read_d2,wad1,pcprev,input [27:0] wad2, input [4:0] wregMuxed, rs1,rt1,rd1,
   input RegWrite,MemtoReg,PCsrc,MemWrite,MemRead,ALUsrc,input [2:0] ALUop,
   output reg RegWrite2,MemtoReg2,PCsrc2,MemWrite2,MemRead2,ALUsrc2,output reg [2:0] ALUop2,
   output reg [31:0] rd1_out,rd2_out,wad1_out,pcnext,output reg [27:0] wad2_out,output reg [4:0] wregMuxed_out,rs2,rt2,rd2
 );

 always @(posedge clk ) begin
      rd1_out <= read_d1;
      rd2_out <= read_d2;
      wad1_out <= wad1;
      pcnext <= pcprev;
      RegWrite2 <= RegWrite;
      MemtoReg2 <= MemtoReg;
      PCsrc2 <= PCsrc;
      MemWrite2 <= MemWrite;
      MemRead2 <= MemRead;
      ALUsrc2 <= ALUsrc;
      ALUop2 <= ALUop;
      wregMuxed_out <= wregMuxed;
      wad2_out <= wad2;
      rs2 <= rs1;
      rt2 <= rt1;
      rd2 <= rd1;

 end

 endmodule

module stage3(
   input clk,input [31:0] pcupdated,aluresult,read_d2,input [27:0] wad2,input [4:0] wregmuxed,rs2,rt2,rd2,
   input RegWrite,MemRead,MemWrite,MemtoReg,PCsrc,
   output reg [31:0] pcnext,result_address,write_data,output reg [27:0] wad2_out, 
   output reg [4:0] wregmuxed_out,rs3,rt3,rd3,output reg Regwrite2,MemRead2,MemWrite2,MemtoReg2,PCsrc2
 ); 
   
   always @(posedge clk ) begin
      Regwrite2 <= RegWrite;
      MemRead2 <= MemRead;
      MemtoReg2 <= MemtoReg;
      MemWrite2 <= MemWrite;
      PCsrc2 <= PCsrc;
      pcnext <= pcupdated;
      result_address <= aluresult;
      write_data <= read_d2;
      wregmuxed_out <= wregmuxed;
      wad2_out <= wad2;
      rs3 <= rs2;
      rt3 <= rt2;
      rd3 <= rd2;
   end

 endmodule

module stage4(
   input clk,Regwrite,MemtoReg,input [31:0] read_data,alu_result,input [4:0] wregmuxed,rs3,rt3,rd3,
   output reg Regwrite2,MemtoReg2, output reg [31:0] read_out,aluresult_out,
   output reg [4:0] wregmuxed_out,rs4,rt4,rd4
 );


  always @(posedge clk ) begin
      Regwrite2 <= Regwrite;
      MemtoReg2 <= MemtoReg;
      read_out <= read_data;
      aluresult_out <= alu_result;
      wregmuxed_out <= wregmuxed;
      rs4 <= rs3;
      rt4 <= rt3;
      rd4 <= rd3;
  end

 endmodule

module stage5(
   input clk,reset,input [4:0] w1,input rwf1, output reg [4:0] w2,output reg rwf2
 );
  always @(posedge clk) begin
     w2 <= w1;
     rwf2 <= rwf1;
  end
 endmodule

module Pcinitialise(
   input PCsrc_Final, output reg PC_src_final2);

 always @(*) begin

  if(PCsrc_Final === 1'bz)
      PC_src_final2 <= 0;
   else
      PC_src_final2 <= PCsrc_Final;
  end
 endmodule

module jump(
   input [25:0] address,input [31:0] currentPC,output reg [31:0] address_out
 );

 always @(*) begin
      address_out <= {currentPC[31:28],(address<<2)};
 end

 endmodule

module forwarding_unit(
  input [4:0] id_ex_rs,ex_dm_rd,dm_wb_rd,id_ex_rt,ex_dm_rt,output reg [1:0] fwdA,fwdB,output reg fwdC
 );

 always @(*) begin
    if((ex_dm_rt == id_ex_rs))
        fwdA <= 'd2;
    else if((dm_wb_rd == id_ex_rt))
        fwdA <= 'd1;
      else
        fwdA <= 0;
 end

 always @(*) begin
    if((ex_dm_rd != 0) && (ex_dm_rd == id_ex_rs))
        fwdB <= 'd1;
    else if((dm_wb_rd == id_ex_rs))
        fwdB <= 'd2;
      else
        fwdB <= 0;
 end

 always @(*) begin
      if((dm_wb_rd != 0) && (dm_wb_rd == ex_dm_rt))
        fwdC <= 1;
      else
        fwdC <= 0;
 end

 endmodule


module completeProcessor(
   input clk,reset, output zeroflag);



   wire Regwrite_Final2,noop_extended,noop,noop_out,Regdst,RegWrite,RegWrite2,RegWrite3,Regwrite_Final,ALUsrc,ALUsrc2,MemRead,MemRead2,MemRead3,MemWrite,MemWrite2,MemWrite3,PCsrc,PCsrc2,PCsrc_Final,PC_src_final2,MemtoReg,MemtoReg2,MemtoReg3,MemtoReg4,fwdC;
   wire [1:0] fwdA,fwdB;
   wire [2:0] ALUop,ALUop2;
   wire [4:0] write_reg_Final2,read_reg1,read_reg2,write_reg1,write_reg_Final,wreg_muxed,wregmuxed_s2,wregmuxed_s3,rs1,rs2,rs3,rs4,rd1,rd2,rd3,rd4,rt1,rt2,rt3,rt4;
   wire [5:0] instOp;
   wire [27:0] jump_address1,jump_address2,jump_address3;
   wire [31:0] write_data_forwarded,Read_Data1_s2_forwarded,Read_Data2_s2_forwarded,PCout_s3,currentPC,PCmuxed,instCode,write_address1,PCout1,Read_Data1,Read_Data2,Read_Data1_s2,Read_Data2_s2,write_address1_s2,PCout_s2,Read_Data2_s2_muxed,aluresult,result_address,write_data,Read_Data_mem,result_address_out,Write_Data_Final,Read_Data_mem_s4;


   Pcinitialise p2(PCsrc_Final,PC_src_final2);
   //mux2x1 m1((currentPC+'d4),PCout_s3,PC_src_final2,PCmuxed);  // branch
   mux2x1 m1((currentPC+'d4),{currentPC[31:28],jump_address3},PC_src_final2,PCmuxed);  // jump
   PCevaluate p1(clk,reset,noop_extended,PCmuxed,currentPC);
   InstMem i1(currentPC,reset,instCode);
   stage1 s1(clk,noop_extended,(currentPC+'d4),instCode,instOp,read_reg1,read_reg2,write_reg1,jump_address1,write_address1,PCout1);
   mainControlUnit c1(clk,reset,instOp,noop,Regdst,RegWrite,ALUsrc,MemRead,MemWrite,PCsrc,MemtoReg,ALUop);
   RegFile r1(clk,reset,Regwrite_Final2,read_reg1,read_reg2,write_reg_Final2,Write_Data_Final,Read_Data1,Read_Data2);
   mux2x1_2 m2(instCode[20:16],instCode[15:11],Regdst,wreg_muxed);
   stage2 s2(clk,Read_Data1,Read_Data2,write_address1,PCout1,jump_address1,wreg_muxed,read_reg1,read_reg2,write_reg1,RegWrite,MemtoReg,PCsrc,MemWrite,MemRead,ALUsrc,ALUop,RegWrite2,MemtoReg2,PCsrc2,MemWrite2,MemRead2,ALUsrc2,ALUop2,Read_Data1_s2,Read_Data2_s2,write_address1_s2,PCout_s2,jump_address2,wregmuxed_s2,rs2,rt2,rd2);
   mux2x1 m3(Read_Data2_s2,write_address1_s2,ALUsrc2,Read_Data2_s2_muxed);
   ALU a1(Read_Data1_s2_forwarded,Read_Data2_s2_forwarded,ALUop2,aluresult,zeroflag);
   stage3 s3(clk,(PCout_s2 + (write_address1_s2<<2)),aluresult,Read_Data2_s2,jump_address2,wregmuxed_s2,rs2,rt2,rd2,RegWrite2,MemRead2,MemWrite2,MemtoReg2,PCsrc2,PCout_s3,result_address,write_data,jump_address3,wregmuxed_s3,rs3,rt3,rd3,RegWrite3,MemRead3,MemWrite3,MemtoReg3,PCsrc_Final);
   DataMem d1(clk,reset,result_address,write_data_forwarded,MemWrite3,MemRead3,Read_Data_mem);
   stage4 s4(clk,RegWrite3,MemtoReg3,Read_Data_mem,result_address,wregmuxed_s3,rs3,rt3,rd3,Regwrite_Final,MemtoReg4,Read_Data_mem_s4,result_address_out,write_reg_Final,rs4,rt4,rd4);
   stage5 s6(clk,reset,write_reg_Final,Regwrite_Final,write_reg_Final2,Regwrite_Final2);
   mux2x1 m4(result_address_out,Read_Data_mem_s4,MemtoReg4,Write_Data_Final);
   stall s5(clk,reset,noop,noop_out,noop_extended);
   forwarding_unit f1(rs2/*rs2*/,rd3,rd4,rt2/**rt1*/,write_reg_Final2,fwdA,fwdB,fwdC);
   mux2x1_3 m5(Read_Data1_s2,result_address,result_address_out,fwdA,Read_Data1_s2_forwarded);
   mux2x1_3 m6(Read_Data2_s2_muxed,result_address,result_address_out,fwdB,Read_Data2_s2_forwarded);
   mux2x1 m7(write_data,result_address_out,fwdC,write_data_forwarded);


 endmodule


module tb();
  
  reg clk,reset;
  wire zeroflag;

  completeProcessor c2(clk,reset,zeroflag);

  initial begin
    clk = 0;
    forever begin
        #50 clk = ~clk;
    end
 end

 initial begin
    reset = 0;
    #300;
    reset = 1;
    #1500;
    #200;
 end
 
 endmodule


 /* Sequence of operations

 1. Reset is asserted for first few cycles. 
 All initialisations
 First inst. is loaded at PC = 0

 2. Reset deasserted
 PC should start incrementing


 To check for PC:
  If PC is working fine normally or incase of branch.
  Is pipeline stalled in case of branch.
  Correct address = 80 after jump.
  No. of stall cycles = 2

  To check for RegFile

 */

