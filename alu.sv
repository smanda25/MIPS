module alu(input logic [31:0] A, B,
 input logic [2:0] F,
 output logic [31:0] Y,
 output logic zero);
 logic OF;
 logic[31:0] B_Temp, Y_dummy, cout;
 assign B_Temp = F[2]?(~B):B;
 adder32 A2(A, B_Temp, F[2], Y_dummy, cout);
 assign OF = cout[31] ^ cout[30];
 always_comb
 begin
	case(F[1:0])
		2'b00: Y = A & B_Temp;
		2'b01: Y = A | B_Temp;
		2'b10: Y = Y_dummy;
		2'b11: if(F[2] == 1)
			   begin
					if(A<B)
					begin
						if((B[31] == 1) || (A[31] == 1))
							Y = 32'h0;
						else
							Y = 32'h1;
					end
					else
					begin
						if((B[31] == 1) || (A[31] == 1) )
							Y = 32'h1;
						else
							Y = 32'h0;
					end
				end
				else	
				Y = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
				
		default: Y = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
	endcase
	if(OF == 1)
		Y = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
	if(Y == 0)
		zero = 1;
	else
		zero = 0;
	
 end
endmodule

module fulladder
(
 input logic x,
 input logic y,
 input logic cin,
 
 output logic S, 
 output logic cout
 );
 assign S = x^y^cin;
 assign cout = ((x^y) & cin) | (x & y);
endmodule

module adder32(
input logic[31:0] x, y,
input logic cin,
output logic [31:0] s,
output logic[31:0] cout);
genvar i;
generate
for(i=0;i<32;i++)
begin: adder32bit
if (i == 0)
	fulladder A1(x[0],y[0],cin,s[0],cout[0]);
else
	fulladder A1(x[i],y[i],cout[i-1],s[i],cout[i]);
end: adder32bit
endgenerate
endmodule
