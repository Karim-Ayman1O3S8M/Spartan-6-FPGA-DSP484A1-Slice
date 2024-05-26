module tb_DSP_bcout_self ();
    reg [17:0] A,B,D;
    reg [47:0] C,PCIN;
    reg CARRYIN,CLK,CEA,CEB,CEC,CED,CEM,CEP,CECARRYIN,CEOPMODE,RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP;
    reg [7:0] OPMODE;
    wire [35:0] M;
    wire [47:0] P,PCOUT;
    wire CARRYOUT,CARRYOUTFF;

//Testing registers
 wire [17:0] BCOUT_000,BCOUT_001,BCOUT_010,BCOUT_011,BCOUT_100,BCOUT_101,BCOUT_110,BCOUT_111;
 
//{D,B0,B1}

DSP #(.DREG(0),.B0REG(0),.B1REG(0)) Test_BCOUT_000(A,B,C,D,CARRYIN,M,P,
    CARRYOUT,CARRYOUTF,CLK,OPMODE,
    CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP,//8
    RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP, //8
    BCOUT_000,PCIN,PCOUT);

DSP #(.DREG(0),.B0REG(0),.B1REG(1)) Test_BCOUT_001(A,B,C,D,CARRYIN,M,P,
    CARRYOUT,CARRYOUTF,CLK,OPMODE,
    CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP,//8
    RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP, //8
    BCOUT_001,PCIN,PCOUT);

DSP #(.DREG(0),.B0REG(1),.B1REG(0)) Test_BCOUT_010(A,B,C,D,CARRYIN,M,P,
    CARRYOUT,CARRYOUTF,CLK,OPMODE,
    CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP,//8
    RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP, //8
    BCOUT_010,PCIN,PCOUT);

DSP #(.DREG(0),.B0REG(1),.B1REG(1)) Test_BCOUT_011(A,B,C,D,CARRYIN,M,P,
    CARRYOUT,CARRYOUTF,CLK,OPMODE,
    CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP,//8
    RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP, //8
    BCOUT_011,PCIN,PCOUT);
DSP #(.DREG(1),.B0REG(0),.B1REG(0)) Test_BCOUT_100(A,B,C,D,CARRYIN,M,P,
    CARRYOUT,CARRYOUTF,CLK,OPMODE,
    CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP,//8
    RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP, //8
    BCOUT_100,PCIN,PCOUT);
DSP #(.DREG(1),.B0REG(0),.B1REG(1)) Test_BCOUT_101(A,B,C,D,CARRYIN,M,P,
    CARRYOUT,CARRYOUTF,CLK,OPMODE,
    CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP,//8
    RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP, //8
    BCOUT_101,PCIN,PCOUT);
DSP #(.DREG(1),.B0REG(1),.B1REG(0)) Test_BCOUT_110(A,B,C,D,CARRYIN,M,P,
    CARRYOUT,CARRYOUTF,CLK,OPMODE,
    CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP,//8
    RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP, //8
    BCOUT_110,PCIN,PCOUT);
DSP #(.DREG(1),.B0REG(1),.B1REG(1)) Test_BCOUT_111(A,B,C,D,CARRYIN,M,P,
    CARRYOUT,CARRYOUTF,CLK,OPMODE,
    CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP,//8
    RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP, //8
    BCOUT_111,PCIN,PCOUT);


//Test registers
 reg test_flag;
 integer counter=1;
 reg [17:0] expected;
 integer failed,success;



initial begin 
CLK=0;
forever #1 CLK=~CLK;
end

initial begin
    //Initialization
    {A,B,C,D,PCIN,CARRYIN,RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP,OPMODE}='d0;//128'b0
    {CEA,CEB,CEC,CED,CEM,CEP,CECARRYIN,CEOPMODE}='b11111111;
    test_flag=0;
    success=0; failed=0;
    //Inially Reset the cicruit for 10 cycles
    {RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP}='b11111111;
    repeat(10) @(negedge CLK);
    {RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP}='b00000000;
    //Release 5 cycles till operation
    repeat(5) @(negedge CLK);
    $display("\n\t\t\t\t\t\t\t\tTesting BCOUT for 20 cycles\n\n");
    @(negedge CLK);
    repeat(20) #6 begin
        test_flag=1;
        A=$random;
        B=$random;
        C=$random;
        D=$random;
        PCIN=$random;
        CARRYIN=$random;
        OPMODE=$random;
    end
$display("\n\t\t\t\tEnd of testbench with %0d checks , %0d errors\n",success,failed);
$stop;
end


always @(D,B,OPMODE) begin
    if(test_flag)
    begin
        #6
        if(BCOUT_000!=expected || BCOUT_010!=expected || BCOUT_011!=expected || BCOUT_100!=expected || BCOUT_101!=expected || BCOUT_110!=expected || BCOUT_111!=expected|| BCOUT_001!=expected  )
        begin
            failed=failed+1;
            if(!OPMODE[4])
                $display("\n\t\t\t\tError @ t=%0t ,BCOUT Unmatching while Expected(B) = %d , passed : %0d , Failed : %0d \n",
                $time,expected,success,failed);
            else 
                if(OPMODE[6])
                    $display("\n\t\t\t\tError @t=%0t ,BCOUT Unmatching while Expected(D-B) = %d , passed : %0d , Failed : %0d \n",
                                    $time,expected,success,failed);
                else 
                     $display("\n\t\t\t\tError @t=%0t ,BCOUT Unmatching while Expected(D+B) = %0d ,Success : %0d ,Failed : %0d \n",
                                    $time,expected,success, failed);
          $stop;
        end
        else success=success+1;
    end   
end

always @(D,B,OPMODE) begin
    if(!OPMODE[4])
        expected = B;
    else 
        if(!OPMODE[6])
            expected=D+B;
        else expected=D-B;
end

initial begin
    $monitor("Time = %0t,D = %d , B = %d , OPMODE = %b , BCOUT_000 = %d , BCOUT_001 = %d , BCOUT_010 = %d , BCOUT_011 = %d , BCOUT_100 = %d , BCOUT_101 = %d , BCOUT_110 = %d , BCOUT_111 = %d",
    $time,D,B,OPMODE,BCOUT_000,BCOUT_001,BCOUT_010,BCOUT_011,BCOUT_100,BCOUT_101,BCOUT_011,BCOUT_111);
end
endmodule