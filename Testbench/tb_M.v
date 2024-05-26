module tb_M ();
 
    
    reg [17:0] A,B,D;
    reg [47:0] C,PCIN;
    reg CARRYIN,CLK,CEA,CEB,CEC,CED,CEM,CEP,CECARRYIN,CEOPMODE,RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP;
    reg [7:0] OPMODE;
    wire [35:0] M;
    wire [47:0] P,PCOUT;
    wire CARRYOUT,CARRYOUTFF;
    wire [17:0] BCOUT;

//Testing registers
 reg [35:0] M_ref;
 integer M_flag;
 integer success=0;
 integer failed=0;
 
//{D,B0,B1}

DSP  Test_M(A,B,C,D,CARRYIN,M,P,CARRYOUT,CARRYOUTF,CLK,OPMODE,
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
    //Inially Reset the cicruit for 10 cycles
    {RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP}='b11111111;
    repeat(10) @(negedge CLK);
    {RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP}='b00000000;
     M_flag=0;
    //Release 5 cycles till operation
    repeat(5) @(negedge CLK);
    $display("\n\t\t\t\t\t\tTesting M for 10 cycles\n\n");
    @(negedge CLK);
    repeat(10) #10 begin
        A=$random;
        B=$random;
        C=$random;
        D=$random;
        PCIN=$random;
        CARRYIN=$random;
        OPMODE=$random;
        M_flag=1;
       
    end 
$display("\n\t\t\t\tEnd of testbench with %0d checks , %0d errors\n",success,failed);
$stop; 
end


always @(negedge CLK /*M*/) begin
    if(M_flag)
    begin
        #10
         begin 
        if(M==M_ref) begin
            success=success+1;
            $display("\nI am here @ t=%0t , I am expecting M_ref = %d while M =%0d , Successful Check = %d\n",$time,M_ref,M,success);
        end
        else begin
            failed=failed+1;
            $display("\nCheck failed @ t=%0t , failed check = %0d\n",$time,failed);
        end 
        end 
        /*if(M!= M_ref)
           begin
            $display("\n\t\t\t\tError No match \n");
            $stop;
           end 
    end*/
    end
    
end

always @ (M) begin
    M_ref = BCOUT * A;    
end


initial begin
    $monitor("Time = %0t,A = %d , B = %d , D = %d ,OPMODE = %b , M = %d , Mref = %d , BCOUT = %d",
    $time,A,B,D,OPMODE,M,M_ref,BCOUT);
end

endmodule