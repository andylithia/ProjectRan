/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : O-2018.06-SP5-1
// Date      : Mon Nov 29 23:02:57 2021
/////////////////////////////////////////////////////////////


module FPALU ( clk, opcode, din_uni_a_sgn, din_uni_a_exp, din_uni_a_man_dn, 
        din_uni_b_sgn, din_uni_b_exp, din_uni_b_man_dn, dout_uni_y_sgn, 
        dout_uni_y_exp, dout_uni_y_man_dn );
  input [1:0] opcode;
  input [5:0] din_uni_a_exp;
  input [21:0] din_uni_a_man_dn;
  input [5:0] din_uni_b_exp;
  input [21:0] din_uni_b_man_dn;
  output [5:0] dout_uni_y_exp;
  output [21:0] dout_uni_y_man_dn;
  input clk, din_uni_a_sgn, din_uni_b_sgn;
  output dout_uni_y_sgn;
  wire   s2_sa_r, s2_ea_gte_eb_r, s2_addsubn_r, N110, s3_sa_r, s3_addsubn_r,
         s3_ea_gte_eb_r, s3_s2_r, s4_ea_gte_eb_r, s4_addsubn_r, s4_sa_r,
         s5_addsubn_r, s5_sa_r, s5_ea_gte_eb_r, N210, C43_DATA2_0, C43_DATA2_1,
         C43_DATA2_2, C43_DATA2_3, C43_DATA2_4, n561, n563, n570, n571, n572,
         n573, n574, n575, n576, n577, n578, n579, n580, n581, n582, n583,
         n584, n585, n586, n587, n588, n589, n590, n591, n592, n593, n594,
         n599, n600, n601, n602, n603, n604, n605, n606, n607, n608, n609,
         n610, n611, n612, n613, n614, n615, n616, n617, n618, n619, n620,
         n621, n622, n623, n624, n625, n626, n627, n628, n629, n630, n631,
         n632, n633, n634, n635, n636, n637, n638, n639, n640, n641, n642,
         n643, n644, n645, n646, n647, n648, n649, n650, n651, n652, n653,
         n654, n655, n656, n657, n658, n659, n660, n661, n662, n663, n664,
         n665, n666, n667, n668, n669, n671, U2_RSOP_134_C1_Z_4,
         U2_RSOP_134_C1_Z_3, U2_RSOP_134_C1_Z_2, U2_RSOP_134_C1_Z_1,
         U2_RSOP_134_C1_Z_0, DP_OP_155J1_125_6824_n43,
         DP_OP_155J1_125_6824_n42, DP_OP_155J1_125_6824_n41,
         DP_OP_155J1_125_6824_n40, DP_OP_155J1_125_6824_n39,
         DP_OP_155J1_125_6824_n37, DP_OP_155J1_125_6824_n36,
         DP_OP_155J1_125_6824_n35, DP_OP_155J1_125_6824_n34,
         DP_OP_155J1_125_6824_n33, DP_OP_155J1_125_6824_n28,
         DP_OP_155J1_125_6824_n27, DP_OP_155J1_125_6824_n26,
         DP_OP_155J1_125_6824_n25, DP_OP_155J1_125_6824_n24,
         DP_OP_155J1_125_6824_n21, DP_OP_155J1_125_6824_n20,
         DP_OP_155J1_125_6824_n19, DP_OP_155J1_125_6824_n18,
         DP_OP_155J1_125_6824_n17, DP_OP_155J1_125_6824_n16,
         DP_OP_155J1_125_6824_n15, DP_OP_155J1_125_6824_n14,
         DP_OP_155J1_125_6824_n13, DP_OP_155J1_125_6824_n12,
         DP_OP_155J1_125_6824_n11, DP_OP_155J1_125_6824_n10,
         DP_OP_155J1_125_6824_n6, DP_OP_155J1_125_6824_n5,
         DP_OP_155J1_125_6824_n4, DP_OP_155J1_125_6824_n3,
         DP_OP_155J1_125_6824_n2, intadd_0_A_14_, intadd_0_A_13_,
         intadd_0_A_12_, intadd_0_A_11_, intadd_0_A_10_, intadd_0_A_9_,
         intadd_0_A_8_, intadd_0_A_7_, intadd_0_A_6_, intadd_0_A_5_,
         intadd_0_A_4_, intadd_0_A_3_, intadd_0_A_2_, intadd_0_A_1_,
         intadd_0_B_13_, intadd_0_B_12_, intadd_0_B_11_, intadd_0_B_10_,
         intadd_0_B_9_, intadd_0_B_8_, intadd_0_B_7_, intadd_0_B_6_,
         intadd_0_B_5_, intadd_0_B_4_, intadd_0_B_3_, intadd_0_B_2_,
         intadd_0_B_1_, intadd_0_B_0_, intadd_0_CI, intadd_0_n15, intadd_0_n14,
         intadd_0_n13, intadd_0_n12, intadd_0_n11, intadd_0_n10, intadd_0_n9,
         intadd_0_n8, intadd_0_n7, intadd_0_n6, intadd_0_n5, intadd_0_n4,
         intadd_0_n3, intadd_0_n2, intadd_0_n1, intadd_1_A_12_, intadd_1_A_11_,
         intadd_1_A_10_, intadd_1_A_9_, intadd_1_A_8_, intadd_1_A_7_,
         intadd_1_A_6_, intadd_1_A_5_, intadd_1_A_4_, intadd_1_A_3_,
         intadd_1_A_2_, intadd_1_A_1_, intadd_1_A_0_, intadd_1_B_12_,
         intadd_1_B_11_, intadd_1_B_10_, intadd_1_B_9_, intadd_1_B_8_,
         intadd_1_B_7_, intadd_1_B_6_, intadd_1_B_5_, intadd_1_B_4_,
         intadd_1_B_3_, intadd_1_B_2_, intadd_1_B_1_, intadd_1_B_0_,
         intadd_1_CI, intadd_1_SUM_12_, intadd_1_SUM_11_, intadd_1_SUM_10_,
         intadd_1_SUM_9_, intadd_1_SUM_8_, intadd_1_SUM_7_, intadd_1_SUM_6_,
         intadd_1_SUM_5_, intadd_1_SUM_4_, intadd_1_SUM_3_, intadd_1_SUM_2_,
         intadd_1_SUM_1_, intadd_1_SUM_0_, intadd_1_n13, intadd_1_n12,
         intadd_1_n11, intadd_1_n10, intadd_1_n9, intadd_1_n8, intadd_1_n7,
         intadd_1_n6, intadd_1_n5, intadd_1_n4, intadd_1_n3, intadd_1_n2,
         intadd_1_n1, intadd_2_A_12_, intadd_2_A_11_, intadd_2_A_10_,
         intadd_2_A_9_, intadd_2_A_8_, intadd_2_A_7_, intadd_2_A_6_,
         intadd_2_A_5_, intadd_2_A_4_, intadd_2_A_3_, intadd_2_A_2_,
         intadd_2_A_1_, intadd_2_B_12_, intadd_2_B_11_, intadd_2_B_10_,
         intadd_2_B_9_, intadd_2_B_8_, intadd_2_B_7_, intadd_2_B_6_,
         intadd_2_B_5_, intadd_2_B_4_, intadd_2_B_3_, intadd_2_B_2_,
         intadd_2_B_1_, intadd_2_B_0_, intadd_2_CI, intadd_2_n13, intadd_2_n12,
         intadd_2_n11, intadd_2_n10, intadd_2_n9, intadd_2_n8, intadd_2_n7,
         intadd_2_n6, intadd_2_n5, intadd_2_n4, intadd_2_n3, intadd_2_n2,
         intadd_2_n1, intadd_3_B_3_, intadd_3_B_2_, intadd_3_B_1_,
         intadd_3_B_0_, intadd_3_CI, intadd_3_SUM_3_, intadd_3_SUM_2_,
         intadd_3_SUM_1_, intadd_3_SUM_0_, intadd_3_n4, intadd_3_n3,
         intadd_3_n2, intadd_3_n1, n672, n673, n674, n675, n676, n677, n678,
         n679, n680, n681, n682, n683, n684, n685, n686, n687, n688, n689,
         n690, n691, n692, n693, n694, n695, n696, n697, n698, n699, n700,
         n701, n702, n703, n704, n705, n706, n707, n708, n709, n710, n711,
         n712, n713, n714, n715, n716, n717, n718, n719, n720, n721, n722,
         n723, n724, n725, n726, n727, n728, n729, n730, n731, n732, n733,
         n734, n735, n736, n737, n738, n739, n740, n741, n742, n743, n744,
         n745, n746, n747, n748, n749, n750, n751, n752, n753, n754, n755,
         n756, n757, n758, n759, n760, n761, n762, n763, n764, n765, n766,
         n767, n768, n769, n770, n771, n772, n773, n774, n775, n776, n777,
         n778, n779, n780, n781, n782, n783, n784, n785, n786, n787, n788,
         n789, n790, n791, n792, n793, n794, n795, n796, n797, n798, n799,
         n800, n801, n802, n803, n804, n805, n806, n807, n808, n809, n810,
         n811, n812, n813, n814, n815, n816, n817, n818, n819, n820, n821,
         n822, n823, n824, n825, n826, n827, n828, n829, n830, n831, n832,
         n833, n834, n835, n836, n837, n838, n839, n840, n841, n842, n843,
         n844, n845, n846, n847, n848, n849, n850, n851, n852, n853, n854,
         n855, n856, n857, n858, n859, n860, n861, n862, n863, n864, n865,
         n866, n867, n868, n869, n870, n871, n872, n873, n874, n875, n876,
         n877, n878, n879, n880, n881, n882, n883, n884, n885, n886, n887,
         n888, n889, n890, n891, n892, n893, n894, n895, n896, n897, n898,
         n899, n900, n901, n902, n903, n904, n905, n906, n907, n908, n909,
         n910, n911, n912, n913, n914, n915, n916, n917, n918, n919, n920,
         n921, n922, n923, n924, n925, n926, n927, n928, n929, n930, n931,
         n932, n933, n934, n935, n936, n937, n938, n939, n940, n941, n942,
         n943, n944, n945, n946, n947, n948, n949, n950, n951, n952, n953,
         n954, n955, n956, n957, n958, n959, n960, n961, n962, n963, n964,
         n965, n966, n967, n968, n969, n970, n971, n972, n973, n974, n975,
         n976, n977, n978, n979, n980, n981, n982, n983, n984, n985, n986,
         n987, n988, n989, n990, n991, n992, n993, n994, n995, n996, n997,
         n998, n999, n1000, n1001, n1002, n1003, n1004, n1005, n1006, n1007,
         n1008, n1009, n1010, n1011, n1012, n1013, n1014, n1015, n1016, n1017,
         n1018, n1019, n1020, n1021, n1022, n1023, n1024, n1025, n1026, n1027,
         n1028, n1029, n1030, n1031, n1032, n1033, n1034, n1035, n1036, n1037,
         n1038, n1039, n1040, n1041, n1042, n1043, n1044, n1045, n1046, n1047,
         n1048, n1049, n1050, n1051, n1052, n1053, n1054, n1055, n1056, n1057,
         n1058, n1059, n1060, n1061, n1062, n1063, n1064, n1065, n1066, n1067,
         n1068, n1069, n1070, n1071, n1072, n1073, n1074, n1075, n1076, n1077,
         n1078, n1079, n1080, n1081, n1082, n1083, n1084, n1085, n1086, n1087,
         n1088, n1089, n1090, n1091, n1092, n1093, n1094, n1095, n1096, n1097,
         n1098, n1099, n1100, n1101, n1102, n1103, n1104, n1105, n1106, n1107,
         n1108, n1109, n1110, n1111, n1112, n1113, n1114, n1115, n1116, n1117,
         n1118, n1119, n1120, n1121, n1122, n1123, n1124, n1125, n1126, n1127,
         n1128, n1129, n1130, n1131, n1132, n1133, n1134, n1135, n1136, n1137,
         n1138, n1139, n1140, n1141, n1142, n1143, n1144, n1145, n1146, n1147,
         n1148, n1149, n1150, n1151, n1152, n1153, n1154, n1155, n1156, n1157,
         n1158, n1159, n1160, n1161, n1162, n1163, n1164, n1165, n1166, n1167,
         n1168, n1169, n1170, n1171, n1172, n1173, n1174, n1175, n1176, n1177,
         n1178, n1179, n1180, n1181, n1182, n1183, n1184, n1185, n1186, n1187,
         n1188, n1189, n1190, n1191, n1192, n1193, n1194, n1195, n1196, n1197,
         n1198, n1199, n1200, n1201, n1202, n1203, n1204, n1205, n1206, n1207,
         n1208, n1209, n1210, n1211, n1212, n1213, n1214, n1215, n1216, n1217,
         n1218, n1219, n1220, n1221, n1222, n1223, n1224, n1225, n1226, n1227,
         n1228, n1229, n1230, n1231, n1232, n1233, n1234, n1235, n1236, n1237,
         n1238, n1239, n1240, n1241, n1242, n1243, n1244, n1245, n1246, n1247,
         n1248, n1249, n1250, n1251, n1252, n1253, n1254, n1255, n1256, n1257,
         n1258, n1259, n1260, n1261, n1262, n1263, n1264, n1265, n1266, n1267,
         n1268, n1269, n1270, n1271, n1272, n1273, n1274, n1275, n1276, n1277,
         n1278, n1279, n1280, n1281, n1282, n1283, n1284, n1285, n1286, n1287,
         n1288, n1289, n1290, n1291, n1292, n1293, n1294, n1295, n1296, n1297,
         n1298, n1299, n1300, n1301, n1302, n1303, n1304, n1305, n1306, n1307,
         n1308, n1309, n1310, n1311, n1312, n1313, n1314, n1315, n1316, n1317,
         n1318, n1319, n1320, n1321, n1322, n1323, n1324, n1325, n1326, n1327,
         n1328, n1329, n1330, n1331, n1332, n1333, n1334, n1335, n1336, n1337,
         n1338, n1339, n1340, n1341, n1342, n1343, n1344, n1345, n1346, n1347,
         n1348, n1349, n1350, n1351, n1352, n1353, n1354, n1355, n1356, n1357,
         n1358, n1359, n1360, n1361, n1362, n1363, n1364, n1365, n1366, n1367,
         n1368, n1369, n1370, n1371, n1372, n1373, n1374, n1375, n1376, n1377,
         n1378, n1379, n1380, n1381, n1382, n1383, n1384, n1385, n1386, n1387,
         n1388, n1389, n1390, n1391, n1392, n1393, n1394, n1395, n1396, n1397,
         n1398, n1399, n1400, n1401, n1402, n1403, n1404, n1405, n1406, n1407,
         n1408, n1409, n1410, n1411, n1412, n1413, n1414, n1415, n1416, n1417,
         n1418, n1419, n1420, n1421, n1422, n1423, n1424, n1425, n1426, n1427,
         n1428, n1429, n1430, n1431, n1432, n1433, n1434, n1435, n1436, n1437,
         n1438, n1439, n1440, n1441, n1442, n1443, n1444, n1445, n1446, n1447,
         n1448, n1449, n1450, n1451, n1452, n1453, n1454, n1455, n1456, n1457,
         n1458, n1459, n1460, n1461, n1462, n1463, n1464, n1465, n1466, n1467,
         n1468, n1469, n1470, n1471, n1472, n1473, n1474, n1475, n1476, n1477,
         n1478, n1479, n1480, n1481, n1482, n1483, n1484, n1485, n1486, n1487,
         n1488, n1489, n1490, n1491, n1492, n1493, n1494, n1495, n1496, n1497,
         n1498, n1499, n1500, n1501, n1502, n1503, n1504, n1505, n1506, n1507,
         n1508, n1509, n1510, n1511, n1512, n1513, n1514, n1515, n1516, n1517,
         n1518, n1519, n1520, n1521, n1522, n1523, n1524, n1525, n1526, n1527,
         n1528, n1529, n1530, n1531, n1532, n1533, n1534, n1535, n1536, n1537,
         n1538, n1539, n1540, n1541, n1542, n1543, n1544, n1545, n1546, n1547,
         n1548, n1549, n1550, n1551, n1552, n1553, n1554, n1555, n1556, n1557,
         n1558, n1559, n1560, n1561, n1562, n1563, n1564, n1565, n1566, n1567,
         n1568, n1569, n1570, n1571, n1572, n1573, n1574, n1575, n1576, n1577,
         n1578, n1579, n1580, n1581, n1582, n1583, n1584, n1585, n1586, n1587,
         n1588, n1589, n1590, n1591, n1592, n1593, n1594, n1595, n1596, n1597,
         n1598, n1599, n1600, n1601, n1602, n1603, n1604, n1605, n1606, n1607,
         n1608, n1609, n1610, n1611, n1612, n1613, n1614, n1615, n1616, n1617,
         n1618, n1619, n1620, n1621, n1622, n1623, n1624, n1625, n1626, n1627,
         n1628, n1629, n1630, n1631, n1632, n1633, n1634, n1635, n1636, n1637,
         n1638, n1639, n1640, n1641, n1642, n1643, n1644, n1645, n1646, n1647,
         n1648, n1649, n1650, n1651, n1652, n1653, n1654, n1655, n1656, n1657,
         n1658, n1659, n1660, n1661, n1662, n1663, n1664, n1665, n1666, n1667,
         n1668, n1669, n1670, n1671, n1672, n1673, n1674, n1675, n1676, n1677,
         n1678, n1679, n1680, n1681;
  wire   [5:0] s1_ea_sub_eb_abs;
  wire   [21:0] s1_mmux_lhs;
  wire   [21:0] s1_mmux_rhs;
  wire   [71:60] s1_br4_pp;
  wire   [1:0] s2_opcode_r;
  wire   [5:0] s2_expa_r;
  wire   [5:0] s2_expb_r;
  wire   [5:0] s2_ea_sub_eb_abs_r;
  wire   [21:0] s2_mmux_lhs_r;
  wire   [21:0] s2_mmux_rhs_r;
  wire   [21:0] s2_mmux3_rhs_addsub;
  wire   [21:0] s2_mmux3_lhs_addsub;
  wire   [71:0] s2_br4_pp_r;
  wire   [4:0] s2_br4_s_r;
  wire   [17:0] s2_ps0;
  wire   [15:0] s2_ps1;
  wire   [1:0] s3_opcode_r;
  wire   [5:0] s3_expa_r;
  wire   [5:0] s3_expb_r;
  wire   [21:0] s3_lhs_r;
  wire   [22:0] s3_rhs_r;
  wire   [18:0] s3_ps0_r;
  wire   [15:0] s3_ps1_r;
  wire   [22:0] s3_mmux_y;
  wire   [22:0] s4_many_r;
  wire   [1:0] s4_opcode_r;
  wire   [5:0] s4_ea_r;
  wire   [5:0] s4_eb_r;
  wire   [1:0] s5_opcode_r;
  wire   [22:0] s5_many_r;
  wire   [4:0] s5_lzd_r;
  wire   [5:0] s5_ea_r;
  wire   [5:0] s5_eb_r;

  DFFQX1TS s2_sa_r_reg ( .D(din_uni_a_sgn), .CK(clk), .Q(s2_sa_r) );
  DFFQX1TS s2_opcode_r_reg_1_ ( .D(opcode[1]), .CK(clk), .Q(s2_opcode_r[1]) );
  DFFQX1TS s2_expb_r_reg_5_ ( .D(n563), .CK(clk), .Q(s2_expb_r[5]) );
  DFFQX1TS s2_expa_r_reg_5_ ( .D(n561), .CK(clk), .Q(s2_expa_r[5]) );
  DFFQX1TS s2_ea_sub_eb_abs_r_reg_5_ ( .D(s1_ea_sub_eb_abs[5]), .CK(clk), .Q(
        s2_ea_sub_eb_abs_r[5]) );
  DFFQX1TS s2_ea_sub_eb_abs_r_reg_4_ ( .D(s1_ea_sub_eb_abs[4]), .CK(clk), .Q(
        s2_ea_sub_eb_abs_r[4]) );
  DFFQX1TS s2_ea_sub_eb_abs_r_reg_3_ ( .D(s1_ea_sub_eb_abs[3]), .CK(clk), .Q(
        s2_ea_sub_eb_abs_r[3]) );
  DFFQX1TS s2_ea_sub_eb_abs_r_reg_2_ ( .D(s1_ea_sub_eb_abs[2]), .CK(clk), .Q(
        s2_ea_sub_eb_abs_r[2]) );
  DFFQX1TS s2_ea_sub_eb_abs_r_reg_1_ ( .D(s1_ea_sub_eb_abs[1]), .CK(clk), .Q(
        s2_ea_sub_eb_abs_r[1]) );
  DFFQX1TS s2_ea_sub_eb_abs_r_reg_0_ ( .D(s1_ea_sub_eb_abs[0]), .CK(clk), .Q(
        s2_ea_sub_eb_abs_r[0]) );
  DFFQX1TS s2_ea_gte_eb_r_reg ( .D(n1676), .CK(clk), .Q(s2_ea_gte_eb_r) );
  DFFQX1TS s2_mmux_lhs_r_reg_21_ ( .D(s1_mmux_lhs[21]), .CK(clk), .Q(
        s2_mmux_lhs_r[21]) );
  DFFQX1TS s2_mmux_lhs_r_reg_20_ ( .D(s1_mmux_lhs[20]), .CK(clk), .Q(
        s2_mmux_lhs_r[20]) );
  DFFQX1TS s2_mmux_lhs_r_reg_19_ ( .D(s1_mmux_lhs[19]), .CK(clk), .Q(
        s2_mmux_lhs_r[19]) );
  DFFQX1TS s2_mmux_lhs_r_reg_18_ ( .D(s1_mmux_lhs[18]), .CK(clk), .Q(
        s2_mmux_lhs_r[18]) );
  DFFQX1TS s2_mmux_lhs_r_reg_17_ ( .D(s1_mmux_lhs[17]), .CK(clk), .Q(
        s2_mmux_lhs_r[17]) );
  DFFQX1TS s2_mmux_lhs_r_reg_16_ ( .D(s1_mmux_lhs[16]), .CK(clk), .Q(
        s2_mmux_lhs_r[16]) );
  DFFQX1TS s2_mmux_lhs_r_reg_15_ ( .D(s1_mmux_lhs[15]), .CK(clk), .Q(
        s2_mmux_lhs_r[15]) );
  DFFQX1TS s2_mmux_lhs_r_reg_14_ ( .D(s1_mmux_lhs[14]), .CK(clk), .Q(
        s2_mmux_lhs_r[14]) );
  DFFQX1TS s2_mmux_lhs_r_reg_13_ ( .D(s1_mmux_lhs[13]), .CK(clk), .Q(
        s2_mmux_lhs_r[13]) );
  DFFQX1TS s2_mmux_lhs_r_reg_12_ ( .D(s1_mmux_lhs[12]), .CK(clk), .Q(
        s2_mmux_lhs_r[12]) );
  DFFQX1TS s2_mmux_lhs_r_reg_11_ ( .D(s1_mmux_lhs[11]), .CK(clk), .Q(
        s2_mmux_lhs_r[11]) );
  DFFQX1TS s2_mmux_lhs_r_reg_10_ ( .D(s1_mmux_lhs[10]), .CK(clk), .Q(
        s2_mmux_lhs_r[10]) );
  DFFQX1TS s2_mmux_lhs_r_reg_9_ ( .D(s1_mmux_lhs[9]), .CK(clk), .Q(
        s2_mmux_lhs_r[9]) );
  DFFQX1TS s2_mmux_lhs_r_reg_8_ ( .D(s1_mmux_lhs[8]), .CK(clk), .Q(
        s2_mmux_lhs_r[8]) );
  DFFQX1TS s2_mmux_lhs_r_reg_7_ ( .D(s1_mmux_lhs[7]), .CK(clk), .Q(
        s2_mmux_lhs_r[7]) );
  DFFQX1TS s2_mmux_lhs_r_reg_6_ ( .D(s1_mmux_lhs[6]), .CK(clk), .Q(
        s2_mmux_lhs_r[6]) );
  DFFQX1TS s2_mmux_lhs_r_reg_5_ ( .D(s1_mmux_lhs[5]), .CK(clk), .Q(
        s2_mmux_lhs_r[5]) );
  DFFQX1TS s2_mmux_lhs_r_reg_4_ ( .D(s1_mmux_lhs[4]), .CK(clk), .Q(
        s2_mmux_lhs_r[4]) );
  DFFQX1TS s2_mmux_lhs_r_reg_3_ ( .D(s1_mmux_lhs[3]), .CK(clk), .Q(
        s2_mmux_lhs_r[3]) );
  DFFQX1TS s2_mmux_lhs_r_reg_2_ ( .D(s1_mmux_lhs[2]), .CK(clk), .Q(
        s2_mmux_lhs_r[2]) );
  DFFQX1TS s2_mmux_lhs_r_reg_1_ ( .D(s1_mmux_lhs[1]), .CK(clk), .Q(
        s2_mmux_lhs_r[1]) );
  DFFQX1TS s2_mmux_lhs_r_reg_0_ ( .D(s1_mmux_lhs[0]), .CK(clk), .Q(
        s2_mmux_lhs_r[0]) );
  DFFQX1TS s2_mmux_rhs_r_reg_21_ ( .D(s1_mmux_rhs[21]), .CK(clk), .Q(
        s2_mmux_rhs_r[21]) );
  DFFQX1TS s2_mmux_rhs_r_reg_20_ ( .D(s1_mmux_rhs[20]), .CK(clk), .Q(
        s2_mmux_rhs_r[20]) );
  DFFQX1TS s2_mmux_rhs_r_reg_19_ ( .D(s1_mmux_rhs[19]), .CK(clk), .Q(
        s2_mmux_rhs_r[19]) );
  DFFQX1TS s2_mmux_rhs_r_reg_18_ ( .D(s1_mmux_rhs[18]), .CK(clk), .Q(
        s2_mmux_rhs_r[18]) );
  DFFQX1TS s2_mmux_rhs_r_reg_17_ ( .D(s1_mmux_rhs[17]), .CK(clk), .Q(
        s2_mmux_rhs_r[17]) );
  DFFQX1TS s2_mmux_rhs_r_reg_16_ ( .D(s1_mmux_rhs[16]), .CK(clk), .Q(
        s2_mmux_rhs_r[16]) );
  DFFQX1TS s2_mmux_rhs_r_reg_15_ ( .D(s1_mmux_rhs[15]), .CK(clk), .Q(
        s2_mmux_rhs_r[15]) );
  DFFQX1TS s2_mmux_rhs_r_reg_14_ ( .D(s1_mmux_rhs[14]), .CK(clk), .Q(
        s2_mmux_rhs_r[14]) );
  DFFQX1TS s2_mmux_rhs_r_reg_13_ ( .D(s1_mmux_rhs[13]), .CK(clk), .Q(
        s2_mmux_rhs_r[13]) );
  DFFQX1TS s2_mmux_rhs_r_reg_12_ ( .D(s1_mmux_rhs[12]), .CK(clk), .Q(
        s2_mmux_rhs_r[12]) );
  DFFQX1TS s2_mmux_rhs_r_reg_11_ ( .D(s1_mmux_rhs[11]), .CK(clk), .Q(
        s2_mmux_rhs_r[11]) );
  DFFQX1TS s2_mmux_rhs_r_reg_10_ ( .D(s1_mmux_rhs[10]), .CK(clk), .Q(
        s2_mmux_rhs_r[10]) );
  DFFQX1TS s2_mmux_rhs_r_reg_9_ ( .D(s1_mmux_rhs[9]), .CK(clk), .Q(
        s2_mmux_rhs_r[9]) );
  DFFQX1TS s2_mmux_rhs_r_reg_8_ ( .D(s1_mmux_rhs[8]), .CK(clk), .Q(
        s2_mmux_rhs_r[8]) );
  DFFQX1TS s2_mmux_rhs_r_reg_7_ ( .D(s1_mmux_rhs[7]), .CK(clk), .Q(
        s2_mmux_rhs_r[7]) );
  DFFQX1TS s2_mmux_rhs_r_reg_6_ ( .D(s1_mmux_rhs[6]), .CK(clk), .Q(
        s2_mmux_rhs_r[6]) );
  DFFQX1TS s2_mmux_rhs_r_reg_5_ ( .D(s1_mmux_rhs[5]), .CK(clk), .Q(
        s2_mmux_rhs_r[5]) );
  DFFQX1TS s2_mmux_rhs_r_reg_4_ ( .D(s1_mmux_rhs[4]), .CK(clk), .Q(
        s2_mmux_rhs_r[4]) );
  DFFQX1TS s2_mmux_rhs_r_reg_3_ ( .D(s1_mmux_rhs[3]), .CK(clk), .Q(
        s2_mmux_rhs_r[3]) );
  DFFQX1TS s2_mmux_rhs_r_reg_2_ ( .D(s1_mmux_rhs[2]), .CK(clk), .Q(
        s2_mmux_rhs_r[2]) );
  DFFQX1TS s2_mmux_rhs_r_reg_1_ ( .D(s1_mmux_rhs[1]), .CK(clk), .Q(
        s2_mmux_rhs_r[1]) );
  DFFQX1TS s2_mmux_rhs_r_reg_0_ ( .D(s1_mmux_rhs[0]), .CK(clk), .Q(
        s2_mmux_rhs_r[0]) );
  DFFQX1TS s2_addsubn_r_reg ( .D(n669), .CK(clk), .Q(s2_addsubn_r) );
  DFFQX1TS s2_br4_pp_r_reg_71_ ( .D(s1_br4_pp[71]), .CK(clk), .Q(
        s2_br4_pp_r[71]) );
  DFFQX1TS s2_br4_pp_r_reg_70_ ( .D(n600), .CK(clk), .Q(s2_br4_pp_r[70]) );
  DFFQX1TS s2_br4_pp_r_reg_69_ ( .D(n611), .CK(clk), .Q(s2_br4_pp_r[69]) );
  DFFQX1TS s2_br4_pp_r_reg_68_ ( .D(n617), .CK(clk), .Q(s2_br4_pp_r[68]) );
  DFFQX1TS s2_br4_pp_r_reg_67_ ( .D(n623), .CK(clk), .Q(s2_br4_pp_r[67]) );
  DFFQX1TS s2_br4_pp_r_reg_66_ ( .D(n629), .CK(clk), .Q(s2_br4_pp_r[66]) );
  DFFQX1TS s2_br4_pp_r_reg_65_ ( .D(n635), .CK(clk), .Q(s2_br4_pp_r[65]) );
  DFFQX1TS s2_br4_pp_r_reg_64_ ( .D(n641), .CK(clk), .Q(s2_br4_pp_r[64]) );
  DFFQX1TS s2_br4_pp_r_reg_63_ ( .D(n647), .CK(clk), .Q(s2_br4_pp_r[63]) );
  DFFQX1TS s2_br4_pp_r_reg_62_ ( .D(n653), .CK(clk), .Q(s2_br4_pp_r[62]) );
  DFFQX1TS s2_br4_pp_r_reg_61_ ( .D(n659), .CK(clk), .Q(s2_br4_pp_r[61]) );
  DFFQX1TS s2_br4_pp_r_reg_60_ ( .D(s1_br4_pp[60]), .CK(clk), .Q(
        s2_br4_pp_r[60]) );
  DFFQX1TS s2_br4_pp_r_reg_59_ ( .D(n608), .CK(clk), .Q(s2_br4_pp_r[59]) );
  DFFQX1TS s2_br4_pp_r_reg_58_ ( .D(n607), .CK(clk), .Q(s2_br4_pp_r[58]) );
  DFFQX1TS s2_br4_pp_r_reg_57_ ( .D(n615), .CK(clk), .Q(s2_br4_pp_r[57]) );
  DFFQX1TS s2_br4_pp_r_reg_56_ ( .D(n621), .CK(clk), .Q(s2_br4_pp_r[56]) );
  DFFQX1TS s2_br4_pp_r_reg_55_ ( .D(n627), .CK(clk), .Q(s2_br4_pp_r[55]) );
  DFFQX1TS s2_br4_pp_r_reg_54_ ( .D(n633), .CK(clk), .Q(s2_br4_pp_r[54]) );
  DFFQX1TS s2_br4_pp_r_reg_53_ ( .D(n639), .CK(clk), .Q(s2_br4_pp_r[53]) );
  DFFQX1TS s2_br4_pp_r_reg_52_ ( .D(n645), .CK(clk), .Q(s2_br4_pp_r[52]) );
  DFFQX1TS s2_br4_pp_r_reg_51_ ( .D(n651), .CK(clk), .Q(s2_br4_pp_r[51]) );
  DFFQX1TS s2_br4_pp_r_reg_50_ ( .D(n657), .CK(clk), .Q(s2_br4_pp_r[50]) );
  DFFQX1TS s2_br4_pp_r_reg_49_ ( .D(n663), .CK(clk), .Q(s2_br4_pp_r[49]) );
  DFFQX1TS s2_br4_pp_r_reg_48_ ( .D(n668), .CK(clk), .Q(s2_br4_pp_r[48]) );
  DFFQX1TS s2_br4_pp_r_reg_47_ ( .D(n606), .CK(clk), .Q(s2_br4_pp_r[47]) );
  DFFQX1TS s2_br4_pp_r_reg_46_ ( .D(n605), .CK(clk), .Q(s2_br4_pp_r[46]) );
  DFFQX1TS s2_br4_pp_r_reg_45_ ( .D(n614), .CK(clk), .Q(s2_br4_pp_r[45]) );
  DFFQX1TS s2_br4_pp_r_reg_44_ ( .D(n620), .CK(clk), .Q(s2_br4_pp_r[44]) );
  DFFQX1TS s2_br4_pp_r_reg_43_ ( .D(n626), .CK(clk), .Q(s2_br4_pp_r[43]) );
  DFFQX1TS s2_br4_pp_r_reg_42_ ( .D(n632), .CK(clk), .Q(s2_br4_pp_r[42]) );
  DFFQX1TS s2_br4_pp_r_reg_41_ ( .D(n638), .CK(clk), .Q(s2_br4_pp_r[41]) );
  DFFQX1TS s2_br4_pp_r_reg_40_ ( .D(n644), .CK(clk), .Q(s2_br4_pp_r[40]) );
  DFFQX1TS s2_br4_pp_r_reg_39_ ( .D(n650), .CK(clk), .Q(s2_br4_pp_r[39]) );
  DFFQX1TS s2_br4_pp_r_reg_38_ ( .D(n656), .CK(clk), .Q(s2_br4_pp_r[38]) );
  DFFQX1TS s2_br4_pp_r_reg_37_ ( .D(n662), .CK(clk), .Q(s2_br4_pp_r[37]) );
  DFFQX1TS s2_br4_pp_r_reg_36_ ( .D(n667), .CK(clk), .Q(s2_br4_pp_r[36]) );
  DFFQX1TS s2_br4_pp_r_reg_35_ ( .D(n604), .CK(clk), .Q(s2_br4_pp_r[35]) );
  DFFQX1TS s2_br4_pp_r_reg_34_ ( .D(n603), .CK(clk), .Q(s2_br4_pp_r[34]) );
  DFFQX1TS s2_br4_pp_r_reg_33_ ( .D(n613), .CK(clk), .Q(s2_br4_pp_r[33]) );
  DFFQX1TS s2_br4_pp_r_reg_32_ ( .D(n619), .CK(clk), .Q(s2_br4_pp_r[32]) );
  DFFQX1TS s2_br4_pp_r_reg_31_ ( .D(n625), .CK(clk), .Q(s2_br4_pp_r[31]) );
  DFFQX1TS s2_br4_pp_r_reg_30_ ( .D(n631), .CK(clk), .Q(s2_br4_pp_r[30]) );
  DFFQX1TS s2_br4_pp_r_reg_29_ ( .D(n637), .CK(clk), .Q(s2_br4_pp_r[29]) );
  DFFQX1TS s2_br4_pp_r_reg_28_ ( .D(n643), .CK(clk), .Q(s2_br4_pp_r[28]) );
  DFFQX1TS s2_br4_pp_r_reg_27_ ( .D(n649), .CK(clk), .Q(s2_br4_pp_r[27]) );
  DFFQX1TS s2_br4_pp_r_reg_26_ ( .D(n655), .CK(clk), .Q(s2_br4_pp_r[26]) );
  DFFQX1TS s2_br4_pp_r_reg_25_ ( .D(n661), .CK(clk), .Q(s2_br4_pp_r[25]) );
  DFFQX1TS s2_br4_pp_r_reg_24_ ( .D(n666), .CK(clk), .Q(s2_br4_pp_r[24]) );
  DFFQX1TS s2_br4_pp_r_reg_23_ ( .D(n602), .CK(clk), .Q(s2_br4_pp_r[23]) );
  DFFQX1TS s2_br4_pp_r_reg_22_ ( .D(n601), .CK(clk), .Q(s2_br4_pp_r[22]) );
  DFFQX1TS s2_br4_pp_r_reg_21_ ( .D(n612), .CK(clk), .Q(s2_br4_pp_r[21]) );
  DFFQX1TS s2_br4_pp_r_reg_20_ ( .D(n618), .CK(clk), .Q(s2_br4_pp_r[20]) );
  DFFQX1TS s2_br4_pp_r_reg_19_ ( .D(n624), .CK(clk), .Q(s2_br4_pp_r[19]) );
  DFFQX1TS s2_br4_pp_r_reg_18_ ( .D(n630), .CK(clk), .Q(s2_br4_pp_r[18]) );
  DFFQX1TS s2_br4_pp_r_reg_17_ ( .D(n636), .CK(clk), .Q(s2_br4_pp_r[17]) );
  DFFQX1TS s2_br4_pp_r_reg_16_ ( .D(n642), .CK(clk), .Q(s2_br4_pp_r[16]) );
  DFFQX1TS s2_br4_pp_r_reg_15_ ( .D(n648), .CK(clk), .Q(s2_br4_pp_r[15]) );
  DFFQX1TS s2_br4_pp_r_reg_14_ ( .D(n654), .CK(clk), .Q(s2_br4_pp_r[14]) );
  DFFQX1TS s2_br4_pp_r_reg_13_ ( .D(n660), .CK(clk), .Q(s2_br4_pp_r[13]) );
  DFFQX1TS s2_br4_pp_r_reg_12_ ( .D(n665), .CK(clk), .Q(s2_br4_pp_r[12]) );
  DFFQX1TS s2_br4_pp_r_reg_11_ ( .D(n609), .CK(clk), .Q(s2_br4_pp_r[11]) );
  DFFQX1TS s2_br4_pp_r_reg_10_ ( .D(n599), .CK(clk), .Q(s2_br4_pp_r[10]) );
  DFFQX1TS s2_br4_pp_r_reg_9_ ( .D(n610), .CK(clk), .Q(s2_br4_pp_r[9]) );
  DFFQX1TS s2_br4_pp_r_reg_8_ ( .D(n616), .CK(clk), .Q(s2_br4_pp_r[8]) );
  DFFQX1TS s2_br4_pp_r_reg_7_ ( .D(n622), .CK(clk), .Q(s2_br4_pp_r[7]) );
  DFFQX1TS s2_br4_pp_r_reg_6_ ( .D(n628), .CK(clk), .Q(s2_br4_pp_r[6]) );
  DFFQX1TS s2_br4_pp_r_reg_5_ ( .D(n634), .CK(clk), .Q(s2_br4_pp_r[5]) );
  DFFQX1TS s2_br4_pp_r_reg_4_ ( .D(n640), .CK(clk), .Q(s2_br4_pp_r[4]) );
  DFFQX1TS s2_br4_pp_r_reg_3_ ( .D(n646), .CK(clk), .Q(s2_br4_pp_r[3]) );
  DFFQX1TS s2_br4_pp_r_reg_2_ ( .D(n652), .CK(clk), .Q(s2_br4_pp_r[2]) );
  DFFQX1TS s2_br4_pp_r_reg_1_ ( .D(n658), .CK(clk), .Q(s2_br4_pp_r[1]) );
  DFFQX1TS s2_br4_pp_r_reg_0_ ( .D(n664), .CK(clk), .Q(s2_br4_pp_r[0]) );
  DFFQX1TS s2_br4_s_r_reg_4_ ( .D(din_uni_b_man_dn[9]), .CK(clk), .Q(
        s2_br4_s_r[4]) );
  DFFQX1TS s2_br4_s_r_reg_3_ ( .D(n1010), .CK(clk), .Q(s2_br4_s_r[3]) );
  DFFQX1TS s2_br4_s_r_reg_2_ ( .D(n1007), .CK(clk), .Q(s2_br4_s_r[2]) );
  DFFQX1TS s2_br4_s_r_reg_1_ ( .D(n1013), .CK(clk), .Q(s2_br4_s_r[1]) );
  DFFQX1TS s2_br4_s_r_reg_0_ ( .D(din_uni_b_man_dn[1]), .CK(clk), .Q(
        s2_br4_s_r[0]) );
  DFFQX1TS s3_sa_r_reg ( .D(s2_sa_r), .CK(clk), .Q(s3_sa_r) );
  DFFQX1TS s3_opcode_r_reg_1_ ( .D(N110), .CK(clk), .Q(s3_opcode_r[1]) );
  DFFQX1TS s3_opcode_r_reg_0_ ( .D(s2_opcode_r[0]), .CK(clk), .Q(
        s3_opcode_r[0]) );
  DFFQX1TS s3_expa_r_reg_5_ ( .D(s2_expa_r[5]), .CK(clk), .Q(s3_expa_r[5]) );
  DFFQX1TS s3_expa_r_reg_4_ ( .D(s2_expa_r[4]), .CK(clk), .Q(s3_expa_r[4]) );
  DFFQX1TS s3_expa_r_reg_3_ ( .D(s2_expa_r[3]), .CK(clk), .Q(s3_expa_r[3]) );
  DFFQX1TS s3_expa_r_reg_2_ ( .D(s2_expa_r[2]), .CK(clk), .Q(s3_expa_r[2]) );
  DFFQX1TS s3_expa_r_reg_1_ ( .D(s2_expa_r[1]), .CK(clk), .Q(s3_expa_r[1]) );
  DFFQX1TS s3_expa_r_reg_0_ ( .D(s2_expa_r[0]), .CK(clk), .Q(s3_expa_r[0]) );
  DFFQX1TS s3_expb_r_reg_5_ ( .D(s2_expb_r[5]), .CK(clk), .Q(s3_expb_r[5]) );
  DFFQX1TS s3_expb_r_reg_4_ ( .D(s2_expb_r[4]), .CK(clk), .Q(s3_expb_r[4]) );
  DFFQX1TS s3_expb_r_reg_3_ ( .D(s2_expb_r[3]), .CK(clk), .Q(s3_expb_r[3]) );
  DFFQX1TS s3_expb_r_reg_2_ ( .D(s2_expb_r[2]), .CK(clk), .Q(s3_expb_r[2]) );
  DFFQX1TS s3_expb_r_reg_1_ ( .D(s2_expb_r[1]), .CK(clk), .Q(s3_expb_r[1]) );
  DFFQX1TS s3_expb_r_reg_0_ ( .D(s2_expb_r[0]), .CK(clk), .Q(s3_expb_r[0]) );
  DFFQX1TS s3_lhs_r_reg_21_ ( .D(s2_mmux3_lhs_addsub[21]), .CK(clk), .Q(
        s3_lhs_r[21]) );
  DFFQX1TS s3_lhs_r_reg_20_ ( .D(s2_mmux3_lhs_addsub[20]), .CK(clk), .Q(
        s3_lhs_r[20]) );
  DFFQX1TS s3_lhs_r_reg_19_ ( .D(s2_mmux3_lhs_addsub[19]), .CK(clk), .Q(
        s3_lhs_r[19]) );
  DFFQX1TS s3_lhs_r_reg_18_ ( .D(s2_mmux3_lhs_addsub[18]), .CK(clk), .Q(
        s3_lhs_r[18]) );
  DFFQX1TS s3_lhs_r_reg_17_ ( .D(s2_mmux3_lhs_addsub[17]), .CK(clk), .Q(
        s3_lhs_r[17]) );
  DFFQX1TS s3_lhs_r_reg_16_ ( .D(s2_mmux3_lhs_addsub[16]), .CK(clk), .Q(
        s3_lhs_r[16]) );
  DFFQX1TS s3_lhs_r_reg_15_ ( .D(s2_mmux3_lhs_addsub[15]), .CK(clk), .Q(
        s3_lhs_r[15]) );
  DFFQX1TS s3_lhs_r_reg_14_ ( .D(s2_mmux3_lhs_addsub[14]), .CK(clk), .Q(
        s3_lhs_r[14]) );
  DFFQX1TS s3_lhs_r_reg_13_ ( .D(s2_mmux3_lhs_addsub[13]), .CK(clk), .Q(
        s3_lhs_r[13]) );
  DFFQX1TS s3_lhs_r_reg_12_ ( .D(s2_mmux3_lhs_addsub[12]), .CK(clk), .Q(
        s3_lhs_r[12]) );
  DFFQX1TS s3_lhs_r_reg_11_ ( .D(s2_mmux3_lhs_addsub[11]), .CK(clk), .Q(
        s3_lhs_r[11]) );
  DFFQX1TS s3_lhs_r_reg_10_ ( .D(s2_mmux3_lhs_addsub[10]), .CK(clk), .Q(
        s3_lhs_r[10]) );
  DFFQX1TS s3_lhs_r_reg_9_ ( .D(s2_mmux3_lhs_addsub[9]), .CK(clk), .Q(
        s3_lhs_r[9]) );
  DFFQX1TS s3_lhs_r_reg_8_ ( .D(s2_mmux3_lhs_addsub[8]), .CK(clk), .Q(
        s3_lhs_r[8]) );
  DFFQX1TS s3_lhs_r_reg_7_ ( .D(s2_mmux3_lhs_addsub[7]), .CK(clk), .Q(
        s3_lhs_r[7]) );
  DFFQX1TS s3_lhs_r_reg_6_ ( .D(s2_mmux3_lhs_addsub[6]), .CK(clk), .Q(
        s3_lhs_r[6]) );
  DFFQX1TS s3_lhs_r_reg_5_ ( .D(s2_mmux3_lhs_addsub[5]), .CK(clk), .Q(
        s3_lhs_r[5]) );
  DFFQX1TS s3_lhs_r_reg_4_ ( .D(s2_mmux3_lhs_addsub[4]), .CK(clk), .Q(
        s3_lhs_r[4]) );
  DFFQX1TS s3_lhs_r_reg_3_ ( .D(s2_mmux3_lhs_addsub[3]), .CK(clk), .Q(
        s3_lhs_r[3]) );
  DFFQX1TS s3_lhs_r_reg_2_ ( .D(s2_mmux3_lhs_addsub[2]), .CK(clk), .Q(
        s3_lhs_r[2]) );
  DFFQX1TS s3_lhs_r_reg_1_ ( .D(s2_mmux3_lhs_addsub[1]), .CK(clk), .Q(
        s3_lhs_r[1]) );
  DFFQX1TS s3_lhs_r_reg_0_ ( .D(s2_mmux3_lhs_addsub[0]), .CK(clk), .Q(
        s3_lhs_r[0]) );
  DFFQX1TS s3_rhs_r_reg_22_ ( .D(n1678), .CK(clk), .Q(s3_rhs_r[22]) );
  DFFQX1TS s3_rhs_r_reg_21_ ( .D(s2_mmux3_rhs_addsub[21]), .CK(clk), .Q(
        s3_rhs_r[21]) );
  DFFQX1TS s3_rhs_r_reg_20_ ( .D(s2_mmux3_rhs_addsub[20]), .CK(clk), .Q(
        s3_rhs_r[20]) );
  DFFQX1TS s3_rhs_r_reg_19_ ( .D(s2_mmux3_rhs_addsub[19]), .CK(clk), .Q(
        s3_rhs_r[19]) );
  DFFQX1TS s3_rhs_r_reg_18_ ( .D(s2_mmux3_rhs_addsub[18]), .CK(clk), .Q(
        s3_rhs_r[18]) );
  DFFQX1TS s3_rhs_r_reg_17_ ( .D(s2_mmux3_rhs_addsub[17]), .CK(clk), .Q(
        s3_rhs_r[17]) );
  DFFQX1TS s3_rhs_r_reg_16_ ( .D(s2_mmux3_rhs_addsub[16]), .CK(clk), .Q(
        s3_rhs_r[16]) );
  DFFQX1TS s3_rhs_r_reg_15_ ( .D(s2_mmux3_rhs_addsub[15]), .CK(clk), .Q(
        s3_rhs_r[15]) );
  DFFQX1TS s3_rhs_r_reg_14_ ( .D(s2_mmux3_rhs_addsub[14]), .CK(clk), .Q(
        s3_rhs_r[14]) );
  DFFQX1TS s3_rhs_r_reg_13_ ( .D(s2_mmux3_rhs_addsub[13]), .CK(clk), .Q(
        s3_rhs_r[13]) );
  DFFQX1TS s3_rhs_r_reg_12_ ( .D(s2_mmux3_rhs_addsub[12]), .CK(clk), .Q(
        s3_rhs_r[12]) );
  DFFQX1TS s3_rhs_r_reg_11_ ( .D(s2_mmux3_rhs_addsub[11]), .CK(clk), .Q(
        s3_rhs_r[11]) );
  DFFQX1TS s3_rhs_r_reg_10_ ( .D(s2_mmux3_rhs_addsub[10]), .CK(clk), .Q(
        s3_rhs_r[10]) );
  DFFQX1TS s3_rhs_r_reg_9_ ( .D(s2_mmux3_rhs_addsub[9]), .CK(clk), .Q(
        s3_rhs_r[9]) );
  DFFQX1TS s3_rhs_r_reg_8_ ( .D(s2_mmux3_rhs_addsub[8]), .CK(clk), .Q(
        s3_rhs_r[8]) );
  DFFQX1TS s3_rhs_r_reg_7_ ( .D(s2_mmux3_rhs_addsub[7]), .CK(clk), .Q(
        s3_rhs_r[7]) );
  DFFQX1TS s3_rhs_r_reg_6_ ( .D(s2_mmux3_rhs_addsub[6]), .CK(clk), .Q(
        s3_rhs_r[6]) );
  DFFQX1TS s3_rhs_r_reg_5_ ( .D(s2_mmux3_rhs_addsub[5]), .CK(clk), .Q(
        s3_rhs_r[5]) );
  DFFQX1TS s3_rhs_r_reg_4_ ( .D(s2_mmux3_rhs_addsub[4]), .CK(clk), .Q(
        s3_rhs_r[4]) );
  DFFQX1TS s3_rhs_r_reg_3_ ( .D(s2_mmux3_rhs_addsub[3]), .CK(clk), .Q(
        s3_rhs_r[3]) );
  DFFQX1TS s3_rhs_r_reg_2_ ( .D(s2_mmux3_rhs_addsub[2]), .CK(clk), .Q(
        s3_rhs_r[2]) );
  DFFQX1TS s3_rhs_r_reg_1_ ( .D(s2_mmux3_rhs_addsub[1]), .CK(clk), .Q(
        s3_rhs_r[1]) );
  DFFQX1TS s3_rhs_r_reg_0_ ( .D(s2_mmux3_rhs_addsub[0]), .CK(clk), .Q(
        s3_rhs_r[0]) );
  DFFQX1TS s3_addsubn_r_reg ( .D(n1677), .CK(clk), .Q(s3_addsubn_r) );
  DFFQX1TS s3_ea_gte_eb_r_reg ( .D(s2_ea_gte_eb_r), .CK(clk), .Q(
        s3_ea_gte_eb_r) );
  DFFQX1TS s3_ps0_r_reg_18_ ( .D(intadd_0_n1), .CK(clk), .Q(s3_ps0_r[18]) );
  DFFQX1TS s3_ps0_r_reg_17_ ( .D(s2_ps0[17]), .CK(clk), .Q(s3_ps0_r[17]) );
  DFFQX1TS s3_ps0_r_reg_16_ ( .D(s2_ps0[16]), .CK(clk), .Q(s3_ps0_r[16]) );
  DFFQX1TS s3_ps0_r_reg_15_ ( .D(s2_ps0[15]), .CK(clk), .Q(s3_ps0_r[15]) );
  DFFQX1TS s3_ps0_r_reg_14_ ( .D(s2_ps0[14]), .CK(clk), .Q(s3_ps0_r[14]) );
  DFFQX1TS s3_ps0_r_reg_13_ ( .D(s2_ps0[13]), .CK(clk), .Q(s3_ps0_r[13]) );
  DFFQX1TS s3_ps0_r_reg_12_ ( .D(s2_ps0[12]), .CK(clk), .Q(s3_ps0_r[12]) );
  DFFQX1TS s3_ps0_r_reg_11_ ( .D(s2_ps0[11]), .CK(clk), .Q(s3_ps0_r[11]) );
  DFFQX1TS s3_ps0_r_reg_10_ ( .D(s2_ps0[10]), .CK(clk), .Q(s3_ps0_r[10]) );
  DFFQX1TS s3_ps0_r_reg_9_ ( .D(s2_ps0[9]), .CK(clk), .Q(s3_ps0_r[9]) );
  DFFQX1TS s3_ps0_r_reg_8_ ( .D(s2_ps0[8]), .CK(clk), .Q(s3_ps0_r[8]) );
  DFFQX1TS s3_ps0_r_reg_7_ ( .D(s2_ps0[7]), .CK(clk), .Q(s3_ps0_r[7]) );
  DFFQX1TS s3_ps0_r_reg_6_ ( .D(s2_ps0[6]), .CK(clk), .Q(s3_ps0_r[6]) );
  DFFQX1TS s3_ps0_r_reg_5_ ( .D(s2_ps0[5]), .CK(clk), .Q(s3_ps0_r[5]) );
  DFFQX1TS s3_ps0_r_reg_4_ ( .D(s2_ps0[4]), .CK(clk), .Q(s3_ps0_r[4]) );
  DFFQX1TS s3_ps0_r_reg_3_ ( .D(s2_ps0[3]), .CK(clk), .Q(s3_ps0_r[3]) );
  DFFQX1TS s3_ps0_r_reg_2_ ( .D(s2_ps0[2]), .CK(clk), .Q(s3_ps0_r[2]) );
  DFFQX1TS s3_ps0_r_reg_1_ ( .D(s2_ps0[1]), .CK(clk), .Q(s3_ps0_r[1]) );
  DFFQX1TS s3_ps0_r_reg_0_ ( .D(s2_ps0[0]), .CK(clk), .Q(s3_ps0_r[0]) );
  DFFQX1TS s3_ps1_r_reg_15_ ( .D(s2_ps1[15]), .CK(clk), .Q(s3_ps1_r[15]) );
  DFFQX1TS s3_ps1_r_reg_14_ ( .D(s2_ps1[14]), .CK(clk), .Q(s3_ps1_r[14]) );
  DFFQX1TS s3_ps1_r_reg_13_ ( .D(s2_ps1[13]), .CK(clk), .Q(s3_ps1_r[13]) );
  DFFQX1TS s3_ps1_r_reg_12_ ( .D(s2_ps1[12]), .CK(clk), .Q(s3_ps1_r[12]) );
  DFFQX1TS s3_ps1_r_reg_11_ ( .D(s2_ps1[11]), .CK(clk), .Q(s3_ps1_r[11]) );
  DFFQX1TS s3_ps1_r_reg_10_ ( .D(s2_ps1[10]), .CK(clk), .Q(s3_ps1_r[10]) );
  DFFQX1TS s3_ps1_r_reg_9_ ( .D(s2_ps1[9]), .CK(clk), .Q(s3_ps1_r[9]) );
  DFFQX1TS s3_ps1_r_reg_8_ ( .D(s2_ps1[8]), .CK(clk), .Q(s3_ps1_r[8]) );
  DFFQX1TS s3_ps1_r_reg_7_ ( .D(s2_ps1[7]), .CK(clk), .Q(s3_ps1_r[7]) );
  DFFQX1TS s3_ps1_r_reg_6_ ( .D(s2_ps1[6]), .CK(clk), .Q(s3_ps1_r[6]) );
  DFFQX1TS s3_ps1_r_reg_5_ ( .D(s2_ps1[5]), .CK(clk), .Q(s3_ps1_r[5]) );
  DFFQX1TS s3_ps1_r_reg_4_ ( .D(s2_ps1[4]), .CK(clk), .Q(s3_ps1_r[4]) );
  DFFQX1TS s3_ps1_r_reg_3_ ( .D(s2_ps1[3]), .CK(clk), .Q(s3_ps1_r[3]) );
  DFFQX1TS s3_ps1_r_reg_2_ ( .D(s2_ps1[2]), .CK(clk), .Q(s3_ps1_r[2]) );
  DFFQX1TS s3_ps1_r_reg_1_ ( .D(s2_ps1[1]), .CK(clk), .Q(s3_ps1_r[1]) );
  DFFQX1TS s3_ps1_r_reg_0_ ( .D(s2_ps1[0]), .CK(clk), .Q(s3_ps1_r[0]) );
  DFFQX1TS s3_s2_r_reg ( .D(s2_br4_s_r[2]), .CK(clk), .Q(s3_s2_r) );
  DFFQX1TS s4_many_r_reg_22_ ( .D(s3_mmux_y[22]), .CK(clk), .Q(s4_many_r[22])
         );
  DFFQX1TS s4_many_r_reg_21_ ( .D(s3_mmux_y[21]), .CK(clk), .Q(s4_many_r[21])
         );
  DFFQX1TS s4_many_r_reg_20_ ( .D(s3_mmux_y[20]), .CK(clk), .Q(s4_many_r[20])
         );
  DFFQX1TS s4_many_r_reg_19_ ( .D(s3_mmux_y[19]), .CK(clk), .Q(s4_many_r[19])
         );
  DFFQX1TS s4_many_r_reg_18_ ( .D(s3_mmux_y[18]), .CK(clk), .Q(s4_many_r[18])
         );
  DFFQX1TS s4_many_r_reg_17_ ( .D(s3_mmux_y[17]), .CK(clk), .Q(s4_many_r[17])
         );
  DFFQX1TS s4_many_r_reg_16_ ( .D(s3_mmux_y[16]), .CK(clk), .Q(s4_many_r[16])
         );
  DFFQX1TS s4_many_r_reg_15_ ( .D(s3_mmux_y[15]), .CK(clk), .Q(s4_many_r[15])
         );
  DFFQX1TS s4_many_r_reg_14_ ( .D(s3_mmux_y[14]), .CK(clk), .Q(s4_many_r[14])
         );
  DFFQX1TS s4_many_r_reg_13_ ( .D(s3_mmux_y[13]), .CK(clk), .Q(s4_many_r[13])
         );
  DFFQX1TS s4_many_r_reg_12_ ( .D(s3_mmux_y[12]), .CK(clk), .Q(s4_many_r[12])
         );
  DFFQX1TS s4_many_r_reg_11_ ( .D(s3_mmux_y[11]), .CK(clk), .Q(s4_many_r[11])
         );
  DFFQX1TS s4_many_r_reg_10_ ( .D(s3_mmux_y[10]), .CK(clk), .Q(s4_many_r[10])
         );
  DFFQX1TS s4_many_r_reg_9_ ( .D(s3_mmux_y[9]), .CK(clk), .Q(s4_many_r[9]) );
  DFFQX1TS s4_many_r_reg_8_ ( .D(s3_mmux_y[8]), .CK(clk), .Q(s4_many_r[8]) );
  DFFQX1TS s4_many_r_reg_7_ ( .D(s3_mmux_y[7]), .CK(clk), .Q(s4_many_r[7]) );
  DFFQX1TS s4_many_r_reg_6_ ( .D(s3_mmux_y[6]), .CK(clk), .Q(s4_many_r[6]) );
  DFFQX1TS s4_many_r_reg_5_ ( .D(s3_mmux_y[5]), .CK(clk), .Q(s4_many_r[5]) );
  DFFQX1TS s4_many_r_reg_4_ ( .D(s3_mmux_y[4]), .CK(clk), .Q(s4_many_r[4]) );
  DFFQX1TS s4_many_r_reg_3_ ( .D(s3_mmux_y[3]), .CK(clk), .Q(s4_many_r[3]) );
  DFFQX1TS s4_many_r_reg_2_ ( .D(s3_mmux_y[2]), .CK(clk), .Q(s4_many_r[2]) );
  DFFQX1TS s4_many_r_reg_1_ ( .D(s3_mmux_y[1]), .CK(clk), .Q(s4_many_r[1]) );
  DFFQX1TS s4_many_r_reg_0_ ( .D(s3_mmux_y[0]), .CK(clk), .Q(s4_many_r[0]) );
  DFFQX1TS s4_opcode_r_reg_1_ ( .D(s3_opcode_r[1]), .CK(clk), .Q(
        s4_opcode_r[1]) );
  DFFQX1TS s4_opcode_r_reg_0_ ( .D(n778), .CK(clk), .Q(s4_opcode_r[0]) );
  DFFQX1TS s4_ea_r_reg_5_ ( .D(s3_expa_r[5]), .CK(clk), .Q(s4_ea_r[5]) );
  DFFQX1TS s4_ea_r_reg_4_ ( .D(s3_expa_r[4]), .CK(clk), .Q(s4_ea_r[4]) );
  DFFQX1TS s4_ea_r_reg_3_ ( .D(s3_expa_r[3]), .CK(clk), .Q(s4_ea_r[3]) );
  DFFQX1TS s4_ea_r_reg_2_ ( .D(s3_expa_r[2]), .CK(clk), .Q(s4_ea_r[2]) );
  DFFQX1TS s4_ea_r_reg_1_ ( .D(s3_expa_r[1]), .CK(clk), .Q(s4_ea_r[1]) );
  DFFQX1TS s4_ea_r_reg_0_ ( .D(s3_expa_r[0]), .CK(clk), .Q(s4_ea_r[0]) );
  DFFQX1TS s4_eb_r_reg_5_ ( .D(s3_expb_r[5]), .CK(clk), .Q(s4_eb_r[5]) );
  DFFQX1TS s4_eb_r_reg_4_ ( .D(s3_expb_r[4]), .CK(clk), .Q(s4_eb_r[4]) );
  DFFQX1TS s4_eb_r_reg_3_ ( .D(s3_expb_r[3]), .CK(clk), .Q(s4_eb_r[3]) );
  DFFQX1TS s4_eb_r_reg_2_ ( .D(s3_expb_r[2]), .CK(clk), .Q(s4_eb_r[2]) );
  DFFQX1TS s4_eb_r_reg_1_ ( .D(s3_expb_r[1]), .CK(clk), .Q(s4_eb_r[1]) );
  DFFQX1TS s4_eb_r_reg_0_ ( .D(s3_expb_r[0]), .CK(clk), .Q(s4_eb_r[0]) );
  DFFQX1TS s4_ea_gte_eb_r_reg ( .D(s3_ea_gte_eb_r), .CK(clk), .Q(
        s4_ea_gte_eb_r) );
  DFFQX1TS s4_addsubn_r_reg ( .D(s3_addsubn_r), .CK(clk), .Q(s4_addsubn_r) );
  DFFQX1TS s4_sa_r_reg ( .D(s3_sa_r), .CK(clk), .Q(s4_sa_r) );
  DFFQX1TS s5_addsubn_r_reg ( .D(s4_addsubn_r), .CK(clk), .Q(s5_addsubn_r) );
  DFFQX1TS s5_sa_r_reg ( .D(s4_sa_r), .CK(clk), .Q(s5_sa_r) );
  DFFQX1TS s5_many_r_reg_22_ ( .D(s4_many_r[22]), .CK(clk), .Q(s5_many_r[22])
         );
  DFFQX1TS s5_many_r_reg_21_ ( .D(s4_many_r[21]), .CK(clk), .Q(s5_many_r[21])
         );
  DFFQX1TS s5_many_r_reg_20_ ( .D(s4_many_r[20]), .CK(clk), .Q(s5_many_r[20])
         );
  DFFQX1TS s5_many_r_reg_19_ ( .D(s4_many_r[19]), .CK(clk), .Q(s5_many_r[19])
         );
  DFFQX1TS s5_many_r_reg_18_ ( .D(s4_many_r[18]), .CK(clk), .Q(s5_many_r[18])
         );
  DFFQX1TS s5_many_r_reg_17_ ( .D(s4_many_r[17]), .CK(clk), .Q(s5_many_r[17])
         );
  DFFQX1TS s5_many_r_reg_16_ ( .D(s4_many_r[16]), .CK(clk), .Q(s5_many_r[16])
         );
  DFFQX1TS s5_many_r_reg_15_ ( .D(s4_many_r[15]), .CK(clk), .Q(s5_many_r[15])
         );
  DFFQX1TS s5_many_r_reg_14_ ( .D(s4_many_r[14]), .CK(clk), .Q(s5_many_r[14])
         );
  DFFQX1TS s5_many_r_reg_13_ ( .D(s4_many_r[13]), .CK(clk), .Q(s5_many_r[13])
         );
  DFFQX1TS s5_many_r_reg_12_ ( .D(s4_many_r[12]), .CK(clk), .Q(s5_many_r[12])
         );
  DFFQX1TS s5_many_r_reg_11_ ( .D(s4_many_r[11]), .CK(clk), .Q(s5_many_r[11])
         );
  DFFQX1TS s5_many_r_reg_10_ ( .D(s4_many_r[10]), .CK(clk), .Q(s5_many_r[10])
         );
  DFFQX1TS s5_many_r_reg_9_ ( .D(s4_many_r[9]), .CK(clk), .Q(s5_many_r[9]) );
  DFFQX1TS s5_many_r_reg_8_ ( .D(s4_many_r[8]), .CK(clk), .Q(s5_many_r[8]) );
  DFFQX1TS s5_many_r_reg_7_ ( .D(s4_many_r[7]), .CK(clk), .Q(s5_many_r[7]) );
  DFFQX1TS s5_many_r_reg_6_ ( .D(s4_many_r[6]), .CK(clk), .Q(s5_many_r[6]) );
  DFFQX1TS s5_many_r_reg_5_ ( .D(s4_many_r[5]), .CK(clk), .Q(s5_many_r[5]) );
  DFFQX1TS s5_many_r_reg_4_ ( .D(s4_many_r[4]), .CK(clk), .Q(s5_many_r[4]) );
  DFFQX1TS s5_many_r_reg_3_ ( .D(s4_many_r[3]), .CK(clk), .Q(s5_many_r[3]) );
  DFFQX1TS s5_many_r_reg_2_ ( .D(s4_many_r[2]), .CK(clk), .Q(s5_many_r[2]) );
  DFFQX1TS s5_many_r_reg_1_ ( .D(s4_many_r[1]), .CK(clk), .Q(s5_many_r[1]) );
  DFFQX1TS s5_many_r_reg_0_ ( .D(s4_many_r[0]), .CK(clk), .Q(s5_many_r[0]) );
  DFFQX1TS s5_lzd_r_reg_4_ ( .D(n1028), .CK(clk), .Q(s5_lzd_r[4]) );
  DFFQX1TS s5_lzd_r_reg_3_ ( .D(n1679), .CK(clk), .Q(s5_lzd_r[3]) );
  DFFQX1TS s5_ea_r_reg_5_ ( .D(s4_ea_r[5]), .CK(clk), .Q(s5_ea_r[5]) );
  DFFQX1TS s5_ea_r_reg_4_ ( .D(s4_ea_r[4]), .CK(clk), .Q(s5_ea_r[4]) );
  DFFQX1TS s5_ea_r_reg_3_ ( .D(s4_ea_r[3]), .CK(clk), .Q(s5_ea_r[3]) );
  DFFQX1TS s5_ea_r_reg_2_ ( .D(s4_ea_r[2]), .CK(clk), .Q(s5_ea_r[2]) );
  DFFQX1TS s5_eb_r_reg_5_ ( .D(s4_eb_r[5]), .CK(clk), .Q(s5_eb_r[5]) );
  DFFQX1TS s5_eb_r_reg_4_ ( .D(s4_eb_r[4]), .CK(clk), .Q(s5_eb_r[4]) );
  DFFQX1TS s5_eb_r_reg_3_ ( .D(s4_eb_r[3]), .CK(clk), .Q(s5_eb_r[3]) );
  DFFQX1TS s5_eb_r_reg_2_ ( .D(s4_eb_r[2]), .CK(clk), .Q(s5_eb_r[2]) );
  EDFFX1TS s2_expb_r_reg_4_ ( .D(n964), .E(n1015), .CK(clk), .Q(s2_expb_r[4])
         );
  EDFFX1TS s2_expb_r_reg_3_ ( .D(n962), .E(n1016), .CK(clk), .Q(s2_expb_r[3])
         );
  EDFFX1TS s2_expb_r_reg_2_ ( .D(n960), .E(n1017), .CK(clk), .Q(s2_expb_r[2])
         );
  EDFFX1TS s2_expb_r_reg_1_ ( .D(n958), .E(n1015), .CK(clk), .Q(s2_expb_r[1])
         );
  EDFFX1TS s2_expb_r_reg_0_ ( .D(din_uni_b_exp[0]), .E(n1016), .CK(clk), .Q(
        s2_expb_r[0]) );
  EDFFX1TS s2_expa_r_reg_4_ ( .D(din_uni_a_exp[4]), .E(n1017), .CK(clk), .Q(
        s2_expa_r[4]) );
  EDFFX1TS s2_expa_r_reg_3_ ( .D(din_uni_a_exp[3]), .E(n1017), .CK(clk), .Q(
        s2_expa_r[3]) );
  EDFFX1TS s2_expa_r_reg_2_ ( .D(din_uni_a_exp[2]), .E(n1016), .CK(clk), .Q(
        s2_expa_r[2]) );
  EDFFX1TS s2_expa_r_reg_1_ ( .D(din_uni_a_exp[1]), .E(n1017), .CK(clk), .Q(
        s2_expa_r[1]) );
  EDFFX1TS s2_expa_r_reg_0_ ( .D(n984), .E(n1016), .CK(clk), .Q(s2_expa_r[0])
         );
  ADDHXLTS DP_OP_155J1_125_6824_U32 ( .A(s5_eb_r[0]), .B(s5_ea_r[0]), .CO(
        DP_OP_155J1_125_6824_n28), .S(DP_OP_155J1_125_6824_n39) );
  CMPR32X2TS DP_OP_155J1_125_6824_U31 ( .A(s5_ea_r[1]), .B(s5_eb_r[1]), .C(
        DP_OP_155J1_125_6824_n28), .CO(DP_OP_155J1_125_6824_n27), .S(
        DP_OP_155J1_125_6824_n40) );
  CMPR32X2TS DP_OP_155J1_125_6824_U30 ( .A(s5_ea_r[2]), .B(s5_eb_r[2]), .C(
        DP_OP_155J1_125_6824_n27), .CO(DP_OP_155J1_125_6824_n26), .S(
        DP_OP_155J1_125_6824_n41) );
  CMPR32X2TS DP_OP_155J1_125_6824_U29 ( .A(s5_ea_r[3]), .B(s5_eb_r[3]), .C(
        DP_OP_155J1_125_6824_n26), .CO(DP_OP_155J1_125_6824_n25), .S(
        DP_OP_155J1_125_6824_n42) );
  CMPR32X2TS DP_OP_155J1_125_6824_U28 ( .A(s5_ea_r[4]), .B(s5_eb_r[4]), .C(
        DP_OP_155J1_125_6824_n25), .CO(DP_OP_155J1_125_6824_n24), .S(
        DP_OP_155J1_125_6824_n43) );
  CMPR32X2TS DP_OP_155J1_125_6824_U14 ( .A(DP_OP_155J1_125_6824_n21), .B(
        U2_RSOP_134_C1_Z_1), .C(n775), .CO(DP_OP_155J1_125_6824_n16), .S(
        DP_OP_155J1_125_6824_n17) );
  CMPR32X2TS DP_OP_155J1_125_6824_U13 ( .A(DP_OP_155J1_125_6824_n20), .B(
        U2_RSOP_134_C1_Z_2), .C(DP_OP_155J1_125_6824_n16), .CO(
        DP_OP_155J1_125_6824_n14), .S(DP_OP_155J1_125_6824_n15) );
  CMPR32X2TS DP_OP_155J1_125_6824_U12 ( .A(DP_OP_155J1_125_6824_n19), .B(
        U2_RSOP_134_C1_Z_3), .C(DP_OP_155J1_125_6824_n14), .CO(
        DP_OP_155J1_125_6824_n12), .S(DP_OP_155J1_125_6824_n13) );
  CMPR32X2TS DP_OP_155J1_125_6824_U11 ( .A(DP_OP_155J1_125_6824_n18), .B(
        U2_RSOP_134_C1_Z_4), .C(DP_OP_155J1_125_6824_n12), .CO(
        DP_OP_155J1_125_6824_n10), .S(DP_OP_155J1_125_6824_n11) );
  TLATXLTS s3_mmux_y_reg_22_ ( .G(n794), .D(n671), .Q(s3_mmux_y[22]) );
  TLATXLTS s3_mmux_y_reg_21_ ( .G(n795), .D(n591), .Q(s3_mmux_y[21]) );
  TLATXLTS s3_mmux_y_reg_20_ ( .G(n1079), .D(n590), .Q(s3_mmux_y[20]) );
  TLATXLTS s3_mmux_y_reg_19_ ( .G(n1082), .D(n589), .Q(s3_mmux_y[19]) );
  TLATXLTS s3_mmux_y_reg_18_ ( .G(n794), .D(n588), .Q(s3_mmux_y[18]) );
  TLATXLTS s3_mmux_y_reg_17_ ( .G(n1081), .D(n587), .Q(s3_mmux_y[17]) );
  TLATXLTS s3_mmux_y_reg_16_ ( .G(n1080), .D(n586), .Q(s3_mmux_y[16]) );
  TLATXLTS s3_mmux_y_reg_15_ ( .G(n1081), .D(n585), .Q(s3_mmux_y[15]) );
  TLATXLTS s3_mmux_y_reg_14_ ( .G(n794), .D(n584), .Q(s3_mmux_y[14]) );
  TLATXLTS s3_mmux_y_reg_13_ ( .G(n1079), .D(n583), .Q(s3_mmux_y[13]) );
  TLATXLTS s3_mmux_y_reg_12_ ( .G(n1082), .D(n582), .Q(s3_mmux_y[12]) );
  TLATXLTS s3_mmux_y_reg_11_ ( .G(n1079), .D(n581), .Q(s3_mmux_y[11]) );
  TLATXLTS s3_mmux_y_reg_10_ ( .G(n795), .D(n580), .Q(s3_mmux_y[10]) );
  TLATXLTS s3_mmux_y_reg_9_ ( .G(n1080), .D(n579), .Q(s3_mmux_y[9]) );
  TLATXLTS s3_mmux_y_reg_8_ ( .G(n1081), .D(n578), .Q(s3_mmux_y[8]) );
  TLATXLTS s3_mmux_y_reg_7_ ( .G(n794), .D(n577), .Q(s3_mmux_y[7]) );
  TLATXLTS s3_mmux_y_reg_6_ ( .G(n795), .D(n576), .Q(s3_mmux_y[6]) );
  TLATXLTS s3_mmux_y_reg_5_ ( .G(n1082), .D(n575), .Q(s3_mmux_y[5]) );
  TLATXLTS s3_mmux_y_reg_4_ ( .G(n1079), .D(n574), .Q(s3_mmux_y[4]) );
  TLATXLTS s3_mmux_y_reg_3_ ( .G(n1082), .D(n573), .Q(s3_mmux_y[3]) );
  TLATXLTS s3_mmux_y_reg_2_ ( .G(n795), .D(n572), .Q(s3_mmux_y[2]) );
  TLATXLTS s3_mmux_y_reg_1_ ( .G(n1081), .D(n571), .Q(s3_mmux_y[1]) );
  TLATXLTS s3_mmux_y_reg_0_ ( .G(n1080), .D(n570), .Q(s3_mmux_y[0]) );
  TLATXLTS s5_sign_final_reg ( .G(s5_opcode_r[1]), .D(N210), .Q(dout_uni_y_sgn) );
  DFFQX1TS s5_lzd_r_reg_2_ ( .D(n1680), .CK(clk), .Q(s5_lzd_r[2]) );
  DFFQX1TS s5_lzd_r_reg_1_ ( .D(n594), .CK(clk), .Q(s5_lzd_r[1]) );
  DFFQX1TS s5_lzd_r_reg_0_ ( .D(n593), .CK(clk), .Q(s5_lzd_r[0]) );
  DFFQX1TS s5_eb_r_reg_0_ ( .D(s4_eb_r[0]), .CK(clk), .Q(s5_eb_r[0]) );
  DFFQX1TS s5_ea_r_reg_0_ ( .D(s4_ea_r[0]), .CK(clk), .Q(s5_ea_r[0]) );
  DFFQX1TS s5_ea_r_reg_1_ ( .D(s4_ea_r[1]), .CK(clk), .Q(s5_ea_r[1]) );
  DFFQX1TS s5_opcode_r_reg_0_ ( .D(s4_opcode_r[0]), .CK(clk), .Q(
        s5_opcode_r[0]) );
  DFFQX1TS s5_eb_r_reg_1_ ( .D(s4_eb_r[1]), .CK(clk), .Q(s5_eb_r[1]) );
  DFFQX1TS s5_opcode_r_reg_1_ ( .D(s4_opcode_r[1]), .CK(clk), .Q(
        s5_opcode_r[1]) );
  DFFQX1TS s5_ea_gte_eb_r_reg ( .D(s4_ea_gte_eb_r), .CK(clk), .Q(
        s5_ea_gte_eb_r) );
  CMPR32X2TS intadd_1_U14 ( .A(intadd_1_A_0_), .B(intadd_1_B_0_), .C(
        intadd_1_CI), .CO(intadd_1_n13), .S(intadd_1_SUM_0_) );
  CMPR32X2TS intadd_1_U13 ( .A(intadd_1_A_1_), .B(intadd_1_B_1_), .C(
        intadd_1_n13), .CO(intadd_1_n12), .S(intadd_1_SUM_1_) );
  CMPR32X2TS intadd_1_U12 ( .A(intadd_1_A_2_), .B(intadd_1_B_2_), .C(
        intadd_1_n12), .CO(intadd_1_n11), .S(intadd_1_SUM_2_) );
  CMPR32X2TS intadd_1_U11 ( .A(intadd_1_A_3_), .B(intadd_1_B_3_), .C(
        intadd_1_n11), .CO(intadd_1_n10), .S(intadd_1_SUM_3_) );
  CMPR32X2TS intadd_1_U10 ( .A(intadd_1_A_4_), .B(intadd_1_B_4_), .C(
        intadd_1_n10), .CO(intadd_1_n9), .S(intadd_1_SUM_4_) );
  CMPR32X2TS intadd_1_U9 ( .A(intadd_1_A_5_), .B(intadd_1_B_5_), .C(
        intadd_1_n9), .CO(intadd_1_n8), .S(intadd_1_SUM_5_) );
  CMPR32X2TS intadd_1_U8 ( .A(intadd_1_A_6_), .B(intadd_1_B_6_), .C(
        intadd_1_n8), .CO(intadd_1_n7), .S(intadd_1_SUM_6_) );
  CMPR32X2TS intadd_1_U7 ( .A(intadd_1_A_7_), .B(intadd_1_B_7_), .C(
        intadd_1_n7), .CO(intadd_1_n6), .S(intadd_1_SUM_7_) );
  CMPR32X2TS intadd_1_U6 ( .A(intadd_1_A_8_), .B(intadd_1_B_8_), .C(
        intadd_1_n6), .CO(intadd_1_n5), .S(intadd_1_SUM_8_) );
  CMPR32X2TS intadd_1_U5 ( .A(intadd_1_A_9_), .B(intadd_1_B_9_), .C(
        intadd_1_n5), .CO(intadd_1_n4), .S(intadd_1_SUM_9_) );
  CMPR32X2TS intadd_1_U4 ( .A(intadd_1_A_10_), .B(intadd_1_B_10_), .C(
        intadd_1_n4), .CO(intadd_1_n3), .S(intadd_1_SUM_10_) );
  CMPR32X2TS intadd_1_U3 ( .A(intadd_1_A_11_), .B(intadd_1_B_11_), .C(
        intadd_1_n3), .CO(intadd_1_n2), .S(intadd_1_SUM_11_) );
  CMPR32X2TS intadd_1_U2 ( .A(intadd_1_A_12_), .B(intadd_1_B_12_), .C(
        intadd_1_n2), .CO(intadd_1_n1), .S(intadd_1_SUM_12_) );
  CMPR32X2TS intadd_0_U2 ( .A(intadd_0_A_14_), .B(s2_br4_pp_r[35]), .C(
        intadd_0_n2), .CO(intadd_0_n1), .S(s2_ps0[16]) );
  CMPR32X2TS intadd_3_U2 ( .A(n964), .B(intadd_3_B_3_), .C(intadd_3_n2), .CO(
        intadd_3_n1), .S(intadd_3_SUM_3_) );
  CMPR32X2TS intadd_0_U16 ( .A(s2_br4_s_r[1]), .B(intadd_0_B_0_), .C(
        intadd_0_CI), .CO(intadd_0_n15), .S(s2_ps0[2]) );
  CMPR32X2TS intadd_0_U15 ( .A(intadd_0_A_1_), .B(intadd_0_B_1_), .C(
        intadd_0_n15), .CO(intadd_0_n14), .S(s2_ps0[3]) );
  CMPR32X2TS intadd_0_U14 ( .A(intadd_0_A_2_), .B(intadd_0_B_2_), .C(
        intadd_0_n14), .CO(intadd_0_n13), .S(s2_ps0[4]) );
  CMPR32X2TS intadd_0_U13 ( .A(intadd_0_A_3_), .B(intadd_0_B_3_), .C(
        intadd_0_n13), .CO(intadd_0_n12), .S(s2_ps0[5]) );
  CMPR32X2TS intadd_0_U12 ( .A(intadd_0_A_4_), .B(intadd_0_B_4_), .C(
        intadd_0_n12), .CO(intadd_0_n11), .S(s2_ps0[6]) );
  CMPR32X2TS intadd_0_U11 ( .A(intadd_0_A_5_), .B(intadd_0_B_5_), .C(
        intadd_0_n11), .CO(intadd_0_n10), .S(s2_ps0[7]) );
  CMPR32X2TS intadd_0_U10 ( .A(intadd_0_A_6_), .B(intadd_0_B_6_), .C(
        intadd_0_n10), .CO(intadd_0_n9), .S(s2_ps0[8]) );
  CMPR32X2TS intadd_0_U9 ( .A(intadd_0_A_7_), .B(intadd_0_B_7_), .C(
        intadd_0_n9), .CO(intadd_0_n8), .S(s2_ps0[9]) );
  CMPR32X2TS intadd_0_U8 ( .A(intadd_0_A_8_), .B(intadd_0_B_8_), .C(
        intadd_0_n8), .CO(intadd_0_n7), .S(s2_ps0[10]) );
  CMPR32X2TS intadd_0_U7 ( .A(intadd_0_A_9_), .B(intadd_0_B_9_), .C(
        intadd_0_n7), .CO(intadd_0_n6), .S(s2_ps0[11]) );
  CMPR32X2TS intadd_0_U6 ( .A(intadd_0_A_10_), .B(intadd_0_B_10_), .C(
        intadd_0_n6), .CO(intadd_0_n5), .S(s2_ps0[12]) );
  CMPR32X2TS intadd_0_U5 ( .A(intadd_0_A_11_), .B(intadd_0_B_11_), .C(
        intadd_0_n5), .CO(intadd_0_n4), .S(s2_ps0[13]) );
  CMPR32X2TS intadd_0_U4 ( .A(intadd_0_A_12_), .B(intadd_0_B_12_), .C(
        intadd_0_n4), .CO(intadd_0_n3), .S(s2_ps0[14]) );
  CMPR32X2TS intadd_0_U3 ( .A(intadd_0_A_13_), .B(intadd_0_B_13_), .C(
        intadd_0_n3), .CO(intadd_0_n2), .S(s2_ps0[15]) );
  CMPR32X2TS intadd_2_U14 ( .A(s2_br4_s_r[4]), .B(intadd_2_B_0_), .C(
        intadd_2_CI), .CO(intadd_2_n13), .S(s2_ps1[2]) );
  CMPR32X2TS intadd_2_U13 ( .A(intadd_2_A_1_), .B(intadd_2_B_1_), .C(
        intadd_2_n13), .CO(intadd_2_n12), .S(s2_ps1[3]) );
  CMPR32X2TS intadd_2_U12 ( .A(intadd_2_A_2_), .B(intadd_2_B_2_), .C(
        intadd_2_n12), .CO(intadd_2_n11), .S(s2_ps1[4]) );
  CMPR32X2TS intadd_2_U11 ( .A(intadd_2_A_3_), .B(intadd_2_B_3_), .C(
        intadd_2_n11), .CO(intadd_2_n10), .S(s2_ps1[5]) );
  CMPR32X2TS intadd_2_U10 ( .A(intadd_2_A_4_), .B(intadd_2_B_4_), .C(
        intadd_2_n10), .CO(intadd_2_n9), .S(s2_ps1[6]) );
  CMPR32X2TS intadd_2_U9 ( .A(intadd_2_A_5_), .B(intadd_2_B_5_), .C(
        intadd_2_n9), .CO(intadd_2_n8), .S(s2_ps1[7]) );
  CMPR32X2TS intadd_2_U8 ( .A(intadd_2_A_6_), .B(intadd_2_B_6_), .C(
        intadd_2_n8), .CO(intadd_2_n7), .S(s2_ps1[8]) );
  CMPR32X2TS intadd_2_U7 ( .A(intadd_2_A_7_), .B(intadd_2_B_7_), .C(
        intadd_2_n7), .CO(intadd_2_n6), .S(s2_ps1[9]) );
  CMPR32X2TS intadd_2_U6 ( .A(intadd_2_A_8_), .B(intadd_2_B_8_), .C(
        intadd_2_n6), .CO(intadd_2_n5), .S(s2_ps1[10]) );
  CMPR32X2TS intadd_2_U5 ( .A(intadd_2_A_9_), .B(intadd_2_B_9_), .C(
        intadd_2_n5), .CO(intadd_2_n4), .S(s2_ps1[11]) );
  CMPR32X2TS intadd_2_U4 ( .A(intadd_2_A_10_), .B(intadd_2_B_10_), .C(
        intadd_2_n4), .CO(intadd_2_n3), .S(s2_ps1[12]) );
  CMPR32X2TS intadd_2_U3 ( .A(intadd_2_A_11_), .B(intadd_2_B_11_), .C(
        intadd_2_n3), .CO(intadd_2_n2), .S(s2_ps1[13]) );
  CMPR32X2TS intadd_2_U2 ( .A(intadd_2_A_12_), .B(intadd_2_B_12_), .C(
        intadd_2_n2), .CO(intadd_2_n1), .S(s2_ps1[14]) );
  CMPR32X2TS DP_OP_155J1_125_6824_U7 ( .A(U2_RSOP_134_C1_Z_0), .B(n776), .C(
        DP_OP_155J1_125_6824_n33), .CO(DP_OP_155J1_125_6824_n6), .S(
        C43_DATA2_0) );
  CMPR32X2TS DP_OP_155J1_125_6824_U6 ( .A(DP_OP_155J1_125_6824_n34), .B(
        DP_OP_155J1_125_6824_n17), .C(DP_OP_155J1_125_6824_n6), .CO(
        DP_OP_155J1_125_6824_n5), .S(C43_DATA2_1) );
  CMPR32X2TS DP_OP_155J1_125_6824_U5 ( .A(DP_OP_155J1_125_6824_n35), .B(
        DP_OP_155J1_125_6824_n15), .C(DP_OP_155J1_125_6824_n5), .CO(
        DP_OP_155J1_125_6824_n4), .S(C43_DATA2_2) );
  CMPR32X2TS DP_OP_155J1_125_6824_U4 ( .A(DP_OP_155J1_125_6824_n36), .B(
        DP_OP_155J1_125_6824_n13), .C(DP_OP_155J1_125_6824_n4), .CO(
        DP_OP_155J1_125_6824_n3), .S(C43_DATA2_3) );
  CMPR32X2TS DP_OP_155J1_125_6824_U3 ( .A(DP_OP_155J1_125_6824_n37), .B(
        DP_OP_155J1_125_6824_n11), .C(DP_OP_155J1_125_6824_n3), .CO(
        DP_OP_155J1_125_6824_n2), .S(C43_DATA2_4) );
  CMPR32X2TS intadd_3_U5 ( .A(n958), .B(intadd_3_B_0_), .C(intadd_3_CI), .CO(
        intadd_3_n4), .S(intadd_3_SUM_0_) );
  CMPR32X2TS intadd_3_U4 ( .A(n960), .B(intadd_3_B_1_), .C(intadd_3_n4), .CO(
        intadd_3_n3), .S(intadd_3_SUM_1_) );
  CMPR32X2TS intadd_3_U3 ( .A(n962), .B(intadd_3_B_2_), .C(intadd_3_n3), .CO(
        intadd_3_n2), .S(intadd_3_SUM_2_) );
  DFFXLTS s2_opcode_r_reg_0_ ( .D(opcode[0]), .CK(clk), .Q(s2_opcode_r[0]), 
        .QN(n1681) );
  CMPR32X2TS U790 ( .A(s2_br4_pp_r[23]), .B(s2_br4_pp_r[33]), .C(s2_br4_s_r[0]), .CO(intadd_0_A_12_), .S(intadd_0_B_11_) );
  CMPR32X2TS U791 ( .A(n1356), .B(n1027), .C(s2_br4_s_r[1]), .CO(n1357), .S(
        n1355) );
  CMPR32X2TS U792 ( .A(s2_br4_pp_r[22]), .B(s2_br4_pp_r[32]), .C(s2_br4_s_r[0]), .CO(intadd_0_A_11_), .S(intadd_0_B_10_) );
  INVX2TS U793 ( .A(n1118), .Y(n946) );
  INVX2TS U794 ( .A(n1672), .Y(n937) );
  AO22XLTS U795 ( .A0(n883), .A1(n988), .B0(n980), .B1(n868), .Y(n676) );
  AO22XLTS U796 ( .A0(n882), .A1(n980), .B0(n990), .B1(n869), .Y(n677) );
  AO22XLTS U797 ( .A0(n883), .A1(n990), .B0(n982), .B1(n1230), .Y(n678) );
  AO22XLTS U798 ( .A0(n883), .A1(n982), .B0(n992), .B1(n1230), .Y(n679) );
  AO22XLTS U799 ( .A0(n883), .A1(n992), .B0(n968), .B1(n1230), .Y(n682) );
  NOR3XLTS U800 ( .A(n1135), .B(n1264), .C(n1262), .Y(n1476) );
  AO22XLTS U801 ( .A0(n942), .A1(n741), .B0(n1071), .B1(n743), .Y(n675) );
  NAND2BXLTS U802 ( .AN(n996), .B(n1023), .Y(n1220) );
  NAND2BXLTS U803 ( .AN(n998), .B(n1022), .Y(n1218) );
  NAND2BXLTS U804 ( .AN(n1000), .B(n1021), .Y(n1216) );
  INVX2TS U805 ( .A(n1015), .Y(n1673) );
  OAI31X1TS U806 ( .A0(n994), .A1(n1002), .A2(n1057), .B0(n1013), .Y(n1222) );
  AO22XLTS U807 ( .A0(n1431), .A1(din_uni_a_man_dn[10]), .B0(n1430), .B1(n986), 
        .Y(s1_mmux_rhs[10]) );
  OR2X1TS U808 ( .A(n756), .B(n1315), .Y(n672) );
  OR3X1TS U809 ( .A(n1261), .B(n1263), .C(n756), .Y(n673) );
  OR2X1TS U810 ( .A(s2_ea_sub_eb_abs_r[0]), .B(n1106), .Y(n674) );
  INVX2TS U811 ( .A(n1002), .Y(n1661) );
  NOR3XLTS U812 ( .A(n817), .B(n994), .C(n1023), .Y(n1654) );
  NOR3XLTS U813 ( .A(n1009), .B(n1000), .C(n1003), .Y(n1639) );
  NOR3XLTS U814 ( .A(n1006), .B(n998), .C(n1021), .Y(n1644) );
  NOR3XLTS U815 ( .A(n1012), .B(n996), .C(n1022), .Y(n1649) );
  OR2X1TS U816 ( .A(s2_ea_sub_eb_abs_r[1]), .B(s2_ea_sub_eb_abs_r[0]), .Y(n680) );
  OR2X1TS U817 ( .A(n1315), .B(n1456), .Y(n681) );
  OR2X1TS U818 ( .A(intadd_3_B_0_), .B(n1087), .Y(n683) );
  OR2X1TS U819 ( .A(n1011), .B(n1658), .Y(n684) );
  OR2X1TS U820 ( .A(n881), .B(n1436), .Y(n685) );
  OR2X1TS U821 ( .A(n972), .B(n818), .Y(n686) );
  OR2X1TS U822 ( .A(n1018), .B(n693), .Y(n687) );
  OR2X1TS U823 ( .A(n1008), .B(n697), .Y(n688) );
  OR2X1TS U824 ( .A(n1005), .B(n695), .Y(n689) );
  OAI21XLTS U825 ( .A0(n1004), .A1(n986), .B0(n885), .Y(n1660) );
  NOR2XLTS U826 ( .A(n818), .B(n971), .Y(n1233) );
  NOR2XLTS U827 ( .A(n818), .B(n993), .Y(n1636) );
  INVX2TS U828 ( .A(n972), .Y(n1666) );
  NOR2XLTS U829 ( .A(s3_opcode_r[1]), .B(n777), .Y(n1672) );
  INVX2TS U830 ( .A(n1579), .Y(n690) );
  INVX2TS U831 ( .A(n690), .Y(n691) );
  INVX2TS U832 ( .A(n1643), .Y(n692) );
  INVX2TS U833 ( .A(n692), .Y(n693) );
  INVX2TS U834 ( .A(n1653), .Y(n694) );
  INVX2TS U835 ( .A(n694), .Y(n695) );
  INVX2TS U836 ( .A(n1648), .Y(n696) );
  INVX2TS U837 ( .A(n696), .Y(n697) );
  INVX2TS U838 ( .A(n1518), .Y(n698) );
  INVX2TS U839 ( .A(n698), .Y(n699) );
  INVX2TS U840 ( .A(n1562), .Y(n700) );
  INVX2TS U841 ( .A(n700), .Y(n701) );
  INVX2TS U842 ( .A(n1454), .Y(n702) );
  INVX2TS U843 ( .A(n702), .Y(n703) );
  INVX2TS U844 ( .A(n1457), .Y(n704) );
  INVX2TS U845 ( .A(n704), .Y(n705) );
  INVX2TS U846 ( .A(n1469), .Y(n706) );
  INVX2TS U847 ( .A(n706), .Y(n707) );
  INVX2TS U848 ( .A(s5_opcode_r[0]), .Y(n708) );
  INVX2TS U849 ( .A(n708), .Y(n709) );
  INVX2TS U850 ( .A(s2_mmux_rhs_r[3]), .Y(n710) );
  INVX2TS U851 ( .A(n710), .Y(n711) );
  INVX2TS U852 ( .A(s2_mmux_rhs_r[4]), .Y(n712) );
  INVX2TS U853 ( .A(n712), .Y(n713) );
  INVX2TS U854 ( .A(s2_mmux_rhs_r[5]), .Y(n714) );
  INVX2TS U855 ( .A(n714), .Y(n715) );
  INVX2TS U856 ( .A(s2_mmux_rhs_r[6]), .Y(n716) );
  INVX2TS U857 ( .A(n716), .Y(n717) );
  INVX2TS U858 ( .A(s2_mmux_rhs_r[7]), .Y(n718) );
  INVX2TS U859 ( .A(n718), .Y(n719) );
  INVX2TS U860 ( .A(s2_mmux_rhs_r[8]), .Y(n720) );
  INVX2TS U861 ( .A(n720), .Y(n721) );
  INVX2TS U862 ( .A(s2_mmux_rhs_r[9]), .Y(n722) );
  INVX2TS U863 ( .A(n722), .Y(n723) );
  INVX2TS U864 ( .A(s2_mmux_rhs_r[10]), .Y(n724) );
  INVX2TS U865 ( .A(n724), .Y(n725) );
  INVX2TS U866 ( .A(s2_mmux_rhs_r[12]), .Y(n726) );
  INVX2TS U867 ( .A(n726), .Y(n727) );
  INVX2TS U868 ( .A(s2_mmux_rhs_r[13]), .Y(n728) );
  INVX2TS U869 ( .A(n728), .Y(n729) );
  INVX2TS U870 ( .A(s2_mmux_rhs_r[14]), .Y(n730) );
  INVX2TS U871 ( .A(n730), .Y(n731) );
  INVX2TS U872 ( .A(s2_mmux_rhs_r[15]), .Y(n732) );
  INVX2TS U873 ( .A(n732), .Y(n733) );
  INVX2TS U874 ( .A(s2_mmux_rhs_r[16]), .Y(n734) );
  INVX2TS U875 ( .A(n734), .Y(n735) );
  INVX2TS U876 ( .A(s2_mmux_rhs_r[17]), .Y(n736) );
  INVX2TS U877 ( .A(n736), .Y(n737) );
  INVX2TS U878 ( .A(s2_mmux_rhs_r[18]), .Y(n738) );
  INVX2TS U879 ( .A(n738), .Y(n739) );
  INVX2TS U880 ( .A(s2_mmux_rhs_r[20]), .Y(n740) );
  INVX2TS U881 ( .A(n740), .Y(n741) );
  INVX2TS U882 ( .A(s2_mmux_rhs_r[21]), .Y(n742) );
  INVX2TS U883 ( .A(n742), .Y(n743) );
  INVX2TS U884 ( .A(n931), .Y(n744) );
  INVX2TS U885 ( .A(n744), .Y(n745) );
  INVX2TS U886 ( .A(n937), .Y(n940) );
  INVX2TS U887 ( .A(n937), .Y(n941) );
  INVX2TS U888 ( .A(n937), .Y(n939) );
  INVX2TS U889 ( .A(n937), .Y(n938) );
  INVX2TS U890 ( .A(n940), .Y(n746) );
  INVX2TS U891 ( .A(n746), .Y(n747) );
  INVX2TS U892 ( .A(n680), .Y(n945) );
  INVX2TS U893 ( .A(n680), .Y(n944) );
  INVX2TS U894 ( .A(n680), .Y(n943) );
  INVX2TS U895 ( .A(n680), .Y(n942) );
  INVX2TS U896 ( .A(n1064), .Y(n748) );
  INVX2TS U897 ( .A(n748), .Y(n749) );
  INVX2TS U898 ( .A(n1484), .Y(n750) );
  INVX2TS U899 ( .A(n1470), .Y(n751) );
  INVX2TS U900 ( .A(n1084), .Y(n752) );
  INVX2TS U901 ( .A(n752), .Y(n753) );
  INVX2TS U902 ( .A(n1047), .Y(n754) );
  INVX2TS U903 ( .A(n1264), .Y(n755) );
  INVX2TS U904 ( .A(n755), .Y(n756) );
  INVX2TS U905 ( .A(n1308), .Y(n757) );
  INVX2TS U906 ( .A(n1308), .Y(n758) );
  INVX2TS U907 ( .A(n1467), .Y(n759) );
  INVX2TS U908 ( .A(n759), .Y(n760) );
  INVX2TS U909 ( .A(n806), .Y(n761) );
  INVX2TS U910 ( .A(n761), .Y(n762) );
  INVX2TS U911 ( .A(n1539), .Y(n763) );
  INVX2TS U912 ( .A(n763), .Y(n764) );
  INVX2TS U913 ( .A(n675), .Y(n765) );
  INVX2TS U914 ( .A(n675), .Y(n766) );
  INVX2TS U915 ( .A(n685), .Y(n767) );
  INVX2TS U916 ( .A(n685), .Y(n768) );
  INVX2TS U917 ( .A(n1391), .Y(n769) );
  INVX2TS U918 ( .A(n769), .Y(n770) );
  INVX2TS U919 ( .A(n681), .Y(n771) );
  INVX2TS U920 ( .A(n681), .Y(n772) );
  INVX2TS U921 ( .A(s5_opcode_r[1]), .Y(n773) );
  INVX2TS U922 ( .A(n773), .Y(n774) );
  INVX2TS U923 ( .A(s5_lzd_r[0]), .Y(n775) );
  INVX2TS U924 ( .A(n775), .Y(n776) );
  INVX2TS U925 ( .A(s3_opcode_r[0]), .Y(n777) );
  INVX2TS U926 ( .A(n777), .Y(n778) );
  INVX2TS U927 ( .A(n942), .Y(n779) );
  INVX2TS U928 ( .A(n779), .Y(n780) );
  INVX2TS U929 ( .A(n779), .Y(n781) );
  INVX2TS U930 ( .A(n946), .Y(n947) );
  INVX2TS U931 ( .A(n946), .Y(n950) );
  INVX2TS U932 ( .A(n946), .Y(n949) );
  INVX2TS U933 ( .A(n946), .Y(n948) );
  INVX2TS U934 ( .A(n947), .Y(n782) );
  INVX2TS U935 ( .A(n782), .Y(n783) );
  INVX2TS U936 ( .A(n1068), .Y(n784) );
  INVX2TS U937 ( .A(n784), .Y(n785) );
  INVX2TS U938 ( .A(n784), .Y(n786) );
  INVX2TS U939 ( .A(n750), .Y(n787) );
  INVX2TS U940 ( .A(n787), .Y(n788) );
  INVX2TS U941 ( .A(n787), .Y(n789) );
  INVX2TS U942 ( .A(n751), .Y(n790) );
  INVX2TS U943 ( .A(n790), .Y(n791) );
  INVX2TS U944 ( .A(n790), .Y(n792) );
  INVX2TS U945 ( .A(n1080), .Y(n793) );
  INVX2TS U946 ( .A(n793), .Y(n794) );
  INVX2TS U947 ( .A(n793), .Y(n795) );
  INVX2TS U948 ( .A(n1395), .Y(n796) );
  INVX2TS U949 ( .A(n1342), .Y(n797) );
  INVX2TS U950 ( .A(n1662), .Y(n798) );
  INVX2TS U951 ( .A(n798), .Y(n799) );
  INVX2TS U952 ( .A(n1559), .Y(n800) );
  INVX2TS U953 ( .A(n800), .Y(n801) );
  INVX2TS U954 ( .A(s2_ea_sub_eb_abs_r[3]), .Y(n802) );
  INVX2TS U955 ( .A(n802), .Y(n803) );
  INVX2TS U956 ( .A(s2_ea_sub_eb_abs_r[4]), .Y(n804) );
  INVX2TS U957 ( .A(n804), .Y(n805) );
  INVX2TS U958 ( .A(s2_ea_sub_eb_abs_r[5]), .Y(n806) );
  INVX2TS U959 ( .A(n1498), .Y(n807) );
  INVX2TS U960 ( .A(n807), .Y(n808) );
  INVX2TS U961 ( .A(n1098), .Y(n809) );
  INVX2TS U962 ( .A(n1053), .Y(n810) );
  INVX2TS U963 ( .A(n1233), .Y(n811) );
  INVX2TS U964 ( .A(n811), .Y(n812) );
  INVX2TS U965 ( .A(n811), .Y(n813) );
  INVX2TS U966 ( .A(n1557), .Y(n814) );
  INVX2TS U967 ( .A(n814), .Y(n815) );
  INVX2TS U968 ( .A(n814), .Y(n816) );
  INVX2TS U969 ( .A(n1661), .Y(n817) );
  INVX2TS U970 ( .A(n817), .Y(n818) );
  INVX2TS U971 ( .A(n1641), .Y(n819) );
  INVX2TS U972 ( .A(n1641), .Y(n820) );
  INVX2TS U973 ( .A(n1641), .Y(n821) );
  INVX2TS U974 ( .A(n693), .Y(n822) );
  INVX2TS U975 ( .A(n1656), .Y(n823) );
  INVX2TS U976 ( .A(n1656), .Y(n824) );
  INVX2TS U977 ( .A(n1656), .Y(n825) );
  INVX2TS U978 ( .A(n1651), .Y(n826) );
  INVX2TS U979 ( .A(n1651), .Y(n827) );
  INVX2TS U980 ( .A(n1651), .Y(n828) );
  INVX2TS U981 ( .A(n695), .Y(n829) );
  INVX2TS U982 ( .A(n1646), .Y(n830) );
  INVX2TS U983 ( .A(n1646), .Y(n831) );
  INVX2TS U984 ( .A(n1646), .Y(n832) );
  INVX2TS U985 ( .A(n697), .Y(n833) );
  INVX2TS U986 ( .A(n1639), .Y(n834) );
  INVX2TS U987 ( .A(n834), .Y(n835) );
  INVX2TS U988 ( .A(n834), .Y(n836) );
  INVX2TS U989 ( .A(n1654), .Y(n837) );
  INVX2TS U990 ( .A(n837), .Y(n838) );
  INVX2TS U991 ( .A(n837), .Y(n839) );
  INVX2TS U992 ( .A(n1649), .Y(n840) );
  INVX2TS U993 ( .A(n840), .Y(n841) );
  INVX2TS U994 ( .A(n840), .Y(n842) );
  INVX2TS U995 ( .A(n1644), .Y(n843) );
  INVX2TS U996 ( .A(n843), .Y(n844) );
  INVX2TS U997 ( .A(n843), .Y(n845) );
  INVX2TS U998 ( .A(n1598), .Y(n846) );
  INVX2TS U999 ( .A(n846), .Y(n847) );
  INVX2TS U1000 ( .A(n846), .Y(n848) );
  INVX2TS U1001 ( .A(n686), .Y(n849) );
  INVX2TS U1002 ( .A(n686), .Y(n850) );
  INVX2TS U1003 ( .A(n686), .Y(n851) );
  INVX2TS U1004 ( .A(n687), .Y(n852) );
  INVX2TS U1005 ( .A(n687), .Y(n853) );
  INVX2TS U1006 ( .A(n687), .Y(n854) );
  INVX2TS U1007 ( .A(n1636), .Y(n855) );
  INVX2TS U1008 ( .A(n855), .Y(n856) );
  INVX2TS U1009 ( .A(n855), .Y(n857) );
  INVX2TS U1010 ( .A(n684), .Y(n858) );
  INVX2TS U1011 ( .A(n684), .Y(n859) );
  INVX2TS U1012 ( .A(n684), .Y(n860) );
  INVX2TS U1013 ( .A(n689), .Y(n861) );
  INVX2TS U1014 ( .A(n689), .Y(n862) );
  INVX2TS U1015 ( .A(n689), .Y(n863) );
  INVX2TS U1016 ( .A(n688), .Y(n864) );
  INVX2TS U1017 ( .A(n688), .Y(n865) );
  INVX2TS U1018 ( .A(n688), .Y(n866) );
  INVX2TS U1019 ( .A(n1230), .Y(n867) );
  INVX2TS U1020 ( .A(n867), .Y(n868) );
  INVX2TS U1021 ( .A(n867), .Y(n869) );
  INVX2TS U1022 ( .A(n1640), .Y(n870) );
  INVX2TS U1023 ( .A(n1640), .Y(n871) );
  INVX2TS U1024 ( .A(n1655), .Y(n872) );
  INVX2TS U1025 ( .A(n1655), .Y(n873) );
  INVX2TS U1026 ( .A(n1650), .Y(n874) );
  INVX2TS U1027 ( .A(n1650), .Y(n875) );
  INVX2TS U1028 ( .A(n1645), .Y(n876) );
  INVX2TS U1029 ( .A(n1645), .Y(n877) );
  INVX2TS U1030 ( .A(n1660), .Y(n878) );
  INVX2TS U1031 ( .A(n878), .Y(n879) );
  INVX2TS U1032 ( .A(n878), .Y(n880) );
  INVX2TS U1033 ( .A(n683), .Y(n881) );
  INVX2TS U1034 ( .A(n683), .Y(n882) );
  INVX2TS U1035 ( .A(n683), .Y(n883) );
  INVX2TS U1036 ( .A(n1659), .Y(n884) );
  INVX2TS U1037 ( .A(n884), .Y(n885) );
  INVX2TS U1038 ( .A(n884), .Y(n886) );
  INVX2TS U1039 ( .A(n884), .Y(n887) );
  INVX2TS U1040 ( .A(n682), .Y(n888) );
  INVX2TS U1041 ( .A(n682), .Y(n889) );
  INVX2TS U1042 ( .A(n682), .Y(n890) );
  INVX2TS U1043 ( .A(n679), .Y(n891) );
  INVX2TS U1044 ( .A(n679), .Y(n892) );
  INVX2TS U1045 ( .A(n679), .Y(n893) );
  INVX2TS U1046 ( .A(n679), .Y(n894) );
  INVX2TS U1047 ( .A(n1614), .Y(n895) );
  INVX2TS U1048 ( .A(n895), .Y(n896) );
  INVX2TS U1049 ( .A(n895), .Y(n897) );
  INVX2TS U1050 ( .A(n895), .Y(n898) );
  INVX2TS U1051 ( .A(n1609), .Y(n899) );
  INVX2TS U1052 ( .A(n899), .Y(n900) );
  INVX2TS U1053 ( .A(n899), .Y(n901) );
  INVX2TS U1054 ( .A(n899), .Y(n902) );
  INVX2TS U1055 ( .A(n678), .Y(n903) );
  INVX2TS U1056 ( .A(n678), .Y(n904) );
  INVX2TS U1057 ( .A(n678), .Y(n905) );
  INVX2TS U1058 ( .A(n678), .Y(n906) );
  INVX2TS U1059 ( .A(n677), .Y(n907) );
  INVX2TS U1060 ( .A(n677), .Y(n908) );
  INVX2TS U1061 ( .A(n677), .Y(n909) );
  INVX2TS U1062 ( .A(n677), .Y(n910) );
  INVX2TS U1063 ( .A(n676), .Y(n911) );
  INVX2TS U1064 ( .A(n676), .Y(n912) );
  INVX2TS U1065 ( .A(n676), .Y(n913) );
  INVX2TS U1066 ( .A(n676), .Y(n914) );
  INVX2TS U1067 ( .A(n1093), .Y(n915) );
  INVX2TS U1068 ( .A(n915), .Y(n916) );
  INVX2TS U1069 ( .A(n915), .Y(n917) );
  INVX2TS U1070 ( .A(n915), .Y(n918) );
  INVX2TS U1071 ( .A(n672), .Y(n919) );
  INVX2TS U1072 ( .A(n672), .Y(n920) );
  INVX2TS U1073 ( .A(n672), .Y(n921) );
  INVX2TS U1074 ( .A(n672), .Y(n922) );
  INVX2TS U1075 ( .A(n1517), .Y(n923) );
  INVX2TS U1076 ( .A(n923), .Y(n924) );
  INVX2TS U1077 ( .A(n923), .Y(n925) );
  INVX2TS U1078 ( .A(n923), .Y(n926) );
  INVX2TS U1079 ( .A(n923), .Y(n927) );
  INVX2TS U1080 ( .A(n674), .Y(n928) );
  INVX2TS U1081 ( .A(n674), .Y(n929) );
  INVX2TS U1082 ( .A(n674), .Y(n930) );
  INVX2TS U1083 ( .A(n674), .Y(n931) );
  INVX2TS U1084 ( .A(n1471), .Y(n932) );
  INVX2TS U1085 ( .A(n932), .Y(n933) );
  INVX2TS U1086 ( .A(n932), .Y(n934) );
  INVX2TS U1087 ( .A(n932), .Y(n935) );
  INVX2TS U1088 ( .A(n932), .Y(n936) );
  INVX2TS U1089 ( .A(n1476), .Y(n951) );
  INVX2TS U1090 ( .A(n951), .Y(n952) );
  INVX2TS U1091 ( .A(n951), .Y(n953) );
  INVX2TS U1092 ( .A(n673), .Y(n954) );
  INVX2TS U1093 ( .A(n673), .Y(n955) );
  INVX2TS U1094 ( .A(n673), .Y(n956) );
  INVX2TS U1095 ( .A(din_uni_b_exp[1]), .Y(n957) );
  INVX2TS U1096 ( .A(n957), .Y(n958) );
  INVX2TS U1097 ( .A(din_uni_b_exp[2]), .Y(n959) );
  INVX2TS U1098 ( .A(n959), .Y(n960) );
  INVX2TS U1099 ( .A(din_uni_b_exp[3]), .Y(n961) );
  INVX2TS U1100 ( .A(n961), .Y(n962) );
  INVX2TS U1101 ( .A(din_uni_b_exp[4]), .Y(n963) );
  INVX2TS U1102 ( .A(n963), .Y(n964) );
  INVX2TS U1103 ( .A(din_uni_a_exp[5]), .Y(n965) );
  INVX2TS U1104 ( .A(n965), .Y(n966) );
  INVX2TS U1105 ( .A(din_uni_a_man_dn[9]), .Y(n967) );
  INVX2TS U1106 ( .A(n967), .Y(n968) );
  INVX2TS U1107 ( .A(din_uni_b_exp[5]), .Y(n969) );
  INVX2TS U1108 ( .A(n969), .Y(n970) );
  INVX2TS U1109 ( .A(din_uni_b_man_dn[0]), .Y(n971) );
  INVX2TS U1110 ( .A(n971), .Y(n972) );
  INVX2TS U1111 ( .A(din_uni_a_man_dn[1]), .Y(n973) );
  INVX2TS U1112 ( .A(n973), .Y(n974) );
  INVX2TS U1113 ( .A(din_uni_a_man_dn[2]), .Y(n975) );
  INVX2TS U1114 ( .A(n975), .Y(n976) );
  INVX2TS U1115 ( .A(din_uni_a_man_dn[3]), .Y(n977) );
  INVX2TS U1116 ( .A(n977), .Y(n978) );
  INVX2TS U1117 ( .A(din_uni_a_man_dn[5]), .Y(n979) );
  INVX2TS U1118 ( .A(n979), .Y(n980) );
  INVX2TS U1119 ( .A(din_uni_a_man_dn[7]), .Y(n981) );
  INVX2TS U1120 ( .A(n981), .Y(n982) );
  INVX2TS U1121 ( .A(din_uni_a_exp[0]), .Y(n983) );
  INVX2TS U1122 ( .A(n983), .Y(n984) );
  INVX2TS U1123 ( .A(din_uni_b_man_dn[10]), .Y(n985) );
  INVX2TS U1124 ( .A(n985), .Y(n986) );
  INVX2TS U1125 ( .A(din_uni_a_man_dn[4]), .Y(n987) );
  INVX2TS U1126 ( .A(n987), .Y(n988) );
  INVX2TS U1127 ( .A(din_uni_a_man_dn[6]), .Y(n989) );
  INVX2TS U1128 ( .A(n989), .Y(n990) );
  INVX2TS U1129 ( .A(din_uni_a_man_dn[8]), .Y(n991) );
  INVX2TS U1130 ( .A(n991), .Y(n992) );
  INVX2TS U1131 ( .A(din_uni_b_man_dn[2]), .Y(n993) );
  INVX2TS U1132 ( .A(n993), .Y(n994) );
  INVX2TS U1133 ( .A(din_uni_b_man_dn[4]), .Y(n995) );
  INVX2TS U1134 ( .A(n995), .Y(n996) );
  INVX2TS U1135 ( .A(din_uni_b_man_dn[6]), .Y(n997) );
  INVX2TS U1136 ( .A(n997), .Y(n998) );
  INVX2TS U1137 ( .A(din_uni_b_man_dn[8]), .Y(n999) );
  INVX2TS U1138 ( .A(n999), .Y(n1000) );
  INVX2TS U1139 ( .A(din_uni_b_man_dn[1]), .Y(n1001) );
  INVX2TS U1140 ( .A(n1001), .Y(n1002) );
  INVX2TS U1141 ( .A(din_uni_b_man_dn[9]), .Y(n1003) );
  INVX2TS U1142 ( .A(n1003), .Y(n1004) );
  INVX2TS U1143 ( .A(din_uni_b_man_dn[5]), .Y(n1005) );
  INVX2TS U1144 ( .A(n1005), .Y(n1006) );
  INVX2TS U1145 ( .A(n1005), .Y(n1007) );
  INVX2TS U1146 ( .A(din_uni_b_man_dn[7]), .Y(n1008) );
  INVX2TS U1147 ( .A(n1008), .Y(n1009) );
  INVX2TS U1148 ( .A(n1008), .Y(n1010) );
  INVX2TS U1149 ( .A(din_uni_b_man_dn[3]), .Y(n1011) );
  INVX2TS U1150 ( .A(n1011), .Y(n1012) );
  INVX2TS U1151 ( .A(n1011), .Y(n1013) );
  INVX2TS U1152 ( .A(opcode[1]), .Y(n1014) );
  INVX2TS U1153 ( .A(n1014), .Y(n1015) );
  INVX2TS U1154 ( .A(n1014), .Y(n1016) );
  INVX2TS U1155 ( .A(n1014), .Y(n1017) );
  CLKBUFX2TS U1156 ( .A(n1004), .Y(n1442) );
  INVX2TS U1157 ( .A(n1442), .Y(n1018) );
  CLKBUFX2TS U1158 ( .A(n1571), .Y(n1019) );
  CLKBUFX2TS U1159 ( .A(n1179), .Y(n1020) );
  INVX2TS U1160 ( .A(n1009), .Y(n1021) );
  INVX2TS U1161 ( .A(n1006), .Y(n1022) );
  INVX2TS U1162 ( .A(n1012), .Y(n1023) );
  INVX2TS U1163 ( .A(n1104), .Y(n1024) );
  CLKBUFX2TS U1164 ( .A(n1387), .Y(n1025) );
  CLKBUFX2TS U1165 ( .A(n1314), .Y(n1026) );
  CLKBUFX2TS U1166 ( .A(s2_br4_s_r[0]), .Y(n1027) );
  NAND2X1TS U1167 ( .A(n1396), .B(n796), .Y(n1675) );
  INVX2TS U1168 ( .A(n1675), .Y(n1028) );
  INVX2TS U1169 ( .A(n1675), .Y(n1029) );
  INVX2TS U1170 ( .A(n1347), .Y(n1030) );
  INVX2TS U1171 ( .A(n891), .Y(n1031) );
  INVX2TS U1172 ( .A(n891), .Y(n1032) );
  INVX2TS U1173 ( .A(n903), .Y(n1033) );
  INVX2TS U1174 ( .A(n903), .Y(n1034) );
  INVX2TS U1175 ( .A(n907), .Y(n1035) );
  INVX2TS U1176 ( .A(n907), .Y(n1036) );
  INVX2TS U1177 ( .A(n911), .Y(n1037) );
  INVX2TS U1178 ( .A(n911), .Y(n1038) );
  INVX2TS U1179 ( .A(n896), .Y(n1039) );
  INVX2TS U1180 ( .A(n896), .Y(n1040) );
  INVX2TS U1181 ( .A(n900), .Y(n1041) );
  INVX2TS U1182 ( .A(n900), .Y(n1042) );
  INVX2TS U1183 ( .A(n1093), .Y(n1043) );
  CLKBUFX2TS U1184 ( .A(n888), .Y(n1665) );
  INVX2TS U1185 ( .A(n1665), .Y(n1044) );
  INVX2TS U1186 ( .A(n1665), .Y(n1045) );
  OR2X1TS U1187 ( .A(n761), .B(n699), .Y(n1567) );
  INVX2TS U1188 ( .A(n1567), .Y(n1046) );
  INVX2TS U1189 ( .A(n1567), .Y(n1047) );
  INVX2TS U1190 ( .A(n1567), .Y(n1048) );
  INVX2TS U1191 ( .A(s5_ea_gte_eb_r), .Y(n1049) );
  INVX2TS U1192 ( .A(n1049), .Y(n1050) );
  INVX2TS U1193 ( .A(n1049), .Y(n1051) );
  INVX2TS U1194 ( .A(n1049), .Y(n1052) );
  INVX2TS U1195 ( .A(n1098), .Y(n1604) );
  INVX2TS U1196 ( .A(n1604), .Y(n1053) );
  INVX2TS U1197 ( .A(n1604), .Y(n1054) );
  INVX2TS U1198 ( .A(n1604), .Y(n1055) );
  OR2X1TS U1199 ( .A(n968), .B(n868), .Y(n1663) );
  INVX2TS U1200 ( .A(n1663), .Y(n1056) );
  INVX2TS U1201 ( .A(n1663), .Y(n1057) );
  INVX2TS U1202 ( .A(n1663), .Y(n1058) );
  INVX2TS U1203 ( .A(n1663), .Y(n1059) );
  CLKBUFX2TS U1204 ( .A(n767), .Y(n1599) );
  INVX2TS U1205 ( .A(n1599), .Y(n1060) );
  INVX2TS U1206 ( .A(n1599), .Y(n1061) );
  INVX2TS U1207 ( .A(n1599), .Y(n1062) );
  INVX2TS U1208 ( .A(n1599), .Y(n1063) );
  OR2X1TS U1209 ( .A(n1119), .B(n1120), .Y(n1472) );
  INVX2TS U1210 ( .A(n1472), .Y(n1064) );
  INVX2TS U1211 ( .A(n1472), .Y(n1065) );
  INVX2TS U1212 ( .A(n1472), .Y(n1066) );
  INVX2TS U1213 ( .A(n1472), .Y(n1067) );
  OR2X1TS U1214 ( .A(s2_ea_sub_eb_abs_r[1]), .B(n1105), .Y(n1516) );
  INVX2TS U1215 ( .A(n1516), .Y(n1068) );
  INVX2TS U1216 ( .A(n1516), .Y(n1069) );
  INVX2TS U1217 ( .A(n1516), .Y(n1070) );
  INVX2TS U1218 ( .A(n1516), .Y(n1071) );
  INVX2TS U1219 ( .A(n1241), .Y(n1484) );
  INVX2TS U1220 ( .A(n1484), .Y(n1072) );
  INVX2TS U1221 ( .A(n1484), .Y(n1073) );
  INVX2TS U1222 ( .A(n1484), .Y(n1074) );
  INVX2TS U1223 ( .A(n1117), .Y(n1470) );
  INVX2TS U1224 ( .A(n1470), .Y(n1075) );
  INVX2TS U1225 ( .A(n1470), .Y(n1076) );
  INVX2TS U1226 ( .A(n1470), .Y(n1077) );
  CLKBUFX2TS U1227 ( .A(n1522), .Y(n1078) );
  CLKAND2X2TS U1228 ( .A(n777), .B(n1155), .Y(n592) );
  INVX2TS U1229 ( .A(n592), .Y(n1079) );
  INVX2TS U1230 ( .A(n592), .Y(n1080) );
  INVX2TS U1231 ( .A(n592), .Y(n1081) );
  INVX2TS U1232 ( .A(n592), .Y(n1082) );
  OR2X1TS U1233 ( .A(n756), .B(n1455), .Y(n1480) );
  INVX2TS U1234 ( .A(n1480), .Y(n1083) );
  INVX2TS U1235 ( .A(n1480), .Y(n1084) );
  INVX2TS U1236 ( .A(n1480), .Y(n1085) );
  INVX2TS U1237 ( .A(n1480), .Y(n1086) );
  NOR2XLTS U1238 ( .A(n1050), .B(s5_eb_r[5]), .Y(n1380) );
  NOR2XLTS U1239 ( .A(n804), .B(n1509), .Y(n1530) );
  NOR2XLTS U1240 ( .A(n1116), .B(n1119), .Y(n1121) );
  OAI21XLTS U1241 ( .A0(s4_many_r[16]), .A1(n1398), .B0(n1680), .Y(n1399) );
  NOR2XLTS U1242 ( .A(n1198), .B(n1199), .Y(n1182) );
  OAI21XLTS U1243 ( .A0(n1193), .A1(intadd_1_n1), .B0(n1192), .Y(n1194) );
  OAI21XLTS U1244 ( .A0(n779), .A1(n1280), .B0(n1247), .Y(n1248) );
  OAI21XLTS U1245 ( .A0(n1281), .A1(n1277), .B0(n1276), .Y(n1278) );
  NOR2XLTS U1246 ( .A(n1050), .B(s5_eb_r[0]), .Y(n1343) );
  OAI21XLTS U1247 ( .A0(n1089), .A1(n708), .B0(s5_sa_r), .Y(n1088) );
  NOR2XLTS U1248 ( .A(n1164), .B(n1163), .Y(n1193) );
  OAI21XLTS U1249 ( .A0(n1531), .A1(n1524), .B0(n1489), .Y(n1490) );
  NOR2XLTS U1250 ( .A(n1022), .B(n1210), .Y(n1651) );
  NOR2XLTS U1251 ( .A(n1018), .B(n1214), .Y(n1641) );
  OAI21XLTS U1252 ( .A0(n1146), .A1(n1139), .B0(n1129), .Y(n1130) );
  NOR2XLTS U1253 ( .A(n1416), .B(n1417), .Y(n1189) );
  AOI211XLTS U1254 ( .A0(n1527), .A1(n1504), .B0(n1503), .C0(n1502), .Y(n1505)
         );
  INVX2TS U1255 ( .A(s2_addsubn_r), .Y(n1543) );
  AOI221XLTS U1256 ( .A0(n857), .A1(n767), .B0(n838), .B1(n1060), .C0(n858), 
        .Y(n1095) );
  AOI221XLTS U1257 ( .A0(n1636), .A1(n1033), .B0(n838), .B1(n903), .C0(n858), 
        .Y(n1626) );
  AOI221XLTS U1258 ( .A0(n1633), .A1(n1035), .B0(n841), .B1(n907), .C0(n861), 
        .Y(n1621) );
  AOI221XLTS U1259 ( .A0(n1630), .A1(n1037), .B0(n844), .B1(n911), .C0(n864), 
        .Y(n1616) );
  AOI221XLTS U1260 ( .A0(n822), .A1(n809), .B0(n835), .B1(n1054), .C0(n852), 
        .Y(n1600) );
  AOI221XLTS U1261 ( .A0(n1641), .A1(n1057), .B0(n1640), .B1(n1662), .C0(n852), 
        .Y(n1642) );
  NOR2XLTS U1262 ( .A(n1405), .B(n1291), .Y(n1680) );
  NOR2XLTS U1263 ( .A(n1280), .B(n1072), .Y(s2_mmux3_lhs_addsub[11]) );
  OAI21XLTS U1264 ( .A0(n1093), .A1(n847), .B0(n1223), .Y(n658) );
  OAI21XLTS U1265 ( .A0(n1665), .A1(n1598), .B0(n1092), .Y(n610) );
  OAI21XLTS U1266 ( .A0(n1063), .A1(n874), .B0(n1211), .Y(n666) );
  OAI21XLTS U1267 ( .A0(n1058), .A1(n1648), .B0(n1219), .Y(n606) );
  OAI21XLTS U1268 ( .A0(n1059), .A1(n1643), .B0(n1217), .Y(n608) );
  NOR2XLTS U1269 ( .A(n1308), .B(n1026), .Y(dout_uni_y_man_dn[0]) );
  OAI211XLTS U1270 ( .A0(n1456), .A1(n1300), .B0(n1299), .C0(n1298), .Y(
        dout_uni_y_man_dn[19]) );
  INVX1TS U1271 ( .A(din_uni_a_exp[1]), .Y(intadd_3_B_0_) );
  INVX1TS U1272 ( .A(din_uni_a_exp[4]), .Y(intadd_3_B_3_) );
  NAND4XLTS U1273 ( .A(n984), .B(din_uni_a_exp[3]), .C(din_uni_a_exp[2]), .D(
        intadd_3_B_3_), .Y(n1087) );
  INVX1TS U1274 ( .A(din_uni_a_man_dn[0]), .Y(n1436) );
  NAND2X1TS U1275 ( .A(n1004), .B(n986), .Y(n1659) );
  NOR2XLTS U1276 ( .A(n1063), .B(n879), .Y(s1_br4_pp[60]) );
  INVX2TS U1277 ( .A(n881), .Y(n1230) );
  NOR2XLTS U1278 ( .A(n1059), .B(n886), .Y(s1_br4_pp[71]) );
  INVX2TS U1279 ( .A(s3_opcode_r[1]), .Y(n1155) );
  AO21XLTS U1280 ( .A0(s3_lhs_r[16]), .A1(n941), .B0(intadd_1_SUM_10_), .Y(
        n586) );
  NOR2XLTS U1281 ( .A(n1052), .B(s5_addsubn_r), .Y(n1089) );
  OAI211XLTS U1282 ( .A0(s5_sa_r), .A1(n1089), .B0(s5_opcode_r[1]), .C0(n1088), 
        .Y(n1090) );
  OAI31X1TS U1283 ( .A0(n709), .A1(s5_addsubn_r), .A2(n773), .B0(n1090), .Y(
        N210) );
  AO21XLTS U1284 ( .A0(s3_lhs_r[8]), .A1(n747), .B0(intadd_1_SUM_2_), .Y(n578)
         );
  AO21XLTS U1285 ( .A0(s3_lhs_r[9]), .A1(n941), .B0(intadd_1_SUM_3_), .Y(n579)
         );
  AO21XLTS U1286 ( .A0(s3_lhs_r[10]), .A1(n941), .B0(intadd_1_SUM_4_), .Y(n580) );
  AO21XLTS U1287 ( .A0(s3_lhs_r[11]), .A1(n938), .B0(intadd_1_SUM_5_), .Y(n581) );
  AO21XLTS U1288 ( .A0(s3_lhs_r[12]), .A1(n747), .B0(intadd_1_SUM_6_), .Y(n582) );
  AO21XLTS U1289 ( .A0(s3_lhs_r[13]), .A1(n938), .B0(intadd_1_SUM_7_), .Y(n583) );
  AO21XLTS U1290 ( .A0(s3_lhs_r[6]), .A1(n938), .B0(intadd_1_SUM_0_), .Y(n576)
         );
  AO21XLTS U1291 ( .A0(s3_lhs_r[14]), .A1(n939), .B0(intadd_1_SUM_8_), .Y(n584) );
  AO21XLTS U1292 ( .A0(s3_lhs_r[7]), .A1(n747), .B0(intadd_1_SUM_1_), .Y(n577)
         );
  AO21XLTS U1293 ( .A0(s3_lhs_r[15]), .A1(n939), .B0(intadd_1_SUM_9_), .Y(n585) );
  AO21XLTS U1294 ( .A0(s3_lhs_r[17]), .A1(n939), .B0(intadd_1_SUM_11_), .Y(
        n587) );
  AO21XLTS U1295 ( .A0(s3_lhs_r[18]), .A1(n941), .B0(intadd_1_SUM_12_), .Y(
        n588) );
  INVX1TS U1296 ( .A(din_uni_b_exp[0]), .Y(n1091) );
  NOR2XLTS U1297 ( .A(n1091), .B(n984), .Y(intadd_3_CI) );
  AOI21X1TS U1298 ( .A0(n984), .A1(n1091), .B0(intadd_3_CI), .Y(n1585) );
  INVX2TS U1299 ( .A(n1585), .Y(s1_ea_sub_eb_abs[0]) );
  AND3X1TS U1300 ( .A(s2_br4_s_r[3]), .B(s2_br4_pp_r[36]), .C(s2_br4_pp_r[37]), 
        .Y(intadd_2_CI) );
  CLKAND2X2TS U1301 ( .A(s2_br4_pp_r[36]), .B(s2_br4_s_r[3]), .Y(n1415) );
  AOI2BB1XLTS U1302 ( .A0N(n1415), .A1N(s2_br4_pp_r[37]), .B0(intadd_2_CI), 
        .Y(s2_ps1[1]) );
  AND3X1TS U1303 ( .A(s2_br4_pp_r[0]), .B(s2_br4_s_r[0]), .C(s2_br4_pp_r[1]), 
        .Y(intadd_0_CI) );
  CLKAND2X2TS U1304 ( .A(s2_br4_pp_r[0]), .B(n1027), .Y(n1414) );
  AOI2BB1XLTS U1305 ( .A0N(n1414), .A1N(s2_br4_pp_r[1]), .B0(intadd_0_CI), .Y(
        s2_ps0[1]) );
  NAND2X1TS U1306 ( .A(n972), .B(n1661), .Y(n1598) );
  AOI22X1TS U1307 ( .A0(n892), .A1(n849), .B0(n890), .B1(n1233), .Y(n1092) );
  NOR2XLTS U1308 ( .A(n708), .B(n774), .Y(n1387) );
  NOR2BX1TS U1309 ( .AN(C43_DATA2_0), .B(n1387), .Y(dout_uni_y_exp[0]) );
  AOI22X1TS U1310 ( .A0(n881), .A1(din_uni_a_man_dn[0]), .B0(n974), .B1(n868), 
        .Y(n1093) );
  NAND2X1TS U1311 ( .A(n1009), .B(n1000), .Y(n1643) );
  NAND2X1TS U1312 ( .A(n1216), .B(n693), .Y(n1214) );
  NOR2XLTS U1313 ( .A(n1214), .B(n1004), .Y(n1640) );
  INVX2TS U1314 ( .A(n1640), .Y(n1629) );
  INVX2TS U1315 ( .A(n916), .Y(n1102) );
  INVX2TS U1316 ( .A(n693), .Y(n1627) );
  AOI221XLTS U1317 ( .A0(n692), .A1(n768), .B0(n836), .B1(n1061), .C0(n854), 
        .Y(n1094) );
  OAI221XLTS U1318 ( .A0(n916), .A1(n1629), .B0(n1043), .B1(n819), .C0(n1094), 
        .Y(n663) );
  INVX2TS U1319 ( .A(n856), .Y(n1658) );
  OAI21XLTS U1320 ( .A0(n1002), .A1(n994), .B0(n1658), .Y(n1224) );
  NOR2XLTS U1321 ( .A(n1224), .B(n1013), .Y(n1655) );
  INVX2TS U1322 ( .A(n1655), .Y(n1638) );
  NOR2XLTS U1323 ( .A(n1023), .B(n1224), .Y(n1656) );
  OAI221XLTS U1324 ( .A0(n918), .A1(n1638), .B0(n1043), .B1(n823), .C0(n1095), 
        .Y(n660) );
  NAND2X1TS U1325 ( .A(n1012), .B(n996), .Y(n1653) );
  NAND2X1TS U1326 ( .A(n1220), .B(n695), .Y(n1210) );
  NOR2XLTS U1327 ( .A(n1210), .B(n1007), .Y(n1650) );
  INVX2TS U1328 ( .A(n1650), .Y(n1635) );
  INVX2TS U1329 ( .A(n695), .Y(n1633) );
  AOI221XLTS U1330 ( .A0(n694), .A1(n768), .B0(n842), .B1(n1062), .C0(n863), 
        .Y(n1096) );
  OAI221XLTS U1331 ( .A0(n917), .A1(n1635), .B0(n1043), .B1(n826), .C0(n1096), 
        .Y(n661) );
  NAND2X1TS U1332 ( .A(n1006), .B(n998), .Y(n1648) );
  NAND2X1TS U1333 ( .A(n1218), .B(n697), .Y(n1212) );
  NOR2XLTS U1334 ( .A(n1212), .B(n1010), .Y(n1645) );
  INVX2TS U1335 ( .A(n1645), .Y(n1632) );
  NOR2XLTS U1336 ( .A(n1021), .B(n1212), .Y(n1646) );
  INVX2TS U1337 ( .A(n697), .Y(n1630) );
  AOI221XLTS U1338 ( .A0(n696), .A1(n768), .B0(n845), .B1(n1063), .C0(n866), 
        .Y(n1097) );
  OAI221XLTS U1339 ( .A0(n1093), .A1(n1632), .B0(n1043), .B1(n830), .C0(n1097), 
        .Y(n662) );
  AOI22X1TS U1340 ( .A0(n882), .A1(n974), .B0(n976), .B1(n869), .Y(n1098) );
  AOI221XLTS U1341 ( .A0(n845), .A1(n916), .B0(n833), .B1(n1102), .C0(n865), 
        .Y(n1099) );
  OAI221XLTS U1342 ( .A0(n1055), .A1(n1632), .B0(n810), .B1(n830), .C0(n1099), 
        .Y(n656) );
  AOI221XLTS U1343 ( .A0(n836), .A1(n918), .B0(n822), .B1(n1102), .C0(n853), 
        .Y(n1100) );
  OAI221XLTS U1344 ( .A0(n1053), .A1(n1629), .B0(n810), .B1(n819), .C0(n1100), 
        .Y(n657) );
  AOI221XLTS U1345 ( .A0(n839), .A1(n917), .B0(n857), .B1(n1102), .C0(n859), 
        .Y(n1101) );
  OAI221XLTS U1346 ( .A0(n1054), .A1(n1638), .B0(n810), .B1(n823), .C0(n1101), 
        .Y(n654) );
  AOI221XLTS U1347 ( .A0(n842), .A1(n916), .B0(n829), .B1(n1102), .C0(n862), 
        .Y(n1103) );
  OAI221XLTS U1348 ( .A0(n1098), .A1(n1635), .B0(n810), .B1(n826), .C0(n1103), 
        .Y(n655) );
  CLKBUFX2TS U1349 ( .A(n1543), .Y(n1678) );
  NAND2X1TS U1350 ( .A(n942), .B(n743), .Y(n1558) );
  INVX2TS U1351 ( .A(n1558), .Y(n1104) );
  CLKBUFX2TS U1352 ( .A(n1543), .Y(n1572) );
  INVX2TS U1353 ( .A(n1572), .Y(n1581) );
  INVX2TS U1354 ( .A(n1572), .Y(n1493) );
  INVX2TS U1355 ( .A(s2_ea_sub_eb_abs_r[2]), .Y(n1498) );
  NAND2X1TS U1356 ( .A(n802), .B(n808), .Y(n1509) );
  OR2X1TS U1357 ( .A(n1509), .B(n805), .Y(n1518) );
  NAND2X1TS U1358 ( .A(n1493), .B(n1047), .Y(n1582) );
  NAND2X1TS U1359 ( .A(n1678), .B(n1567), .Y(n1580) );
  OAI221XLTS U1360 ( .A0(n1104), .A1(n1581), .B0(n1024), .B1(n1582), .C0(n1580), .Y(s2_mmux3_rhs_addsub[21]) );
  INVX2TS U1361 ( .A(s2_ea_sub_eb_abs_r[0]), .Y(n1105) );
  AOI22X1TS U1362 ( .A0(n943), .A1(n739), .B0(n1068), .B1(s2_mmux_rhs_r[19]), 
        .Y(n1108) );
  INVX2TS U1363 ( .A(s2_ea_sub_eb_abs_r[1]), .Y(n1106) );
  NAND2X1TS U1364 ( .A(s2_ea_sub_eb_abs_r[1]), .B(s2_ea_sub_eb_abs_r[0]), .Y(
        n1281) );
  INVX2TS U1365 ( .A(n1281), .Y(n1517) );
  AOI22X1TS U1366 ( .A0(n928), .A1(n741), .B0(n924), .B1(s2_mmux_rhs_r[21]), 
        .Y(n1107) );
  NAND2X1TS U1367 ( .A(n1108), .B(n1107), .Y(n1562) );
  OAI221XLTS U1368 ( .A0(n700), .A1(n1582), .B0(n1562), .B1(n1581), .C0(n1580), 
        .Y(s2_mmux3_rhs_addsub[18]) );
  NOR2BX1TS U1369 ( .AN(C43_DATA2_1), .B(n1387), .Y(dout_uni_y_exp[1]) );
  NOR4XLTS U1370 ( .A(s4_many_r[11]), .B(s4_many_r[10]), .C(s4_many_r[8]), .D(
        s4_many_r[9]), .Y(n1110) );
  NOR4XLTS U1371 ( .A(s4_many_r[7]), .B(s4_many_r[14]), .C(s4_many_r[13]), .D(
        s4_many_r[12]), .Y(n1109) );
  CLKAND2X2TS U1372 ( .A(n1110), .B(n1109), .Y(n1396) );
  NOR4XLTS U1373 ( .A(s4_many_r[19]), .B(s4_many_r[18]), .C(s4_many_r[16]), 
        .D(s4_many_r[17]), .Y(n1112) );
  NOR4XLTS U1374 ( .A(s4_many_r[20]), .B(s4_many_r[15]), .C(s4_many_r[22]), 
        .D(s4_many_r[21]), .Y(n1111) );
  NAND2X1TS U1375 ( .A(n1112), .B(n1111), .Y(n1395) );
  INVX2TS U1376 ( .A(n1395), .Y(n1398) );
  NOR2XLTS U1377 ( .A(n774), .B(n709), .Y(n1391) );
  NAND3XLTS U1378 ( .A(s5_lzd_r[1]), .B(n770), .C(n776), .Y(n1114) );
  NOR2BX1TS U1379 ( .AN(s5_lzd_r[2]), .B(n1114), .Y(n1124) );
  NAND2X1TS U1380 ( .A(n1124), .B(s5_lzd_r[3]), .Y(n1113) );
  XOR2XLTS U1381 ( .A(s5_lzd_r[4]), .B(n1113), .Y(n1456) );
  INVX2TS U1382 ( .A(n1456), .Y(n1264) );
  INVX2TS U1383 ( .A(n1114), .Y(n1116) );
  AOI2BB1XLTS U1384 ( .A0N(n1116), .A1N(s5_lzd_r[2]), .B0(n1124), .Y(n1263) );
  NOR2XLTS U1385 ( .A(n1124), .B(s5_lzd_r[3]), .Y(n1135) );
  NAND2X1TS U1386 ( .A(n1263), .B(n1135), .Y(n1455) );
  NAND2X1TS U1387 ( .A(n770), .B(s5_lzd_r[0]), .Y(n1115) );
  OAI21XLTS U1388 ( .A0(n770), .A1(s5_lzd_r[0]), .B0(n1115), .Y(n1120) );
  AOI21X1TS U1389 ( .A0(n1391), .A1(s5_lzd_r[0]), .B0(s5_lzd_r[1]), .Y(n1119)
         );
  NOR2BX1TS U1390 ( .AN(n1120), .B(n1121), .Y(n1117) );
  NOR2BX1TS U1391 ( .AN(n1119), .B(n1120), .Y(n1118) );
  AOI22X1TS U1392 ( .A0(n1076), .A1(s5_many_r[3]), .B0(n783), .B1(s5_many_r[2]), .Y(n1123) );
  NAND2X1TS U1393 ( .A(n1121), .B(n1120), .Y(n1146) );
  INVX2TS U1394 ( .A(n1146), .Y(n1471) );
  AOI22X1TS U1395 ( .A0(n1064), .A1(s5_many_r[0]), .B0(n936), .B1(s5_many_r[1]), .Y(n1122) );
  NAND2X1TS U1396 ( .A(n1123), .B(n1122), .Y(n1454) );
  INVX2TS U1397 ( .A(n1263), .Y(n1262) );
  AO21XLTS U1398 ( .A0(s5_lzd_r[3]), .A1(n1124), .B0(n1135), .Y(n1261) );
  NAND2X1TS U1399 ( .A(n1262), .B(n1261), .Y(n1315) );
  AOI22X1TS U1400 ( .A0(n1065), .A1(s5_many_r[4]), .B0(n949), .B1(s5_many_r[6]), .Y(n1126) );
  AOI22X1TS U1401 ( .A0(n935), .A1(s5_many_r[5]), .B0(n791), .B1(s5_many_r[7]), 
        .Y(n1125) );
  NAND2X1TS U1402 ( .A(n1126), .B(n1125), .Y(n1331) );
  AO22XLTS U1403 ( .A0(n1086), .A1(n703), .B0(n919), .B1(n1331), .Y(
        dout_uni_y_man_dn[6]) );
  AOI22X1TS U1404 ( .A0(n1075), .A1(s5_many_r[1]), .B0(n950), .B1(s5_many_r[0]), .Y(n1308) );
  AOI22X1TS U1405 ( .A0(n1075), .A1(s5_many_r[5]), .B0(n783), .B1(s5_many_r[4]), .Y(n1128) );
  AOI22X1TS U1406 ( .A0(n749), .A1(s5_many_r[2]), .B0(n934), .B1(s5_many_r[3]), 
        .Y(n1127) );
  NAND2X1TS U1407 ( .A(n1128), .B(n1127), .Y(n1457) );
  AO22XLTS U1408 ( .A0(n753), .A1(n757), .B0(n919), .B1(n705), .Y(
        dout_uni_y_man_dn[4]) );
  INVX2TS U1409 ( .A(s5_many_r[6]), .Y(n1139) );
  AOI22X1TS U1410 ( .A0(n1076), .A1(s5_many_r[8]), .B0(n947), .B1(s5_many_r[7]), .Y(n1129) );
  AOI21X1TS U1411 ( .A0(n749), .A1(s5_many_r[5]), .B0(n1130), .Y(n1327) );
  INVX2TS U1412 ( .A(n1327), .Y(n1297) );
  AOI22X1TS U1413 ( .A0(n1065), .A1(s5_many_r[1]), .B0(n948), .B1(s5_many_r[3]), .Y(n1132) );
  AOI22X1TS U1414 ( .A0(n935), .A1(s5_many_r[2]), .B0(n1075), .B1(s5_many_r[4]), .Y(n1131) );
  NAND2X1TS U1415 ( .A(n1132), .B(n1131), .Y(n1322) );
  AOI22X1TS U1416 ( .A0(n1084), .A1(n1297), .B0(n955), .B1(n1322), .Y(n1137)
         );
  AOI22X1TS U1417 ( .A0(n792), .A1(s5_many_r[12]), .B0(n948), .B1(
        s5_many_r[11]), .Y(n1134) );
  AOI22X1TS U1418 ( .A0(n1066), .A1(s5_many_r[9]), .B0(n933), .B1(
        s5_many_r[10]), .Y(n1133) );
  NAND2X1TS U1419 ( .A(n1134), .B(n1133), .Y(n1323) );
  CLKAND2X2TS U1420 ( .A(n791), .B(s5_many_r[0]), .Y(n1321) );
  AOI22X1TS U1421 ( .A0(n922), .A1(n1323), .B0(n953), .B1(n1321), .Y(n1136) );
  NAND2X1TS U1422 ( .A(n1137), .B(n1136), .Y(dout_uni_y_man_dn[11]) );
  AOI22X1TS U1423 ( .A0(n791), .A1(s5_many_r[9]), .B0(n783), .B1(s5_many_r[8]), 
        .Y(n1138) );
  OAI21XLTS U1424 ( .A0(n748), .A1(n1139), .B0(n1138), .Y(n1140) );
  AOI21X1TS U1425 ( .A0(n935), .A1(s5_many_r[7]), .B0(n1140), .Y(n1320) );
  INVX2TS U1426 ( .A(n1320), .Y(n1460) );
  AOI22X1TS U1427 ( .A0(n1083), .A1(n1460), .B0(n956), .B1(n1457), .Y(n1144)
         );
  AOI22X1TS U1428 ( .A0(s5_many_r[13]), .A1(n1077), .B0(n949), .B1(
        s5_many_r[12]), .Y(n1142) );
  AOI22X1TS U1429 ( .A0(n1065), .A1(s5_many_r[10]), .B0(n934), .B1(
        s5_many_r[11]), .Y(n1141) );
  NAND2X1TS U1430 ( .A(n1142), .B(n1141), .Y(n1462) );
  AOI22X1TS U1431 ( .A0(n921), .A1(n1462), .B0(n1476), .B1(n758), .Y(n1143) );
  NAND2X1TS U1432 ( .A(n1144), .B(n1143), .Y(dout_uni_y_man_dn[12]) );
  INVX2TS U1433 ( .A(s5_many_r[8]), .Y(n1302) );
  AOI22X1TS U1434 ( .A0(n1077), .A1(s5_many_r[10]), .B0(n947), .B1(
        s5_many_r[9]), .Y(n1145) );
  OAI21XLTS U1435 ( .A0(n1146), .A1(n1302), .B0(n1145), .Y(n1147) );
  AOI21X1TS U1436 ( .A0(n1067), .A1(s5_many_r[7]), .B0(n1147), .Y(n1341) );
  INVX2TS U1437 ( .A(n1341), .Y(n1475) );
  AOI22X1TS U1438 ( .A0(n1077), .A1(s5_many_r[6]), .B0(n950), .B1(s5_many_r[5]), .Y(n1149) );
  AOI22X1TS U1439 ( .A0(n1067), .A1(s5_many_r[3]), .B0(n933), .B1(s5_many_r[4]), .Y(n1148) );
  NAND2X1TS U1440 ( .A(n1149), .B(n1148), .Y(n1469) );
  AOI22X1TS U1441 ( .A0(n1085), .A1(n1475), .B0(n955), .B1(n707), .Y(n1153) );
  AOI22X1TS U1442 ( .A0(s5_many_r[13]), .A1(n1118), .B0(s5_many_r[14]), .B1(
        n792), .Y(n1151) );
  AOI22X1TS U1443 ( .A0(n1067), .A1(s5_many_r[11]), .B0(n936), .B1(
        s5_many_r[12]), .Y(n1150) );
  NAND2X1TS U1444 ( .A(n1151), .B(n1150), .Y(n1478) );
  AOI222XLTS U1445 ( .A0(s5_many_r[1]), .A1(n947), .B0(s5_many_r[0]), .B1(n933), .C0(s5_many_r[2]), .C1(n1117), .Y(n1309) );
  INVX2TS U1446 ( .A(n1309), .Y(n1467) );
  AOI22X1TS U1447 ( .A0(n920), .A1(n1478), .B0(n953), .B1(n1467), .Y(n1152) );
  NAND2X1TS U1448 ( .A(n1153), .B(n1152), .Y(dout_uni_y_man_dn[13]) );
  AO22XLTS U1449 ( .A0(n1083), .A1(n760), .B0(n919), .B1(n707), .Y(
        dout_uni_y_man_dn[5]) );
  NOR2BX1TS U1450 ( .AN(C43_DATA2_2), .B(n1387), .Y(dout_uni_y_exp[2]) );
  NOR2BX1TS U1451 ( .AN(C43_DATA2_3), .B(n1025), .Y(dout_uni_y_exp[3]) );
  NOR2BX1TS U1452 ( .AN(C43_DATA2_4), .B(n1025), .Y(dout_uni_y_exp[4]) );
  CMPR32X2TS U1453 ( .A(s2_br4_pp_r[40]), .B(s2_br4_pp_r[50]), .C(
        s2_br4_pp_r[60]), .CO(intadd_2_A_3_), .S(intadd_2_B_2_) );
  CMPR32X2TS U1454 ( .A(s2_br4_pp_r[41]), .B(s2_br4_pp_r[51]), .C(
        s2_br4_pp_r[61]), .CO(intadd_2_A_4_), .S(intadd_2_B_3_) );
  CMPR32X2TS U1455 ( .A(s2_br4_pp_r[42]), .B(s2_br4_pp_r[52]), .C(
        s2_br4_pp_r[62]), .CO(intadd_2_A_5_), .S(intadd_2_B_4_) );
  CMPR32X2TS U1456 ( .A(s2_br4_pp_r[43]), .B(s2_br4_pp_r[53]), .C(
        s2_br4_pp_r[63]), .CO(intadd_2_A_6_), .S(intadd_2_B_5_) );
  CMPR32X2TS U1457 ( .A(s2_br4_pp_r[44]), .B(s2_br4_pp_r[54]), .C(
        s2_br4_pp_r[64]), .CO(intadd_2_A_7_), .S(intadd_2_B_6_) );
  CMPR32X2TS U1458 ( .A(s2_br4_pp_r[45]), .B(s2_br4_pp_r[55]), .C(
        s2_br4_pp_r[65]), .CO(intadd_2_A_8_), .S(intadd_2_B_7_) );
  CMPR32X2TS U1459 ( .A(s2_br4_pp_r[46]), .B(s2_br4_pp_r[56]), .C(
        s2_br4_pp_r[66]), .CO(intadd_2_A_9_), .S(intadd_2_B_8_) );
  CMPR32X2TS U1460 ( .A(s2_br4_pp_r[47]), .B(s2_br4_pp_r[57]), .C(
        s2_br4_pp_r[67]), .CO(intadd_2_B_10_), .S(intadd_2_B_9_) );
  INVX2TS U1461 ( .A(s2_br4_s_r[3]), .Y(n1154) );
  CMPR32X2TS U1462 ( .A(s2_br4_pp_r[58]), .B(s2_br4_pp_r[68]), .C(n1154), .CO(
        intadd_2_A_11_), .S(intadd_2_A_10_) );
  INVX2TS U1463 ( .A(intadd_0_n1), .Y(s2_ps0[17]) );
  CMPR32X2TS U1464 ( .A(s2_br4_pp_r[4]), .B(s2_br4_pp_r[14]), .C(
        s2_br4_pp_r[24]), .CO(intadd_0_A_3_), .S(intadd_0_B_2_) );
  CMPR32X2TS U1465 ( .A(s2_br4_pp_r[5]), .B(s2_br4_pp_r[15]), .C(
        s2_br4_pp_r[25]), .CO(intadd_0_A_4_), .S(intadd_0_B_3_) );
  CMPR32X2TS U1466 ( .A(s2_br4_pp_r[6]), .B(s2_br4_pp_r[16]), .C(
        s2_br4_pp_r[26]), .CO(intadd_0_A_5_), .S(intadd_0_B_4_) );
  CMPR32X2TS U1467 ( .A(s2_br4_pp_r[7]), .B(s2_br4_pp_r[17]), .C(
        s2_br4_pp_r[27]), .CO(intadd_0_A_6_), .S(intadd_0_B_5_) );
  CMPR32X2TS U1468 ( .A(s2_br4_pp_r[8]), .B(s2_br4_pp_r[18]), .C(
        s2_br4_pp_r[28]), .CO(intadd_0_A_7_), .S(intadd_0_B_6_) );
  CMPR32X2TS U1469 ( .A(s2_br4_pp_r[9]), .B(s2_br4_pp_r[19]), .C(
        s2_br4_pp_r[29]), .CO(intadd_0_A_8_), .S(intadd_0_B_7_) );
  CMPR32X2TS U1470 ( .A(s2_br4_pp_r[10]), .B(s2_br4_pp_r[20]), .C(
        s2_br4_pp_r[30]), .CO(intadd_0_A_9_), .S(intadd_0_B_8_) );
  CMPR32X2TS U1471 ( .A(s2_br4_pp_r[11]), .B(s2_br4_pp_r[21]), .C(
        s2_br4_pp_r[31]), .CO(intadd_0_A_10_), .S(intadd_0_B_9_) );
  INVX2TS U1472 ( .A(s2_br4_s_r[2]), .Y(intadd_0_A_14_) );
  NAND2X1TS U1473 ( .A(s3_opcode_r[0]), .B(s3_opcode_r[1]), .Y(n1179) );
  INVX2TS U1474 ( .A(n1179), .Y(n1364) );
  CLKBUFX2TS U1475 ( .A(n1364), .Y(n1367) );
  CLKBUFX2TS U1476 ( .A(n1367), .Y(n1191) );
  NOR2XLTS U1477 ( .A(s3_opcode_r[0]), .B(n1155), .Y(n1365) );
  CLKBUFX2TS U1478 ( .A(n1365), .Y(n1368) );
  CLKBUFX2TS U1479 ( .A(n1368), .Y(n1358) );
  CLKBUFX2TS U1480 ( .A(n1358), .Y(n1190) );
  AOI22X1TS U1481 ( .A0(n1191), .A1(s3_lhs_r[1]), .B0(n1190), .B1(s3_ps0_r[1]), 
        .Y(n1159) );
  INVX2TS U1482 ( .A(s3_rhs_r[0]), .Y(n1156) );
  NOR2XLTS U1483 ( .A(n1156), .B(s3_addsubn_r), .Y(n1174) );
  CLKBUFX2TS U1484 ( .A(n1367), .Y(n1184) );
  CLKBUFX2TS U1485 ( .A(n1358), .Y(n1183) );
  AOI22X1TS U1486 ( .A0(n1184), .A1(s3_lhs_r[0]), .B0(n1183), .B1(s3_ps0_r[0]), 
        .Y(n1177) );
  INVX2TS U1487 ( .A(n1177), .Y(n1157) );
  AOI21X1TS U1488 ( .A0(s3_addsubn_r), .A1(n1156), .B0(n1179), .Y(n1175) );
  OAI21XLTS U1489 ( .A0(n1174), .A1(n1157), .B0(n1175), .Y(n1158) );
  NOR2XLTS U1490 ( .A(n1159), .B(n1158), .Y(n1167) );
  NAND2X1TS U1491 ( .A(n1159), .B(n1158), .Y(n1168) );
  NAND2BXLTS U1492 ( .AN(n1167), .B(n1168), .Y(n1162) );
  NOR2BX1TS U1493 ( .AN(s3_rhs_r[1]), .B(n1179), .Y(n1161) );
  AOI22X1TS U1494 ( .A0(s3_lhs_r[1]), .A1(n940), .B0(n1162), .B1(n1161), .Y(
        n1160) );
  OAI21XLTS U1495 ( .A0(n1162), .A1(n1161), .B0(n1160), .Y(n571) );
  AOI22X1TS U1496 ( .A0(n1191), .A1(s3_rhs_r[19]), .B0(n1190), .B1(
        s3_ps1_r[13]), .Y(n1164) );
  CLKBUFX2TS U1497 ( .A(n1364), .Y(n1377) );
  NAND2X1TS U1498 ( .A(n1377), .B(s3_lhs_r[19]), .Y(n1163) );
  NAND2X1TS U1499 ( .A(n1164), .B(n1163), .Y(n1192) );
  NAND2BXLTS U1500 ( .AN(n1193), .B(n1192), .Y(n1166) );
  AOI22X1TS U1501 ( .A0(s3_lhs_r[19]), .A1(n939), .B0(n1166), .B1(intadd_1_n1), 
        .Y(n1165) );
  OAI21XLTS U1502 ( .A0(n1166), .A1(intadd_1_n1), .B0(n1165), .Y(n589) );
  AOI22X1TS U1503 ( .A0(n1191), .A1(s3_lhs_r[2]), .B0(n1190), .B1(s3_ps0_r[2]), 
        .Y(n1170) );
  CLKBUFX2TS U1504 ( .A(n1367), .Y(n1205) );
  AOI31XLTS U1505 ( .A0(n1205), .A1(s3_rhs_r[1]), .A2(n1168), .B0(n1167), .Y(
        n1169) );
  NOR2XLTS U1506 ( .A(n1170), .B(n1169), .Y(n1180) );
  NAND2X1TS U1507 ( .A(n1170), .B(n1169), .Y(n1181) );
  NAND2BXLTS U1508 ( .AN(n1180), .B(n1181), .Y(n1173) );
  NOR2BX1TS U1509 ( .AN(s3_rhs_r[2]), .B(n1020), .Y(n1172) );
  AOI22X1TS U1510 ( .A0(s3_lhs_r[2]), .A1(n940), .B0(n1173), .B1(n1172), .Y(
        n1171) );
  OAI21XLTS U1511 ( .A0(n1173), .A1(n1172), .B0(n1171), .Y(n572) );
  NOR2BX1TS U1512 ( .AN(n1175), .B(n1174), .Y(n1178) );
  AOI22X1TS U1513 ( .A0(s3_lhs_r[0]), .A1(n1672), .B0(n1178), .B1(n1177), .Y(
        n1176) );
  OAI21XLTS U1514 ( .A0(n1178), .A1(n1177), .B0(n1176), .Y(n570) );
  NOR2BX1TS U1515 ( .AN(s3_rhs_r[3]), .B(n1020), .Y(n1201) );
  AOI31XLTS U1516 ( .A0(n1205), .A1(s3_rhs_r[2]), .A2(n1181), .B0(n1180), .Y(
        n1198) );
  AOI22X1TS U1517 ( .A0(s3_lhs_r[3]), .A1(n1205), .B0(n1183), .B1(s3_ps0_r[3]), 
        .Y(n1199) );
  OAI2BB2XLTS U1518 ( .B0(n1201), .B1(n1182), .A0N(n1198), .A1N(n1199), .Y(
        n1670) );
  AOI22X1TS U1519 ( .A0(n1184), .A1(s3_rhs_r[4]), .B0(n1183), .B1(s3_s2_r), 
        .Y(n1669) );
  AOI22X1TS U1520 ( .A0(n1184), .A1(s3_lhs_r[4]), .B0(n1183), .B1(s3_ps0_r[4]), 
        .Y(n1668) );
  CLKBUFX2TS U1521 ( .A(n1358), .Y(n1376) );
  AOI22X1TS U1522 ( .A0(n1184), .A1(s3_lhs_r[5]), .B0(n1376), .B1(s3_ps0_r[5]), 
        .Y(n1186) );
  CLKBUFX2TS U1523 ( .A(n1364), .Y(n1372) );
  CLKBUFX2TS U1524 ( .A(n1372), .Y(n1361) );
  CLKBUFX2TS U1525 ( .A(n1361), .Y(n1422) );
  NAND2X1TS U1526 ( .A(n1422), .B(s3_rhs_r[5]), .Y(n1185) );
  NOR2XLTS U1527 ( .A(n1186), .B(n1185), .Y(n1416) );
  INVX2TS U1528 ( .A(n1186), .Y(n1187) );
  AOI21X1TS U1529 ( .A0(n1422), .A1(s3_rhs_r[5]), .B0(n1187), .Y(n1417) );
  AOI22X1TS U1530 ( .A0(s3_lhs_r[5]), .A1(n940), .B0(n1419), .B1(n1189), .Y(
        n1188) );
  OAI21XLTS U1531 ( .A0(n1419), .A1(n1189), .B0(n1188), .Y(n575) );
  AOI22X1TS U1532 ( .A0(n1191), .A1(s3_rhs_r[20]), .B0(n1190), .B1(
        s3_ps1_r[14]), .Y(n1195) );
  NOR2XLTS U1533 ( .A(n1195), .B(n1194), .Y(n1203) );
  NAND2X1TS U1534 ( .A(n1195), .B(n1194), .Y(n1204) );
  NAND2BXLTS U1535 ( .AN(n1203), .B(n1204), .Y(n1197) );
  NAND2X1TS U1536 ( .A(s3_lhs_r[20]), .B(n778), .Y(n1196) );
  XOR2XLTS U1537 ( .A(n1197), .B(n1196), .Y(n590) );
  XNOR2X1TS U1538 ( .A(n1199), .B(n1198), .Y(n1202) );
  AOI22X1TS U1539 ( .A0(s3_lhs_r[3]), .A1(n938), .B0(n1202), .B1(n1201), .Y(
        n1200) );
  OAI21XLTS U1540 ( .A0(n1202), .A1(n1201), .B0(n1200), .Y(n573) );
  AOI31XLTS U1541 ( .A0(n1422), .A1(s3_lhs_r[20]), .A2(n1204), .B0(n1203), .Y(
        n1207) );
  AOI22X1TS U1542 ( .A0(n1205), .A1(s3_rhs_r[21]), .B0(n1376), .B1(
        s3_ps1_r[15]), .Y(n1206) );
  NOR2XLTS U1543 ( .A(n1207), .B(n1206), .Y(n1420) );
  NAND2X1TS U1544 ( .A(n1207), .B(n1206), .Y(n1421) );
  NAND2BXLTS U1545 ( .AN(n1420), .B(n1421), .Y(n1209) );
  NAND2X1TS U1546 ( .A(s3_lhs_r[21]), .B(n778), .Y(n1208) );
  XOR2XLTS U1547 ( .A(n1209), .B(n1208), .Y(n591) );
  OAI21XLTS U1548 ( .A0(n1210), .A1(n1060), .B0(n1007), .Y(n1211) );
  OAI21XLTS U1549 ( .A0(n1212), .A1(n1061), .B0(n1010), .Y(n1213) );
  OAI21XLTS U1550 ( .A0(n1060), .A1(n876), .B0(n1213), .Y(n667) );
  OAI21XLTS U1551 ( .A0(n1214), .A1(n1062), .B0(n1442), .Y(n1215) );
  OAI21XLTS U1552 ( .A0(n1061), .A1(n870), .B0(n1215), .Y(n668) );
  OAI21XLTS U1553 ( .A0(n1058), .A1(n1216), .B0(n1442), .Y(n1217) );
  OAI21XLTS U1554 ( .A0(n1059), .A1(n1218), .B0(n1010), .Y(n1219) );
  OAI21XLTS U1555 ( .A0(n1056), .A1(n1220), .B0(n1007), .Y(n1221) );
  OAI21XLTS U1556 ( .A0(n1056), .A1(n1653), .B0(n1221), .Y(n604) );
  OAI21XLTS U1557 ( .A0(n1057), .A1(n1658), .B0(n1222), .Y(n602) );
  AOI22X1TS U1558 ( .A0(n918), .A1(n812), .B0(n849), .B1(n1060), .Y(n1223) );
  OAI21XLTS U1559 ( .A0(n1224), .A1(n1063), .B0(n1013), .Y(n1225) );
  OAI21XLTS U1560 ( .A0(n1062), .A1(n872), .B0(n1225), .Y(n665) );
  AOI22X1TS U1561 ( .A0(n917), .A1(n849), .B0(n1054), .B1(n813), .Y(n1226) );
  OAI21XLTS U1562 ( .A0(n1053), .A1(n848), .B0(n1226), .Y(n652) );
  AOI22X1TS U1563 ( .A0(n882), .A1(n978), .B0(n988), .B1(n869), .Y(n1614) );
  AOI22X1TS U1564 ( .A0(n882), .A1(n976), .B0(n978), .B1(n869), .Y(n1609) );
  AOI22X1TS U1565 ( .A0(n901), .A1(n850), .B0(n898), .B1(n812), .Y(n1227) );
  OAI21XLTS U1566 ( .A0(n1614), .A1(n1598), .B0(n1227), .Y(n640) );
  AOI22X1TS U1567 ( .A0(n908), .A1(n851), .B0(n905), .B1(n813), .Y(n1228) );
  OAI21XLTS U1568 ( .A0(n906), .A1(n848), .B0(n1228), .Y(n622) );
  AOI22X1TS U1569 ( .A0(n1098), .A1(n850), .B0(n902), .B1(n812), .Y(n1229) );
  OAI21XLTS U1570 ( .A0(n1609), .A1(n847), .B0(n1229), .Y(n646) );
  AOI22X1TS U1571 ( .A0(n912), .A1(n851), .B0(n909), .B1(n813), .Y(n1231) );
  OAI21XLTS U1572 ( .A0(n910), .A1(n848), .B0(n1231), .Y(n628) );
  AOI22X1TS U1573 ( .A0(n897), .A1(n851), .B0(n913), .B1(n812), .Y(n1232) );
  OAI21XLTS U1574 ( .A0(n914), .A1(n847), .B0(n1232), .Y(n634) );
  AOI22X1TS U1575 ( .A0(n904), .A1(n851), .B0(n893), .B1(n813), .Y(n1234) );
  OAI21XLTS U1576 ( .A0(n894), .A1(n848), .B0(n1234), .Y(n616) );
  INVX2TS U1577 ( .A(s2_mmux_rhs_r[11]), .Y(n1280) );
  NOR4XLTS U1578 ( .A(s2_mmux_lhs_r[3]), .B(s2_mmux_lhs_r[18]), .C(
        s2_mmux_lhs_r[5]), .D(s2_mmux_lhs_r[19]), .Y(n1240) );
  NOR4XLTS U1579 ( .A(s2_mmux_lhs_r[7]), .B(s2_mmux_lhs_r[8]), .C(
        s2_mmux_lhs_r[4]), .D(s2_mmux_lhs_r[17]), .Y(n1239) );
  NOR4XLTS U1580 ( .A(s2_mmux_lhs_r[11]), .B(s2_mmux_lhs_r[13]), .C(
        s2_mmux_lhs_r[6]), .D(s2_mmux_lhs_r[9]), .Y(n1238) );
  OR4X2TS U1581 ( .A(s2_mmux_lhs_r[15]), .B(s2_mmux_lhs_r[2]), .C(
        s2_mmux_lhs_r[1]), .D(s2_mmux_lhs_r[0]), .Y(n1236) );
  OR4X2TS U1582 ( .A(s2_mmux_lhs_r[12]), .B(s2_mmux_lhs_r[14]), .C(
        s2_mmux_lhs_r[16]), .D(s2_mmux_lhs_r[10]), .Y(n1235) );
  NOR4XLTS U1583 ( .A(s2_mmux_lhs_r[21]), .B(s2_mmux_lhs_r[20]), .C(n1236), 
        .D(n1235), .Y(n1237) );
  NAND4XLTS U1584 ( .A(n1240), .B(n1239), .C(n1238), .D(n1237), .Y(n1241) );
  INVX2TS U1585 ( .A(s2_mmux_rhs_r[19]), .Y(n1277) );
  NOR2XLTS U1586 ( .A(n1277), .B(n788), .Y(s2_mmux3_lhs_addsub[19]) );
  INVX2TS U1587 ( .A(n805), .Y(n1570) );
  NAND4XLTS U1588 ( .A(n803), .B(n762), .C(n1570), .D(n1498), .Y(n1559) );
  INVX2TS U1589 ( .A(n801), .Y(n1549) );
  AOI22X1TS U1590 ( .A0(n781), .A1(n733), .B0(n1071), .B1(n735), .Y(n1243) );
  AOI22X1TS U1591 ( .A0(n930), .A1(n737), .B0(n927), .B1(s2_mmux_rhs_r[18]), 
        .Y(n1242) );
  NAND2X1TS U1592 ( .A(n1243), .B(n1242), .Y(n1566) );
  AOI22X1TS U1593 ( .A0(s2_mmux_rhs_r[7]), .A1(n943), .B0(n786), .B1(n721), 
        .Y(n1245) );
  AOI22X1TS U1594 ( .A0(n931), .A1(s2_mmux_rhs_r[9]), .B0(n926), .B1(
        s2_mmux_rhs_r[10]), .Y(n1244) );
  NAND2X1TS U1595 ( .A(n1245), .B(n1244), .Y(n1521) );
  AO22XLTS U1596 ( .A0(n1549), .A1(n1566), .B0(n1046), .B1(n1521), .Y(n1251)
         );
  CLKBUFX2TS U1597 ( .A(n1543), .Y(n1535) );
  INVX2TS U1598 ( .A(n1535), .Y(n1285) );
  AOI22X1TS U1599 ( .A0(n929), .A1(s2_mmux_rhs_r[21]), .B0(n1070), .B1(n741), 
        .Y(n1246) );
  OAI21XLTS U1600 ( .A0(n779), .A1(n1277), .B0(n1246), .Y(n1579) );
  NAND4XLTS U1601 ( .A(s2_ea_sub_eb_abs_r[3]), .B(s2_ea_sub_eb_abs_r[2]), .C(
        n762), .D(n1570), .Y(n1539) );
  AOI22X1TS U1602 ( .A0(n924), .A1(n731), .B0(n785), .B1(n727), .Y(n1247) );
  AOI21X1TS U1603 ( .A0(n929), .A1(n729), .B0(n1248), .Y(n1548) );
  NOR3XLTS U1604 ( .A(n803), .B(n805), .C(n808), .Y(n1522) );
  NAND2X1TS U1605 ( .A(n1522), .B(n806), .Y(n1557) );
  OAI22X1TS U1606 ( .A0(n690), .A1(n1539), .B0(n1548), .B1(n816), .Y(n1250) );
  OAI21XLTS U1607 ( .A0(n1251), .A1(n1250), .B0(n1493), .Y(n1249) );
  OAI31X1TS U1608 ( .A0(n1251), .A1(n1285), .A2(n1250), .B0(n1249), .Y(
        s2_mmux3_rhs_addsub[7]) );
  AOI22X1TS U1609 ( .A0(n944), .A1(n731), .B0(n1070), .B1(n733), .Y(n1253) );
  AOI22X1TS U1610 ( .A0(n928), .A1(n735), .B0(n926), .B1(n737), .Y(n1252) );
  NAND2X1TS U1611 ( .A(n1253), .B(n1252), .Y(n1563) );
  AOI22X1TS U1612 ( .A0(n717), .A1(n945), .B0(s2_mmux_rhs_r[7]), .B1(n1069), 
        .Y(n1255) );
  AOI22X1TS U1613 ( .A0(n745), .A1(s2_mmux_rhs_r[8]), .B0(n1517), .B1(
        s2_mmux_rhs_r[9]), .Y(n1254) );
  NAND2X1TS U1614 ( .A(n1255), .B(n1254), .Y(n1510) );
  AO22XLTS U1615 ( .A0(n1549), .A1(n1563), .B0(n1047), .B1(n1510), .Y(n1260)
         );
  AOI22X1TS U1616 ( .A0(n924), .A1(n729), .B0(n944), .B1(n725), .Y(n1256) );
  OAI2BB1X1TS U1617 ( .A0N(n1069), .A1N(s2_mmux_rhs_r[11]), .B0(n1256), .Y(
        n1257) );
  AOI21X1TS U1618 ( .A0(n745), .A1(n727), .B0(n1257), .Y(n1545) );
  OAI22X1TS U1619 ( .A0(n700), .A1(n1539), .B0(n1545), .B1(n816), .Y(n1259) );
  OAI21XLTS U1620 ( .A0(n1260), .A1(n1259), .B0(n1493), .Y(n1258) );
  OAI31X1TS U1621 ( .A0(n1260), .A1(n1285), .A2(n1259), .B0(n1258), .Y(
        s2_mmux3_rhs_addsub[6]) );
  INVX2TS U1622 ( .A(n1572), .Y(n1677) );
  OAI221XLTS U1623 ( .A0(n1263), .A1(n1322), .B0(n1262), .B1(n1321), .C0(n1261), .Y(n1300) );
  NOR2XLTS U1624 ( .A(n1264), .B(n1300), .Y(dout_uni_y_man_dn[3]) );
  AOI22X1TS U1625 ( .A0(n781), .A1(s2_mmux_rhs_r[13]), .B0(n786), .B1(
        s2_mmux_rhs_r[14]), .Y(n1266) );
  AOI22X1TS U1626 ( .A0(n745), .A1(s2_mmux_rhs_r[15]), .B0(n927), .B1(
        s2_mmux_rhs_r[16]), .Y(n1265) );
  NAND2X1TS U1627 ( .A(n1266), .B(n1265), .Y(n1504) );
  INVX2TS U1628 ( .A(n1504), .Y(n1555) );
  AOI22X1TS U1629 ( .A0(n942), .A1(n737), .B0(n1069), .B1(n739), .Y(n1267) );
  OAI21XLTS U1630 ( .A0(n744), .A1(n1277), .B0(n1267), .Y(n1268) );
  AOI21X1TS U1631 ( .A0(n924), .A1(n741), .B0(n1268), .Y(n1556) );
  OAI22X1TS U1632 ( .A0(n1555), .A1(n816), .B0(n1556), .B1(n801), .Y(n1273) );
  AOI22X1TS U1633 ( .A0(n781), .A1(n723), .B0(n786), .B1(n725), .Y(n1269) );
  OAI21XLTS U1634 ( .A0(n744), .A1(n1280), .B0(n1269), .Y(n1270) );
  AOI21X1TS U1635 ( .A0(n926), .A1(s2_mmux_rhs_r[12]), .B0(n1270), .Y(n1538)
         );
  OAI22X1TS U1636 ( .A0(n1538), .A1(n754), .B0(n764), .B1(n1558), .Y(n1272) );
  INVX2TS U1637 ( .A(n1535), .Y(n1561) );
  OAI21XLTS U1638 ( .A0(n1273), .A1(n1272), .B0(n1561), .Y(n1271) );
  OAI31X1TS U1639 ( .A0(n1273), .A1(n1285), .A2(n1272), .B0(n1271), .Y(
        s2_mmux3_rhs_addsub[9]) );
  AOI22X1TS U1640 ( .A0(n943), .A1(s2_mmux_rhs_r[12]), .B0(n1068), .B1(
        s2_mmux_rhs_r[13]), .Y(n1275) );
  AOI22X1TS U1641 ( .A0(n931), .A1(s2_mmux_rhs_r[14]), .B0(n925), .B1(
        s2_mmux_rhs_r[15]), .Y(n1274) );
  NAND2X1TS U1642 ( .A(n1275), .B(n1274), .Y(n1492) );
  INVX2TS U1643 ( .A(n1492), .Y(n1552) );
  AOI22X1TS U1644 ( .A0(n780), .A1(n735), .B0(n785), .B1(n737), .Y(n1276) );
  AOI21X1TS U1645 ( .A0(n930), .A1(n739), .B0(n1278), .Y(n1553) );
  OAI22X1TS U1646 ( .A0(n1552), .A1(n815), .B0(n1553), .B1(n1559), .Y(n1286)
         );
  AOI22X1TS U1647 ( .A0(n930), .A1(s2_mmux_rhs_r[10]), .B0(n1071), .B1(n723), 
        .Y(n1279) );
  OAI21XLTS U1648 ( .A0(n1281), .A1(n1280), .B0(n1279), .Y(n1282) );
  AOI21X1TS U1649 ( .A0(n945), .A1(s2_mmux_rhs_r[8]), .B0(n1282), .Y(n1531) );
  OAI22X1TS U1650 ( .A0(n766), .A1(n764), .B0(n1531), .B1(n754), .Y(n1284) );
  OAI21XLTS U1651 ( .A0(n1286), .A1(n1284), .B0(n1561), .Y(n1283) );
  OAI31X1TS U1652 ( .A0(n1286), .A1(n1285), .A2(n1284), .B0(n1283), .Y(
        s2_mmux3_rhs_addsub[8]) );
  AOI22X1TS U1653 ( .A0(s4_many_r[4]), .A1(n1029), .B0(n1398), .B1(
        s4_many_r[12]), .Y(n1287) );
  NAND2BXLTS U1654 ( .AN(s4_many_r[20]), .B(n1287), .Y(n1405) );
  AO22XLTS U1655 ( .A0(n796), .A1(s4_many_r[13]), .B0(n1028), .B1(s4_many_r[5]), .Y(n1288) );
  NOR2XLTS U1656 ( .A(s4_many_r[21]), .B(n1288), .Y(n1402) );
  AO22XLTS U1657 ( .A0(n796), .A1(s4_many_r[14]), .B0(n1029), .B1(s4_many_r[6]), .Y(n1289) );
  NOR2XLTS U1658 ( .A(s4_many_r[22]), .B(n1289), .Y(n1410) );
  AOI22X1TS U1659 ( .A0(n1398), .A1(s4_many_r[11]), .B0(n1028), .B1(
        s4_many_r[3]), .Y(n1290) );
  NAND4BXLTS U1660 ( .AN(s4_many_r[19]), .B(n1402), .C(n1410), .D(n1290), .Y(
        n1291) );
  AOI22X1TS U1661 ( .A0(n792), .A1(s5_many_r[20]), .B0(n1118), .B1(
        s5_many_r[19]), .Y(n1293) );
  AOI22X1TS U1662 ( .A0(n749), .A1(s5_many_r[17]), .B0(n935), .B1(
        s5_many_r[18]), .Y(n1292) );
  NAND2X1TS U1663 ( .A(n1293), .B(n1292), .Y(n1296) );
  AOI22X1TS U1664 ( .A0(n1117), .A1(s5_many_r[16]), .B0(n950), .B1(
        s5_many_r[15]), .Y(n1295) );
  AOI22X1TS U1665 ( .A0(n1064), .A1(s5_many_r[13]), .B0(n1471), .B1(
        s5_many_r[14]), .Y(n1294) );
  NAND2X1TS U1666 ( .A(n1295), .B(n1294), .Y(n1324) );
  AOI22X1TS U1667 ( .A0(n921), .A1(n1296), .B0(n1084), .B1(n1324), .Y(n1299)
         );
  AOI22X1TS U1668 ( .A0(n1476), .A1(n1297), .B0(n954), .B1(n1323), .Y(n1298)
         );
  AOI22X1TS U1669 ( .A0(n1117), .A1(s5_many_r[11]), .B0(n783), .B1(
        s5_many_r[10]), .Y(n1301) );
  OAI21XLTS U1670 ( .A0(n748), .A1(n1302), .B0(n1301), .Y(n1303) );
  AOI21X1TS U1671 ( .A0(n936), .A1(s5_many_r[9]), .B0(n1303), .Y(n1335) );
  AOI22X1TS U1672 ( .A0(n956), .A1(n1331), .B0(n953), .B1(n703), .Y(n1307) );
  AOI22X1TS U1673 ( .A0(s5_many_r[14]), .A1(n950), .B0(n1076), .B1(
        s5_many_r[15]), .Y(n1305) );
  AOI22X1TS U1674 ( .A0(n749), .A1(s5_many_r[12]), .B0(s5_many_r[13]), .B1(
        n1471), .Y(n1304) );
  NAND2X1TS U1675 ( .A(n1305), .B(n1304), .Y(n1328) );
  NAND2X1TS U1676 ( .A(n920), .B(n1328), .Y(n1306) );
  OAI211XLTS U1677 ( .A0(n1335), .A1(n752), .B0(n1307), .C0(n1306), .Y(
        dout_uni_y_man_dn[14]) );
  INVX2TS U1678 ( .A(n919), .Y(n1314) );
  NOR2XLTS U1679 ( .A(n1309), .B(n1026), .Y(dout_uni_y_man_dn[1]) );
  AOI22X1TS U1680 ( .A0(n1085), .A1(n1469), .B0(n956), .B1(n760), .Y(n1310) );
  OAI21XLTS U1681 ( .A0(n1341), .A1(n1314), .B0(n1310), .Y(
        dout_uni_y_man_dn[9]) );
  AOI22X1TS U1682 ( .A0(n1084), .A1(n1457), .B0(n955), .B1(n758), .Y(n1311) );
  OAI21XLTS U1683 ( .A0(n1320), .A1(n1314), .B0(n1311), .Y(
        dout_uni_y_man_dn[8]) );
  AOI22X1TS U1684 ( .A0(n1086), .A1(n1322), .B0(n956), .B1(n1321), .Y(n1312)
         );
  OAI21XLTS U1685 ( .A0(n1327), .A1(n1314), .B0(n1312), .Y(
        dout_uni_y_man_dn[7]) );
  AOI22X1TS U1686 ( .A0(n1086), .A1(n1331), .B0(n955), .B1(n703), .Y(n1313) );
  OAI21XLTS U1687 ( .A0(n1335), .A1(n1026), .B0(n1313), .Y(
        dout_uni_y_man_dn[10]) );
  INVX2TS U1688 ( .A(n954), .Y(n1340) );
  AOI22X1TS U1689 ( .A0(n953), .A1(n705), .B0(n771), .B1(n757), .Y(n1319) );
  AOI22X1TS U1690 ( .A0(n1075), .A1(s5_many_r[17]), .B0(s5_many_r[16]), .B1(
        n948), .Y(n1317) );
  AOI22X1TS U1691 ( .A0(n1067), .A1(s5_many_r[14]), .B0(n936), .B1(
        s5_many_r[15]), .Y(n1316) );
  NAND2X1TS U1692 ( .A(n1317), .B(n1316), .Y(n1463) );
  AOI22X1TS U1693 ( .A0(n921), .A1(n1463), .B0(n753), .B1(n1462), .Y(n1318) );
  OAI211XLTS U1694 ( .A0(n1320), .A1(n1340), .B0(n1319), .C0(n1318), .Y(
        dout_uni_y_man_dn[16]) );
  AOI22X1TS U1695 ( .A0(n1476), .A1(n1322), .B0(n771), .B1(n1321), .Y(n1326)
         );
  AOI22X1TS U1696 ( .A0(n920), .A1(n1324), .B0(n1085), .B1(n1323), .Y(n1325)
         );
  OAI211XLTS U1697 ( .A0(n1327), .A1(n1340), .B0(n1326), .C0(n1325), .Y(
        dout_uni_y_man_dn[15]) );
  AOI22X1TS U1698 ( .A0(n1083), .A1(n1328), .B0(n771), .B1(n703), .Y(n1334) );
  AOI22X1TS U1699 ( .A0(n1077), .A1(s5_many_r[19]), .B0(n1118), .B1(
        s5_many_r[18]), .Y(n1330) );
  AOI22X1TS U1700 ( .A0(n1065), .A1(s5_many_r[16]), .B0(n934), .B1(
        s5_many_r[17]), .Y(n1329) );
  NAND2X1TS U1701 ( .A(n1330), .B(n1329), .Y(n1332) );
  AOI22X1TS U1702 ( .A0(n922), .A1(n1332), .B0(n952), .B1(n1331), .Y(n1333) );
  OAI211XLTS U1703 ( .A0(n1335), .A1(n1340), .B0(n1334), .C0(n1333), .Y(
        dout_uni_y_man_dn[18]) );
  AOI22X1TS U1704 ( .A0(n1083), .A1(n1478), .B0(n772), .B1(n760), .Y(n1339) );
  AOI22X1TS U1705 ( .A0(n792), .A1(s5_many_r[18]), .B0(n949), .B1(
        s5_many_r[17]), .Y(n1337) );
  AOI22X1TS U1706 ( .A0(n1066), .A1(s5_many_r[15]), .B0(n1471), .B1(
        s5_many_r[16]), .Y(n1336) );
  NAND2X1TS U1707 ( .A(n1337), .B(n1336), .Y(n1479) );
  AOI22X1TS U1708 ( .A0(n921), .A1(n1479), .B0(n952), .B1(n707), .Y(n1338) );
  OAI211XLTS U1709 ( .A0(n1341), .A1(n1340), .B0(n1339), .C0(n1338), .Y(
        dout_uni_y_man_dn[17]) );
  NOR2BX1TS U1710 ( .AN(n970), .B(n966), .Y(n1595) );
  OA22X1TS U1711 ( .A0(n970), .A1(n965), .B0(n1595), .B1(intadd_3_n1), .Y(
        n1429) );
  CLKBUFX2TS U1712 ( .A(n1429), .Y(n1425) );
  CLKBUFX2TS U1713 ( .A(n1425), .Y(n1446) );
  CLKBUFX2TS U1714 ( .A(n1446), .Y(n1450) );
  INVX2TS U1715 ( .A(n1450), .Y(n1676) );
  CLKINVX1TS U1716 ( .A(din_uni_a_exp[3]), .Y(intadd_3_B_2_) );
  INVX2TS U1717 ( .A(s5_ea_r[0]), .Y(n1344) );
  NAND2X1TS U1718 ( .A(n774), .B(n709), .Y(n1389) );
  NAND2X1TS U1719 ( .A(n769), .B(n1389), .Y(n1342) );
  INVX2TS U1720 ( .A(n1342), .Y(n1381) );
  AOI211XLTS U1721 ( .A0(n1051), .A1(n1344), .B0(n797), .C0(n1343), .Y(
        U2_RSOP_134_C1_Z_0) );
  INVX2TS U1722 ( .A(s5_ea_r[1]), .Y(n1346) );
  NOR2XLTS U1723 ( .A(s5_eb_r[1]), .B(n1050), .Y(n1345) );
  AOI211XLTS U1724 ( .A0(n1051), .A1(n1346), .B0(n797), .C0(n1345), .Y(
        U2_RSOP_134_C1_Z_1) );
  MXI2XLTS U1725 ( .A(s5_eb_r[2]), .B(s5_ea_r[2]), .S0(n1052), .Y(n1348) );
  NOR2XLTS U1726 ( .A(n773), .B(s5_opcode_r[0]), .Y(n1392) );
  INVX2TS U1727 ( .A(n1392), .Y(n1347) );
  OAI21XLTS U1728 ( .A0(n797), .A1(n1348), .B0(n1347), .Y(U2_RSOP_134_C1_Z_2)
         );
  INVX2TS U1729 ( .A(s5_ea_r[3]), .Y(n1350) );
  NOR2XLTS U1730 ( .A(s5_eb_r[3]), .B(n1052), .Y(n1349) );
  AOI211XLTS U1731 ( .A0(n1050), .A1(n1350), .B0(n1381), .C0(n1349), .Y(
        U2_RSOP_134_C1_Z_3) );
  INVX2TS U1732 ( .A(s5_ea_r[4]), .Y(n1352) );
  NOR2XLTS U1733 ( .A(s5_eb_r[4]), .B(n1051), .Y(n1351) );
  AOI211XLTS U1734 ( .A0(n1052), .A1(n1352), .B0(n1381), .C0(n1351), .Y(
        U2_RSOP_134_C1_Z_4) );
  NAND2BXLTS U1735 ( .AN(s2_br4_s_r[4]), .B(s2_br4_pp_r[70]), .Y(n1354) );
  XOR2XLTS U1736 ( .A(s2_br4_pp_r[71]), .B(intadd_2_n1), .Y(n1353) );
  XOR2XLTS U1737 ( .A(n1354), .B(n1353), .Y(s2_ps1[15]) );
  OR2X1TS U1738 ( .A(s2_br4_pp_r[69]), .B(s2_br4_pp_r[59]), .Y(intadd_2_B_12_)
         );
  INVX2TS U1739 ( .A(s2_br4_pp_r[34]), .Y(n1356) );
  INVX2TS U1740 ( .A(n1355), .Y(intadd_0_B_12_) );
  INVX2TS U1741 ( .A(n1357), .Y(intadd_0_B_13_) );
  CLKBUFX2TS U1742 ( .A(n1361), .Y(n1360) );
  CLKBUFX2TS U1743 ( .A(n1368), .Y(n1359) );
  AO22XLTS U1744 ( .A0(n1360), .A1(s3_lhs_r[6]), .B0(n1359), .B1(s3_ps0_r[6]), 
        .Y(intadd_1_CI) );
  CLKBUFX2TS U1745 ( .A(n1365), .Y(n1373) );
  AO22XLTS U1746 ( .A0(n1377), .A1(s3_rhs_r[6]), .B0(n1373), .B1(s3_ps1_r[0]), 
        .Y(intadd_1_B_0_) );
  AO22XLTS U1747 ( .A0(n1360), .A1(s3_lhs_r[7]), .B0(n1359), .B1(s3_ps0_r[7]), 
        .Y(intadd_1_B_1_) );
  AO22XLTS U1748 ( .A0(n1360), .A1(s3_rhs_r[7]), .B0(n1359), .B1(s3_ps1_r[1]), 
        .Y(intadd_1_A_1_) );
  CLKBUFX2TS U1749 ( .A(n1358), .Y(n1362) );
  AO22XLTS U1750 ( .A0(n1372), .A1(s3_lhs_r[8]), .B0(n1362), .B1(s3_ps0_r[8]), 
        .Y(intadd_1_B_2_) );
  AO22XLTS U1751 ( .A0(n1372), .A1(s3_rhs_r[8]), .B0(n1359), .B1(s3_ps1_r[2]), 
        .Y(intadd_1_A_2_) );
  AO22XLTS U1752 ( .A0(n1360), .A1(s3_lhs_r[9]), .B0(n1362), .B1(s3_ps0_r[9]), 
        .Y(intadd_1_B_3_) );
  AO22XLTS U1753 ( .A0(n1361), .A1(s3_rhs_r[9]), .B0(n1362), .B1(s3_ps1_r[3]), 
        .Y(intadd_1_A_3_) );
  CLKBUFX2TS U1754 ( .A(n1361), .Y(n1363) );
  CLKBUFX2TS U1755 ( .A(n1368), .Y(n1366) );
  AO22XLTS U1756 ( .A0(n1363), .A1(s3_lhs_r[10]), .B0(n1366), .B1(s3_ps0_r[10]), .Y(intadd_1_B_4_) );
  AO22XLTS U1757 ( .A0(n1363), .A1(s3_rhs_r[10]), .B0(n1362), .B1(s3_ps1_r[4]), 
        .Y(intadd_1_A_4_) );
  AO22XLTS U1758 ( .A0(n1363), .A1(s3_lhs_r[11]), .B0(n1366), .B1(s3_ps0_r[11]), .Y(intadd_1_B_5_) );
  AO22XLTS U1759 ( .A0(n1363), .A1(s3_rhs_r[11]), .B0(n1366), .B1(s3_ps1_r[5]), 
        .Y(intadd_1_A_5_) );
  CLKBUFX2TS U1760 ( .A(n1364), .Y(n1371) );
  CLKBUFX2TS U1761 ( .A(n1365), .Y(n1370) );
  AO22XLTS U1762 ( .A0(n1371), .A1(s3_lhs_r[12]), .B0(n1370), .B1(s3_ps0_r[12]), .Y(intadd_1_B_6_) );
  AO22XLTS U1763 ( .A0(n1371), .A1(s3_rhs_r[12]), .B0(n1366), .B1(s3_ps1_r[6]), 
        .Y(intadd_1_A_6_) );
  CLKBUFX2TS U1764 ( .A(n1367), .Y(n1369) );
  AO22XLTS U1765 ( .A0(n1369), .A1(s3_lhs_r[13]), .B0(n1370), .B1(s3_ps0_r[13]), .Y(intadd_1_B_7_) );
  AO22XLTS U1766 ( .A0(n1371), .A1(s3_rhs_r[13]), .B0(n1370), .B1(s3_ps1_r[7]), 
        .Y(intadd_1_A_7_) );
  CLKBUFX2TS U1767 ( .A(n1368), .Y(n1374) );
  AO22XLTS U1768 ( .A0(n1369), .A1(s3_lhs_r[14]), .B0(n1374), .B1(s3_ps0_r[14]), .Y(intadd_1_B_8_) );
  AO22XLTS U1769 ( .A0(n1369), .A1(s3_rhs_r[14]), .B0(n1374), .B1(s3_ps1_r[8]), 
        .Y(intadd_1_A_8_) );
  AO22XLTS U1770 ( .A0(n1369), .A1(s3_lhs_r[15]), .B0(n1374), .B1(s3_ps0_r[15]), .Y(intadd_1_B_9_) );
  AO22XLTS U1771 ( .A0(n1371), .A1(s3_rhs_r[15]), .B0(n1370), .B1(s3_ps1_r[9]), 
        .Y(intadd_1_A_9_) );
  CLKBUFX2TS U1772 ( .A(n1372), .Y(n1375) );
  AO22XLTS U1773 ( .A0(n1375), .A1(s3_lhs_r[16]), .B0(n1373), .B1(s3_ps0_r[16]), .Y(intadd_1_B_10_) );
  AO22XLTS U1774 ( .A0(n1375), .A1(s3_rhs_r[16]), .B0(n1373), .B1(s3_ps1_r[10]), .Y(intadd_1_A_10_) );
  AO22XLTS U1775 ( .A0(n1375), .A1(s3_lhs_r[17]), .B0(n1373), .B1(s3_ps0_r[17]), .Y(intadd_1_B_11_) );
  AO22XLTS U1776 ( .A0(n1375), .A1(s3_rhs_r[17]), .B0(n1374), .B1(s3_ps1_r[11]), .Y(intadd_1_A_11_) );
  AO22XLTS U1777 ( .A0(n1377), .A1(s3_lhs_r[18]), .B0(n1376), .B1(s3_ps0_r[18]), .Y(intadd_1_B_12_) );
  AO22XLTS U1778 ( .A0(n1377), .A1(s3_rhs_r[18]), .B0(n1376), .B1(s3_ps1_r[12]), .Y(intadd_1_A_12_) );
  XOR2XLTS U1779 ( .A(s5_ea_r[5]), .B(s5_eb_r[5]), .Y(n1378) );
  XOR2XLTS U1780 ( .A(DP_OP_155J1_125_6824_n24), .B(n1378), .Y(n1379) );
  CLKAND2X2TS U1781 ( .A(n1379), .B(n1030), .Y(n1385) );
  INVX2TS U1782 ( .A(s5_ea_r[5]), .Y(n1382) );
  AOI211XLTS U1783 ( .A0(n1051), .A1(n1382), .B0(n1381), .C0(n1380), .Y(n1383)
         );
  XNOR2X1TS U1784 ( .A(DP_OP_155J1_125_6824_n10), .B(n1383), .Y(n1384) );
  XOR2XLTS U1785 ( .A(n1385), .B(n1384), .Y(n1386) );
  XOR2XLTS U1786 ( .A(n1386), .B(DP_OP_155J1_125_6824_n2), .Y(n1388) );
  NOR2BX1TS U1787 ( .AN(n1388), .B(n1025), .Y(dout_uni_y_exp[5]) );
  INVX2TS U1788 ( .A(s5_lzd_r[1]), .Y(DP_OP_155J1_125_6824_n21) );
  INVX2TS U1789 ( .A(s5_lzd_r[2]), .Y(DP_OP_155J1_125_6824_n20) );
  INVX2TS U1790 ( .A(s5_lzd_r[3]), .Y(DP_OP_155J1_125_6824_n19) );
  INVX2TS U1791 ( .A(s5_lzd_r[4]), .Y(DP_OP_155J1_125_6824_n18) );
  INVX2TS U1792 ( .A(n1389), .Y(n1390) );
  AO21XLTS U1793 ( .A0(DP_OP_155J1_125_6824_n40), .A1(n1392), .B0(n1390), .Y(
        DP_OP_155J1_125_6824_n34) );
  AO21XLTS U1794 ( .A0(DP_OP_155J1_125_6824_n39), .A1(n1392), .B0(n770), .Y(
        DP_OP_155J1_125_6824_n33) );
  CLKAND2X2TS U1795 ( .A(DP_OP_155J1_125_6824_n43), .B(n1030), .Y(
        DP_OP_155J1_125_6824_n37) );
  CLKAND2X2TS U1796 ( .A(DP_OP_155J1_125_6824_n42), .B(n1030), .Y(
        DP_OP_155J1_125_6824_n36) );
  CLKAND2X2TS U1797 ( .A(DP_OP_155J1_125_6824_n41), .B(n1392), .Y(
        DP_OP_155J1_125_6824_n35) );
  NOR3XLTS U1798 ( .A(s4_many_r[5]), .B(s4_many_r[6]), .C(s4_many_r[1]), .Y(
        n1394) );
  NOR4XLTS U1799 ( .A(s4_many_r[4]), .B(s4_many_r[3]), .C(s4_many_r[2]), .D(
        s4_many_r[0]), .Y(n1393) );
  NAND2X1TS U1800 ( .A(n1394), .B(n1393), .Y(n1397) );
  AOI21X1TS U1801 ( .A0(n1397), .A1(n1396), .B0(n1395), .Y(n1679) );
  INVX2TS U1802 ( .A(s4_many_r[8]), .Y(n1400) );
  AOI21X1TS U1803 ( .A0(n1679), .A1(n1400), .B0(n1399), .Y(n1406) );
  AO22XLTS U1804 ( .A0(s4_many_r[9]), .A1(n1679), .B0(n1028), .B1(s4_many_r[1]), .Y(n1401) );
  OAI21XLTS U1805 ( .A0(s4_many_r[17]), .A1(n1401), .B0(n1680), .Y(n1404) );
  INVX2TS U1806 ( .A(n1402), .Y(n1403) );
  NOR2BX1TS U1807 ( .AN(n1404), .B(n1403), .Y(n1413) );
  OAI21XLTS U1808 ( .A0(n1406), .A1(n1405), .B0(n1413), .Y(n1411) );
  INVX2TS U1809 ( .A(s4_many_r[18]), .Y(n1408) );
  AOI22X1TS U1810 ( .A0(s4_many_r[10]), .A1(n1679), .B0(n1029), .B1(
        s4_many_r[2]), .Y(n1407) );
  OAI2BB1X1TS U1811 ( .A0N(n1408), .A1N(n1407), .B0(n1680), .Y(n1409) );
  NAND2X1TS U1812 ( .A(n1410), .B(n1409), .Y(n1412) );
  NOR2BX1TS U1813 ( .AN(n1411), .B(n1412), .Y(n593) );
  NOR2BX1TS U1814 ( .AN(n1413), .B(n1412), .Y(n594) );
  INVX2TS U1815 ( .A(s2_br4_pp_r[35]), .Y(intadd_0_A_13_) );
  CLKAND2X2TS U1816 ( .A(s2_br4_pp_r[13]), .B(s2_br4_pp_r[3]), .Y(
        intadd_0_A_2_) );
  AOI2BB1XLTS U1817 ( .A0N(s2_br4_pp_r[13]), .A1N(s2_br4_pp_r[3]), .B0(
        intadd_0_A_2_), .Y(intadd_0_A_1_) );
  CLKAND2X2TS U1818 ( .A(s2_br4_pp_r[12]), .B(s2_br4_pp_r[2]), .Y(
        intadd_0_B_1_) );
  AOI2BB1XLTS U1819 ( .A0N(s2_br4_pp_r[12]), .A1N(s2_br4_pp_r[2]), .B0(
        intadd_0_B_1_), .Y(intadd_0_B_0_) );
  AOI2BB1XLTS U1820 ( .A0N(s2_br4_pp_r[0]), .A1N(n1027), .B0(n1414), .Y(
        s2_ps0[0]) );
  XNOR2X1TS U1821 ( .A(s2_br4_s_r[4]), .B(s2_br4_pp_r[70]), .Y(intadd_2_A_12_)
         );
  OAI2BB1X1TS U1822 ( .A0N(s2_br4_pp_r[59]), .A1N(s2_br4_pp_r[69]), .B0(
        intadd_2_B_12_), .Y(intadd_2_B_11_) );
  CLKAND2X2TS U1823 ( .A(s2_br4_pp_r[49]), .B(s2_br4_pp_r[39]), .Y(
        intadd_2_A_2_) );
  AOI2BB1XLTS U1824 ( .A0N(s2_br4_pp_r[49]), .A1N(s2_br4_pp_r[39]), .B0(
        intadd_2_A_2_), .Y(intadd_2_A_1_) );
  CLKAND2X2TS U1825 ( .A(s2_br4_pp_r[48]), .B(s2_br4_pp_r[38]), .Y(
        intadd_2_B_1_) );
  AOI2BB1XLTS U1826 ( .A0N(s2_br4_pp_r[48]), .A1N(s2_br4_pp_r[38]), .B0(
        intadd_2_B_1_), .Y(intadd_2_B_0_) );
  AOI2BB1XLTS U1827 ( .A0N(s2_br4_s_r[3]), .A1N(s2_br4_pp_r[36]), .B0(n1415), 
        .Y(s2_ps1[0]) );
  INVX2TS U1828 ( .A(n1416), .Y(n1418) );
  AOI21X1TS U1829 ( .A0(n1419), .A1(n1418), .B0(n1417), .Y(intadd_1_A_0_) );
  AO21XLTS U1830 ( .A0(s3_lhs_r[21]), .A1(n1421), .B0(n1420), .Y(n1424) );
  OAI21XLTS U1831 ( .A0(s3_rhs_r[22]), .A1(n1424), .B0(n1422), .Y(n1423) );
  AOI21X1TS U1832 ( .A0(s3_rhs_r[22]), .A1(n1424), .B0(n1423), .Y(n671) );
  CLKINVX1TS U1833 ( .A(din_uni_a_exp[2]), .Y(intadd_3_B_1_) );
  CLKBUFX2TS U1834 ( .A(n1425), .Y(n1426) );
  CLKBUFX2TS U1835 ( .A(n1426), .Y(n1591) );
  CLKBUFX2TS U1836 ( .A(n1429), .Y(n1433) );
  INVX2TS U1837 ( .A(n1433), .Y(n1589) );
  AOI22X1TS U1838 ( .A0(n1591), .A1(n1436), .B0(n1666), .B1(n1589), .Y(
        s1_mmux_rhs[0]) );
  AOI22X1TS U1839 ( .A0(n1591), .A1(n973), .B0(n1001), .B1(n1589), .Y(
        s1_mmux_rhs[1]) );
  CLKBUFX2TS U1840 ( .A(n1429), .Y(n1435) );
  INVX2TS U1841 ( .A(n1435), .Y(n1427) );
  AOI22X1TS U1842 ( .A0(n1591), .A1(n975), .B0(n993), .B1(n1427), .Y(
        s1_mmux_rhs[2]) );
  CLKBUFX2TS U1843 ( .A(n1426), .Y(n1428) );
  AOI22X1TS U1844 ( .A0(n1428), .A1(n977), .B0(n1023), .B1(n1427), .Y(
        s1_mmux_rhs[3]) );
  CLKBUFX2TS U1845 ( .A(n1425), .Y(n1444) );
  CLKBUFX2TS U1846 ( .A(n1444), .Y(n1451) );
  AO22XLTS U1847 ( .A0(n1451), .A1(n988), .B0(n1676), .B1(din_uni_b_man_dn[4]), 
        .Y(s1_mmux_rhs[4]) );
  AOI22X1TS U1848 ( .A0(n1428), .A1(n979), .B0(n1022), .B1(n1427), .Y(
        s1_mmux_rhs[5]) );
  INVX2TS U1849 ( .A(n1428), .Y(n1430) );
  AO22XLTS U1850 ( .A0(n1425), .A1(n990), .B0(n1430), .B1(din_uni_b_man_dn[6]), 
        .Y(s1_mmux_rhs[6]) );
  CLKBUFX2TS U1851 ( .A(n1426), .Y(n1439) );
  CLKBUFX2TS U1852 ( .A(n1446), .Y(n1438) );
  INVX2TS U1853 ( .A(n1438), .Y(n1437) );
  AOI22X1TS U1854 ( .A0(n1439), .A1(n981), .B0(n1021), .B1(n1437), .Y(
        s1_mmux_rhs[7]) );
  AO22XLTS U1855 ( .A0(n1426), .A1(n992), .B0(n1430), .B1(din_uni_b_man_dn[8]), 
        .Y(s1_mmux_rhs[8]) );
  AOI22X1TS U1856 ( .A0(n1428), .A1(n967), .B0(n1018), .B1(n1427), .Y(
        s1_mmux_rhs[9]) );
  CLKBUFX2TS U1857 ( .A(n1429), .Y(n1431) );
  AO22XLTS U1858 ( .A0(n1431), .A1(din_uni_a_man_dn[11]), .B0(n1430), .B1(
        din_uni_b_man_dn[11]), .Y(s1_mmux_rhs[11]) );
  INVX2TS U1859 ( .A(n1439), .Y(n1432) );
  AO22XLTS U1860 ( .A0(n1431), .A1(din_uni_a_man_dn[12]), .B0(n1432), .B1(
        din_uni_b_man_dn[12]), .Y(s1_mmux_rhs[12]) );
  AO22XLTS U1861 ( .A0(n1431), .A1(din_uni_a_man_dn[13]), .B0(n1432), .B1(
        din_uni_b_man_dn[13]), .Y(s1_mmux_rhs[13]) );
  AO22XLTS U1862 ( .A0(n1433), .A1(din_uni_a_man_dn[14]), .B0(n1432), .B1(
        din_uni_b_man_dn[14]), .Y(s1_mmux_rhs[14]) );
  AO22XLTS U1863 ( .A0(n1433), .A1(din_uni_a_man_dn[15]), .B0(n1432), .B1(
        din_uni_b_man_dn[15]), .Y(s1_mmux_rhs[15]) );
  CLKBUFX2TS U1864 ( .A(n1444), .Y(n1443) );
  INVX2TS U1865 ( .A(n1443), .Y(n1434) );
  AO22XLTS U1866 ( .A0(n1433), .A1(din_uni_a_man_dn[16]), .B0(n1434), .B1(
        din_uni_b_man_dn[16]), .Y(s1_mmux_rhs[16]) );
  AO22XLTS U1867 ( .A0(n1435), .A1(din_uni_a_man_dn[17]), .B0(n1434), .B1(
        din_uni_b_man_dn[17]), .Y(s1_mmux_rhs[17]) );
  AO22XLTS U1868 ( .A0(n1435), .A1(din_uni_a_man_dn[18]), .B0(n1434), .B1(
        din_uni_b_man_dn[18]), .Y(s1_mmux_rhs[18]) );
  AO22XLTS U1869 ( .A0(n1435), .A1(din_uni_a_man_dn[19]), .B0(n1434), .B1(
        din_uni_b_man_dn[19]), .Y(s1_mmux_rhs[19]) );
  CLKBUFX2TS U1870 ( .A(n1444), .Y(n1586) );
  INVX2TS U1871 ( .A(n1586), .Y(n1440) );
  AO22XLTS U1872 ( .A0(n1438), .A1(din_uni_a_man_dn[20]), .B0(n1440), .B1(
        din_uni_b_man_dn[20]), .Y(s1_mmux_rhs[20]) );
  AO22XLTS U1873 ( .A0(n1438), .A1(din_uni_a_man_dn[21]), .B0(n1440), .B1(
        din_uni_b_man_dn[21]), .Y(s1_mmux_rhs[21]) );
  CLKBUFX2TS U1874 ( .A(n1446), .Y(n1445) );
  INVX2TS U1875 ( .A(n1445), .Y(n1441) );
  AOI22X1TS U1876 ( .A0(n1443), .A1(n1666), .B0(n1436), .B1(n1441), .Y(
        s1_mmux_lhs[0]) );
  AOI22X1TS U1877 ( .A0(n1443), .A1(n1001), .B0(n973), .B1(n1437), .Y(
        s1_mmux_lhs[1]) );
  AOI22X1TS U1878 ( .A0(n1439), .A1(n993), .B0(n975), .B1(n1437), .Y(
        s1_mmux_lhs[2]) );
  AOI22X1TS U1879 ( .A0(n1586), .A1(n1011), .B0(n977), .B1(n1437), .Y(
        s1_mmux_lhs[3]) );
  AO22XLTS U1880 ( .A0(n1438), .A1(n996), .B0(n1440), .B1(n988), .Y(
        s1_mmux_lhs[4]) );
  AOI22X1TS U1881 ( .A0(n1439), .A1(n1005), .B0(n979), .B1(n1441), .Y(
        s1_mmux_lhs[5]) );
  AO22XLTS U1882 ( .A0(n1445), .A1(n998), .B0(n1440), .B1(n990), .Y(
        s1_mmux_lhs[6]) );
  AOI22X1TS U1883 ( .A0(n1586), .A1(n1008), .B0(n981), .B1(n1441), .Y(
        s1_mmux_lhs[7]) );
  INVX2TS U1884 ( .A(n1451), .Y(n1447) );
  AO22XLTS U1885 ( .A0(n1445), .A1(n1000), .B0(n1447), .B1(n992), .Y(
        s1_mmux_lhs[8]) );
  AOI22X1TS U1886 ( .A0(n1443), .A1(n1018), .B0(n967), .B1(n1441), .Y(
        s1_mmux_lhs[9]) );
  CLKBUFX2TS U1887 ( .A(n1444), .Y(n1453) );
  INVX2TS U1888 ( .A(n1453), .Y(n1449) );
  AO22XLTS U1889 ( .A0(n1445), .A1(n986), .B0(n1449), .B1(din_uni_a_man_dn[10]), .Y(s1_mmux_lhs[10]) );
  AO22XLTS U1890 ( .A0(n1450), .A1(din_uni_b_man_dn[11]), .B0(n1447), .B1(
        din_uni_a_man_dn[11]), .Y(s1_mmux_lhs[11]) );
  CLKBUFX2TS U1891 ( .A(n1446), .Y(n1448) );
  INVX2TS U1892 ( .A(n1448), .Y(n1452) );
  AO22XLTS U1893 ( .A0(n1448), .A1(din_uni_b_man_dn[12]), .B0(n1452), .B1(
        din_uni_a_man_dn[12]), .Y(s1_mmux_lhs[12]) );
  AO22XLTS U1894 ( .A0(n1448), .A1(din_uni_b_man_dn[13]), .B0(n1449), .B1(
        din_uni_a_man_dn[13]), .Y(s1_mmux_lhs[13]) );
  AO22XLTS U1895 ( .A0(n1450), .A1(din_uni_b_man_dn[14]), .B0(n1447), .B1(
        din_uni_a_man_dn[14]), .Y(s1_mmux_lhs[14]) );
  AO22XLTS U1896 ( .A0(n1453), .A1(din_uni_b_man_dn[15]), .B0(n1449), .B1(
        din_uni_a_man_dn[15]), .Y(s1_mmux_lhs[15]) );
  AO22XLTS U1897 ( .A0(n1453), .A1(din_uni_b_man_dn[16]), .B0(n1447), .B1(
        din_uni_a_man_dn[16]), .Y(s1_mmux_lhs[16]) );
  AO22XLTS U1898 ( .A0(n1448), .A1(din_uni_b_man_dn[17]), .B0(n1452), .B1(
        din_uni_a_man_dn[17]), .Y(s1_mmux_lhs[17]) );
  AO22XLTS U1899 ( .A0(n1450), .A1(din_uni_b_man_dn[18]), .B0(n1449), .B1(
        din_uni_a_man_dn[18]), .Y(s1_mmux_lhs[18]) );
  AO22XLTS U1900 ( .A0(n1451), .A1(din_uni_b_man_dn[19]), .B0(n1452), .B1(
        din_uni_a_man_dn[19]), .Y(s1_mmux_lhs[19]) );
  AO22XLTS U1901 ( .A0(n1451), .A1(din_uni_b_man_dn[20]), .B0(n1676), .B1(
        din_uni_a_man_dn[20]), .Y(s1_mmux_lhs[20]) );
  AO22XLTS U1902 ( .A0(n1453), .A1(din_uni_b_man_dn[21]), .B0(n1452), .B1(
        din_uni_a_man_dn[21]), .Y(s1_mmux_lhs[21]) );
  CLKAND2X2TS U1903 ( .A(n1454), .B(n922), .Y(dout_uni_y_man_dn[2]) );
  NOR2XLTS U1904 ( .A(n1456), .B(n1455), .Y(n1468) );
  AOI22X1TS U1905 ( .A0(n772), .A1(n705), .B0(n1468), .B1(n758), .Y(n1466) );
  AOI22X1TS U1906 ( .A0(n751), .A1(s5_many_r[21]), .B0(n949), .B1(
        s5_many_r[20]), .Y(n1459) );
  AOI22X1TS U1907 ( .A0(n1066), .A1(s5_many_r[18]), .B0(n933), .B1(
        s5_many_r[19]), .Y(n1458) );
  NAND2X1TS U1908 ( .A(n1459), .B(n1458), .Y(n1461) );
  AOI22X1TS U1909 ( .A0(n920), .A1(n1461), .B0(n952), .B1(n1460), .Y(n1465) );
  AOI22X1TS U1910 ( .A0(n1086), .A1(n1463), .B0(n954), .B1(n1462), .Y(n1464)
         );
  NAND3XLTS U1911 ( .A(n1466), .B(n1465), .C(n1464), .Y(dout_uni_y_man_dn[20])
         );
  AOI22X1TS U1912 ( .A0(n772), .A1(n707), .B0(n1468), .B1(n760), .Y(n1483) );
  AOI22X1TS U1913 ( .A0(n791), .A1(s5_many_r[22]), .B0(n948), .B1(
        s5_many_r[21]), .Y(n1474) );
  AOI22X1TS U1914 ( .A0(n1064), .A1(s5_many_r[19]), .B0(n934), .B1(
        s5_many_r[20]), .Y(n1473) );
  NAND2X1TS U1915 ( .A(n1474), .B(n1473), .Y(n1477) );
  AOI22X1TS U1916 ( .A0(n922), .A1(n1477), .B0(n952), .B1(n1475), .Y(n1482) );
  AOI22X1TS U1917 ( .A0(n1085), .A1(n1479), .B0(n954), .B1(n1478), .Y(n1481)
         );
  NAND3XLTS U1918 ( .A(n1483), .B(n1482), .C(n1481), .Y(dout_uni_y_man_dn[21])
         );
  OA21XLTS U1919 ( .A0(n1241), .A1(n1681), .B0(s2_opcode_r[1]), .Y(N110) );
  NOR2BX1TS U1920 ( .AN(s2_mmux_rhs_r[0]), .B(n750), .Y(s2_mmux3_lhs_addsub[0]) );
  NOR2BX1TS U1921 ( .AN(s2_mmux_rhs_r[1]), .B(n788), .Y(s2_mmux3_lhs_addsub[1]) );
  NOR2BX1TS U1922 ( .AN(s2_mmux_rhs_r[2]), .B(n1074), .Y(
        s2_mmux3_lhs_addsub[2]) );
  NOR2BX1TS U1923 ( .AN(s2_mmux_rhs_r[3]), .B(n789), .Y(s2_mmux3_lhs_addsub[3]) );
  NOR2BX1TS U1924 ( .AN(s2_mmux_rhs_r[4]), .B(n1073), .Y(
        s2_mmux3_lhs_addsub[4]) );
  NOR2BX1TS U1925 ( .AN(s2_mmux_rhs_r[5]), .B(n1074), .Y(
        s2_mmux3_lhs_addsub[5]) );
  NOR2BX1TS U1926 ( .AN(s2_mmux_rhs_r[6]), .B(n1072), .Y(
        s2_mmux3_lhs_addsub[6]) );
  NOR2BX1TS U1927 ( .AN(s2_mmux_rhs_r[7]), .B(n789), .Y(s2_mmux3_lhs_addsub[7]) );
  NOR2BX1TS U1928 ( .AN(s2_mmux_rhs_r[8]), .B(n1241), .Y(
        s2_mmux3_lhs_addsub[8]) );
  NOR2BX1TS U1929 ( .AN(s2_mmux_rhs_r[9]), .B(n1072), .Y(
        s2_mmux3_lhs_addsub[9]) );
  NOR2BX1TS U1930 ( .AN(s2_mmux_rhs_r[10]), .B(n1073), .Y(
        s2_mmux3_lhs_addsub[10]) );
  NOR2BX1TS U1931 ( .AN(s2_mmux_rhs_r[12]), .B(n789), .Y(
        s2_mmux3_lhs_addsub[12]) );
  NOR2BX1TS U1932 ( .AN(s2_mmux_rhs_r[13]), .B(n1074), .Y(
        s2_mmux3_lhs_addsub[13]) );
  NOR2BX1TS U1933 ( .AN(s2_mmux_rhs_r[14]), .B(n1073), .Y(
        s2_mmux3_lhs_addsub[14]) );
  NOR2BX1TS U1934 ( .AN(s2_mmux_rhs_r[15]), .B(n1241), .Y(
        s2_mmux3_lhs_addsub[15]) );
  NOR2BX1TS U1935 ( .AN(s2_mmux_rhs_r[16]), .B(n789), .Y(
        s2_mmux3_lhs_addsub[16]) );
  NOR2BX1TS U1936 ( .AN(s2_mmux_rhs_r[17]), .B(n1072), .Y(
        s2_mmux3_lhs_addsub[17]) );
  NOR2BX1TS U1937 ( .AN(s2_mmux_rhs_r[18]), .B(n788), .Y(
        s2_mmux3_lhs_addsub[18]) );
  NOR2BX1TS U1938 ( .AN(s2_mmux_rhs_r[20]), .B(n1074), .Y(
        s2_mmux3_lhs_addsub[20]) );
  NOR2BX1TS U1939 ( .AN(s2_mmux_rhs_r[21]), .B(n788), .Y(
        s2_mmux3_lhs_addsub[21]) );
  NOR3XLTS U1940 ( .A(n805), .B(n802), .C(n1498), .Y(n1527) );
  AOI22X1TS U1941 ( .A0(n943), .A1(s2_mmux_rhs_r[0]), .B0(n1070), .B1(
        s2_mmux_rhs_r[1]), .Y(n1486) );
  AOI22X1TS U1942 ( .A0(n930), .A1(s2_mmux_rhs_r[2]), .B0(n927), .B1(n711), 
        .Y(n1485) );
  AOI21X1TS U1943 ( .A0(n1486), .A1(n1485), .B0(n699), .Y(n1491) );
  NAND3XLTS U1944 ( .A(s2_ea_sub_eb_abs_r[3]), .B(n1570), .C(n808), .Y(n1524)
         );
  AOI221XLTS U1945 ( .A0(s2_ea_sub_eb_abs_r[2]), .A1(n765), .B0(n808), .B1(
        n1553), .C0(n803), .Y(n1573) );
  AOI22X1TS U1946 ( .A0(n944), .A1(n713), .B0(n1070), .B1(n715), .Y(n1488) );
  AOI22X1TS U1947 ( .A0(n745), .A1(n717), .B0(n925), .B1(n719), .Y(n1487) );
  NAND2X1TS U1948 ( .A(n1488), .B(n1487), .Y(n1534) );
  AOI22X1TS U1949 ( .A0(s2_ea_sub_eb_abs_r[4]), .A1(n1573), .B0(n1522), .B1(
        n1534), .Y(n1489) );
  AOI211XLTS U1950 ( .A0(n1527), .A1(n1492), .B0(n1491), .C0(n1490), .Y(n1494)
         );
  NOR2XLTS U1951 ( .A(n1494), .B(s2_ea_sub_eb_abs_r[5]), .Y(n1495) );
  NAND2X1TS U1952 ( .A(n1493), .B(n762), .Y(n1571) );
  OAI22X1TS U1953 ( .A0(n1581), .A1(n1495), .B0(n1494), .B1(n1571), .Y(
        s2_mmux3_rhs_addsub[0]) );
  AOI22X1TS U1954 ( .A0(n944), .A1(s2_mmux_rhs_r[1]), .B0(n1071), .B1(
        s2_mmux_rhs_r[2]), .Y(n1497) );
  AOI22X1TS U1955 ( .A0(n928), .A1(n711), .B0(n926), .B1(n713), .Y(n1496) );
  AOI21X1TS U1956 ( .A0(n1497), .A1(n1496), .B0(n699), .Y(n1503) );
  AOI221XLTS U1957 ( .A0(s2_ea_sub_eb_abs_r[2]), .A1(n1558), .B0(n1498), .B1(
        n1556), .C0(s2_ea_sub_eb_abs_r[3]), .Y(n1576) );
  AOI22X1TS U1958 ( .A0(n717), .A1(n1068), .B0(n945), .B1(n715), .Y(n1500) );
  AOI22X1TS U1959 ( .A0(n929), .A1(n719), .B0(n927), .B1(n721), .Y(n1499) );
  NAND2X1TS U1960 ( .A(n1500), .B(n1499), .Y(n1542) );
  AOI22X1TS U1961 ( .A0(s2_ea_sub_eb_abs_r[4]), .A1(n1576), .B0(n1522), .B1(
        n1542), .Y(n1501) );
  OAI21XLTS U1962 ( .A0(n1538), .A1(n1524), .B0(n1501), .Y(n1502) );
  NOR2XLTS U1963 ( .A(n1505), .B(s2_ea_sub_eb_abs_r[5]), .Y(n1506) );
  OAI22X1TS U1964 ( .A0(s2_addsubn_r), .A1(n1506), .B0(n1505), .B1(n1571), .Y(
        s2_mmux3_rhs_addsub[1]) );
  AOI22X1TS U1965 ( .A0(n945), .A1(s2_mmux_rhs_r[2]), .B0(n786), .B1(n711), 
        .Y(n1508) );
  AOI22X1TS U1966 ( .A0(n929), .A1(s2_mmux_rhs_r[4]), .B0(n925), .B1(n715), 
        .Y(n1507) );
  AOI21X1TS U1967 ( .A0(n1508), .A1(n1507), .B0(n1518), .Y(n1513) );
  AOI22X1TS U1968 ( .A0(n1078), .A1(n1510), .B0(n1530), .B1(n701), .Y(n1511)
         );
  OAI21XLTS U1969 ( .A0(n1545), .A1(n1524), .B0(n1511), .Y(n1512) );
  AOI211XLTS U1970 ( .A0(n1527), .A1(n1563), .B0(n1513), .C0(n1512), .Y(n1514)
         );
  NOR2XLTS U1971 ( .A(n1514), .B(n761), .Y(n1515) );
  OAI22X1TS U1972 ( .A0(s2_addsubn_r), .A1(n1515), .B0(n1514), .B1(n1019), .Y(
        s2_mmux3_rhs_addsub[2]) );
  AOI22X1TS U1973 ( .A0(n781), .A1(s2_mmux_rhs_r[3]), .B0(s2_mmux_rhs_r[4]), 
        .B1(n1069), .Y(n1520) );
  AOI22X1TS U1974 ( .A0(n928), .A1(s2_mmux_rhs_r[5]), .B0(s2_mmux_rhs_r[6]), 
        .B1(n925), .Y(n1519) );
  AOI21X1TS U1975 ( .A0(n1520), .A1(n1519), .B0(n1518), .Y(n1526) );
  AOI22X1TS U1976 ( .A0(n1078), .A1(n1521), .B0(n1530), .B1(n691), .Y(n1523)
         );
  OAI21XLTS U1977 ( .A0(n1548), .A1(n1524), .B0(n1523), .Y(n1525) );
  AOI211XLTS U1978 ( .A0(n1527), .A1(n1566), .B0(n1526), .C0(n1525), .Y(n1528)
         );
  NOR2XLTS U1979 ( .A(n1528), .B(s2_ea_sub_eb_abs_r[5]), .Y(n1529) );
  OAI22X1TS U1980 ( .A0(s2_addsubn_r), .A1(n1529), .B0(n1528), .B1(n1019), .Y(
        s2_mmux3_rhs_addsub[3]) );
  NAND2X1TS U1981 ( .A(n1530), .B(n806), .Y(n1537) );
  OAI22X1TS U1982 ( .A0(n1553), .A1(n764), .B0(n765), .B1(n1537), .Y(n1533) );
  OAI22X1TS U1983 ( .A0(n1552), .A1(n801), .B0(n1531), .B1(n815), .Y(n1532) );
  AOI211XLTS U1984 ( .A0(n1048), .A1(n1534), .B0(n1533), .C0(n1532), .Y(n1536)
         );
  XNOR2X1TS U1985 ( .A(n1536), .B(n1535), .Y(s2_mmux3_rhs_addsub[4]) );
  OAI22X1TS U1986 ( .A0(n1555), .A1(n801), .B0(n1558), .B1(n1537), .Y(n1541)
         );
  OAI22X1TS U1987 ( .A0(n1556), .A1(n764), .B0(n1538), .B1(n815), .Y(n1540) );
  AOI211XLTS U1988 ( .A0(n1046), .A1(n1542), .B0(n1541), .C0(n1540), .Y(n1544)
         );
  CLKBUFX2TS U1989 ( .A(n1543), .Y(n1568) );
  XNOR2X1TS U1990 ( .A(n1544), .B(n1568), .Y(s2_mmux3_rhs_addsub[5]) );
  INVX2TS U1991 ( .A(n815), .Y(n1565) );
  INVX2TS U1992 ( .A(n1545), .Y(n1546) );
  AOI222XLTS U1993 ( .A0(n1563), .A1(n1565), .B0(n1546), .B1(n1046), .C0(n701), 
        .C1(n1549), .Y(n1547) );
  XNOR2X1TS U1994 ( .A(n1547), .B(n1678), .Y(s2_mmux3_rhs_addsub[10]) );
  INVX2TS U1995 ( .A(n1548), .Y(n1550) );
  AOI222XLTS U1996 ( .A0(n1566), .A1(n1565), .B0(n1550), .B1(n1048), .C0(n691), 
        .C1(n1549), .Y(n1551) );
  XNOR2X1TS U1997 ( .A(n1551), .B(n1568), .Y(s2_mmux3_rhs_addsub[11]) );
  OAI222X1TS U1998 ( .A0(n1559), .A1(n766), .B0(n1557), .B1(n1553), .C0(n754), 
        .C1(n1552), .Y(n1554) );
  XNOR2X1TS U1999 ( .A(n1561), .B(n1554), .Y(s2_mmux3_rhs_addsub[12]) );
  OAI222X1TS U2000 ( .A0(n1559), .A1(n1024), .B0(n816), .B1(n1556), .C0(n754), 
        .C1(n1555), .Y(n1560) );
  XNOR2X1TS U2001 ( .A(n1561), .B(n1560), .Y(s2_mmux3_rhs_addsub[13]) );
  AOI22X1TS U2002 ( .A0(n1048), .A1(n1563), .B0(n1565), .B1(n701), .Y(n1564)
         );
  XNOR2X1TS U2003 ( .A(n1564), .B(n1568), .Y(s2_mmux3_rhs_addsub[14]) );
  AOI22X1TS U2004 ( .A0(n1046), .A1(n1566), .B0(n1565), .B1(n691), .Y(n1569)
         );
  XNOR2X1TS U2005 ( .A(n1569), .B(n1568), .Y(s2_mmux3_rhs_addsub[15]) );
  INVX2TS U2006 ( .A(n1573), .Y(n1574) );
  NAND2BXLTS U2007 ( .AN(n1571), .B(n1570), .Y(n1577) );
  OAI21XLTS U2008 ( .A0(n761), .A1(s2_ea_sub_eb_abs_r[4]), .B0(n1572), .Y(
        n1575) );
  OAI221XLTS U2009 ( .A0(n1574), .A1(n1577), .B0(n1573), .B1(n1677), .C0(n1575), .Y(s2_mmux3_rhs_addsub[16]) );
  INVX2TS U2010 ( .A(n1576), .Y(n1578) );
  OAI221XLTS U2011 ( .A0(n1578), .A1(n1577), .B0(n1576), .B1(n1677), .C0(n1575), .Y(s2_mmux3_rhs_addsub[17]) );
  OAI221XLTS U2012 ( .A0(n690), .A1(n1582), .B0(n1579), .B1(n1677), .C0(n1580), 
        .Y(s2_mmux3_rhs_addsub[19]) );
  OAI221XLTS U2013 ( .A0(n766), .A1(n1582), .B0(n675), .B1(n1581), .C0(n1580), 
        .Y(s2_mmux3_rhs_addsub[20]) );
  NOR2XLTS U2014 ( .A(n1589), .B(n1585), .Y(n1583) );
  XNOR2X1TS U2015 ( .A(n1583), .B(intadd_3_SUM_0_), .Y(s1_ea_sub_eb_abs[1]) );
  AOI21X1TS U2016 ( .A0(n1585), .A1(intadd_3_SUM_0_), .B0(n1676), .Y(n1584) );
  XNOR2X1TS U2017 ( .A(intadd_3_SUM_1_), .B(n1584), .Y(s1_ea_sub_eb_abs[2]) );
  NAND3XLTS U2018 ( .A(intadd_3_SUM_1_), .B(n1585), .C(intadd_3_SUM_0_), .Y(
        n1588) );
  NAND2X1TS U2019 ( .A(n1588), .B(n1586), .Y(n1587) );
  XOR2XLTS U2020 ( .A(intadd_3_SUM_2_), .B(n1587), .Y(s1_ea_sub_eb_abs[3]) );
  NOR2BX1TS U2021 ( .AN(intadd_3_SUM_2_), .B(n1588), .Y(n1593) );
  NOR2XLTS U2022 ( .A(n1589), .B(n1593), .Y(n1590) );
  XNOR2X1TS U2023 ( .A(n1590), .B(intadd_3_SUM_3_), .Y(s1_ea_sub_eb_abs[4]) );
  INVX2TS U2024 ( .A(n1591), .Y(n1592) );
  AO21XLTS U2025 ( .A0(intadd_3_SUM_3_), .A1(n1593), .B0(n1592), .Y(n1597) );
  NOR2XLTS U2026 ( .A(n965), .B(n970), .Y(n1594) );
  OAI22X1TS U2027 ( .A0(n1595), .A1(n1594), .B0(n1597), .B1(intadd_3_n1), .Y(
        n1596) );
  AOI21X1TS U2028 ( .A0(n1597), .A1(intadd_3_n1), .B0(n1596), .Y(
        s1_ea_sub_eb_abs[5]) );
  XNOR2X1TS U2029 ( .A(din_uni_b_sgn), .B(din_uni_a_sgn), .Y(n669) );
  INVX2TS U2030 ( .A(n850), .Y(n1664) );
  OAI221XLTS U2031 ( .A0(n768), .A1(n1661), .B0(n1061), .B1(n847), .C0(n1664), 
        .Y(n664) );
  OAI22X1TS U2032 ( .A0(n917), .A1(n879), .B0(n887), .B1(n1062), .Y(n659) );
  OAI22X1TS U2033 ( .A0(n1054), .A1(n879), .B0(n918), .B1(n885), .Y(n653) );
  OAI221XLTS U2034 ( .A0(n1609), .A1(n871), .B0(n1041), .B1(n819), .C0(n1600), 
        .Y(n651) );
  AOI221XLTS U2035 ( .A0(n845), .A1(n1055), .B0(n833), .B1(n809), .C0(n864), 
        .Y(n1601) );
  OAI221XLTS U2036 ( .A0(n902), .A1(n877), .B0(n1042), .B1(n830), .C0(n1601), 
        .Y(n650) );
  AOI221XLTS U2037 ( .A0(n842), .A1(n1055), .B0(n829), .B1(n809), .C0(n861), 
        .Y(n1602) );
  OAI221XLTS U2038 ( .A0(n901), .A1(n875), .B0(n1041), .B1(n826), .C0(n1602), 
        .Y(n649) );
  AOI221XLTS U2039 ( .A0(n839), .A1(n1053), .B0(n856), .B1(n809), .C0(n859), 
        .Y(n1603) );
  OAI221XLTS U2040 ( .A0(n1609), .A1(n873), .B0(n1042), .B1(n823), .C0(n1603), 
        .Y(n648) );
  OAI22X1TS U2041 ( .A0(n901), .A1(n879), .B0(n1055), .B1(n885), .Y(n647) );
  AOI221XLTS U2042 ( .A0(n1627), .A1(n1041), .B0(n835), .B1(n900), .C0(n853), 
        .Y(n1605) );
  OAI221XLTS U2043 ( .A0(n1614), .A1(n870), .B0(n1039), .B1(n821), .C0(n1605), 
        .Y(n645) );
  AOI221XLTS U2044 ( .A0(n1630), .A1(n1042), .B0(n844), .B1(n901), .C0(n865), 
        .Y(n1606) );
  OAI221XLTS U2045 ( .A0(n898), .A1(n876), .B0(n1040), .B1(n832), .C0(n1606), 
        .Y(n644) );
  AOI221XLTS U2046 ( .A0(n1633), .A1(n1041), .B0(n841), .B1(n902), .C0(n862), 
        .Y(n1607) );
  OAI221XLTS U2047 ( .A0(n897), .A1(n874), .B0(n1039), .B1(n828), .C0(n1607), 
        .Y(n643) );
  AOI221XLTS U2048 ( .A0(n857), .A1(n1042), .B0(n838), .B1(n900), .C0(n860), 
        .Y(n1608) );
  OAI221XLTS U2049 ( .A0(n1614), .A1(n872), .B0(n1040), .B1(n825), .C0(n1608), 
        .Y(n642) );
  OAI22X1TS U2050 ( .A0(n897), .A1(n880), .B0(n902), .B1(n885), .Y(n641) );
  AOI221XLTS U2051 ( .A0(n1627), .A1(n1039), .B0(n835), .B1(n896), .C0(n852), 
        .Y(n1610) );
  OAI221XLTS U2052 ( .A0(n914), .A1(n871), .B0(n1037), .B1(n820), .C0(n1610), 
        .Y(n639) );
  AOI221XLTS U2053 ( .A0(n696), .A1(n1040), .B0(n844), .B1(n897), .C0(n864), 
        .Y(n1611) );
  OAI221XLTS U2054 ( .A0(n913), .A1(n877), .B0(n1038), .B1(n831), .C0(n1611), 
        .Y(n638) );
  AOI221XLTS U2055 ( .A0(n694), .A1(n1039), .B0(n841), .B1(n898), .C0(n861), 
        .Y(n1612) );
  OAI221XLTS U2056 ( .A0(n912), .A1(n875), .B0(n1037), .B1(n827), .C0(n1612), 
        .Y(n637) );
  AOI221XLTS U2057 ( .A0(n856), .A1(n1040), .B0(n838), .B1(n896), .C0(n858), 
        .Y(n1613) );
  OAI221XLTS U2058 ( .A0(n914), .A1(n873), .B0(n1038), .B1(n824), .C0(n1613), 
        .Y(n636) );
  OAI22X1TS U2059 ( .A0(n912), .A1(n1660), .B0(n898), .B1(n887), .Y(n635) );
  AOI221XLTS U2060 ( .A0(n692), .A1(n1038), .B0(n835), .B1(n912), .C0(n854), 
        .Y(n1615) );
  OAI221XLTS U2061 ( .A0(n910), .A1(n870), .B0(n1035), .B1(n821), .C0(n1615), 
        .Y(n633) );
  OAI221XLTS U2062 ( .A0(n909), .A1(n876), .B0(n1036), .B1(n832), .C0(n1616), 
        .Y(n632) );
  AOI221XLTS U2063 ( .A0(n1633), .A1(n1037), .B0(n841), .B1(n913), .C0(n863), 
        .Y(n1617) );
  OAI221XLTS U2064 ( .A0(n908), .A1(n874), .B0(n1035), .B1(n828), .C0(n1617), 
        .Y(n631) );
  AOI221XLTS U2065 ( .A0(n1636), .A1(n1038), .B0(n839), .B1(n914), .C0(n859), 
        .Y(n1618) );
  OAI221XLTS U2066 ( .A0(n910), .A1(n872), .B0(n1036), .B1(n825), .C0(n1618), 
        .Y(n630) );
  OAI22X1TS U2067 ( .A0(n908), .A1(n880), .B0(n913), .B1(n886), .Y(n629) );
  AOI221XLTS U2068 ( .A0(n1627), .A1(n1036), .B0(n836), .B1(n908), .C0(n853), 
        .Y(n1619) );
  OAI221XLTS U2069 ( .A0(n906), .A1(n871), .B0(n1033), .B1(n820), .C0(n1619), 
        .Y(n627) );
  AOI221XLTS U2070 ( .A0(n1630), .A1(n1035), .B0(n844), .B1(n909), .C0(n866), 
        .Y(n1620) );
  OAI221XLTS U2071 ( .A0(n905), .A1(n877), .B0(n1034), .B1(n831), .C0(n1620), 
        .Y(n626) );
  OAI221XLTS U2072 ( .A0(n904), .A1(n875), .B0(n1033), .B1(n827), .C0(n1621), 
        .Y(n625) );
  AOI221XLTS U2073 ( .A0(n857), .A1(n1036), .B0(n1654), .B1(n910), .C0(n860), 
        .Y(n1622) );
  OAI221XLTS U2074 ( .A0(n906), .A1(n873), .B0(n1034), .B1(n824), .C0(n1622), 
        .Y(n624) );
  OAI22X1TS U2075 ( .A0(n904), .A1(n1660), .B0(n909), .B1(n887), .Y(n623) );
  AOI221XLTS U2076 ( .A0(n822), .A1(n1034), .B0(n1639), .B1(n904), .C0(n854), 
        .Y(n1623) );
  OAI221XLTS U2077 ( .A0(n894), .A1(n870), .B0(n1031), .B1(n821), .C0(n1623), 
        .Y(n621) );
  AOI221XLTS U2078 ( .A0(n833), .A1(n1033), .B0(n845), .B1(n905), .C0(n865), 
        .Y(n1624) );
  OAI221XLTS U2079 ( .A0(n893), .A1(n876), .B0(n1032), .B1(n832), .C0(n1624), 
        .Y(n620) );
  AOI221XLTS U2080 ( .A0(n829), .A1(n1034), .B0(n842), .B1(n906), .C0(n862), 
        .Y(n1625) );
  OAI221XLTS U2081 ( .A0(n892), .A1(n874), .B0(n1031), .B1(n828), .C0(n1625), 
        .Y(n619) );
  OAI221XLTS U2082 ( .A0(n894), .A1(n872), .B0(n1032), .B1(n825), .C0(n1626), 
        .Y(n618) );
  OAI22X1TS U2083 ( .A0(n892), .A1(n880), .B0(n905), .B1(n886), .Y(n617) );
  AOI221XLTS U2084 ( .A0(n822), .A1(n1031), .B0(n836), .B1(n891), .C0(n853), 
        .Y(n1628) );
  OAI221XLTS U2085 ( .A0(n889), .A1(n871), .B0(n1045), .B1(n820), .C0(n1628), 
        .Y(n615) );
  AOI221XLTS U2086 ( .A0(n833), .A1(n1032), .B0(n1644), .B1(n892), .C0(n866), 
        .Y(n1631) );
  OAI221XLTS U2087 ( .A0(n888), .A1(n877), .B0(n1044), .B1(n831), .C0(n1631), 
        .Y(n614) );
  AOI221XLTS U2088 ( .A0(n829), .A1(n1031), .B0(n1649), .B1(n893), .C0(n863), 
        .Y(n1634) );
  OAI221XLTS U2089 ( .A0(n890), .A1(n875), .B0(n1045), .B1(n827), .C0(n1634), 
        .Y(n613) );
  AOI221XLTS U2090 ( .A0(n856), .A1(n1032), .B0(n839), .B1(n894), .C0(n859), 
        .Y(n1637) );
  OAI221XLTS U2091 ( .A0(n889), .A1(n873), .B0(n682), .B1(n824), .C0(n1637), 
        .Y(n612) );
  OAI22X1TS U2092 ( .A0(n889), .A1(n1660), .B0(n893), .B1(n887), .Y(n611) );
  INVX2TS U2093 ( .A(n1056), .Y(n1662) );
  AOI21X1TS U2094 ( .A0(n1666), .A1(n799), .B0(n1001), .Y(n609) );
  OAI221XLTS U2095 ( .A0(n888), .A1(n1643), .B0(n1044), .B1(n834), .C0(n1642), 
        .Y(n607) );
  AOI221XLTS U2096 ( .A0(n1646), .A1(n1058), .B0(n1645), .B1(n1662), .C0(n865), 
        .Y(n1647) );
  OAI221XLTS U2097 ( .A0(n890), .A1(n1648), .B0(n1045), .B1(n843), .C0(n1647), 
        .Y(n605) );
  AOI221XLTS U2098 ( .A0(n1651), .A1(n1059), .B0(n1650), .B1(n1662), .C0(n862), 
        .Y(n1652) );
  OAI221XLTS U2099 ( .A0(n889), .A1(n1653), .B0(n1044), .B1(n840), .C0(n1652), 
        .Y(n603) );
  AOI221XLTS U2100 ( .A0(n1656), .A1(n1056), .B0(n1655), .B1(n799), .C0(n860), 
        .Y(n1657) );
  OAI221XLTS U2101 ( .A0(n888), .A1(n1658), .B0(n1044), .B1(n837), .C0(n1657), 
        .Y(n601) );
  OAI22X1TS U2102 ( .A0(n1058), .A1(n880), .B0(n890), .B1(n886), .Y(n600) );
  AOI22X1TS U2103 ( .A0(n1002), .A1(n1057), .B0(n799), .B1(n818), .Y(n1667) );
  OAI22X1TS U2104 ( .A0(n1667), .A1(n1666), .B0(n1045), .B1(n1664), .Y(n599)
         );
  CMPR32X2TS U2105 ( .A(n1670), .B(n1669), .C(n1668), .CO(n1419), .S(n1671) );
  OAI2BB1X1TS U2106 ( .A0N(n747), .A1N(s3_lhs_r[4]), .B0(n1671), .Y(n574) );
  CLKAND2X2TS U2107 ( .A(opcode[0]), .B(n1015), .Y(n1674) );
  AO22XLTS U2108 ( .A0(n970), .A1(n1674), .B0(s2_expb_r[5]), .B1(n1673), .Y(
        n563) );
  AO22XLTS U2109 ( .A0(n966), .A1(n1674), .B0(s2_expa_r[5]), .B1(n1673), .Y(
        n561) );
endmodule

