
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


module all_synth ( ph1, ph2, reset, rd1, rd2, rd3, wd, row, col, RWSelect, 
        addr, new_r );
  input [7:0] rd1;
  input [7:0] rd2;
  input [7:0] rd3;
  input [7:0] wd;
  output [7:0] row;
  output [7:0] col;
  output [2:0] addr;
  output [7:0] new_r;
  input ph1, ph2, reset;
  output RWSelect;
  wire   disp_control_N7, disp_control_N6, disp_control_N5, disp_control_N4,
         disp_control_N3, disp_control_N2, disp_control_N1, disp_control_N0,
         n41, n42, n43, n44, n45, n46, n47, n48, n175, n176, n177, n178, n179,
         n180, n181, n182, n183, n184, n185, n186, n187, n188, n189, n190,
         n191, n192, n193, n194, n195, n196, n197, n198, n199, n200, n201,
         n202, n203, n204, n205, n206, n207, n208, n209, n210, n211, n212,
         n213, n214, n215, n216, n217, n218, n219, n220, n221, n222, n223,
         n224, n225, n226, n227, n228, n229, n230, n231, n232, n233, n234,
         n235, n236, n237, n238, n239, n240, n241, n242, n243, n244, n245,
         n246, n247, n248, n249, n250, n251, n252, n253, n254, n255, n256,
         n257, n258, n259, n260, n261, n262, n263, n264, n265, n266, n267,
         n268, n269, n270, n271, n272, n273, n274, n275, n276, n277, n278,
         n279, n280, n281, n282, n283, n284, n285, n286, n287, n288, n289,
         n290, n291, n292, n293, n294, n295, n296, n297, n298, n299, n300,
         n301, n302, n303, n304, n305, n306, n307, n308, n309, n310, n311,
         n312, n313, n314, n315, n316, n317, n318, n319, n320, n321, n322,
         n323, n324, n325, n326, n327, n328, n329, n330, n331, n332, n333,
         n334, n335, n336, n337, n338, n339, n340, n341, n342, n343;

  controller controller1 ( .ph1(ph1), .ph2(ph2), .reset(reset), .RWSelect(
        RWSelect), .addr(addr) );
  latch_c_1x disp_control_row_reg_0_ ( .ph(ph1), .d(disp_control_N0), .q(
        row[0]) );
  latch_c_1x disp_control_row_reg_1_ ( .ph(ph1), .d(disp_control_N1), .q(
        row[1]) );
  latch_c_1x disp_control_row_reg_2_ ( .ph(ph1), .d(disp_control_N2), .q(
        row[2]) );
  latch_c_1x disp_control_row_reg_3_ ( .ph(ph1), .d(disp_control_N3), .q(
        row[3]) );
  latch_c_1x disp_control_row_reg_4_ ( .ph(ph1), .d(disp_control_N4), .q(
        row[4]) );
  latch_c_1x disp_control_row_reg_5_ ( .ph(ph1), .d(disp_control_N5), .q(
        row[5]) );
  latch_c_1x disp_control_row_reg_6_ ( .ph(ph1), .d(disp_control_N6), .q(
        row[6]) );
  latch_c_1x disp_control_row_reg_7_ ( .ph(ph1), .d(disp_control_N7), .q(
        row[7]) );
  latch_c_1x disp_control_col_reg_0_ ( .ph(ph1), .d(n48), .q(col[0]) );
  latch_c_1x disp_control_col_reg_1_ ( .ph(ph1), .d(n47), .q(col[1]) );
  latch_c_1x disp_control_col_reg_2_ ( .ph(ph1), .d(n46), .q(col[2]) );
  latch_c_1x disp_control_col_reg_3_ ( .ph(ph1), .d(n45), .q(col[3]) );
  latch_c_1x disp_control_col_reg_4_ ( .ph(ph1), .d(n44), .q(col[4]) );
  latch_c_1x disp_control_col_reg_5_ ( .ph(ph1), .d(n43), .q(col[5]) );
  latch_c_1x disp_control_col_reg_6_ ( .ph(ph1), .d(n42), .q(col[6]) );
  latch_c_1x disp_control_col_reg_7_ ( .ph(ph1), .d(n41), .q(col[7]) );
  nor3_1x U191 ( .a(n217), .b(n210), .c(n211), .y(n175) );
  inv_1x U192 ( .a(rd2[1]), .y(n176) );
  a2o1_1x U193 ( .a(n217), .b(n211), .c(n175), .y(n177) );
  nand2_1x U194 ( .a(n177), .b(n176), .y(n178) );
  nor2_1x U195 ( .a(n216), .b(n227), .y(n179) );
  and2_1x U196 ( .a(n176), .b(n217), .y(n180) );
  nor2_1x U197 ( .a(n228), .b(n180), .y(n181) );
  nor2_1x U198 ( .a(n219), .b(n181), .y(n182) );
  a2o1_1x U199 ( .a(rd2[0]), .b(rd2[2]), .c(n175), .y(n183) );
  inv_1x U200 ( .a(n219), .y(n184) );
  nor3_1x U201 ( .a(n228), .b(n218), .c(n184), .y(n185) );
  nor3_1x U202 ( .a(n185), .b(n182), .c(n183), .y(n186) );
  a2o1_1x U203 ( .a(n185), .b(n183), .c(n186), .y(n187) );
  nand2_1x U204 ( .a(n187), .b(n178), .y(n188) );
  nor3_1x U205 ( .a(n179), .b(n233), .c(n188), .y(new_r[1]) );
  nor2_2x U206 ( .a(rd2[3]), .b(n240), .y(n253) );
  nor2_1x U207 ( .a(n251), .b(n250), .y(n248) );
  nor2_1x U208 ( .a(n203), .b(n202), .y(n200) );
  nor2_1x U209 ( .a(n336), .b(n335), .y(n331) );
  nor2_1x U210 ( .a(n267), .b(n266), .y(n262) );
  nor2_1x U211 ( .a(n231), .b(n230), .y(n226) );
  nor2_2x U212 ( .a(n279), .b(n284), .y(n280) );
  inv_2x U213 ( .a(n198), .y(n195) );
  inv_2x U214 ( .a(n284), .y(n291) );
  nand2_1x U215 ( .a(n244), .b(n243), .y(n250) );
  nand2_1x U216 ( .a(n330), .b(n329), .y(n335) );
  nand2_1x U217 ( .a(n312), .b(n311), .y(n315) );
  inv_2x U218 ( .a(n261), .y(n258) );
  inv_2x U219 ( .a(n329), .y(n326) );
  inv_2x U220 ( .a(n219), .y(n210) );
  inv_2x U221 ( .a(n243), .y(n239) );
  inv_2x U222 ( .a(n228), .y(n227) );
  nand2_2x U223 ( .a(n209), .b(n221), .y(n219) );
  inv_2x U224 ( .a(n263), .y(n264) );
  nand2_2x U225 ( .a(n306), .b(n282), .y(n284) );
  inv_2x U226 ( .a(n333), .y(n332) );
  nor2_1x U227 ( .a(n213), .b(n212), .y(n207) );
  inv_1x U228 ( .a(n209), .y(n193) );
  inv_1x U229 ( .a(n282), .y(n236) );
  nor2_1x U230 ( .a(n278), .b(n277), .y(n276) );
  nand2_1x U231 ( .a(n319), .b(n307), .y(n301) );
  inv_2x U232 ( .a(n283), .y(n285) );
  inv_1x U233 ( .a(n310), .y(n302) );
  nor2_2x U234 ( .a(n290), .b(n241), .y(n269) );
  nor2_2x U235 ( .a(n330), .b(n273), .y(n322) );
  inv_2x U236 ( .a(n273), .y(n255) );
  nor2_2x U237 ( .a(n216), .b(n311), .y(n338) );
  nor2_2x U238 ( .a(n244), .b(n215), .y(n233) );
  inv_2x U239 ( .a(n216), .y(n218) );
  inv_2x U240 ( .a(n215), .y(n190) );
  nor2_2x U241 ( .a(rd3[1]), .b(rd1[1]), .y(n189) );
  nor2_2x U242 ( .a(rd3[3]), .b(rd1[3]), .y(n220) );
  nor2_2x U243 ( .a(rd3[0]), .b(rd1[0]), .y(n191) );
  inv_2x U244 ( .a(rd2[7]), .y(n299) );
  nor2_2x U245 ( .a(rd3[4]), .b(rd1[4]), .y(n235) );
  inv_4x U246 ( .a(rd2[5]), .y(n300) );
  nor2_2x U247 ( .a(rd3[5]), .b(rd1[5]), .y(n254) );
  inv_2x U248 ( .a(rd2[6]), .y(n319) );
  nor2_2x U249 ( .a(rd2[2]), .b(n223), .y(n234) );
  nand2_2x U250 ( .a(rd3[2]), .b(rd1[2]), .y(n244) );
  nor2_2x U251 ( .a(rd2[4]), .b(n259), .y(n270) );
  nand2_2x U252 ( .a(rd3[3]), .b(rd1[3]), .y(n241) );
  nor2_2x U253 ( .a(rd2[7]), .b(n327), .y(n339) );
  nand2_2x U254 ( .a(n324), .b(n323), .y(n329) );
  nor2_2x U255 ( .a(rd2[0]), .b(n196), .y(n205) );
  nand2_2x U256 ( .a(rd3[7]), .b(rd1[7]), .y(n311) );
  inv_4x U257 ( .a(n277), .y(n324) );
  nand2_2x U258 ( .a(rd3[6]), .b(rd1[6]), .y(n330) );
  nand2_2x U259 ( .a(n237), .b(n256), .y(n243) );
  nor2_2x U260 ( .a(addr[0]), .b(n340), .y(disp_control_N6) );
  inv_4x U261 ( .a(addr[1]), .y(n342) );
  inv_4x U262 ( .a(addr[2]), .y(n341) );
  nor2_2x U263 ( .a(n343), .b(n340), .y(disp_control_N7) );
  nand2_2x U264 ( .a(addr[2]), .b(addr[1]), .y(n340) );
  nor2_2x U265 ( .a(n225), .b(n222), .y(n224) );
  nor2_2x U266 ( .a(n239), .b(n238), .y(n242) );
  inv_4x U267 ( .a(n212), .y(n237) );
  nand2_2x U268 ( .a(n244), .b(n206), .y(n212) );
  nor2_2x U269 ( .a(n258), .b(n257), .y(n260) );
  nor2_2x U270 ( .a(n247), .b(n220), .y(n245) );
  inv_4x U271 ( .a(n241), .y(n247) );
  nor2_2x U272 ( .a(n326), .b(n325), .y(n328) );
  nor2_2x U273 ( .a(n300), .b(n299), .y(n310) );
  nor2_2x U274 ( .a(n195), .b(n194), .y(n197) );
  nor2_2x U275 ( .a(n218), .b(n191), .y(n209) );
  nand2_2x U276 ( .a(rd3[0]), .b(rd1[0]), .y(n216) );
  nor2_2x U277 ( .a(n190), .b(n189), .y(n213) );
  nand2_2x U278 ( .a(rd3[1]), .b(rd1[1]), .y(n215) );
  inv_4x U279 ( .a(n289), .y(n312) );
  nor2_2x U280 ( .a(n281), .b(n235), .y(n282) );
  nor2_2x U281 ( .a(n288), .b(n274), .y(n283) );
  inv_4x U282 ( .a(n290), .y(n281) );
  nand2_2x U283 ( .a(rd3[4]), .b(rd1[4]), .y(n290) );
  nor2_2x U284 ( .a(n255), .b(n254), .y(n278) );
  nand2_2x U285 ( .a(n330), .b(n271), .y(n277) );
  nand2_2x U286 ( .a(rd3[5]), .b(rd1[5]), .y(n273) );
  inv_4x U287 ( .a(wd[2]), .y(n46) );
  inv_4x U288 ( .a(wd[3]), .y(n45) );
  inv_4x U289 ( .a(wd[4]), .y(n44) );
  inv_4x U290 ( .a(wd[5]), .y(n43) );
  inv_4x U291 ( .a(wd[6]), .y(n42) );
  inv_4x U292 ( .a(wd[7]), .y(n41) );
  inv_4x U293 ( .a(wd[0]), .y(n48) );
  inv_4x U294 ( .a(wd[1]), .y(n47) );
  inv_4x U295 ( .a(addr[0]), .y(n343) );
  or2_1x U296 ( .a(rd3[7]), .b(rd1[7]), .y(n192) );
  and2_1x U297 ( .a(n311), .b(n192), .y(n305) );
  mux2_c_1x U298 ( .d0(n209), .d1(n193), .s(n305), .y(n323) );
  nand2_1x U299 ( .a(n213), .b(n323), .y(n198) );
  nor2_1x U300 ( .a(n213), .b(n323), .y(n194) );
  fulladder U301 ( .a(rd2[1]), .b(rd2[7]), .c(n197), .cout(n203), .s(n196) );
  nand2_1x U302 ( .a(n215), .b(n198), .y(n202) );
  nand2_1x U303 ( .a(n209), .b(n305), .y(n199) );
  nand3_1x U304 ( .a(n216), .b(n311), .c(n199), .y(n333) );
  mux2_c_1x U305 ( .d0(n333), .d1(n332), .s(n200), .y(n201) );
  a2o1_1x U306 ( .a(n203), .b(n202), .c(n201), .y(n204) );
  nor3_1x U307 ( .a(n205), .b(n338), .c(n204), .y(new_r[0]) );
  or2_1x U308 ( .a(rd3[2]), .b(rd1[2]), .y(n206) );
  a2o1_1x U309 ( .a(n213), .b(n212), .c(n207), .y(n221) );
  nor2_1x U310 ( .a(n209), .b(n221), .y(n211) );
  inv_1x U311 ( .a(rd2[2]), .y(n208) );
  mux2_c_1x U312 ( .d0(n208), .d1(rd2[2]), .s(rd2[0]), .y(n217) );
  nand2_1x U313 ( .a(n237), .b(n213), .y(n214) );
  nand3_1x U314 ( .a(n244), .b(n215), .c(n214), .y(n228) );
  and2_1x U315 ( .a(n221), .b(n245), .y(n225) );
  nor2_1x U316 ( .a(n221), .b(n245), .y(n222) );
  fulladder U317 ( .a(rd2[3]), .b(rd2[1]), .c(n224), .cout(n231), .s(n223) );
  or2_1x U318 ( .a(n247), .b(n225), .y(n230) );
  mux2_c_1x U319 ( .d0(n228), .d1(n227), .s(n226), .y(n229) );
  a2o1_1x U320 ( .a(n231), .b(n230), .c(n229), .y(n232) );
  nor3_1x U321 ( .a(n234), .b(n233), .c(n232), .y(new_r[2]) );
  mux2_c_1x U322 ( .d0(n282), .d1(n236), .s(n245), .y(n256) );
  nor2_1x U323 ( .a(n237), .b(n256), .y(n238) );
  fulladder U324 ( .a(rd2[4]), .b(rd2[2]), .c(n242), .cout(n251), .s(n240) );
  and2_1x U325 ( .a(n282), .b(n245), .y(n246) );
  nor3_1x U326 ( .a(n281), .b(n247), .c(n246), .y(n263) );
  mux2_c_1x U327 ( .d0(n264), .d1(n263), .s(n248), .y(n249) );
  a2o1_1x U328 ( .a(n251), .b(n250), .c(n249), .y(n252) );
  nor3_1x U329 ( .a(n253), .b(n269), .c(n252), .y(new_r[3]) );
  nand2_1x U330 ( .a(n278), .b(n256), .y(n261) );
  nor2_1x U331 ( .a(n278), .b(n256), .y(n257) );
  fulladder U332 ( .a(rd2[5]), .b(rd2[3]), .c(n260), .cout(n267), .s(n259) );
  nand2_1x U333 ( .a(n273), .b(n261), .y(n266) );
  mux2_c_1x U334 ( .d0(n264), .d1(n263), .s(n262), .y(n265) );
  a2o1_1x U335 ( .a(n267), .b(n266), .c(n265), .y(n268) );
  nor3_1x U336 ( .a(n270), .b(n269), .c(n268), .y(new_r[4]) );
  or2_1x U337 ( .a(rd3[6]), .b(rd1[6]), .y(n271) );
  nand2_1x U338 ( .a(n324), .b(n278), .y(n272) );
  nand3_1x U339 ( .a(n330), .b(n273), .c(n272), .y(n289) );
  and2_1x U340 ( .a(rd2[6]), .b(rd2[4]), .y(n288) );
  nor2_1x U341 ( .a(rd2[6]), .b(rd2[4]), .y(n274) );
  nor2_1x U342 ( .a(n283), .b(rd2[5]), .y(n275) );
  nor3_1x U343 ( .a(n275), .b(n288), .c(n289), .y(n279) );
  a2o1_1x U344 ( .a(n278), .b(n277), .c(n276), .y(n306) );
  a2o1_1x U345 ( .a(n289), .b(n281), .c(n280), .y(n298) );
  nor2_1x U346 ( .a(n306), .b(n282), .y(n286) );
  nor3_1x U347 ( .a(n291), .b(n286), .c(n285), .y(n287) );
  a2o1_1x U348 ( .a(n286), .b(n285), .c(n287), .y(n296) );
  or2_1x U349 ( .a(n288), .b(n287), .y(n294) );
  nand2_1x U350 ( .a(n312), .b(n290), .y(n293) );
  nor3_1x U351 ( .a(n293), .b(n294), .c(n291), .y(n292) );
  a2o1_1x U352 ( .a(n294), .b(n293), .c(n292), .y(n295) );
  a2o1_1x U353 ( .a(n300), .b(n296), .c(n295), .y(n297) );
  nor3_1x U354 ( .a(n322), .b(n298), .c(n297), .y(new_r[5]) );
  and2_1x U355 ( .a(n306), .b(n305), .y(n313) );
  a2o1_1x U356 ( .a(n300), .b(n299), .c(n310), .y(n307) );
  nand3_1x U357 ( .a(n302), .b(n312), .c(n301), .y(n304) );
  nor2_1x U358 ( .a(n311), .b(n312), .y(n303) );
  a2o1_1x U359 ( .a(n313), .b(n304), .c(n303), .y(n321) );
  nor2_1x U360 ( .a(n306), .b(n305), .y(n308) );
  nor3_1x U361 ( .a(n313), .b(n308), .c(n307), .y(n309) );
  a2o1_1x U362 ( .a(n308), .b(n307), .c(n309), .y(n318) );
  or2_1x U363 ( .a(n310), .b(n309), .y(n316) );
  nor3_1x U364 ( .a(n315), .b(n316), .c(n313), .y(n314) );
  a2o1_1x U365 ( .a(n316), .b(n315), .c(n314), .y(n317) );
  a2o1_1x U366 ( .a(n319), .b(n318), .c(n317), .y(n320) );
  nor3_1x U367 ( .a(n322), .b(n321), .c(n320), .y(new_r[6]) );
  nor2_1x U368 ( .a(n324), .b(n323), .y(n325) );
  fulladder U369 ( .a(rd2[6]), .b(rd2[0]), .c(n328), .cout(n336), .s(n327) );
  mux2_c_1x U370 ( .d0(n333), .d1(n332), .s(n331), .y(n334) );
  a2o1_1x U371 ( .a(n336), .b(n335), .c(n334), .y(n337) );
  nor3_1x U372 ( .a(n339), .b(n338), .c(n337), .y(new_r[7]) );
  nor3_1x U373 ( .a(addr[1]), .b(n341), .c(n343), .y(disp_control_N5) );
  nor3_1x U374 ( .a(addr[0]), .b(addr[1]), .c(n341), .y(disp_control_N4) );
  nor3_1x U375 ( .a(addr[2]), .b(n343), .c(n342), .y(disp_control_N3) );
  nor3_1x U376 ( .a(addr[0]), .b(addr[2]), .c(n342), .y(disp_control_N2) );
  nor3_1x U377 ( .a(addr[2]), .b(addr[1]), .c(n343), .y(disp_control_N1) );
  nor3_1x U378 ( .a(addr[0]), .b(addr[2]), .c(addr[1]), .y(disp_control_N0) );
endmodule

