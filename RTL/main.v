module DSP (
    A,B,C,D,CARRYIN,M,P,CARRYOUT,CARRYOUTF,CLK,OPMODE, // data
    CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP, //clock enables
    RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP, //resets
    BCOUT,PCIN,PCOUT //cascades
); // rst, clk, in, out
    //Parameters
    parameter A0REG = 0;
    parameter A1REG = 1;
    parameter B0REG = 0;
    parameter B1REG = 1;
    parameter CREG = 1; 
    parameter DREG = 1; 
    parameter MREG = 1;
    parameter PREG = 1; 
    parameter CARRYINREG = 1; 
    parameter CARRYOUTREG = 1; 
    parameter OPMODEREG = 1;
    parameter CARRYINSEL = "OPMODE5"; // OR "CARRYIN" ELSE 0
    parameter B_INPUT = "DIRECT" ; // OR "CASCADE" ELSE 0
    parameter RSTTYPE = "SYNC"; // OR "ASYNC" 

    //inputs
    input [17:0] A,B,D;
    input [47:0] C;
    input CARRYIN; // input to post add/Subtract
    input [7:0]OPMODE;
    
    //outputs
    output [35:0] M; // Multiplier data out (Wire from Mreg)
    output [47:0] P; //Primary data output from the post-adder/subtracter (No cover for overflow)
    output CARRYOUT,CARRYOUTF;
    
    // clock/clock enable(s)/Resets
    input CLK;
    input CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP;
    input RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP;
    
    //Cascades
    input [47:0] PCIN;
    output [47:0] PCOUT;
    output [17:0] BCOUT; //BCOUT=CASCADE FROM DCP SLICE = BCIN
    
    //Some aiding registers
    wire [7:0] out_opmode_reg;
    wire [17:0] out_A0_reg,out_B0_reg,out_A1_reg,out_B1_reg,out_D_reg,out_BIN_mux;
    wire [47:0] out_C_reg,cat_ABD_reg,in_P_reg;
    wire out_carry_cascade,out_CARRYIN_reg,in_CARRYOUT_reg;
     wire [35:0] in_M_reg,out_M_reg ;
    reg [17:0] in_B1_reg ;
    reg [47:0] out_Z_reg,out_X_reg;
    
    // Data entry level
    assign out_BIN_mux = (B_INPUT=="DIRECT")? B : (B_INPUT=="CASCADE")? BCOUT: 0;
     pipe #(.width(18),.rst_mode(RSTTYPE)) REGA0 (.in(A),.out(out_A0_reg),.clk(CLK),.clk_en(CEA),.rst(RSTA),.Setting(A0REG)); //A0
     pipe #(.width(18),.rst_mode(RSTTYPE)) REGB0 (.in(out_BIN_mux),.out(out_B0_reg),.clk(CLK),.clk_en(CEB),.rst(RSTB),.Setting(B0REG)); //B0
     pipe #(.width(48),.rst_mode(RSTTYPE)) REGC (.in(C),.out(out_C_reg),.clk(CLK),.clk_en(CEC),.rst(RSTC),.Setting(CREG)); //C
     pipe #(.width(18),.rst_mode(RSTTYPE)) REGD (.in(D),.out(out_D_reg),.clk(CLK),.clk_en(CED),.rst(RSTD),.Setting(DREG)); //D
     pipe #(.width(1),.rst_mode(RSTTYPE)) CYI (.in(out_carry_cascade),.out(out_CARRYIN_reg),.clk(CLK),.clk_en(CECARRYIN),.rst(RSTCARRYIN), .Setting(CARRYINREG)); //carryin
     pipe #(.width(8),.rst_mode(RSTTYPE)) REG_OPM (.in(OPMODE),.out(out_opmode_reg),.clk(CLK),.clk_en(CEOPMODE),.rst(RSTOPMODE),.Setting(OPMODEREG));  //OPMODE
    always @(out_B0_reg,out_D_reg,out_opmode_reg,out_opmode_reg) begin
        if(!out_opmode_reg[4])
            in_B1_reg = out_B0_reg;
        else 
            if(out_opmode_reg[6])
                in_B1_reg = out_D_reg - out_B0_reg;
            else in_B1_reg = out_D_reg + out_B0_reg;
    end

     pipe #(.width(18),.rst_mode(RSTTYPE)) REGB1 (.in(in_B1_reg),.out(out_B1_reg),.clk(CLK),.clk_en(CEB),.rst(RSTB),.Setting(B1REG)); //B1
     pipe #(.width(18),.rst_mode(RSTTYPE)) REGA1 (.in(out_A0_reg),.out(out_A1_reg),.clk(CLK),.clk_en(CEA),.rst(RSTA),.Setting(A1REG)); //A1

     assign BCOUT = out_B1_reg;
     assign in_M_reg = out_A1_reg * out_B1_reg;
     
     pipe #(.width(36),.rst_mode(RSTTYPE)) REGM (.in(in_M_reg),.out(out_M_reg),.clk(CLK),.clk_en(CEM),.rst(RSTM),.Setting(MREG)); //M
     
     assign M = out_M_reg;

     assign out_carry_cascade = (CARRYINSEL=="OPMODE5")? OPMODE[5] : (CARRYINSEL=="CARRYIN")? CARRYIN :0;

    assign cat_ABD_reg = {D[11:0],out_A1_reg[17:0],out_B1_reg[17:0]};

    always @(out_opmode_reg, out_M_reg, PCOUT , cat_ABD_reg) begin  //X reg
        case (out_opmode_reg[1:0])
            2'd0: out_X_reg = 0;
            2'd1: out_X_reg = out_M_reg;
            2'd2: out_X_reg = PCOUT;
            2'd3: out_X_reg =  cat_ABD_reg;
        endcase
    end

    always @(out_opmode_reg, PCIN,PCOUT,out_C_reg) begin //Z reg
        case (out_opmode_reg[3:2])
            2'd0: out_Z_reg =0; 
            2'd1: out_Z_reg = PCIN;
            2'd2: out_Z_reg =  PCOUT;
            2'd3: out_Z_reg =  out_C_reg;
        endcase
    end

    assign {in_CARRYOUT_reg,in_P_reg} = (out_opmode_reg[7])? out_Z_reg-(out_X_reg+out_CARRYIN_reg) :  out_Z_reg+out_X_reg+out_CARRYIN_reg ;
    assign PCOUT =P;
    assign CARRYOUTF=CARRYOUT;
    pipe #(.width(48),.rst_mode(RSTTYPE)) REGP (.in(in_P_reg),.out(P),.clk(CLK),.clk_en(CEP),.rst(RSTP),.Setting(PREG)); //P
    pipe #(.width(1),.rst_mode(RSTTYPE)) REGCOUT (.in(in_CARRYOUT_reg),.out(CARRYOUT),.clk(CLK),.clk_en(CECARRYIN),.rst(RSTCARRYIN),.Setting(CARRYOUTREG)); //P
 


endmodule