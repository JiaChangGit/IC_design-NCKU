module Sbox(input [7:0] word, output reg [7:0] hashTB);

	always @(word)
		case (word)
			8'h00: hashTB = 8'h63;
			8'h01: hashTB = 8'h7c;
			8'h02: hashTB = 8'h77;
			8'h03: hashTB = 8'h7b;
			8'h04: hashTB = 8'hf2;
			8'h05: hashTB = 8'h6b;
			8'h06: hashTB = 8'h6f;
			8'h07: hashTB = 8'hc5;
			8'h08: hashTB = 8'h30;
			8'h09: hashTB = 8'h01;
			8'h0a: hashTB = 8'h67;
			8'h0b: hashTB = 8'h2b;
			8'h0c: hashTB = 8'hfe;
			8'h0d: hashTB = 8'hd7;
			8'h0e: hashTB = 8'hab;
			8'h0f: hashTB = 8'h76;
			8'h10: hashTB = 8'hca;
			8'h11: hashTB = 8'h82;
			8'h12: hashTB = 8'hc9;
			8'h13: hashTB = 8'h7d;
			8'h14: hashTB = 8'hfa;
			8'h15: hashTB = 8'h59;
			8'h16: hashTB = 8'h47;
			8'h17: hashTB = 8'hf0;
			8'h18: hashTB = 8'had;
			8'h19: hashTB = 8'hd4;
			8'h1a: hashTB = 8'ha2;
			8'h1b: hashTB = 8'haf;
			8'h1c: hashTB = 8'h9c;
			8'h1d: hashTB = 8'ha4;
			8'h1e: hashTB = 8'h72;
			8'h1f: hashTB = 8'hc0;
			8'h20: hashTB = 8'hb7;
			8'h21: hashTB = 8'hfd;
			8'h22: hashTB = 8'h93;
			8'h23: hashTB = 8'h26;
			8'h24: hashTB = 8'h36;
			8'h25: hashTB = 8'h3f;
			8'h26: hashTB = 8'hf7;
			8'h27: hashTB = 8'hcc;
			8'h28: hashTB = 8'h34;
			8'h29: hashTB = 8'ha5;
			8'h2a: hashTB = 8'he5;
			8'h2b: hashTB = 8'hf1;
			8'h2c: hashTB = 8'h71;
			8'h2d: hashTB = 8'hd8;
			8'h2e: hashTB = 8'h31;
			8'h2f: hashTB = 8'h15;
			8'h30: hashTB = 8'h04;
			8'h31: hashTB = 8'hc7;
			8'h32: hashTB = 8'h23;
			8'h33: hashTB = 8'hc3;
			8'h34: hashTB = 8'h18;
			8'h35: hashTB = 8'h96;
			8'h36: hashTB = 8'h05;
			8'h37: hashTB = 8'h9a;
			8'h38: hashTB = 8'h07;
			8'h39: hashTB = 8'h12;
			8'h3a: hashTB = 8'h80;
			8'h3b: hashTB = 8'he2;
			8'h3c: hashTB = 8'heb;
			8'h3d: hashTB = 8'h27;
			8'h3e: hashTB = 8'hb2;
			8'h3f: hashTB = 8'h75;
			8'h40: hashTB = 8'h09;
			8'h41: hashTB = 8'h83;
			8'h42: hashTB = 8'h2c;
			8'h43: hashTB = 8'h1a;
			8'h44: hashTB = 8'h1b;
			8'h45: hashTB = 8'h6e;
			8'h46: hashTB = 8'h5a;
			8'h47: hashTB = 8'ha0;
			8'h48: hashTB = 8'h52;
			8'h49: hashTB = 8'h3b;
			8'h4a: hashTB = 8'hd6;
			8'h4b: hashTB = 8'hb3;
			8'h4c: hashTB = 8'h29;
			8'h4d: hashTB = 8'he3;
			8'h4e: hashTB = 8'h2f;
			8'h4f: hashTB = 8'h84;
			8'h50: hashTB = 8'h53;
			8'h51: hashTB = 8'hd1;
			8'h52: hashTB = 8'h00;
			8'h53: hashTB = 8'hed;
			8'h54: hashTB = 8'h20;
			8'h55: hashTB = 8'hfc;
			8'h56: hashTB = 8'hb1;
			8'h57: hashTB = 8'h5b;
			8'h58: hashTB = 8'h6a;
			8'h59: hashTB = 8'hcb;
			8'h5a: hashTB = 8'hbe;
			8'h5b: hashTB = 8'h39;
			8'h5c: hashTB = 8'h4a;
			8'h5d: hashTB = 8'h4c;
			8'h5e: hashTB = 8'h58;
			8'h5f: hashTB = 8'hcf;
			8'h60: hashTB = 8'hd0;
			8'h61: hashTB = 8'hef;
			8'h62: hashTB = 8'haa;
			8'h63: hashTB = 8'hfb;
			8'h64: hashTB = 8'h43;
			8'h65: hashTB = 8'h4d;
			8'h66: hashTB = 8'h33;
			8'h67: hashTB = 8'h85;
			8'h68: hashTB = 8'h45;
			8'h69: hashTB = 8'hf9;
			8'h6a: hashTB = 8'h02;
			8'h6b: hashTB = 8'h7f;
			8'h6c: hashTB = 8'h50;
			8'h6d: hashTB = 8'h3c;
			8'h6e: hashTB = 8'h9f;
			8'h6f: hashTB = 8'ha8;
			8'h70: hashTB = 8'h51;
			8'h71: hashTB = 8'ha3;
			8'h72: hashTB = 8'h40;
			8'h73: hashTB = 8'h8f;
			8'h74: hashTB = 8'h92;
			8'h75: hashTB = 8'h9d;
			8'h76: hashTB = 8'h38;
			8'h77: hashTB = 8'hf5;
			8'h78: hashTB = 8'hbc;
			8'h79: hashTB = 8'hb6;
			8'h7a: hashTB = 8'hda;
			8'h7b: hashTB = 8'h21;
			8'h7c: hashTB = 8'h10;
			8'h7d: hashTB = 8'hff;
			8'h7e: hashTB = 8'hf3;
			8'h7f: hashTB = 8'hd2;
			8'h80: hashTB = 8'hcd;
			8'h81: hashTB = 8'h0c;
			8'h82: hashTB = 8'h13;
			8'h83: hashTB = 8'hec;
			8'h84: hashTB = 8'h5f;
			8'h85: hashTB = 8'h97;
			8'h86: hashTB = 8'h44;
			8'h87: hashTB = 8'h17;
			8'h88: hashTB = 8'hc4;
			8'h89: hashTB = 8'ha7;
			8'h8a: hashTB = 8'h7e;
			8'h8b: hashTB = 8'h3d;
			8'h8c: hashTB = 8'h64;
			8'h8d: hashTB = 8'h5d;
			8'h8e: hashTB = 8'h19;
			8'h8f: hashTB = 8'h73;
			8'h90: hashTB = 8'h60;
			8'h91: hashTB = 8'h81;
			8'h92: hashTB = 8'h4f;
			8'h93: hashTB = 8'hdc;
			8'h94: hashTB = 8'h22;
			8'h95: hashTB = 8'h2a;
			8'h96: hashTB = 8'h90;
			8'h97: hashTB = 8'h88;
			8'h98: hashTB = 8'h46;
			8'h99: hashTB = 8'hee;
			8'h9a: hashTB = 8'hb8;
			8'h9b: hashTB = 8'h14;
			8'h9c: hashTB = 8'hde;
			8'h9d: hashTB = 8'h5e;
			8'h9e: hashTB = 8'h0b;
			8'h9f: hashTB = 8'hdb;
			8'ha0: hashTB = 8'he0;
			8'ha1: hashTB = 8'h32;
			8'ha2: hashTB = 8'h3a;
			8'ha3: hashTB = 8'h0a;
			8'ha4: hashTB = 8'h49;
			8'ha5: hashTB = 8'h06;
			8'ha6: hashTB = 8'h24;
			8'ha7: hashTB = 8'h5c;
			8'ha8: hashTB = 8'hc2;
			8'ha9: hashTB = 8'hd3;
			8'haa: hashTB = 8'hac;
			8'hab: hashTB = 8'h62;
			8'hac: hashTB = 8'h91;
			8'had: hashTB = 8'h95;
			8'hae: hashTB = 8'he4;
			8'haf: hashTB = 8'h79;
			8'hb0: hashTB = 8'he7;
			8'hb1: hashTB = 8'hc8;
			8'hb2: hashTB = 8'h37;
			8'hb3: hashTB = 8'h6d;
			8'hb4: hashTB = 8'h8d;
			8'hb5: hashTB = 8'hd5;
			8'hb6: hashTB = 8'h4e;
			8'hb7: hashTB = 8'ha9;
			8'hb8: hashTB = 8'h6c;
			8'hb9: hashTB = 8'h56;
			8'hba: hashTB = 8'hf4;
			8'hbb: hashTB = 8'hea;
			8'hbc: hashTB = 8'h65;
			8'hbd: hashTB = 8'h7a;
			8'hbe: hashTB = 8'hae;
			8'hbf: hashTB = 8'h08;
			8'hc0: hashTB = 8'hba;
			8'hc1: hashTB = 8'h78;
			8'hc2: hashTB = 8'h25;
			8'hc3: hashTB = 8'h2e;
			8'hc4: hashTB = 8'h1c;
			8'hc5: hashTB = 8'ha6;
			8'hc6: hashTB = 8'hb4;
			8'hc7: hashTB = 8'hc6;
			8'hc8: hashTB = 8'he8;
			8'hc9: hashTB = 8'hdd;
			8'hca: hashTB = 8'h74;
			8'hcb: hashTB = 8'h1f;
			8'hcc: hashTB = 8'h4b;
			8'hcd: hashTB = 8'hbd;
			8'hce: hashTB = 8'h8b;
			8'hcf: hashTB = 8'h8a;
			8'hd0: hashTB = 8'h70;
			8'hd1: hashTB = 8'h3e;
			8'hd2: hashTB = 8'hb5;
			8'hd3: hashTB = 8'h66;
			8'hd4: hashTB = 8'h48;
			8'hd5: hashTB = 8'h03;
			8'hd6: hashTB = 8'hf6;
			8'hd7: hashTB = 8'h0e;
			8'hd8: hashTB = 8'h61;
			8'hd9: hashTB = 8'h35;
			8'hda: hashTB = 8'h57;
			8'hdb: hashTB = 8'hb9;
			8'hdc: hashTB = 8'h86;
			8'hdd: hashTB = 8'hc1;
			8'hde: hashTB = 8'h1d;
			8'hdf: hashTB = 8'h9e;
			8'he0: hashTB = 8'he1;
			8'he1: hashTB = 8'hf8;
			8'he2: hashTB = 8'h98;
			8'he3: hashTB = 8'h11;
			8'he4: hashTB = 8'h69;
			8'he5: hashTB = 8'hd9;
			8'he6: hashTB = 8'h8e;
			8'he7: hashTB = 8'h94;
			8'he8: hashTB = 8'h9b;
			8'he9: hashTB = 8'h1e;
			8'hea: hashTB = 8'h87;
			8'heb: hashTB = 8'he9;
			8'hec: hashTB = 8'hce;
			8'hed: hashTB = 8'h55;
			8'hee: hashTB = 8'h28;
			8'hef: hashTB = 8'hdf;
			8'hf0: hashTB = 8'h8c;
			8'hf1: hashTB = 8'ha1;
			8'hf2: hashTB = 8'h89;
			8'hf3: hashTB = 8'h0d;
			8'hf4: hashTB = 8'hbf;
			8'hf5: hashTB = 8'he6;
			8'hf6: hashTB = 8'h42;
			8'hf7: hashTB = 8'h68;
			8'hf8: hashTB = 8'h41;
			8'hf9: hashTB = 8'h99;
			8'hfa: hashTB = 8'h2d;
			8'hfb: hashTB = 8'h0f;
			8'hfc: hashTB = 8'hb0;
			8'hfd: hashTB = 8'h54;
			8'hfe: hashTB = 8'hbb;
			8'hff: hashTB = 8'h16;
		endcase

endmodule
