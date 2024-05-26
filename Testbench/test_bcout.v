module tb_DSP_bcout ();    
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

DSP #(.DREG(0),.B0REG(0),.B1REG(0)) Test_BCOUT_000(A,B,C,D,CARRYIN,M,P,CARRYOUT,CARRYOUTF,CLK,OPMODE,
    CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP,//8
    RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP, //8
    BCOUT_000,PCIN,PCOUT);

DSP #(.DREG(0),.B0REG(0),.B1REG(1)) Test_BCOUT_001(A,B,C,D,CARRYIN,M,P,CARRYOUT,CARRYOUTF,CLK,OPMODE,
    CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP,//8
    RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP, //8
    BCOUT_001,PCIN,PCOUT);

DSP #(.DREG(0),.B0REG(1),.B1REG(0)) Test_BCOUT_010(A,B,C,D,CARRYIN,M,P,CARRYOUT,CARRYOUTF,CLK,OPMODE,
    CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP,//8
    RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP, //8
    BCOUT_010,PCIN,PCOUT);

DSP #(.DREG(0),.B0REG(1),.B1REG(1)) Test_BCOUT_011(A,B,C,D,CARRYIN,M,P,CARRYOUT,CARRYOUTF,CLK,OPMODE,
    CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP,//8
    RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP, //8
    BCOUT_011,PCIN,PCOUT);
DSP #(.DREG(1),.B0REG(0),.B1REG(0)) Test_BCOUT_100(A,B,C,D,CARRYIN,M,P,CARRYOUT,CARRYOUTF,CLK,OPMODE,
    CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP,//8
    RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP, //8
    BCOUT_100,PCIN,PCOUT);
DSP #(.DREG(1),.B0REG(0),.B1REG(1)) Test_BCOUT_101(A,B,C,D,CARRYIN,M,P,CARRYOUT,CARRYOUTF,CLK,OPMODE,
    CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP,//8
    RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP, //8
    BCOUT_101,PCIN,PCOUT);
DSP #(.DREG(1),.B0REG(1),.B1REG(0)) Test_BCOUT_110(A,B,C,D,CARRYIN,M,P,CARRYOUT,CARRYOUTF,CLK,OPMODE,
    CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP,//8
    RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP, //8
    BCOUT_110,PCIN,PCOUT);
DSP #(.DREG(1),.B0REG(1),.B1REG(1)) Test_BCOUT_111(A,B,C,D,CARRYIN,M,P,CARRYOUT,CARRYOUTF,CLK,OPMODE,
    CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP,//8
    RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP, //8
    BCOUT_111,PCIN,PCOUT);


//Test registers
 reg test_flag;
 integer counter=1;
 reg [17:0]temp1,temp2;

//Checking registers
reg MUL_check,pre_arith,post_arith;

initial begin 
CLK=0;
forever #1 CLK=~CLK;
end

initial begin
    //Initialization
    {A,B,C,D,PCIN,CARRYIN,RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP,OPMODE}='d0;//128'b0
    {CEA,CEB,CEC,CED,CEM,CEP,CECARRYIN,CEOPMODE}='b11111111;
    test_flag=0;
    {MUL_check,pre_arith,post_arith}='d0;
    //Inially Reset the cicruit for 10 cycles
    {RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP}='b11111111;
    repeat(10) @(negedge CLK);
    {RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP}='b00000000;
    //Release 5 cycles till operation
    repeat(5) @(negedge CLK);
    $display("\n\t\t\t\t\t\t\t\tTesting BCOUT for 20 cycles\n\n");
    @(negedge CLK);
    repeat(20) #4 begin
        test_flag=1'b1;
        A=$random;
        B=$random;
        C=$random;
        D=$random;
        PCIN=$random;
        CARRYIN=$random;
        OPMODE=$random;
    
    if(OPMODE[4])
            if(BCOUT_000!=B)
            begin
        $display("\nERROR\n");
        $stop;
        end
    else 
        if(OPMODE[6])
            if(BCOUT_000!=D-B)
                begin
                 $display("\nERROR\n");
                 $stop;
                end
        else 
            if(BCOUT_000!=D+B)
                begin
                 $display("\nERROR\n");
                 $stop;
                end    
    end
$stop; 
end


always @(posedge CLK)begin //For the "BCOUT" that needs 1 clock cycle
    if(test_flag)
            begin
       if(!OPMODE[4])
    if({BCOUT_010,BCOUT_100,BCOUT_110}!={3{B}})
    begin
        $display("\nERROR\n");
         $display("Time = %0t,D = %d , B = %d , OPMODE = %b , BCOUT_000 = %d , BCOUT_001 = %d , BCOUT_010 = %d , BCOUT_011 = %d , BCOUT_100 = %d , BCOUT_101 = %d , BCOUT_110 = %d , BCOUT_111 = %d",
                            $time,D,B,OPMODE,BCOUT_000,BCOUT_001,BCOUT_010,BCOUT_011,BCOUT_100,BCOUT_101,BCOUT_011,BCOUT_111);
        $stop;
    end
        else 
    if(OPMODE[6])begin
        temp1=D-B;
        if({BCOUT_010,BCOUT_100,BCOUT_110}!={3{temp1}})
            begin
                 $display("\nERROR\n");
                  $display("Time = %0t,D = %d , B = %d , OPMODE = %b , BCOUT_000 = %d , BCOUT_001 = %d , BCOUT_010 = %d , BCOUT_011 = %d , BCOUT_100 = %d , BCOUT_101 = %d , BCOUT_110 = %d , BCOUT_111 = %d",
                            $time,D,B,OPMODE,BCOUT_000,BCOUT_001,BCOUT_010,BCOUT_011,BCOUT_100,BCOUT_101,BCOUT_011,BCOUT_111);
                 $stop;
            end
    end
    else 
        begin
        temp2=D+B;
        if({BCOUT_010,BCOUT_100,BCOUT_110}!={3{temp2}})
         begin
                 $display("\nERROR\n");
                  $display("Time = %0t,D = %d , B = %d , OPMODE = %b , BCOUT_000 = %d , BCOUT_001 = %d , BCOUT_010 = %d , BCOUT_011 = %d , BCOUT_100 = %d , BCOUT_101 = %d , BCOUT_110 = %d , BCOUT_111 = %d",
                            $time,D,B,OPMODE,BCOUT_000,BCOUT_001,BCOUT_010,BCOUT_011,BCOUT_100,BCOUT_101,BCOUT_011,BCOUT_111);
                 $stop;
         end
            end
end
end


always @(posedge CLK)begin //For the "BCOUT" that needs 2 clock cycles
    if(test_flag)
       if(counter %2 ==0)
        begin
     if(!OPMODE[4])
    if({BCOUT_101,BCOUT_111,BCOUT_011,BCOUT_001}!={4{B}})
    begin
        $display("\nERROR\n");
         $display("Time = %0t,D = %d , B = %d , OPMODE = %b , BCOUT_000 = %d , BCOUT_001 = %d , BCOUT_010 = %d , BCOUT_011 = %d , BCOUT_100 = %d , BCOUT_101 = %d , BCOUT_110 = %d , BCOUT_111 = %d",
                    $time,D,B,OPMODE,BCOUT_000,BCOUT_001,BCOUT_010,BCOUT_011,BCOUT_100,BCOUT_101,BCOUT_011,BCOUT_111);
        $stop;
    end
else 
    if(OPMODE[6])begin
        temp1=D-B;
        if({BCOUT_101,BCOUT_111,BCOUT_011,BCOUT_001}!={4{temp1}})
            begin
                 $display("\nERROR\n");
                  $display("Time = %0t,D = %d , B = %d , OPMODE = %b , BCOUT_000 = %d , BCOUT_001 = %d , BCOUT_010 = %d , BCOUT_011 = %d , BCOUT_100 = %d , BCOUT_101 = %d , BCOUT_110 = %d , BCOUT_111 = %d",
                                $time,D,B,OPMODE,BCOUT_000,BCOUT_001,BCOUT_010,BCOUT_011,BCOUT_100,BCOUT_101,BCOUT_011,BCOUT_111);
                 $stop;
            end
    end
    else 
        begin
        temp2=D+B;
        if({BCOUT_101,BCOUT_111,BCOUT_011,BCOUT_001}!={4{temp2}})
         begin
                 $display("\nERROR\n");
                  $display("Time = %0t,D = %d , B = %d , OPMODE = %b , BCOUT_000 = %d , BCOUT_001 = %d , BCOUT_010 = %d , BCOUT_011 = %d , BCOUT_100 = %d , BCOUT_101 = %d , BCOUT_110 = %d , BCOUT_111 = %d",
                            $time,D,B,OPMODE,BCOUT_000,BCOUT_001,BCOUT_010,BCOUT_011,BCOUT_100,BCOUT_101,BCOUT_011,BCOUT_111);
                 $stop;
         end
            end
        else
            counter=counter+1;
end
end

initial begin
    $monitor("Time = %0t,D = %d , B = %d , OPMODE = %b , BCOUT_000 = %d , BCOUT_001 = %d , BCOUT_010 = %d , BCOUT_011 = %d , BCOUT_100 = %d , BCOUT_101 = %d , BCOUT_110 = %d , BCOUT_111 = %d",
    $time,D,B,OPMODE,BCOUT_000,BCOUT_001,BCOUT_010,BCOUT_011,BCOUT_100,BCOUT_101,BCOUT_011,BCOUT_111);
end
endmodule