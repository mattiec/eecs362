module 2to130bit(a,b,sel,out);
        parameter width = 30;
        input [0:width-1] a,b;
        input sel;

        output [0:width-1] out;

        assign out[0] = (a[0] & !sel) | (b[0] & sel);
        assign out[1] = (a[1] & !sel) | (b[1] & sel);
        assign out[2] = (a[2] & !sel) | (b[2] & sel);
        assign out[3] = (a[3] & !sel) | (b[3] & sel);
        assign out[4] = (a[4] & !sel) | (b[4] & sel);
        assign out[5] = (a[5] & !sel) | (b[5] & sel);
        assign out[6] = (a[6] & !sel) | (b[6] & sel);
        assign out[7] = (a[7] & !sel) | (b[7] & sel);
        assign out[8] = (a[8] & !sel) | (b[8] & sel);
        assign out[9] = (a[9] & !sel) | (b[9] & sel);
        assign out[10] = (a[10] & !sel) | (b[10] & sel);
        assign out[11] = (a[11] & !sel) | (b[11] & sel);
        assign out[12] = (a[12] & !sel) | (b[12] & sel);
        assign out[13] = (a[13] & !sel) | (b[13] & sel);
        assign out[14] = (a[14] & !sel) | (b[14] & sel);
        assign out[15] = (a[15] & !sel) | (b[15] & sel);
        assign out[16] = (a[16] & !sel) | (b[16] & sel);
        assign out[17] = (a[17] & !sel) | (b[17] & sel);
        assign out[18] = (a[18] & !sel) | (b[18] & sel);
        assign out[19] = (a[19] & !sel) | (b[19] & sel);
        assign out[20] = (a[20] & !sel) | (b[20] & sel);
        assign out[21] = (a[21] & !sel) | (b[21] & sel);
        assign out[22] = (a[22] & !sel) | (b[22] & sel);
        assign out[23] = (a[23] & !sel) | (b[23] & sel);
        assign out[24] = (a[24] & !sel) | (b[24] & sel);
        assign out[25] = (a[25] & !sel) | (b[25] & sel);
        assign out[26] = (a[26] & !sel) | (b[26] & sel);
        assign out[27] = (a[27] & !sel) | (b[27] & sel);
        assign out[28] = (a[28] & !sel) | (b[28] & sel);
        assign out[29] = (a[29] & !sel) | (b[29] & sel);
             
endmodule                                                  
