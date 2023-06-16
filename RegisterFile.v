module RegisterFile(ReadRegister1, ReadRegister2, WriteRegister1 , WriteRegister2, 
WriteData1, WriteData2, RegWrite1, RegWrite2, Clk, ReadData1, ReadData2);

	/* Please fill in the implementation here... */ 
	input [4:0] ReadRegister1,ReadRegister2,WriteRegister1,WriteRegister2;
	input [31:0] WriteData1, WriteData2;
	input RegWrite1, RegWrite2 ,Clk;
	
	output reg [31:0] ReadData1,ReadData2;
	
	//reg [31:0] Registers = new reg[32];
	reg [31:0] Registers [0:31];

      initial begin
		Registers[0] <= 0;
		Registers[1] <= 0;
            Registers[2] <= 0;
            Registers[3] <= 0;
            Registers[4] <= 0;
            Registers[5] <= 0;
            Registers[6] <= 0;
            Registers[7] <= 0;
            Registers[8] <= 0;
		Registers[9] <= 0;
		Registers[10] <= 0;
		Registers[11] <= 0;
		Registers[12] <= 0;
		Registers[13] <= 0;
		Registers[14] <= 0;
		Registers[15] <= 0;
		Registers[16] <= 0;
		Registers[17] <= 0;
		Registers[18] <= 0;
		Registers[19] <= 0;
		Registers[20] <= 0;
		Registers[21] <= 0;
		Registers[22] <= 0;
		Registers[23] <= 0;
		Registers[24] <= 0;
		Registers[25] <= 0;
		Registers[29] <= 252; // this value should point to the top of data memory, byte addressing
		Registers[31] <= 0;
	end
	


	always @(posedge Clk)
	begin
		if (RegWrite1 == 1 && RegWrite2 == 0 ) 
		begin
			Registers[WriteRegister1] <= WriteData1;
		end
            else if (RegWrite1 == 0 && RegWrite2 == 1 ) 
		begin
			Registers[WriteRegister2] <= WriteData2;
		end
            else if (RegWrite1 == 1 && RegWrite2 == 1 ) 
		begin
                  //handling Race condition by giving periority to WriteRegister1 over WriteRegister2
                  if(WriteRegister1 == WriteRegister2) begin
                        Registers[WriteRegister1] <= WriteData1;
                  end
                  else begin
                        Registers[WriteRegister1] <= WriteData1;
                        Registers[WriteRegister2] <= WriteData2;
                  end
			
		end
            else if (RegWrite1 == 0 && RegWrite2 == 0 ) 
		begin
			ReadData1 <= Registers[ReadRegister1];
		      ReadData2 <= Registers[ReadRegister2];
		end
	end
	

endmodule