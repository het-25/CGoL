// Created by ihdl
module controller ( ph1, ph2, reset, RWSelect, addr );
  output [2:0] addr;
  input ph1, ph2, reset;
  output RWSelect;
  wire   snps_logic_one, snps_logic_zero, n_1_net__2_, n_1_net__1_,
         n_1_net__0_, n_3_net__3_, n_3_net__2_, n_3_net__1_, n_3_net__0_,
         add_x_136_1_n8, add_x_136_1_n7, add_x_136_1_n5, add_x_136_1_n4,
         add_x_135_1_n3, add_x_135_1_n2, n1, n2, n3, n4, n5, n6;
  wire   [2:0] count;
  assign snps_logic_one = 1'b1;
  assign snps_logic_zero = 1'b0;

  flopenr count_flop ( .p1(ph1), .p2(ph2), .p3(reset), .p4(snps_logic_one), 
        .p5({n_1_net__2_, n_1_net__1_, n_1_net__0_}), .p6(count) );
  flopenr addr_flop ( .p1(ph1), .p2(ph2), .p3(reset), .p4(snps_logic_one), 
        .p5({snps_logic_zero, snps_logic_zero, snps_logic_zero, 
        snps_logic_zero, snps_logic_zero, snps_logic_zero, snps_logic_zero, 
        snps_logic_zero, snps_logic_zero, snps_logic_zero, snps_logic_zero, 
        snps_logic_zero, snps_logic_zero, snps_logic_zero, snps_logic_zero, 
        snps_logic_zero, snps_logic_zero, snps_logic_zero, snps_logic_zero, 
        snps_logic_zero, snps_logic_zero, snps_logic_zero, snps_logic_zero, 
        snps_logic_zero, snps_logic_zero, snps_logic_zero, snps_logic_zero, 
        snps_logic_zero, n_3_net__3_, n_3_net__2_, n_3_net__1_, n_3_net__0_}), 
        .p6(addr) );
  inv_4x add_x_136_1_U15 ( .a(addr[0]), .y(n_3_net__0_) );
  nand2_2x add_x_136_1_U10 ( .a(add_x_136_1_n8), .b(add_x_136_1_n7), .y(
        n_3_net__1_) );
  nand2_2x add_x_136_1_U5 ( .a(add_x_136_1_n5), .b(add_x_136_1_n4), .y(
        n_3_net__2_) );
  nand2_2x add_x_136_1_U1 ( .a(n6), .b(1'b1), .y(n_3_net__3_) );
  fulladder add_x_135_1_U3 ( .a(count[0]), .b(n1), .c(1'b0), .cout(
        add_x_135_1_n3), .s(n_1_net__0_) );
  fulladder add_x_135_1_U2 ( .a(count[1]), .b(1'b0), .c(add_x_135_1_n3), 
        .cout(add_x_135_1_n2), .s(n_1_net__1_) );
  fulladder add_x_135_1_U1 ( .a(count[2]), .b(1'b0), .c(add_x_135_1_n2), .s(
        n_1_net__2_) );
  nand2_1x U5 ( .a(addr[2]), .b(n3), .y(n6) );
  or2_1x U6 ( .a(addr[1]), .b(n_3_net__0_), .y(add_x_136_1_n8) );
  nand2_1x U7 ( .a(addr[1]), .b(n_3_net__0_), .y(add_x_136_1_n7) );
  or2_1x U8 ( .a(n2), .b(addr[2]), .y(add_x_136_1_n5) );
  nor2_1x U10 ( .a(n4), .b(n_3_net__0_), .y(n3) );
  nand3_1x U12 ( .a(count[2]), .b(count[0]), .c(count[1]), .y(RWSelect) );
  nand3_1x U13 ( .a(addr[2]), .b(addr[1]), .c(addr[0]), .y(n5) );
  inv_4x U11 ( .a(addr[1]), .y(n4) );
  nand2_2x U9 ( .a(addr[2]), .b(n2), .y(add_x_136_1_n4) );
  inv_4x U3 ( .a(n5), .y(n1) );
  inv_4x U4 ( .a(n3), .y(n2) );
endmodule
