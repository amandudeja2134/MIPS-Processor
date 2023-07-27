module mux2x1(
   input [31:0] in1, in2,input select,output [31:0] out);
   assign out = select ? in2 : in1;
 endmodule

module mux2x1_2(
   input [4:0] in1, in2,input select,output [4:0] out);
   assign out = select ? in2 : in1;
 endmodule

module InstMem (
    input [31:0] pc, input reset, output [31:0] instCode
 );
 reg [7:0] mem [100:0];

 assign instCode = {mem[pc],mem[pc+1],mem[pc+2],mem[pc+3]};

 always @(reset) begin
    if(reset == 0)
    begin
        mem[0] = 8'h8D; mem[1] = 8'h61; mem[2] = 8'h00; mem[3] = 8'h0C;  // 8C2B000C lw R1,R11,12
        mem[4] = 8'h39; mem[5] = 8'h03; mem[6] = 8'h00; mem[7] = 8'h08;  // 38680008 xori R3,R8,8
        mem[8] = 8'h00; mem[9] = 8'h27; mem[10] = 8'h10; mem[11] = 8'h22; // 00271022 sub R2,R1,R7
        mem[12] = 8'h08; mem[13] = 8'h00; mem[14] = 8'h00; mem[15] = 8'h14; // 08000014 J L1
        mem[16] = 8'h00; mem[17] = 8'hC6; mem[18] = 8'h30; mem[19] = 8'h22; // 00C63022 Sub r6,r6,r6
        mem[48] = 8'h00; mem[49] = 8'h65; mem[50] = 8'h20; mem[51] = 8'h22; // 00652022 sub r4,r3,r5
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

 always @(reset) begin
    if(reset == 0)
    begin
        for(integer i =0;i<32;i=i+1)begin
            RegFileContent[i] = 0;
        end
    end
 end

 always @(negedge clk) begin
    Read_Data1 <= RegFileContent[Read_Reg_Num_1];
    Read_Data2 <= RegFileContent[Read_Reg_Num_2];
 end

 always @(posedge clk) begin
    if(WriteEn == 1)
      RegFileContent[Write_Reg_Num] <= Write_Data;
 end
 endmodule

module DataMem (
    input clk,reset,input [31:0] address, Write_Data,input MemWrite,MemRead,output reg [31:0] Read_Data
 );

 reg [31:0] DataMem [100:0];

 always @(reset) begin
    if(reset == 0)
    begin
        for(integer i =0;i<101;i=i+1)begin
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
    input  clk,reset,input [31:26] instCode,output reg  Regdst,RegWrite,ALUsrc,MemRead,MemWrite,PCsrc,MemtoReg,output reg [2:0] ALUop
 );

 always @(*) begin
    case (instCode[31:26])
        6'b100011: ALUsrc = 1'b1;      // lw
        6'b101011: ALUsrc = 1'b1;      //sw
        6'b000000: ALUsrc = 1'b0;      //sub
        6'b001110: ALUsrc = 1'b0;      //xori
        6'b000010: ALUsrc = 1'b0;      //j
    endcase
 end
 always @(*) begin
    case (instCode[31:26])
        6'b100011: Regdst = 1'b1;      // lw
        6'b101011: Regdst = 1'b0;      //sw
        6'b000000: Regdst = 1'b0;      //sub
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
   input clk,reset,input [31:0] PC, output reg [31:0] PCnew);
   

   always @(posedge clk or negedge reset) begin
        if(!reset)
           PCnew <=0;
        else 
          PCnew <= PC;
   end

 endmodule

module stage1(
  input clk,input [31:0] nextPC,instCode,output reg [5:0] instOp,
  output reg [4:0] reg1,reg2,wreg,output reg [31:0] wad1,nextPC_out);

  always @(posedge clk ) begin
      instOp <= instCode[31:26];
      reg1 <= instCode[25:21];
      reg2 <= instCode[20:16];
      wreg <= instCode[15:11];
      wad1 <= {16'b0000000000000000,instCode[15:0]};
      nextPC_out <= nextPC;
  end 

 endmodule

module stage2(
   input clk, input [31:0] rd1,rd2,wad1,pcprev,input [4:0] wregMuxed, 
   input RegWrite,MemtoReg,PCsrc,MemWrite,MemRead,ALUsrc,input [2:0] ALUop,
   output reg RegWrite2,MemtoReg2,PCsrc2,MemWrite2,MemRead2,ALUsrc2,output reg [2:0] ALUop2,
   output reg [31:0] rd1_out,rd2_out,wad1_out,pcnext,output reg [4:0] wregMuxed_out
 );

 always @(posedge clk ) begin
      rd1_out <= rd1;
      rd2_out <= rd2;
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

 end

 endmodule

module stage3(
   input clk,input [31:0] pcupdated,aluresult,rd2,input [4:0] wregmuxed,
   input RegWrite,MemRead,MemWrite,MemtoReg,PCsrc,
   output reg [31:0] pcnext,result_address,write_data,output reg [4:0] wregmuxed_out,
   output reg Regwrite2,MemRead2,MemWrite2,MemtoReg2,PCsrc2
 ); 
   
   always @(posedge clk ) begin
      Regwrite2 <= RegWrite;
      MemRead2 <= MemRead;
      MemtoReg2 <= MemtoReg;
      MemWrite2 <= MemWrite;
      PCsrc2 <= PCsrc;
      pcnext <= pcupdated;
      result_address <= aluresult;
      write_data <= rd2;
      wregmuxed_out <= wregmuxed;
   end

 endmodule

module stage4(
   input clk,Regwrite,MemtoReg,input [31:0] read_data,alu_result,input [4:0] wregmuxed,
   output reg Regwrite2,MemtoReg2, output reg [31:0] read_out,aluresult_out,
   output reg [4:0] wregmuxed_out
 );


  always @(posedge clk ) begin
      Regwrite2 <= Regwrite;
      MemtoReg2 <= MemtoReg;
      read_out <= read_data;
      aluresult_out <= alu_result;
      wregmuxed_out <= wregmuxed;
  end

 endmodule



module completeProcessor(
   input clk,reset, output zeroflag);



   wire Regdst,RegWrite,RegWrite1,RegWrite2,RegWrite3,Regwrite_Final,ALUsrc,ALUsrc1,ALUsrc2,MemRead,MemRead1,MemRead2,MemRead3,MemWrite,MemWrite1,MemWrite2,MemWrite3,PCsrc,PCsrc1,PCsrc2,PCsrc_Final,MemtoReg,MemtoReg1,MemtoReg2,MemtoReg3,MemtoReg4;
   wire [2:0] ALUop,ALUop1,ALUop2;
   wire [4:0] read_reg1,read_reg2,write_reg1,write_reg_Final,wreg_muxed,wregmuxed_s2,wregmuxed_s3;
   wire [5:0] instOp;
   wire [31:0] PCout_s3,currentPC,PCmuxed,instCode,write_address1,PCout1,Read_Data1,Read_Data2,Read_Data1_s2,Read_Data2_s2,write_address1_s2,PCout_s2,Read_Data2_s2_muxed,aluresult,result_address,write_data,Read_Data_mem,result_address_out,Write_Data_Final,Read_Data_mem_s4;

   mux2x1 m1(PCout_s3,(currentPC+'d4),PCsrc_Final,PCmuxed);
   PCevaluate p1(clk,reset,PCmuxed,currentPC);
   InstMem i1(currentPC,reset,instCode);
   stage1 s1(clk,(currentPC+'d4),instCode,instOp,read_reg1,read_reg2,write_reg1,write_address1,PCout1);
   mainControlUnit c1(clk,reset,instOp,Regdst,RegWrite,ALUsrc,MemRead,MemWrite,PCsrc,MemtoReg,ALUop);
   RegFile r1(clk,reset,Regwrite_Final,read_reg1,read_reg2,write_reg_Final,Write_Data_Final,Read_Data1,Read_Data2);
   mux2x1_2 m2(instCode[20:16],instCode[15:11],Regdst,wreg_muxed);
   stage2 s2(clk,Read_Data1,Read_Data2,write_address1,PCout1,wreg_muxed,RegWrite1,MemtoReg1,PCsrc1,MemWrite1,MemRead1,ALUsrc1,ALUop1,RegWrite2,MemtoReg2,PCsrc2,MemWrite2,MemRead2,ALUsrc2,ALUop2,Read_Data1_s2,Read_Data2_s2,write_address1_s2,PCout_s2,wregmuxed_s2);
   mux2x1 m3(Read_Data2_s2,write_address1_s2,ALUsrc2,Read_Data2_s2_muxed);
   ALU a1(Read_Data1_s2,Read_Data2_s2_muxed,ALUop2,aluresult,zeroflag);
   stage3 s3(clk,(PCout_s2 + (write_address1_s2<<2)),aluresult,Read_Data2_s2,wregmuxed_s2,RegWrite2,MemRead2,MemWrite2,MemtoReg2,PCsrc2,PCout_s3,result_address,write_data,wregmuxed_s3,RegWrite3,MemRead3,MemWrite3,MemtoReg3,PCsrc_Final);
   DataMem d1(clk,reset,result_address,write_data,MemWrite3,MemRead3,Read_Data_mem);
   stage4 s4(clk,RegWrite3,MemtoReg3,Read_Data_mem,result_address,wregmuxed_s3,Regwrite_Final,MemtoReg4,Read_Data_mem_s4,result_address_out,write_reg_Final);
   mux2x1 m4(Read_Data_mem_s4,result_address_out,MemtoReg4,Write_Data_Final);



 endmodule