module tb_DSP_org ();  
    reg [17:0] A,B,D;
    reg [47:0] C,PCIN;
    reg CARRYIN,CLK,CEA,CEB,CEC,CED,CEM,CEP,CECARRYIN,CEOPMODE,RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP;
    reg [7:0] OPMODE;
    wire [35:0] M;
    wire [47:0] P,PCOUT;
    wire [17:0] BCOUT;
    wire CARRYOUT,CARRYOUTFF;

DSP /*#(.RSTTYPE("ASYNC"))*/Test_reset(A,B,C,D,CARRYIN,M,P,CARRYOUT,CARRYOUTF,CLK,OPMODE,
    CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP,//8
    RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP, //8
    BCOUT,PCIN,PCOUT);

initial begin 
CLK=0;
forever #1 CLK=~CLK;
end

initial begin
    //Initialization
    {A,B,C,D,PCIN,CARRYIN,RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP,OPMODE}='d0;//128'b0
    {CEA,CEB,CEC,CED,CEM,CEP,CECARRYIN,CEOPMODE}='b11111111;
    {MUL_check,pre_arith,post_arith}='d0;
    //Inially Reset the cicruit for 10 cycles
    {RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP}='b11111111; // THis won't show the Synchronization of the reset (Later)
    repeat(10) @(negedge CLK) begin
        A=$random;
        B=$random;
        C=$random;
        D=$random;
        PCIN=$random;
        CARRYIN=$random;
        OPMODE=$random;
        $display("Time = %0t , RST = %d , A = %d , B = %d , D = %d , BCOUT = %d , M = %d , P = %d , PCOUT = %d , COUT = %d ,OPMODE = %b",$time,{RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP},A,B,D,BCOUT,M,P,PCOUT,CARRYOUT,OPMODE);
        if({P,PCOUT,CARRYOUT}!='b0)
            begin
                $display("\nReset Error\n");
                $stop;            end
    end
    $stop;
end
endmodule