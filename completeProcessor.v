module mux1(input [31:0] in1, in2,input select,output [31:0] out);
assign out = select ? in2 : in1;
endmodule

module InstMem (
    input [31:0] pc, input reset, output [31:0] instCode, output reg [31:0] pcout
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

always @(*) begin
      pcout <= pc;
end
endmodule


module InstFetch (
    input clk,reset,input [31:0] newpc,output [31:0] instCode, output reg [31:0] pcout
);

reg [31:0] pc;
wire [31:0] pco;
InstMem M0(pc,reset,instCode,pco);

always @(posedge clk or negedge reset) begin
    if(reset == 0)
      pc <= 0;
    else if(instCode[31:26] == 6'b000010)
      pc <= newpc;
    else 
     pc <= pco + 4;
end

always @(*) begin
    pcout <= pc;
end

endmodule

module RegFile (
    input clk,reset, WriteEn,
    input [4:0] Read_Reg_Num_1,Write_Reg_Num,
    input [31:0] Write_Data,
    output reg [31:0] Read_Data1
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
    input  clk,reset,input [31:0] instCode,output reg  Regdst,RegWrite,ALUsrc,MemRead,MemWrite,PCsrc,MemtoReg,output reg [2:0] ALUop
);

always @(*) begin
    case (instCode[31:26])
        6'b100011: ALUsrc = 1'b1;  // lw
        6'b101011: ALUsrc = 1'b1;  //sw
        6'b000000: ALUsrc = 1'b0;      //sub
        6'b001110: ALUsrc = 1'b1;      //xori
        6'b000010: ALUsrc = 1'b0;    //j
    endcase
 end
 always @(*) begin
    case (instCode[31:26])
        6'b100011: Regdst = 1'b0;      // lw
        6'b101011: Regdst = 1'bx;      //sw
        6'b000000: Regdst = 1'b1;      //sub
        6'b001110: Regdst = 1'b1;       //xori
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
        6'b001110:  MemtoReg = 1'b1;     //xori
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

module jumpblock (
    input clk,reset,input [31:0] pc,offset, output reg [31:0] jumpPC
);

always @(posedge clk or negedge reset) begin
    if(reset == 0)
      jumpPC <= 0;
    else
      jumpPC <= (offset<<2) + pc;
end  
endmodule

module fetch_decode (
    input clk,reset,input [31:0] instCode,pc,
    output reg [4:0] Read_Reg_Num_1,Read_Reg_Num_2,Write_Reg_Num,output reg [31:0] offset, output reg [31:0] pcFDstage,
    output  RegdstFDD,RegWriteFDD,ALUsrcFDD,MemReadFDD,MemWriteFDD,PCsrcFDD,MemtoRegFDD,output [2:0] ALUopFDD
);


mainControlUnit c1(clk,reset,instCode,RegdstFDD,RegWriteFDD,ALUsrcFDD,MemReadFDD,MemWriteFDD,PCsrcFDD,MemtoRegFDD,ALUopFDD);
always @(posedge clk ) begin
    
    Read_Reg_Num_1 <= instCode[25:21];
    Read_Reg_Num_2 <= instCode[20:16];
    Write_Reg_Num <= (instCode[31:26] == 6'b000000) ? instCode[15:11] : instCode[20:16];
    offset <= { {16{instCode[15]}}, instCode[15:0]};
    pcFDstage <= pc;
end
    
endmodule

module decode_regread (
    input clk,reset,input [4:0] Read_Reg_Num_1,Read_Reg_Num_2,input [31:0] pc,offset,input [4:0] Write_Reg_Num,
    input RegdstFDD,RegWriteFDD,ALUsrcFDD,MemReadFDD,MemWriteFDD,PCsrcFDD,MemtoRegFDD,input [2:0] ALUopFDD,
    output reg [31:0] pcDRRstage,output [31:0] Read_Data1DRR,Read_Data2DRR,output reg [31:0] offsetDRR,output reg [4:0] Write_Reg_Num_DRR,
    output reg  RegdstDRR,RegWriteDRR,ALUsrcDRR,MemReadDRR,MemWriteDRR,PCsrcDRR,MemtoRegDRR,output reg [2:0] ALUopDRR
);


wire [31:0] Write_Data;

RegFile a2(clk,reset,1'b0,Read_Reg_Num_1,Write_Reg_Num,Write_Data,Read_Data1DRR);
RegFile a3(clk,reset,1'b0,Read_Reg_Num_2,Write_Reg_Num,Write_Data,Read_Data2DRR);
always @(posedge clk ) begin
    Write_Reg_Num_DRR <= Write_Reg_Num;
    offsetDRR <= offset;
    pcDRRstage <= pc;
end

always @(posedge clk) begin
    RegdstDRR <= RegdstFDD;
    RegWriteDRR <= RegWriteFDD;
    ALUsrcDRR <= ALUsrcFDD;
    MemReadDRR <= MemReadFDD;
    MemWriteDRR <= MemWriteFDD;
    PCsrcDRR <= PCsrcFDD;
    MemtoRegDRR <= MemtoRegFDD;
    ALUopDRR <= ALUopFDD;
end
    
endmodule

module regread_execute (
    input clk,reset,input [31:0] Read_Data1DRR,Read_Data2DRR,pcDRRstage,offsetDRR,input [4:0] Write_Reg_Num_DRR,
    input RegdstDRR,RegWriteDRR,ALUsrcDRR,MemReadDRR,MemWriteDRR,PCsrcDRR,MemtoRegDRR,input [2:0] ALUopDRR,
    output reg [31:0] Write_DataRRE,pcRREstage,offsetRRE,output zeroflag,output reg [4:0] Write_Reg_Num_RRE,
    output reg RegdstRRE,RegWriteRRE,ALUsrcRRE,MemReadRRE,MemWriteRRE,PCsrcRRE,MemtoRegRRE,output reg [2:0] ALUopRRE
 );
 always @(posedge clk ) begin
    offsetRRE <= offsetDRR;
    pcRREstage <= pcDRRstage;
    Write_DataRRE <= Read_Data2DRR; 
    Write_Reg_Num_RRE <= Write_Reg_Num_DRR;
 end

 always @(posedge clk) begin
    RegdstRRE <= RegdstDRR;
    RegWriteRRE <= RegWriteDRR;
    ALUsrcRRE <= ALUsrcDRR;
    MemReadRRE <= MemReadDRR;
    MemWriteRRE <= MemWriteDRR;
    PCsrcRRE <= PCsrcDRR;
    MemtoRegRRE <= MemtoRegDRR;
    ALUopRRE <= ALUopDRR;
end
    
 endmodule

module execute_mem (
    input clk,reset,zeroflag,input [31:0] jumpPCRRE,aluresultRRE,Write_DataRRE, input [4:0] Write_Reg_Num_RRE,
    input RegdstRRE,RegWriteRRE,ALUsrcRRE,MemReadRRE,MemWriteRRE,PCsrcRRE,MemtoRegRRE, input [2:0] ALUopRRE,
    output reg [31:0] jumpPCEM,address,output reg [4:0] Write_Reg_Num_EM,
    output reg RegdstEM,RegWriteEM,ALUsrcEM,MemReadEM,MemWriteEM,PCsrcEM,MemtoRegEM,output reg [2:0] ALUopEM
 );
    

    always @(posedge clk ) begin 
     Write_Reg_Num_EM<= Write_Reg_Num_RRE;
     address <= aluresultRRE;
     jumpPCEM <= jumpPCRRE;
    end

 always @(posedge clk) begin
    RegdstEM <= RegdstRRE;
    RegWriteEM <= RegWriteRRE;
    ALUsrcEM <= ALUsrcRRE;
    MemReadEM <= MemReadRRE;
    MemWriteEM <= MemWriteRRE;
    PCsrcEM <= PCsrcRRE;
    MemtoRegEM <= MemtoRegRRE;
    ALUopEM <= ALUopRRE;
end

endmodule

module mem_writeback (
    input clk,reset,input [31:0] Read_DataEM,address,input [4:0] Write_Reg_Num_EM,
    input RegdstEM,RegWriteEM,ALUsrcEM,MemReadEM,MemWriteEM,PCsrcEM,MemtoRegEM,input [2:0] ALUopEM,
    output reg [31:0] Read_Data1MWB,addressMWB,output reg [4:0] Write_Reg_Num_MWB,
    output reg RegdstMWB,RegWriteMWB,ALUsrcMWB,MemReadMWB,MemWriteMWB,PCsrcMWB,MemtoRegMWB,output reg [2:0] ALUopMWB
);

always @(posedge clk ) begin
    Read_Data1MWB <= Read_DataEM;
    Write_Reg_Num_MWB <= Write_Reg_Num_EM;
    addressMWB <= address;
end

always @(posedge clk) begin
    RegdstMWB <= RegdstEM;
    RegWriteMWB <= RegWriteEM;
    ALUsrcMWB <= ALUsrcEM;
    MemReadMWB <= MemReadEM;
    MemWriteMWB <= MemWriteEM;
    PCsrcMWB <= PCsrcEM;
    MemtoRegMWB <= MemtoRegEM;
    ALUopMWB <= ALUopEM;
end
    
endmodule


module datapath (
     input clk,reset, output zeroflag
);

wire [31:0] jumpInp,jumpPCRRE,instCode,pc,pcout,offset,pcFDstage,pcDRRstage, Read_Data1DRR,Read_Data2DRR,offsetDRR,Read_Data2DRR_muxed;
wire [31:0] result,Write_DataRRE,pcRREstage,offsetRRE,jumpPCEM,address,aluresult,Read_DataEM,Read_Data1MWB,addressMWB,Write_Data,Read_Data1;
wire [4:0] Read_Reg_Num_1,Read_Reg_Num_2,Write_Reg_Num,Write_Reg_Num_DRR,Write_Reg_Num_RRE,Write_Reg_Num_EM,Write_Reg_Num_MWB;
wire [2:0] ALUop,ALUopFDD,ALUopDRR,ALUopRRE,ALUopEM,ALUopMWB;
wire Regdst,RegWrite,ALUsrc,MemRead,MemWrite,PCsrc,MemtoReg,RegdstFDD,RegWriteFDD,ALUsrcFDD,MemReadFDD,MemWriteFDD,PCsrcFDD,MemtoRegFDD,RegdstDRR,RegWriteDRR,ALUsrcDRR,MemReadDRR,MemWriteDRR,PCsrcDRR,MemtoRegDRR,RegdstRRE,RegWriteRRE,ALUsrcRRE,MemReadRRE,MemWriteRRE,PCsrcRRE,MemtoRegRRE,RegdstEM,RegWriteEM,ALUsrcEM,MemReadEM,MemWriteEM,PCsrcEM,MemtoRegEM,RegdstMWB,RegWriteMWB,ALUsrcMWB,MemReadMWB,MemWriteMWB,PCsrcMWB,MemtoRegMWB;

mux1 m2(pcout,jumpPCRRE,PCsrcFDD,jumpInp);
InstFetch b1(clk,reset,jumpInp,instCode,pcout);
fetch_decode b2(clk,reset,instCode,pcout,Read_Reg_Num_1,Read_Reg_Num_2,Write_Reg_Num,offset,pcFDstage,RegdstFDD,RegWriteFDD,ALUsrcFDD,MemReadFDD,MemWriteFDD,PCsrcFDD,MemtoRegFDD,ALUopFDD);
decode_regread b3(clk,reset,Read_Reg_Num_1,Read_Reg_Num_2,pcFDstage,offset,Write_Reg_Num,RegdstFDD,RegWriteFDD,ALUsrcFDD,MemReadFDD,MemWriteFDD,PCsrcFDD,MemtoRegFDD,ALUopFDD,pcDRRstage, Read_Data1DRR,Read_Data2DRR,offsetDRR,Write_Reg_Num_DRR,RegdstDRR,RegWriteDRR,ALUsrcDRR,MemReadDRR,MemWriteDRR,PCsrcDRR,MemtoRegDRR,ALUopDRR);
mux1 m3(Read_Data2DRR,offsetDRR,ALUsrcRRE,Read_Data2DRR_muxed);
regread_execute b4(clk,reset,Read_Data1DRR,Read_Data2DRR_muxed,pcDRRstage,offsetDRR,Write_Reg_Num_DRR,RegdstDRR,RegWriteDRR,ALUsrcDRR,MemReadDRR,MemWriteDRR,PCsrcDRR,MemtoRegDRR,ALUopDRR,Write_DataRRE,pcRREstage,offsetRRE,zeroflag,Write_Reg_Num_RRE,RegdstRRE,RegWriteRRE,ALUsrcRRE,MemReadRRE,MemWriteRRE,PCsrcRRE,MemtoRegRRE,ALUopRRE);
jumpblock a6(clk,reset,pcDRRstage,offsetDRR,jumpPCRRE);
//mainControlUnit a4(clk,reset,instCode,Regdst,RegWrite,ALUsrc,MemRead,MemWrite,PCsrc,MemtoReg,ALUop);
ALU a5(Read_Data1DRR,Read_Data2DRR_muxed,ALUopRRE,result,zeroflag);
execute_mem b5(clk,reset,zeroflag,jumpPCRRE,result,Write_DataRRE,Write_Reg_Num_RRE,RegdstRRE,RegWriteRRE,ALUsrcRRE,MemReadRRE,MemWriteRRE,PCsrcRRE,MemtoRegRRE,ALUopRRE,jumpPCEM,address,Write_Reg_Num_EM,RegdstEM,RegWriteEM,ALUsrcEM,MemReadEM,MemWriteEM,PCsrcEM,MemtoRegEM,ALUopEM);
DataMem a7(clk,reset,address,Write_DataRRE,MemWriteEM,MemReadEM,Read_DataEM);
mem_writeback b6(clk,reset,Read_DataEM,address,Write_Reg_Num_EM,RegdstEM,RegWriteEM,ALUsrcEM,MemReadEM,MemWriteEM,PCsrcEM,MemtoRegEM,ALUopEM,Read_Data1MWB,addressMWB,Write_Reg_Num_MWB,RegdstMWB,RegWriteMWB,ALUsrcMWB,MemReadMWB,MemWriteMWB,PCsrcMWB,MemtoRegMWB,ALUopMWB);
mux1 m1(Read_DataEM,addressMWB,MemtoRegMWB,Write_Data);
RegFile b7(clk,reset,RegWriteMWB,Read_Reg_Num_1,Write_Reg_Num_EM,Write_Data,Read_Data1);

//DataMem a7(clk,reset,12,0,0,1,Read_DataEM);
endmodule


module processor_tb ();
reg clk,reset;
wire zeroflag;
datapath d1(clk,reset,zeroflag);

initial begin
    clk = 1;
    forever begin
        #50 clk = ~clk;
    end
end

initial begin
    reset = 0;
    #100;
    reset = 1;#100;#100;#100;#100;
    
    #100;#100;#100;#100;#100;#100;#100;#100;
end
    
endmodule