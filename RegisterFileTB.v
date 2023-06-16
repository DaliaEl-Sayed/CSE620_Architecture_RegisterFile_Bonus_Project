module RegisterFileTB ();

reg [4:0] ReadRegister1,ReadRegister2,WriteRegister1,WriteRegister2;
reg [31:0] WriteData1, WriteData2;
reg RegWrite1, RegWrite2 ,Clk;
	
wire [31:0] ReadData1,ReadData2;


logic [13:0] Testvectors[0:99];
logic [7:0] vectornum;

RegisterFile CUT (ReadRegister1, ReadRegister2, WriteRegister1 , WriteRegister2, 
WriteData1, WriteData2, RegWrite1, RegWrite2, Clk, ReadData1, ReadData2);

initial begin
	$dumpfile("The_output.vcd");
	$dumpvars(0,ReadData1);
	$dumpvars(0,ReadData2);
	$dumpvars(0,WriteData1);
	$dumpvars(0,WriteData2);
	$dumpvars(0,RegWrite1);
	$dumpvars(0,RegWrite2);
	$dumpvars(0,ReadRegister1);
	$dumpvars(0,ReadRegister2);
	$dumpvars(0,WriteRegister1);
	$dumpvars(0,WriteRegister2);
	$dumpvars(0,Clk);
	//$dumpvars(0,Expected_Output);
	//$dumpvars(0,Fault_Indicator);
	//$dumpvars(0,Fault_Counter);
	//Fault_Counter = 0;
	vectornum = 0;
	$readmemb("memory_binary.txt", Testvectors);
end


initial begin 
	Clk = 0;
	repeat(100) #1 Clk = ~Clk;
end
initial begin 
	RegWrite1 = 0;
	repeat(20) #5 RegWrite1 = ~RegWrite1;
end  
initial begin 
	RegWrite2 = 0;
	repeat(25) #4 RegWrite2 = ~RegWrite2;
end

always @ (posedge Clk) begin 
	 ReadRegister1 = 0; 
	 ReadRegister2 = 1;
	 WriteRegister1 = 3;
	 WriteRegister2 = 4;
	 WriteData1 = Testvectors[WriteRegister1];
	 WriteData2 = Testvectors[WriteRegister2];

	 #2
	 ReadRegister1 = 3; 
	 ReadRegister2 = 4;
	 WriteRegister1 = 0;
	 WriteRegister2 = 1;
	 WriteData1 = Testvectors[WriteRegister1];
	 WriteData2 = Testvectors[WriteRegister2];

	 #2
	 ReadRegister1 = 0; 
	 ReadRegister2 = 1;
	 WriteRegister1 = 0;
	 WriteRegister2 = 0;
	 WriteData1 = Testvectors[WriteRegister1];
	 WriteData2 = Testvectors[WriteRegister2];

	 #2
	 ReadRegister1 = 10; 
	 ReadRegister2 = 4;
	 WriteRegister1 = 1;
	 WriteRegister2 = 1;
	 WriteData1 = Testvectors[WriteRegister1];
	 WriteData2 = Testvectors[WriteRegister2];


end


endmodule 
