/*module aluControl (
    input [2:0] ALUop,input [5:0] func, output reg [3:0] control
);
    always @(*) begin
        case (func)
            6'b100011: control <= 0010;    //lw
            6'b101011: control <= 0100;    //sw
            6'b000000: control <= 0000;    //sub
            6'b001110: control <= 0001;    //xori
            6'b000010: control <= 1000;    //j
        endcase
    end     
endmodule*/