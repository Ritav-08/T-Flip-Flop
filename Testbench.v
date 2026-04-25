`timescale 1ns / 1ps

module tb_Tff();
reg T_ti;
reg clk_ti;
reg rst_ti;
wire Q_to;
wire Qbar_to;

//net(s)
reg exp_Q;
reg exp_Qbar;
integer pass;
integer fail;
integer count;

//instantiation
Tff UUT(.T_i(T_ti), 
   .clk_i(clk_ti), 
   .rst_i(rst_ti), 
   .Q_o(Q_to), 
   .Qbar_o(Qbar_to));

//initialization
initial begin
pass = 0;
fail = 0;
count = 0;
exp_Q = 1'b0;
exp_Qbar = 1'b1;
end

//clock
initial begin
clk_ti = 1'b0;
forever
   #5 clk_ti = ~clk_ti;
end

//Reset
initial begin
rst_ti = 1'b1;
#7 rst_ti = 1'b0;
end

//feeding
initial begin
T_ti = 1'b0;
#12 T_ti = 1'b1;
#10 T_ti = 1'b0;
#10 T_ti = 1'b1;
repeat(10)
   #10 T_ti = $urandom_range(0, 1);
#5 $display("-----------");
$display("Total Ckecks: %d | Pass: %d, Fail: %d", count, pass, fail);
$display("-----------");
#5 $finish;
end

always@(posedge clk_ti)
   #1 checker;

//Self checker
task checker(); begin
   if(rst_ti) //Reset will initialize exp_Q
      exp_Q = 1'b0;
   else case(T_ti)
         1'b0: exp_Q = exp_Q;
         1'b1: exp_Q = ~exp_Q;
         default: exp_Q = exp_Q;
        endcase
   exp_Qbar = ~exp_Q;
if((exp_Q !== Q_to) || (exp_Qbar !== Qbar_to)) begin
   $display("Error | Time: %0t, Clock: %b, Reset: %b | T: %b | Q: %b, Q+: %b | Expected Q: %b, Q+: %b", $time, clk_ti, rst_ti, T_ti, Q_to, Qbar_to, exp_Q, exp_Qbar);
   fail = fail + 1;
end
else begin
   pass = pass + 1;
end
count = count + 1;
end
endtask

//capture
initial begin
$dumpfile("Tff.vcd");
$dumpvars(0, tb_Tff);
end

endmodule
