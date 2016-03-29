
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
  wire   n369, controller1_count_0_, controller1_count_1_,
         controller1_count_2_, disp_control_N7, disp_control_N6,
         disp_control_N5, disp_control_N4, disp_control_N3, disp_control_N2,
         disp_control_N1, disp_control_N0, n38, n39, n40, n41, n42, n43, n44,
         n45, n187, n188, n189, n190, n191, n192, n193, n194, n195, n196, n197,
         n198, n199, n200, n201, n203, n204, n205, n206, n207, n208, n209,
         n210, n211, n212, n213, n214, n215, n216, n217, n218, n219, n220,
         n221, n222, n223, n224, n225, n226, n227, n228, n229, n230, n231,
         n232, n233, n234, n235, n236, n237, n238, n239, n240, n241, n242,
         n243, n244, n245, n246, n247, n248, n249, n250, n251, n252, n253,
         n254, n255, n256, n257, n258, n259, n260, n261, n262, n263, n264,
         n265, n266, n267, n268, n269, n270, n271, n272, n273, n274, n275,
         n276, n277, n278, n279, n280, n281, n282, n283, n284, n285, n286,
         n287, n288, n289, n290, n291, n292, n293, n294, n295, n296, n297,
         n298, n299, n300, n301, n302, n303, n304, n305, n306, n307, n308,
         n309, n310, n311, n312, n313, n314, n315, n316, n317, n318, n319,
         n320, n321, n322, n323, n324, n325, n326, n327, n328, n329, n330,
         n331, n332, n333, n334, n335, n336, n337, n338, n339, n340, n341,
         n342, n343, n344, n345, n346, n347, n348, n349, n350, n351, n352,
         n353, n354, n355, n356, n357, n358, n359, n360, n361, n362, n363,
         n364, n365, n366, n367, n368;
  wire   [2:0] controller1_count_flop_d2;
  wire   [2:0] controller1_addr_flop_d2;
  wire   [2:0] controller1_count_flop_f_mid;
  wire   [2:0] controller1_addr_flop_f_mid;

  latch_c_1x disp_control_col_reg_0_ ( .ph(ph1), .d(n45), .q(col[0]) );
  latch_c_1x disp_control_col_reg_1_ ( .ph(ph1), .d(n44), .q(col[1]) );
  latch_c_1x disp_control_col_reg_2_ ( .ph(ph1), .d(n43), .q(col[2]) );
  latch_c_1x disp_control_col_reg_3_ ( .ph(ph1), .d(n42), .q(col[3]) );
  latch_c_1x disp_control_col_reg_4_ ( .ph(ph1), .d(n41), .q(col[4]) );
  latch_c_1x disp_control_col_reg_5_ ( .ph(ph1), .d(n40), .q(col[5]) );
  latch_c_1x disp_control_col_reg_6_ ( .ph(ph1), .d(n39), .q(col[6]) );
  latch_c_1x disp_control_col_reg_7_ ( .ph(ph1), .d(n38), .q(col[7]) );
  latch_c_1x controller1_addr_flop_f_master_q_reg_0_ ( .ph(ph2), .d(
        controller1_addr_flop_d2[0]), .q(controller1_addr_flop_f_mid[0]) );
  latch_c_1x controller1_addr_flop_f_slave_q_reg_0_ ( .ph(ph1), .d(
        controller1_addr_flop_f_mid[0]), .q(addr[0]) );
  latch_c_1x controller1_addr_flop_f_master_q_reg_1_ ( .ph(ph2), .d(
        controller1_addr_flop_d2[1]), .q(controller1_addr_flop_f_mid[1]) );
  latch_c_1x controller1_addr_flop_f_slave_q_reg_1_ ( .ph(ph1), .d(
        controller1_addr_flop_f_mid[1]), .q(addr[1]) );
  latch_c_1x controller1_addr_flop_f_master_q_reg_2_ ( .ph(ph2), .d(
        controller1_addr_flop_d2[2]), .q(controller1_addr_flop_f_mid[2]) );
  latch_c_1x controller1_addr_flop_f_slave_q_reg_2_ ( .ph(ph1), .d(
        controller1_addr_flop_f_mid[2]), .q(n369) );
  latch_c_1x disp_control_row_reg_3_ ( .ph(ph1), .d(disp_control_N3), .q(
        row[3]) );
  latch_c_1x disp_control_row_reg_2_ ( .ph(ph1), .d(disp_control_N2), .q(
        row[2]) );
  latch_c_1x disp_control_row_reg_1_ ( .ph(ph1), .d(disp_control_N1), .q(
        row[1]) );
  latch_c_1x disp_control_row_reg_0_ ( .ph(ph1), .d(disp_control_N0), .q(
        row[0]) );
  latch_c_1x disp_control_row_reg_4_ ( .ph(ph1), .d(disp_control_N4), .q(
        row[4]) );
  latch_c_1x disp_control_row_reg_5_ ( .ph(ph1), .d(disp_control_N5), .q(
        row[5]) );
  latch_c_1x disp_control_row_reg_6_ ( .ph(ph1), .d(disp_control_N6), .q(
        row[6]) );
  latch_c_1x disp_control_row_reg_7_ ( .ph(ph1), .d(disp_control_N7), .q(
        row[7]) );
  latch_c_1x controller1_count_flop_f_slave_q_reg_0_ ( .ph(ph1), .d(
        controller1_count_flop_f_mid[0]), .q(controller1_count_0_) );
  latch_c_1x controller1_count_flop_f_master_q_reg_0_ ( .ph(ph2), .d(
        controller1_count_flop_d2[0]), .q(controller1_count_flop_f_mid[0]) );
  latch_c_1x controller1_count_flop_f_slave_q_reg_1_ ( .ph(ph1), .d(
        controller1_count_flop_f_mid[1]), .q(controller1_count_1_) );
  latch_c_1x controller1_count_flop_f_master_q_reg_1_ ( .ph(ph2), .d(
        controller1_count_flop_d2[1]), .q(controller1_count_flop_f_mid[1]) );
  latch_c_1x controller1_count_flop_f_slave_q_reg_2_ ( .ph(ph1), .d(
        controller1_count_flop_f_mid[2]), .q(controller1_count_2_) );
  latch_c_1x controller1_count_flop_f_master_q_reg_2_ ( .ph(ph2), .d(
        controller1_count_flop_d2[2]), .q(controller1_count_flop_f_mid[2]) );
  nor3_1x U210 ( .a(n242), .b(n235), .c(n236), .y(n187) );
  inv_1x U211 ( .a(rd2[1]), .y(n188) );
  a2o1_1x U212 ( .a(n242), .b(n236), .c(n187), .y(n189) );
  nand2_1x U213 ( .a(n189), .b(n188), .y(n190) );
  nor2_1x U214 ( .a(n241), .b(n252), .y(n191) );
  and2_1x U215 ( .a(n188), .b(n242), .y(n192) );
  nor2_1x U216 ( .a(n253), .b(n192), .y(n193) );
  nor2_1x U217 ( .a(n244), .b(n193), .y(n194) );
  a2o1_1x U218 ( .a(rd2[0]), .b(rd2[2]), .c(n187), .y(n195) );
  inv_1x U219 ( .a(n244), .y(n196) );
  nor3_1x U220 ( .a(n253), .b(n243), .c(n196), .y(n197) );
  nor3_1x U221 ( .a(n197), .b(n194), .c(n195), .y(n198) );
  a2o1_1x U222 ( .a(n197), .b(n195), .c(n198), .y(n199) );
  nand2_1x U223 ( .a(n199), .b(n190), .y(n200) );
  nor3_1x U224 ( .a(n191), .b(n258), .c(n200), .y(new_r[1]) );
  nor2_2x U225 ( .a(rd2[3]), .b(n265), .y(n278) );
  nor2_1x U226 ( .a(n292), .b(n291), .y(n287) );
  nor2_1x U227 ( .a(n228), .b(n227), .y(n225) );
  nor2_1x U228 ( .a(n361), .b(n360), .y(n356) );
  nor2_1x U229 ( .a(n276), .b(n275), .y(n273) );
  nor2_1x U230 ( .a(n256), .b(n255), .y(n251) );
  inv_2x U231 ( .a(n244), .y(n235) );
  inv_2x U232 ( .a(n286), .y(n283) );
  nor2_2x U233 ( .a(n304), .b(n309), .y(n305) );
  nand2_1x U234 ( .a(n337), .b(n336), .y(n340) );
  inv_2x U235 ( .a(n223), .y(n220) );
  inv_2x U236 ( .a(n354), .y(n351) );
  nand2_1x U237 ( .a(n355), .b(n354), .y(n360) );
  nand2_1x U238 ( .a(n269), .b(n268), .y(n275) );
  inv_2x U239 ( .a(n309), .y(n316) );
  inv_2x U240 ( .a(n268), .y(n264) );
  nand2_2x U241 ( .a(n331), .b(n307), .y(n309) );
  inv_2x U242 ( .a(n253), .y(n252) );
  inv_2x U243 ( .a(n288), .y(n289) );
  nand2_2x U244 ( .a(n234), .b(n246), .y(n244) );
  inv_2x U245 ( .a(n358), .y(n357) );
  nor2_1x U246 ( .a(n238), .b(n237), .y(n232) );
  inv_1x U247 ( .a(n234), .y(n218) );
  nor2_1x U248 ( .a(n303), .b(n302), .y(n301) );
  inv_1x U249 ( .a(n307), .y(n261) );
  nand2_1x U250 ( .a(n344), .b(n332), .y(n326) );
  inv_4x U251 ( .a(n201), .y(addr[2]) );
  inv_1x U252 ( .a(n335), .y(n327) );
  inv_2x U253 ( .a(n308), .y(n310) );
  inv_2x U254 ( .a(n298), .y(n280) );
  inv_2x U255 ( .a(n240), .y(n215) );
  inv_2x U256 ( .a(n241), .y(n243) );
  nor2_2x U257 ( .a(n315), .b(n266), .y(n294) );
  nor2_2x U258 ( .a(n355), .b(n298), .y(n347) );
  nor2_2x U259 ( .a(n269), .b(n240), .y(n258) );
  nor2_2x U260 ( .a(n241), .b(n336), .y(n363) );
  inv_4x U261 ( .a(rd2[5]), .y(n325) );
  nor2_2x U262 ( .a(rd3[1]), .b(rd1[1]), .y(n214) );
  nor2_2x U263 ( .a(rd3[3]), .b(rd1[3]), .y(n245) );
  inv_2x U264 ( .a(rd2[6]), .y(n344) );
  nor2_2x U265 ( .a(rd3[0]), .b(rd1[0]), .y(n216) );
  nor2_2x U266 ( .a(rd3[4]), .b(rd1[4]), .y(n260) );
  inv_2x U267 ( .a(rd2[7]), .y(n324) );
  nor2_2x U268 ( .a(rd3[5]), .b(rd1[5]), .y(n279) );
  inv_2x U269 ( .a(n369), .y(n201) );
  nor2_2x U270 ( .a(rd2[2]), .b(n248), .y(n259) );
  nand2_2x U271 ( .a(rd3[2]), .b(rd1[2]), .y(n269) );
  nor2_2x U272 ( .a(rd2[4]), .b(n284), .y(n295) );
  nand2_2x U273 ( .a(rd3[3]), .b(rd1[3]), .y(n266) );
  nor2_2x U274 ( .a(rd2[7]), .b(n352), .y(n364) );
  nand2_2x U275 ( .a(n349), .b(n348), .y(n354) );
  nor2_2x U276 ( .a(rd2[0]), .b(n221), .y(n230) );
  nand2_2x U277 ( .a(rd3[7]), .b(rd1[7]), .y(n336) );
  inv_4x U278 ( .a(n302), .y(n349) );
  nand2_2x U279 ( .a(rd3[6]), .b(rd1[6]), .y(n355) );
  nor2_1x U280 ( .a(n368), .b(n366), .y(disp_control_N5) );
  nand2_1x U281 ( .a(n367), .b(addr[2]), .y(n366) );
  inv_1x U282 ( .a(addr[1]), .y(n367) );
  nor2_1x U283 ( .a(n368), .b(n365), .y(disp_control_N7) );
  inv_1x U284 ( .a(addr[0]), .y(n368) );
  nor2_1x U285 ( .a(reset), .b(n213), .y(controller1_count_flop_d2[2]) );
  inv_4x U286 ( .a(n211), .y(n210) );
  nand2_2x U287 ( .a(n262), .b(n281), .y(n268) );
  nor2_1x U288 ( .a(reset), .b(addr[0]), .y(controller1_addr_flop_d2[0]) );
  nor2_2x U289 ( .a(n250), .b(n247), .y(n249) );
  nor2_2x U290 ( .a(n264), .b(n263), .y(n267) );
  inv_4x U291 ( .a(n237), .y(n262) );
  nand2_2x U292 ( .a(n269), .b(n231), .y(n237) );
  nor2_2x U293 ( .a(n283), .b(n282), .y(n285) );
  nor2_2x U294 ( .a(n272), .b(n245), .y(n270) );
  inv_4x U295 ( .a(n266), .y(n272) );
  nor2_2x U296 ( .a(n351), .b(n350), .y(n353) );
  nor2_2x U297 ( .a(n325), .b(n324), .y(n335) );
  nor2_2x U298 ( .a(n220), .b(n219), .y(n222) );
  nor2_2x U299 ( .a(n243), .b(n216), .y(n234) );
  nand2_2x U300 ( .a(rd3[0]), .b(rd1[0]), .y(n241) );
  nor2_2x U301 ( .a(n215), .b(n214), .y(n238) );
  nand2_2x U302 ( .a(rd3[1]), .b(rd1[1]), .y(n240) );
  inv_4x U303 ( .a(n314), .y(n337) );
  nor2_2x U304 ( .a(n306), .b(n260), .y(n307) );
  nor2_2x U305 ( .a(n313), .b(n299), .y(n308) );
  inv_4x U306 ( .a(n315), .y(n306) );
  nand2_2x U307 ( .a(rd3[4]), .b(rd1[4]), .y(n315) );
  nor2_2x U308 ( .a(n280), .b(n279), .y(n303) );
  nand2_2x U309 ( .a(n355), .b(n296), .y(n302) );
  nand2_2x U310 ( .a(rd3[5]), .b(rd1[5]), .y(n298) );
  inv_4x U311 ( .a(wd[0]), .y(n45) );
  inv_4x U312 ( .a(wd[1]), .y(n44) );
  inv_4x U313 ( .a(wd[2]), .y(n43) );
  inv_4x U314 ( .a(wd[3]), .y(n42) );
  inv_4x U315 ( .a(wd[4]), .y(n41) );
  inv_4x U316 ( .a(wd[5]), .y(n40) );
  inv_4x U317 ( .a(wd[6]), .y(n39) );
  inv_4x U318 ( .a(wd[7]), .y(n38) );
  nand3_1x U319 ( .a(controller1_count_2_), .b(controller1_count_0_), .c(
        controller1_count_1_), .y(RWSelect) );
  nor3_1x U320 ( .a(reset), .b(addr[1]), .c(n368), .y(n203) );
  a2o1_1x U321 ( .a(addr[1]), .b(controller1_addr_flop_d2[0]), .c(n203), .y(
        controller1_addr_flop_d2[1]) );
  nor3_1x U322 ( .a(addr[2]), .b(n368), .c(n367), .y(disp_control_N3) );
  inv_1x U323 ( .a(n366), .y(n204) );
  nor2_1x U324 ( .a(disp_control_N3), .b(n204), .y(n205) );
  nor2_1x U325 ( .a(reset), .b(n205), .y(n206) );
  a2o1_1x U326 ( .a(addr[2]), .b(controller1_addr_flop_d2[0]), .c(n206), .y(
        controller1_addr_flop_d2[2]) );
  nand2_1x U327 ( .a(addr[2]), .b(addr[1]), .y(n365) );
  and2_1x U328 ( .a(disp_control_N7), .b(controller1_count_0_), .y(n208) );
  nor2_1x U329 ( .a(disp_control_N7), .b(controller1_count_0_), .y(n207) );
  nor3_1x U330 ( .a(reset), .b(n208), .c(n207), .y(
        controller1_count_flop_d2[0]) );
  nand3_1x U331 ( .a(disp_control_N7), .b(controller1_count_0_), .c(
        controller1_count_1_), .y(n211) );
  nor2_1x U332 ( .a(n208), .b(controller1_count_1_), .y(n209) );
  nor3_1x U333 ( .a(reset), .b(n210), .c(n209), .y(
        controller1_count_flop_d2[1]) );
  inv_1x U334 ( .a(controller1_count_2_), .y(n212) );
  mux2_c_1x U335 ( .d0(controller1_count_2_), .d1(n212), .s(n211), .y(n213) );
  or2_1x U336 ( .a(rd3[7]), .b(rd1[7]), .y(n217) );
  and2_1x U337 ( .a(n336), .b(n217), .y(n330) );
  mux2_c_1x U338 ( .d0(n234), .d1(n218), .s(n330), .y(n348) );
  nand2_1x U339 ( .a(n238), .b(n348), .y(n223) );
  nor2_1x U340 ( .a(n238), .b(n348), .y(n219) );
  fulladder U341 ( .a(rd2[1]), .b(rd2[7]), .c(n222), .cout(n228), .s(n221) );
  nand2_1x U342 ( .a(n240), .b(n223), .y(n227) );
  nand2_1x U343 ( .a(n234), .b(n330), .y(n224) );
  nand3_1x U344 ( .a(n241), .b(n336), .c(n224), .y(n358) );
  mux2_c_1x U345 ( .d0(n358), .d1(n357), .s(n225), .y(n226) );
  a2o1_1x U346 ( .a(n228), .b(n227), .c(n226), .y(n229) );
  nor3_1x U347 ( .a(n230), .b(n363), .c(n229), .y(new_r[0]) );
  or2_1x U348 ( .a(rd3[2]), .b(rd1[2]), .y(n231) );
  a2o1_1x U349 ( .a(n238), .b(n237), .c(n232), .y(n246) );
  nor2_1x U350 ( .a(n234), .b(n246), .y(n236) );
  inv_1x U351 ( .a(rd2[2]), .y(n233) );
  mux2_c_1x U352 ( .d0(n233), .d1(rd2[2]), .s(rd2[0]), .y(n242) );
  nand2_1x U353 ( .a(n262), .b(n238), .y(n239) );
  nand3_1x U354 ( .a(n269), .b(n240), .c(n239), .y(n253) );
  and2_1x U355 ( .a(n246), .b(n270), .y(n250) );
  nor2_1x U356 ( .a(n246), .b(n270), .y(n247) );
  fulladder U357 ( .a(rd2[3]), .b(rd2[1]), .c(n249), .cout(n256), .s(n248) );
  or2_1x U358 ( .a(n272), .b(n250), .y(n255) );
  mux2_c_1x U359 ( .d0(n253), .d1(n252), .s(n251), .y(n254) );
  a2o1_1x U360 ( .a(n256), .b(n255), .c(n254), .y(n257) );
  nor3_1x U361 ( .a(n259), .b(n258), .c(n257), .y(new_r[2]) );
  mux2_c_1x U362 ( .d0(n307), .d1(n261), .s(n270), .y(n281) );
  nor2_1x U363 ( .a(n262), .b(n281), .y(n263) );
  fulladder U364 ( .a(rd2[4]), .b(rd2[2]), .c(n267), .cout(n276), .s(n265) );
  and2_1x U365 ( .a(n307), .b(n270), .y(n271) );
  nor3_1x U366 ( .a(n306), .b(n272), .c(n271), .y(n288) );
  mux2_c_1x U367 ( .d0(n289), .d1(n288), .s(n273), .y(n274) );
  a2o1_1x U368 ( .a(n276), .b(n275), .c(n274), .y(n277) );
  nor3_1x U369 ( .a(n278), .b(n294), .c(n277), .y(new_r[3]) );
  nand2_1x U370 ( .a(n303), .b(n281), .y(n286) );
  nor2_1x U371 ( .a(n303), .b(n281), .y(n282) );
  fulladder U372 ( .a(rd2[5]), .b(rd2[3]), .c(n285), .cout(n292), .s(n284) );
  nand2_1x U373 ( .a(n298), .b(n286), .y(n291) );
  mux2_c_1x U374 ( .d0(n289), .d1(n288), .s(n287), .y(n290) );
  a2o1_1x U375 ( .a(n292), .b(n291), .c(n290), .y(n293) );
  nor3_1x U376 ( .a(n295), .b(n294), .c(n293), .y(new_r[4]) );
  or2_1x U377 ( .a(rd3[6]), .b(rd1[6]), .y(n296) );
  nand2_1x U378 ( .a(n349), .b(n303), .y(n297) );
  nand3_1x U379 ( .a(n355), .b(n298), .c(n297), .y(n314) );
  and2_1x U380 ( .a(rd2[6]), .b(rd2[4]), .y(n313) );
  nor2_1x U381 ( .a(rd2[6]), .b(rd2[4]), .y(n299) );
  nor2_1x U382 ( .a(n308), .b(rd2[5]), .y(n300) );
  nor3_1x U383 ( .a(n300), .b(n313), .c(n314), .y(n304) );
  a2o1_1x U384 ( .a(n303), .b(n302), .c(n301), .y(n331) );
  a2o1_1x U385 ( .a(n314), .b(n306), .c(n305), .y(n323) );
  nor2_1x U386 ( .a(n331), .b(n307), .y(n311) );
  nor3_1x U387 ( .a(n316), .b(n311), .c(n310), .y(n312) );
  a2o1_1x U388 ( .a(n311), .b(n310), .c(n312), .y(n321) );
  or2_1x U389 ( .a(n313), .b(n312), .y(n319) );
  nand2_1x U390 ( .a(n337), .b(n315), .y(n318) );
  nor3_1x U391 ( .a(n318), .b(n319), .c(n316), .y(n317) );
  a2o1_1x U392 ( .a(n319), .b(n318), .c(n317), .y(n320) );
  a2o1_1x U393 ( .a(n325), .b(n321), .c(n320), .y(n322) );
  nor3_1x U394 ( .a(n347), .b(n323), .c(n322), .y(new_r[5]) );
  and2_1x U395 ( .a(n331), .b(n330), .y(n338) );
  a2o1_1x U396 ( .a(n325), .b(n324), .c(n335), .y(n332) );
  nand3_1x U397 ( .a(n327), .b(n337), .c(n326), .y(n329) );
  nor2_1x U398 ( .a(n336), .b(n337), .y(n328) );
  a2o1_1x U399 ( .a(n338), .b(n329), .c(n328), .y(n346) );
  nor2_1x U400 ( .a(n331), .b(n330), .y(n333) );
  nor3_1x U401 ( .a(n338), .b(n333), .c(n332), .y(n334) );
  a2o1_1x U402 ( .a(n333), .b(n332), .c(n334), .y(n343) );
  or2_1x U403 ( .a(n335), .b(n334), .y(n341) );
  nor3_1x U404 ( .a(n340), .b(n341), .c(n338), .y(n339) );
  a2o1_1x U405 ( .a(n341), .b(n340), .c(n339), .y(n342) );
  a2o1_1x U406 ( .a(n344), .b(n343), .c(n342), .y(n345) );
  nor3_1x U407 ( .a(n347), .b(n346), .c(n345), .y(new_r[6]) );
  nor2_1x U408 ( .a(n349), .b(n348), .y(n350) );
  fulladder U409 ( .a(rd2[6]), .b(rd2[0]), .c(n353), .cout(n361), .s(n352) );
  mux2_c_1x U410 ( .d0(n358), .d1(n357), .s(n356), .y(n359) );
  a2o1_1x U411 ( .a(n361), .b(n360), .c(n359), .y(n362) );
  nor3_1x U412 ( .a(n364), .b(n363), .c(n362), .y(new_r[7]) );
  nor2_1x U413 ( .a(addr[0]), .b(n365), .y(disp_control_N6) );
  nor2_1x U414 ( .a(addr[0]), .b(n366), .y(disp_control_N4) );
  nor3_1x U415 ( .a(addr[0]), .b(addr[2]), .c(n367), .y(disp_control_N2) );
  nor3_1x U416 ( .a(addr[2]), .b(addr[1]), .c(n368), .y(disp_control_N1) );
  nor3_1x U417 ( .a(addr[0]), .b(addr[2]), .c(addr[1]), .y(disp_control_N0) );
endmodule

