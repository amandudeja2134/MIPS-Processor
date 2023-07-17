//------------------2x1 mux--------------------
module mux1(input [31:0] in1, in2,input select,output [31:0] out);
assign out = select ? in2 : in1;
endmodule
//-----------------4x1mux----------------------
module mux2 ( input [31:0] a, b, c, d, input s0, s1,output [31:0] out); 
 assign out = s1 ? (s0 ? d : c) : (s0 ? b : a); 
endmodule


//--------------------------------------INSTRUCTION MEMORY UNIT----------------------------------
module InstMem (
    input [31:0] pc, input reset, output [31:0] instCode, output reg [31:0] pcout
);
reg [7:0] mem [100:0]; // 100 locations assumed

assign instCode = {mem[pc],mem[pc+1],mem[pc+2],mem[pc+3]};

always @(reset) begin
    if(reset == 0)
    begin
        mem[0] = 8'h8D; mem[1] = 8'h61; mem[2] = 8'h00; mem[3] = 8'h0C;  //        8D26100C lw R1,R11,12 -> R1 should store content at the address(data(R11) + 12) in data memory
        mem[4] = 8'h39; mem[5] = 8'h03; mem[6] = 8'h00; mem[7] = 8'h08;  //        39030008 xori R3,R8,8 -> R3 should store (data(R8) xor 8)
        mem[8] = 8'h00; mem[9] = 8'h27; mem[10] = 8'h10; mem[11] = 8'h22; //       00271022 sub R2,R1,R7 -> R2 = R1-R7
        mem[12] = 8'h08; mem[13] = 8'h00; mem[14] = 8'h00; mem[15] = 8'h14; //     08000014 J L1         -> jump to location 50h i.e. 80 in decimal
        mem[16] = 8'h00; mem[17] = 8'hC6; mem[18] = 8'h30; mem[19] = 8'h22; //     00C63022 Sub r6,r6,r6 -> gets skipped due to jump
        mem[80] = 8'h00; mem[81] = 8'h65; mem[82] = 8'h20; mem[83] = 8'h22; // L1: 00652022 sub r4,r3,r5 -> R4 = R3-R5
    end
end

always @(*) begin
      pcout <= pc;
end
endmodule

//------------------------------INSTRUCTION FETCH UNIT---------------------------------
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
      pc <= {pco[31:28],instCode[25:0],2'b00};  //for jump instruction, pc is evaluated this way as given in assignment
    else 
     pc <= pco + 4;
end

always @(*) begin
    pcout <= pc;
end

endmodule


//-----------------------------------REGISTER FILE-------------------------------------
module RegFile (
    input clk,reset, WriteEn,
    input [4:0] Read_Reg_Num_1,Write_Reg_Num,
    input [31:0] Write_Data,
    output reg [31:0] Read_Data1
);

reg [7:0] RegFileContent [31:0]; //32 registers in register file

always @(reset) begin
    if(reset == 0)
    /*begin
        for(integer i =0;i<32;i=i+1)begin       // for simulation this way is fine, but for synthesis comment out the loop and use below given way of initialisation
            RegFileContent[i] = 0; // all registers initialised to zero
        end
    end*/
    RegFileContent[0] = 0;RegFileContent[1] = 0;RegFileContent[2] = 0;RegFileContent[3] = 0;RegFileContent[4] = 0;RegFileContent[5] = 0;
    RegFileContent[6] = 0;RegFileContent[7] = 0;RegFileContent[8] = 0;RegFileContent[9] = 0;RegFileContent[10] = 0;RegFileContent[11] = 0;
    RegFileContent[12] = 0;RegFileContent[13] = 0;RegFileContent[14] = 0;RegFileContent[15] = 0;RegFileContent[16] = 0;RegFileContent[17] = 0;
    RegFileContent[18] = 0;RegFileContent[19] = 0;RegFileContent[20] = 0;RegFileContent[21] = 0;RegFileContent[22] = 0;RegFileContent[23] = 0;
    RegFileContent[24] = 0;RegFileContent[25] = 0;RegFileContent[26] = 0;RegFileContent[27] = 0;RegFileContent[28] = 0;RegFileContent[29] = 0;
    RegFileContent[30] = 0;RegFileContent[31] = 0; 
    // initialise this way for synthesis cos it gives error if we use loop variable in for loop initialization

end

always @(negedge clk) begin  // negedge read as given in ques
    Read_Data1 <= RegFileContent[Read_Reg_Num_1];
end

always @(posedge clk) begin  //posedge write as given in ques
    if(WriteEn == 1)
      RegFileContent[Write_Reg_Num] <= Write_Data;
end
endmodule


//---------------------DATA MEMORY----------------------
module DataMem (
    input clk,reset,input [31:0] address, Write_Data,input MemWrite,MemRead,output reg [31:0] Read_Data
);

reg [31:0] DataMem [100:0];  // 100 locations assumed

always @(reset) begin
    if(reset == 0)
    /*begin
        for(integer i =0;i<101;i=i+1)begin       // for simulation this way is fine, but for synthesis comment out the loop and uncomment below given way of initialisation
            DataMem[i] = i;  //data initialised to same as index value 
        end
    end*/
    DataMem[0] = 0;DataMem[1] = 1;DataMem[2] = 2;DataMem[3] = 3;DataMem[4] = 4;DataMem[5] = 5;DataMem[6] = 6;
    DataMem[7] = 7;DataMem[8] = 8;DataMem[9] = 9;DataMem[10] = 10;DataMem[11] = 11;DataMem[12] = 12;    
    // initialise this way for synthesis cos it gives error if we use loop variable in a for loop initialisation
end

always @(posedge clk) begin //posedge write
    if(MemWrite)
       DataMem[address] <= Write_Data;
end
always @(negedge clk) begin  //negedge read
    if(MemRead)
       Read_Data <= DataMem[address];
end    
endmodule


//-----------------------------------CONTROL UNIT TO GENERATE CONTROL SIGNALS------------------------------
module mainControlUnit (
    input  clk,reset,input [31:0] instCode,output reg  Regdst,RegWrite,ALUsrc,MemRead,MemWrite,PCsrc,MemtoReg,output reg [2:0] ALUop
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
        6'b101011: Regdst = 1'bx;      //sw
        6'b000000: Regdst = 1'b1;      //sub
        6'b001110: Regdst = 1'b1;      //xori
        6'b000010: Regdst = 1'bx;      //j
    endcase
 end
 always @(*) begin
    case (instCode[31:26])
        6'b100011:  RegWrite = 1;       // lw
        6'b101011:  RegWrite = 0;       //sw
        6'b000000:  RegWrite = 1;       //sub
        6'b001110:  RegWrite = 1;       //xori
        6'b000010:  RegWrite = 0;       //j
    endcase
 end
 always @(*) begin
    case (instCode[31:26])
        6'b100011: ALUop = 3'b000;      // lw
        6'b101011: ALUop = 3'b001;      //sw
        6'b000000: ALUop = 3'b010;      //sub
        6'b001110: ALUop = 3'b011;      //xori
        6'b000010: ALUop = 3'b100;      //j
    endcase
 end
 always @(*) begin
    case (instCode[31:26])
        6'b100011: MemRead = 1'b1;     // lw
        6'b101011: MemRead = 1'b0;     //sw
        6'b000000: MemRead = 1'b0;     //sub
        6'b001110: MemRead = 1'b0;     //xori
        6'b000010: MemRead = 1'b0;     //j
    endcase
 end
 always @(*) begin
    case (instCode[31:26])
        6'b100011: MemWrite = 1'b0;       // lw
        6'b101011: MemWrite = 1'b1;       //sw
        6'b000000: MemWrite = 1'b0;       //sub
        6'b001110: MemWrite = 1'b0;       //xori
        6'b000010: MemWrite = 1'b0;       //j
    endcase
 end
 always @(*) begin
    case (instCode[31:26])
        6'b100011:  MemtoReg = 1'b1;      // lw
        6'b101011:  MemtoReg = 1'b0;      //sw
        6'b000000:  MemtoReg = 1'b0;      //sub
        6'b001110:  MemtoReg = 1'b1;      //xori
        6'b000010:  MemtoReg = 1'b0;      //j
    endcase
 end
 always @(*) begin
    case (instCode[31:26])
        6'b100011:  PCsrc = 1'b0;      // lw
        6'b101011:  PCsrc = 1'b0;      //sw
        6'b000000:  PCsrc = 1'b0;      //sub
        6'b001110:  PCsrc = 1'b0;      //xori
        6'b000010:  PCsrc = 1'b1;      //j
    endcase
 end

    
endmodule


//----------------ALU UNIT----------------------------
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


//----------------------Jumpblock-------------------------
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


//-------------------------------------FETCH/DECODE STAGE----------------------------------
module fetch_decode (
    input clk,reset,input [31:0] instCode,pc,
    output reg [4:0] Read_Reg_Num_1,Read_Reg_Num_2,Write_Reg_Num,rdFD,output reg [31:0] offset, output reg [31:0] pcFDstage,
    output  RegdstFDD,RegWriteFDD,ALUsrcFDD,MemReadFDD,MemWriteFDD,PCsrcFDD,MemtoRegFDD,output [2:0] ALUopFDD
);


mainControlUnit c1(clk,reset,instCode,RegdstFDD,RegWriteFDD,ALUsrcFDD,MemReadFDD,MemWriteFDD,PCsrcFDD,MemtoRegFDD,ALUopFDD);
always @(posedge clk ) begin
    
    Read_Reg_Num_1 <= instCode[25:21];  // Fetched 1st operand register
    Read_Reg_Num_2 <= instCode[20:16];  // Fetched 2nd operand register
    Write_Reg_Num <= (instCode[31:26] == 6'b000000) ? instCode[15:11] : instCode[20:16];  // Fetched Write reg number
    offset <= { {16{instCode[15]}}, instCode[15:0]};  // Offset calculation using sign extension 
    pcFDstage <= pc;   // PC pipeline
    rdFD <= instCode[15:11];  // rd pipeline
end
    
endmodule


//-------------------------------DECODE/REGISTER-READ STAGE---------------------------
module decode_regread (
    input clk,reset,input [4:0] Read_Reg_Num_1,Read_Reg_Num_2,rdFD,input [31:0] pc,offset,input [4:0] Write_Reg_Num,
    input RegdstFDD,RegWriteFDD,ALUsrcFDD,MemReadFDD,MemWriteFDD,PCsrcFDD,MemtoRegFDD,input [2:0] ALUopFDD,
    output reg [31:0] pcDRRstage,output [31:0] Read_Data1DRR,Read_Data2DRR,output reg [31:0] offsetDRR,output reg [4:0] Write_Reg_Num_DRR,rdDRR,Read_Reg_Num_1DRR,Read_Reg_Num_2DRR,
    output reg  RegdstDRR,RegWriteDRR,ALUsrcDRR,MemReadDRR,MemWriteDRR,PCsrcDRR,MemtoRegDRR,output reg [2:0] ALUopDRR
);


wire [31:0] Write_Data;

RegFile a2(clk,reset,1'b0,Read_Reg_Num_1,Write_Reg_Num,Write_Data,Read_Data1DRR);// reg1 read, RegWrite has been set to 0 because we just want to read here
RegFile a3(clk,reset,1'b0,Read_Reg_Num_2,Write_Reg_Num,Write_Data,Read_Data2DRR);// reg2 read, RegWrite has been set to 0 because we just want to read here
always @(posedge clk ) begin
    Write_Reg_Num_DRR <= Write_Reg_Num; //Write reg pipeline
    offsetDRR <= offset;               //offset pipeline
    pcDRRstage <= pc;                  // PC pipeline
    rdDRR <= rdFD;                     // rd register pipeline
    Read_Reg_Num_1DRR <= Read_Reg_Num_1; //read reg1 pipeline
    Read_Reg_Num_2DRR <= Read_Reg_Num_2; // read reg2 pipeline
end

always @(posedge clk) begin  // control signals pipeline
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


//-----------------------------REGISTOR-READ/EXECUTE STAGE--------------------------
module regread_execute (
    input clk,reset,input [31:0] Read_Data1DRR,Read_Data2DRR,pcDRRstage,offsetDRR,input [4:0] Write_Reg_Num_DRR,rdDRR,Read_Reg_Num_1DRR,Read_Reg_Num_2DRR,
    input RegdstDRR,RegWriteDRR,ALUsrcDRR,MemReadDRR,MemWriteDRR,PCsrcDRR,MemtoRegDRR,input [2:0] ALUopDRR,
    output reg [31:0] Write_DataRRE,pcRREstage,offsetRRE,output zeroflag,output reg [4:0] Write_Reg_Num_RRE,rdRRE,Read_Reg_Num_1RRE,Read_Reg_Num_2RRE,
    output reg RegdstRRE,RegWriteRRE,ALUsrcRRE,MemReadRRE,MemWriteRRE,PCsrcRRE,MemtoRegRRE,output reg [2:0] ALUopRRE
 );
 always @(posedge clk ) begin  // pipelining extended and continued from prev stage
    offsetRRE <= offsetDRR;
    pcRREstage <= pcDRRstage;
    Write_DataRRE <= Read_Data2DRR;   // for lw, sw instruction execute
    Write_Reg_Num_RRE <= Write_Reg_Num_DRR;
    rdRRE <= rdDRR;
    Read_Reg_Num_1RRE <= Read_Reg_Num_1DRR; 
    Read_Reg_Num_2RRE <= Read_Reg_Num_2DRR;
 end

 always @(posedge clk) begin// pipelining extended and continued from prev stage for control signals
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

//-------------------------EXECUTE/MEMORY STAGE------------------------------
module execute_mem (
    input clk,reset,zeroflag,input [31:0] jumpPCRRE,aluresultRRE,Write_DataRRE, input [4:0] Write_Reg_Num_RRE,rdRRE,Read_Reg_Num_1RRE,Read_Reg_Num_2RRE,
    input RegdstRRE,RegWriteRRE,ALUsrcRRE,MemReadRRE,MemWriteRRE,PCsrcRRE,MemtoRegRRE, input [2:0] ALUopRRE,
    output reg [31:0] jumpPCEM,address,output reg [4:0] Write_Reg_Num_EM,rdEM,Read_Reg_Num_1EM,Read_Reg_Num_2EM,
    output reg RegdstEM,RegWriteEM,ALUsrcEM,MemReadEM,MemWriteEM,PCsrcEM,MemtoRegEM,output reg [2:0] ALUopEM
 );

    always @(posedge clk) begin      
     Write_Reg_Num_EM<= Write_Reg_Num_RRE;
     address <= aluresultRRE;  // mem address generation stage
     jumpPCEM <= jumpPCRRE;
     rdEM <= rdRRE;
     Read_Reg_Num_1EM <= Read_Reg_Num_1RRE;
     Read_Reg_Num_2EM <= Read_Reg_Num_2RRE;
    end

 always @(posedge clk) begin //pipeline for control signals
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


//------------------------MEMORY/WRITEBACK STAGE--------------------------------
module mem_writeback (
    input clk,reset,input [31:0] Read_DataEM,address,input [4:0] Write_Reg_Num_EM,rdEM,
    input RegdstEM,RegWriteEM,ALUsrcEM,MemReadEM,MemWriteEM,PCsrcEM,MemtoRegEM,input [2:0] ALUopEM,
    output reg [31:0] Read_Data1MWB,addressMWB,output reg [4:0] Write_Reg_Num_MWB,rdMWB,
    output reg RegdstMWB,RegWriteMWB,ALUsrcMWB,MemReadMWB,MemWriteMWB,PCsrcMWB,MemtoRegMWB,output reg [2:0] ALUopMWB
);

always @(posedge clk ) begin
    Read_Data1MWB <= Read_DataEM;
    Write_Reg_Num_MWB <= Write_Reg_Num_EM;
    addressMWB <= address; //address gven for writeback for lw sw, inst
    rdMWB <= rdEM;
end

always @(posedge clk) begin //pipeline for control signals
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


//-------------------------FORWARDING UNIT FOR HAZARDS----------------------------
module forwarding_unit (
    input [4:0] DEXrs,DEXrt,EMrd,MWBrd,input EMRegWrite,MWBRegWrite, output reg [1:0] Forwardrs,Forwardrt
);

always @(*) begin
    if(EMRegWrite == 1 && EMrd != 0 && EMrd == DEXrs)
       Forwardrs <= 01;
    if(EMRegWrite == 1 && EMrd != 0 && EMrd == DEXrt)
       Forwardrt <= 01;
    if((MWBRegWrite == 1 && MWBrd != 0 && MWBrd == DEXrs) && !(EMRegWrite == 1 && EMrd != 0 && EMrd == DEXrs))
       Forwardrs <= 10;
    if((MWBRegWrite == 1 && MWBrd != 0 && MWBrd == DEXrt) && !(EMRegWrite == 1 && EMrd != 0 && EMrd == DEXrt))
       Forwardrt <= 10;
end
    
endmodule


// ----------------------------------------MAIN PROCESSOR-------------------------------------
module datapath (
     input clk,reset, output zeroflag
);

wire [31:0] jumpInp,jumpPCRRE,instCode,pc,pcout,offset,pcFDstage,pcDRRstage,Read_Data1DRR_muxed,Read_Data1DRR,Read_Data2DRR,Read_Data2DRRm,offsetDRR,Read_Data2DRR_muxed;
wire [31:0] result,Write_DataRRE,pcRREstage,offsetRRE,jumpPCEM,address,aluresult,Read_DataEM,Read_Data1MWB,addressMWB,Write_Data,Read_Data1;
wire [4:0] Read_Reg_Num_1,Read_Reg_Num_2,Write_Reg_Num,Write_Reg_Num_DRR,Write_Reg_Num_RRE,Write_Reg_Num_EM,Write_Reg_Num_MWB,rdFD,rdDRR,rdRRE,rdEM,rdMWB,Read_Reg_Num_1DRR,Read_Reg_Num_2DRR,Read_Reg_Num_1RRE,Read_Reg_Num_2RRE,Read_Reg_Num_1EM,Read_Reg_Num_2EM;
wire [2:0] ALUop,ALUopFDD,ALUopDRR,ALUopRRE,ALUopEM,ALUopMWB;
wire [1:0] Forwardrs,Forwardrt;
wire Regdst,RegWrite,ALUsrc,MemRead,MemWrite,PCsrc,MemtoReg,RegdstFDD,RegWriteFDD,ALUsrcFDD,MemReadFDD,MemWriteFDD,PCsrcFDD,MemtoRegFDD,RegdstDRR,RegWriteDRR,ALUsrcDRR,MemReadDRR,MemWriteDRR,PCsrcDRR,MemtoRegDRR,RegdstRRE,RegWriteRRE,ALUsrcRRE,MemReadRRE,MemWriteRRE,PCsrcRRE,MemtoRegRRE,RegdstEM,RegWriteEM,ALUsrcEM,MemReadEM,MemWriteEM,PCsrcEM,MemtoRegEM,RegdstMWB,RegWriteMWB,ALUsrcMWB,MemReadMWB,MemWriteMWB,PCsrcMWB,MemtoRegMWB;

mux1 m2(pcout,jumpPCRRE,PCsrcFDD,jumpInp);    // choosing pc based on jump inst or not
InstFetch b1(clk,reset,jumpInp,instCode,pcout); // after pc is given , inst is fetched
fetch_decode b2(clk,reset,instCode,pcout,Read_Reg_Num_1,Read_Reg_Num_2,Write_Reg_Num,rdFD,offset,pcFDstage,RegdstFDD,RegWriteFDD,ALUsrcFDD,MemReadFDD,MemWriteFDD,PCsrcFDD,MemtoRegFDD,ALUopFDD);  // afer fetched inst code is decoded here and given to control unit to generate control signals, also pipeline started
decode_regread b3(clk,reset,Read_Reg_Num_1,Read_Reg_Num_2,rdFD,pcFDstage,offset,Write_Reg_Num,RegdstFDD,RegWriteFDD,ALUsrcFDD,MemReadFDD,MemWriteFDD,PCsrcFDD,MemtoRegFDD,ALUopFDD,pcDRRstage, Read_Data1DRR,Read_Data2DRRm,offsetDRR,Write_Reg_Num_DRR,rdDRR,Read_Reg_Num_1DRR,Read_Reg_Num_2DRR,RegdstDRR,RegWriteDRR,ALUsrcDRR,MemReadDRR,MemWriteDRR,PCsrcDRR,MemtoRegDRR,ALUopDRR);
mux1 m3(Read_Data2DRRm,offsetDRR,ALUsrcRRE,Read_Data2DRR_muxed); // chooses input to operand 2 of alu depending on type of inst
regread_execute b4(clk,reset,Read_Data1DRR_muxed,Read_Data2DRR_muxed,pcDRRstage,offsetDRR,Write_Reg_Num_DRR,rdDRR,Read_Reg_Num_1DRR,Read_Reg_Num_2DRR,RegdstDRR,RegWriteDRR,ALUsrcDRR,MemReadDRR,MemWriteDRR,PCsrcDRR,MemtoRegDRR,ALUopDRR,Write_DataRRE,pcRREstage,offsetRRE,zeroflag,Write_Reg_Num_RRE,rdRRE,Read_Reg_Num_1RRE,Read_Reg_Num_2RRE,RegdstRRE,RegWriteRRE,ALUsrcRRE,MemReadRRE,MemWriteRRE,PCsrcRRE,MemtoRegRRE,ALUopRRE);  // gets the operand values from registers and pipeline is continued with the rest of the signals, also continues pipeline
jumpblock a6(clk,reset,pcDRRstage,offsetDRR,jumpPCRRE);  // used to generate jump address 
ALU a5(Read_Data1DRR,Read_Data2DRR_muxed,ALUopRRE,result,zeroflag); // computes result of two operands for an operation
execute_mem b5(clk,reset,zeroflag,jumpPCRRE,result,Write_DataRRE,Write_Reg_Num_RRE,rdRRE,Read_Reg_Num_1RRE,Read_Reg_Num_2RRE,RegdstRRE,RegWriteRRE,ALUsrcRRE,MemReadRRE,MemWriteRRE,PCsrcRRE,MemtoRegRRE,ALUopRRE,jumpPCEM,address,Write_Reg_Num_EM,rdEM,Read_Reg_Num_1EM,Read_Reg_Num_2EM,RegdstEM,RegWriteEM,ALUsrcEM,MemReadEM,MemWriteEM,PCsrcEM,MemtoRegEM,ALUopEM); //continues pipline and generates address if inst uses mem., also continues pipeline
DataMem a7(clk,reset,address,Write_DataRRE,MemWriteEM,MemReadEM,Read_DataEM);// used for lw or sw inst when memory access is required
mem_writeback b6(clk,reset,Read_DataEM,address,Write_Reg_Num_EM,rdEM,RegdstEM,RegWriteEM,ALUsrcEM,MemReadEM,MemWriteEM,PCsrcEM,MemtoRegEM,ALUopEM,Read_Data1MWB,addressMWB,Write_Reg_Num_MWB,rdMWB,RegdstMWB,RegWriteMWB,ALUsrcMWB,MemReadMWB,MemWriteMWB,PCsrcMWB,MemtoRegMWB,ALUopMWB); // generates address for writeback and is final stage of pipeline in which result is written back if required
mux1 m1(Read_Data1,addressMWB,MemtoRegMWB,Write_Data); // writes data from one of two sources based on type of inst 
RegFile b7(clk,reset,RegWriteMWB,Read_Reg_Num_1EM,Write_Reg_Num_EM,Write_Data,Read_Data1); // here we are writing to the register file if required
mux2 m4(Read_Data1DRR,result,Write_Data,0,Forwardrs[0],Forwardrs[1],Read_Data1DRR_muxed); // 4x1 mux used in forwarding
mux2 m5(Read_Data2DRR,result,Write_Data,0,Forwardrt[0],Forwardrt[1],Read_Data2DRRm); // 4x1 mux used in forwarding
forwarding_unit f1(Read_Reg_Num_1,Read_Reg_Num_2,rdEM,rdMWB,RegWriteEM,RegWriteMWB,Forwardrs,Forwardrt);

endmodule

//-----------------TESTBENCH------------------------
module processor2_tb ();
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
    reset = 1;#100;#100;#100;#100;#100;#100;#100;#100;#100;#100;#100;#100;
end
    
endmodule