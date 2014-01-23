module FA_Seq (A,B,Cin,Sum,Cout);
	input A,B,Cin
	output Sum, Cout;
	reg Sum, Cout;
	reg T1, T2, T3;

	always
	    @ (A or B or Cin) begin 
		Sum =(A^B)^Cin;
		T1=A&Cin;
		T2=B&Cin;
		T3=A&B;
		Cout=(T1|T2)|T3;
		end
endmodule

