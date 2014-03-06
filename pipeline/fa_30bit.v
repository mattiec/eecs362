module fa_30bit(a, b_in, cin, sum, cout);
        parameter width = 30;

        input [0:width-1] a, b_in;
        input cin;

        output [0:width-1] sum;
        output cout;

        wire [0:width-1] b, b_tmp;

        wire cout0, cout1, cout2, cout3, cout4, cout5, cout6, cout7;
        wire cout8, cout9, cout10, cout11, cout12, cout13, cout14, cout15;
        wire cout16, cout17, cout18, cout19, cout20, cout21, cout22, cout23;
        wire cout24, cout25, cout26, cout27, cout28, cout29;

        assign b_tmp = ~b_in;
        mux2to130bit mux_sub(b_in, b_tmp, cin, b);

        fa add0(a[29], b[29], cin, sum[29], cout0);
        fa add1(a[28], b[28], cout0, sum[28], cout1);
        fa add2(a[27], b[27], cout1, sum[27], cout2);
        fa add3(a[26], b[26], cout2, sum[26], cout3);
        fa add4(a[25], b[25], cout3, sum[25], cout4);
        fa add5(a[24], b[24], cout4, sum[24], cout5);
        fa add6(a[23], b[23], cout5, sum[23], cout6);
        fa add7(a[22], b[22], cout6, sum[22], cout7);
        fa add8(a[21], b[21], cout7, sum[21], cout8);
        fa add9(a[20], b[20], cout8, sum[20], cout9);
        fa add10(a[19], b[19], cout9, sum[19], cout10);
        fa add11(a[18], b[18], cout10, sum[18], cout11);
        fa add12(a[17], b[17], cout11, sum[17], cout12);
        fa add13(a[16], b[16], cout12, sum[16], cout13);
        fa add14(a[15], b[15], cout13, sum[15], cout14);
        fa add15(a[14], b[14], cout14, sum[14], cout15);
        fa add16(a[13], b[13], cout15, sum[13], cout16);
        fa add17(a[12], b[12], cout16, sum[12], cout17);
        fa add18(a[11], b[11], cout17, sum[11], cout18);
        fa add19(a[10], b[10], cout18, sum[10], cout19);
        fa add20(a[9], b[9], cout19, sum[9], cout20);
        fa add21(a[8], b[8], cout20, sum[8], cout21);
        fa add22(a[7], b[7], cout21, sum[7], cout22);
        fa add23(a[6], b[6], cout22, sum[6], cout23);
        fa add24(a[5], b[5], cout23, sum[5], cout24);
        fa add25(a[4], b[4], cout24, sum[4], cout25);
        fa add26(a[3], b[3], cout25, sum[3], cout26);
        fa add27(a[2], b[2], cout26, sum[2], cout27);
        fa add28(a[1], b[1], cout27, sum[1], cout28);
        fa add29(a[0], b[0], cout28, sum[0], cout);

endmodule

