module pipe (
    in,out,clk,clk_en,rst,Setting
);
    parameter width = 3; //Default
    parameter rst_mode = "SYNC"; //SYNC OR ASYNC
    input rst,clk,clk_en;
    input [width-1:0] in;
    output  [width-1:0] out;
    input Setting;
    reg [width-1:0] in_reg;
    
    assign out = (Setting)? in_reg: in;

    generate
        case (rst_mode)
            "ASYNC": always @(posedge clk or posedge rst) begin
                if(rst)
                    in_reg <=0;
                else in_reg<=in;
            end 
            "SYNC": always @(posedge clk) begin
                if(rst)
                    in_reg<=0;
                else in_reg<=in;
            end 
        endcase
        endgenerate
    
  
  
  
  
  
  endmodule