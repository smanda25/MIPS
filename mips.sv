module mips(input logic clk, reset,
			output logic [31:0] adr, writedata,
			output logic memwrite,
			input logic [31:0] readdata);
 logic zero, pcen, irwrite, regwrite,
 alusrca, iord, memtoreg, regdst;
 logic [1:0] alusrcb, pcsrc;
 logic [2:0] alucontrol;
 logic [5:0] op, funct;
 controller c(clk, reset, op, funct, zero,
			  pcen, memwrite, irwrite, regwrite,
			  alusrca, iord, memtoreg, regdst,
			  alusrcb, pcsrc, alucontrol);
 datapath dp(clk, reset, pcen, irwrite, regwrite,
			 alusrca, iord, memtoreg, regdst, alusrcb, pcsrc, alucontrol,
			 op, funct, zero, adr, writedata, readdata);
endmodule