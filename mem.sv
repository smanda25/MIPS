module mem(input logic clk, we,
 input logic [31:0] a, wd,
 output logic [31:0] rd);
 logic [31:0] RAM[63:0];
 // initialize memory with instructions
 initial
 begin
 $readmemh("memfile.dat",RAM);
 // "memfile.dat" contains your instructions in hex
 // you must create this file
 end
 assign rd = RAM[a[31:2]]; // word aligned
 always_ff @(posedge clk)
 if (we)
 RAM[a[31:2]] <= wd;
endmodule

