module regFile(rst, clk, WrAddr, WrEn, WrData, ReadAddr1, ReadAddr2, ReadData1, ReadData2);

    input [0:31] WrData;
	input [0:4] WrAddr, ReadAddr1, ReadAddr2;
    input WrEn, clk, rst;

    output [0:31] ReadData1, ReadData2;
	
    reg [0:31] reg_file[0:31];
	
	integer i;
	
	initial begin 
		for (i = 0; i < 32; i = i+1) begin
			reg_file[i] = 32'h00000000;
		end	
	end
	
    // Write data to WrAddr and handle reset
    always @(negedge clk) begin
        
		if(rst) begin
			for (i = 0; i < 32; i = i+1) begin
				reg_file[i] = 32'h00000000;
			end
		end
		else if (WrEn) begin
			case(WrAddr)
				5'b00000: reg_file[0] = WrData;
				5'b00001: reg_file[1] = WrData; 
				5'b00010: reg_file[2] = WrData; 
				5'b00011: reg_file[3] = WrData;
				5'b00100: reg_file[4] = WrData;
				5'b00101: reg_file[5] = WrData;
				5'b00110: reg_file[6] = WrData;
				5'b00111: reg_file[7] = WrData;
				5'b01000: reg_file[8] = WrData;
				5'b01001: reg_file[9] = WrData;
				5'b01010: reg_file[10] = WrData;
				5'b01011: reg_file[11] = WrData;
				5'b01100: reg_file[12] = WrData;
				5'b01101: reg_file[13] = WrData;
				5'b01110: reg_file[14] = WrData;
				5'b01111: reg_file[15] = WrData;
				5'b10000: reg_file[16] = WrData;
				5'b10001: reg_file[17] = WrData;
				5'b10010: reg_file[18] = WrData;
				5'b10011: reg_file[19] = WrData;
				5'b10100: reg_file[20] = WrData;
				5'b10101: reg_file[21] = WrData;
				5'b10110: reg_file[22] = WrData;
				5'b10111: reg_file[23] = WrData;
				5'b11000: reg_file[24] = WrData;
				5'b11001: reg_file[25] = WrData;
				5'b11010: reg_file[26] = WrData;
				5'b11011: reg_file[27] = WrData;
				5'b11100: reg_file[28] = WrData;
				5'b11101: reg_file[29] = WrData;
				5'b11110: reg_file[30] = WrData;
				5'b11111: reg_file[31] = WrData;				
				default:;
			endcase
							
        end
    end
    
    assign ReadData1 = reg_file[ReadAddr1]; //Read Bus 1
	assign ReadData2 = reg_file[ReadAddr2]; //Read Bus 2
	
endmodule