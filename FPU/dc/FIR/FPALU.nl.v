/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : O-2018.06-SP5-1
// Date      : Sun Dec  5 02:21:11 2021
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
  wire   s2_sa_r, s2_sb_r, s2_ea_gte_eb_r, s2_addsubn_r, N114, s3_sa_r,
         s3_sb_r, s3_addsubn_r, s3_ea_gte_eb_r, s3_s2_r, s4_ea_gte_eb_r,
         s4_addsubn_r, s4_sa_r, s4_sb_r, s5_addsubn_r, s5_sa_r, s5_sb_r,
         s5_ea_gte_eb_r, C46_DATA2_0, C46_DATA2_1, C46_DATA2_2, C46_DATA2_3,
         C46_DATA2_4, n593, n595, n602, n603, n604, n605, n606, n607, n608,
         n609, n610, n611, n612, n613, n614, n615, n616, n617, n618, n619,
         n620, n621, n622, n623, n624, n625, n626, n632, n633, n634, n635,
         n636, n637, n638, n639, n640, n641, n642, n643, n644, n645, n646,
         n647, n648, n649, n650, n651, n652, n653, n654, n655, n656, n657,
         n658, n659, n660, n661, n662, n663, n664, n665, n666, n667, n668,
         n669, n670, n671, n672, n673, n674, n675, n676, n677, n678, n679,
         n680, n681, n682, n683, n684, n685, n686, n687, n688, n689, n690,
         n691, n692, n693, n694, n695, n696, n697, n698, n699, n700, n701,
         n702, n703, n705, U2_RSOP_146_C1_Z_4, U2_RSOP_146_C1_Z_3,
         U2_RSOP_146_C1_Z_2, U2_RSOP_146_C1_Z_1, U2_RSOP_146_C1_Z_0,
         DP_OP_167J1_125_280_n43, DP_OP_167J1_125_280_n42,
         DP_OP_167J1_125_280_n41, DP_OP_167J1_125_280_n40,
         DP_OP_167J1_125_280_n39, DP_OP_167J1_125_280_n37,
         DP_OP_167J1_125_280_n36, DP_OP_167J1_125_280_n35,
         DP_OP_167J1_125_280_n34, DP_OP_167J1_125_280_n33,
         DP_OP_167J1_125_280_n28, DP_OP_167J1_125_280_n27,
         DP_OP_167J1_125_280_n26, DP_OP_167J1_125_280_n25,
         DP_OP_167J1_125_280_n24, DP_OP_167J1_125_280_n21,
         DP_OP_167J1_125_280_n20, DP_OP_167J1_125_280_n18,
         DP_OP_167J1_125_280_n17, DP_OP_167J1_125_280_n16,
         DP_OP_167J1_125_280_n15, DP_OP_167J1_125_280_n14,
         DP_OP_167J1_125_280_n13, DP_OP_167J1_125_280_n12,
         DP_OP_167J1_125_280_n11, DP_OP_167J1_125_280_n10,
         DP_OP_167J1_125_280_n6, DP_OP_167J1_125_280_n5,
         DP_OP_167J1_125_280_n4, DP_OP_167J1_125_280_n3,
         DP_OP_167J1_125_280_n2, intadd_0_A_12_, intadd_0_A_11_,
         intadd_0_A_10_, intadd_0_A_9_, intadd_0_A_8_, intadd_0_A_7_,
         intadd_0_A_6_, intadd_0_A_5_, intadd_0_A_4_, intadd_0_A_3_,
         intadd_0_A_2_, intadd_0_A_1_, intadd_0_B_13_, intadd_0_B_12_,
         intadd_0_B_11_, intadd_0_B_10_, intadd_0_B_9_, intadd_0_B_8_,
         intadd_0_B_7_, intadd_0_B_6_, intadd_0_B_5_, intadd_0_B_4_,
         intadd_0_B_3_, intadd_0_B_2_, intadd_0_B_1_, intadd_0_B_0_,
         intadd_0_CI, intadd_0_n15, intadd_0_n14, intadd_0_n13, intadd_0_n12,
         intadd_0_n11, intadd_0_n10, intadd_0_n9, intadd_0_n8, intadd_0_n7,
         intadd_0_n6, intadd_0_n5, intadd_0_n4, intadd_0_n3, intadd_0_n2,
         intadd_0_n1, intadd_1_A_12_, intadd_1_A_11_, intadd_1_A_10_,
         intadd_1_A_9_, intadd_1_A_8_, intadd_1_A_7_, intadd_1_A_6_,
         intadd_1_A_5_, intadd_1_A_4_, intadd_1_A_3_, intadd_1_A_2_,
         intadd_1_A_1_, intadd_1_A_0_, intadd_1_B_12_, intadd_1_B_11_,
         intadd_1_B_10_, intadd_1_B_9_, intadd_1_B_8_, intadd_1_B_7_,
         intadd_1_B_6_, intadd_1_B_5_, intadd_1_B_4_, intadd_1_B_3_,
         intadd_1_B_2_, intadd_1_B_1_, intadd_1_B_0_, intadd_1_CI,
         intadd_1_SUM_12_, intadd_1_SUM_11_, intadd_1_SUM_10_, intadd_1_SUM_9_,
         intadd_1_SUM_8_, intadd_1_SUM_7_, intadd_1_SUM_6_, intadd_1_SUM_5_,
         intadd_1_SUM_4_, intadd_1_SUM_3_, intadd_1_SUM_2_, intadd_1_SUM_1_,
         intadd_1_SUM_0_, intadd_1_n13, intadd_1_n12, intadd_1_n11,
         intadd_1_n10, intadd_1_n9, intadd_1_n8, intadd_1_n7, intadd_1_n6,
         intadd_1_n5, intadd_1_n4, intadd_1_n3, intadd_1_n2, intadd_1_n1,
         intadd_2_A_12_, intadd_2_A_11_, intadd_2_A_10_, intadd_2_A_9_,
         intadd_2_A_8_, intadd_2_A_7_, intadd_2_A_6_, intadd_2_A_5_,
         intadd_2_A_4_, intadd_2_A_3_, intadd_2_A_2_, intadd_2_A_1_,
         intadd_2_B_12_, intadd_2_B_11_, intadd_2_B_10_, intadd_2_B_9_,
         intadd_2_B_8_, intadd_2_B_7_, intadd_2_B_6_, intadd_2_B_5_,
         intadd_2_B_4_, intadd_2_B_3_, intadd_2_B_2_, intadd_2_B_1_,
         intadd_2_B_0_, intadd_2_CI, intadd_2_n13, intadd_2_n12, intadd_2_n11,
         intadd_2_n10, intadd_2_n9, intadd_2_n8, intadd_2_n7, intadd_2_n6,
         intadd_2_n5, intadd_2_n4, intadd_2_n3, intadd_2_n2, intadd_2_n1,
         intadd_3_B_3_, intadd_3_B_2_, intadd_3_B_1_, intadd_3_B_0_,
         intadd_3_CI, intadd_3_SUM_3_, intadd_3_SUM_2_, intadd_3_SUM_1_,
         intadd_3_SUM_0_, intadd_3_n4, intadd_3_n3, intadd_3_n2, intadd_3_n1,
         n706, n707, n708, n709, n710, n711, n712, n713, n714, n715, n716,
         n717, n718, n719, n720, n721, n722, n723, n724, n725, n726, n727,
         n728, n729, n730, n731, n732, n733, n734, n735, n736, n737, n738,
         n739, n740, n741, n742, n743, n744, n745, n746, n747, n748, n749,
         n750, n751, n752, n753, n754, n755, n756, n757, n758, n759, n760,
         n761, n762, n763, n764, n765, n766, n767, n768, n769, n770, n771,
         n772, n773, n774, n775, n776, n777, n778, n779, n780, n781, n783,
         n785, n786, n787, n788, n789, n790, n791, n792, n793, n794, n795,
         n796, n797, n798, n799, n800, n801, n802, n803, n804, n805, n806,
         n807, n808, n809, n810, n811, n812, n813, n814, n815, n816, n817,
         n818, n819, n820, n821, n822, n823, n824, n825, n826, n827, n828,
         n829, n830, n831, n832, n833, n834, n835, n836, n837, n838, n839,
         n840, n841, n842, n843, n844, n845, n846, n847, n848, n849, n850,
         n851, n852, n853, n854, n855, n856, n857, n858, n859, n860, n861,
         n862, n863, n864, n865, n866, n867, n868, n869, n870, n871, n872,
         n873, n874, n875, n876, n877, n878, n879, n880, n881, n882, n883,
         n884, n885, n886, n887, n888, n889, n890, n891, n892, n893, n894,
         n895, n896, n897, n898, n899, n900, n901, n902, n903, n904, n905,
         n906, n907, n908, n909, n910, n911, n912, n913, n914, n915, n916,
         n917, n918, n919, n920, n921, n922, n923, n924, n925, n926, n927,
         n928, n929, n930, n931, n932, n933, n934, n935, n936, n937, n938,
         n939, n940, n941, n942, n943, n944, n945, n946, n947, n948, n949,
         n950, n951, n952, n953, n954, n955, n956, n957, n958, n959, n960,
         n961, n962, n963, n964, n965, n966, n967, n968, n969, n970, n971,
         n972, n973, n974, n975, n976, n977, n978, n979, n980, n981, n982,
         n983, n984, n985, n986, n987, n988, n989, n990, n991, n992, n993,
         n994, n995, n996, n997, n998, n999, n1000, n1001, n1002, n1003, n1004,
         n1005, n1006, n1007, n1008, n1009, n1010, n1011, n1012, n1013, n1014,
         n1015, n1016, n1017, n1018, n1019, n1021, n1022, n1023, n1024, n1025,
         n1026, n1027, n1028, n1029, n1030, n1031, n1032, n1033, n1034, n1035,
         n1036, n1037, n1038, n1039, n1040, n1041, n1042, n1043, n1044, n1045,
         n1046, n1047, n1048, n1049, n1050, n1051, n1052, n1053, n1054, n1055,
         n1056, n1057, n1058, n1059, n1060, n1061, n1062, n1063, n1064, n1065,
         n1066, n1067, n1068, n1069, n1070, n1071, n1072, n1073, n1074, n1075,
         n1076, n1077, n1078, n1079, n1080, n1081, n1082, n1083, n1084, n1085,
         n1086, n1087, n1088, n1089, n1090, n1091, n1092, n1093, n1094, n1095,
         n1096, n1097, n1098, n1099, n1100, n1101, n1102, n1103, n1104, n1105,
         n1106, n1107, n1108, n1109, n1110, n1111, n1112, n1113, n1114, n1115,
         n1116, n1117, n1118, n1119, n1120, n1121, n1122, n1123, n1124, n1125,
         n1126, n1127, n1128, n1129, n1130, n1131, n1132, n1133, n1134, n1135,
         n1136, n1137, n1138, n1139, n1140, n1141, n1142, n1145, n1146, n1147,
         n1148, n1151, n1152, n1153, n1154, n1155, n1156, n1157, n1158, n1159,
         n1160, n1161, n1162, n1163, n1164, n1165, n1166, n1167, n1168, n1169,
         n1170, n1171, n1172, n1173, n1174, n1175, n1176, n1177, n1178, n1179,
         n1180, n1181, n1182, n1183, n1184, n1185, n1186, n1187, n1188, n1189,
         n1190, n1191, n1192, n1193, n1194, n1195, n1196, n1197, n1198, n1199,
         n1200, n1201, n1202, n1203, n1204, n1205, n1206, n1207, n1208, n1209,
         n1210, n1211, n1212, n1213, n1214, n1215, n1216, n1217, n1218, n1219,
         n1220, n1221, n1222, n1223, n1224, n1225, n1226, n1227, n1228, n1229,
         n1230, n1231, n1232, n1233, n1234, n1235, n1236, n1237, n1238, n1239,
         n1240, n1241, n1242, n1243, n1244, n1245, n1246, n1247, n1248, n1249,
         n1250, n1251, n1252, n1253, n1254, n1255, n1256, n1257, n1258, n1259,
         n1260, n1261, n1262, n1263, n1264, n1265, n1266, n1267, n1268, n1269,
         n1270, n1271, n1272, n1273, n1274, n1275, n1276, n1277, n1278, n1279,
         n1280, n1281, n1282, n1283, n1284, n1285, n1286, n1287, n1288, n1289,
         n1290, n1291, n1292, n1293, n1294, n1295, n1296, n1297, n1298, n1299,
         n1300, n1301, n1302, n1303, n1304, n1305, n1306, n1307, n1308, n1309,
         n1310, n1311, n1312, n1313, n1314, n1315, n1316, n1317, n1318, n1319,
         n1320, n1321, n1322, n1323, n1324, n1325, n1326, n1327, n1328, n1329,
         n1330, n1331, n1332, n1333, n1334, n1335, n1336, n1337, n1338, n1339,
         n1340, n1341, n1342, n1343, n1344, n1345, n1346, n1347, n1348, n1349,
         n1350, n1351, n1352, n1353, n1354, n1355, n1356, n1357, n1358, n1359,
         n1361, n1362, n1363, n1364, n1365, n1366, n1367, n1368, n1369, n1370,
         n1371, n1372, n1373, n1374, n1375, n1376, n1377, n1378, n1379, n1380,
         n1381, n1382, n1383, n1384, n1385, n1386, n1387, n1388, n1389, n1390,
         n1391, n1392, n1393, n1394, n1395, n1396, n1397, n1398, n1399, n1400,
         n1401, n1402, n1403, n1404, n1405, n1406, n1407, n1408, n1409, n1410,
         n1411, n1412, n1413, n1414, n1415, n1416, n1417, n1418, n1419, n1420,
         n1421, n1422, n1423, n1424, n1425, n1426, n1427, n1428, n1429, n1430,
         n1431, n1432, n1433, n1434, n1435, n1436, n1437, n1438, n1439, n1440,
         n1441, n1442, n1443, n1444, n1445, n1446, n1447, n1448, n1449, n1450,
         n1451, n1452, n1453, n1454, n1455, n1456, n1457, n1458, n1459, n1460,
         n1461, n1462, n1463, n1464, n1465, n1466, n1467, n1468, n1469, n1470,
         n1471, n1472, n1473, n1474, n1475, n1476, n1477, n1478, n1479, n1480,
         n1481, n1482, n1483, n1484, n1485, n1486, n1487, n1488, n1489, n1490,
         n1491, n1492, n1493, n1494, n1495, n1496, n1497, n1498, n1499, n1500,
         n1501, n1502, n1503, n1505, n1506, n1507, n1508, n1509, n1510, n1511,
         n1512, n1513, n1514, n1515, n1516, n1519, n1520, n1521, n1522, n1523,
         n1524, n1525, n1526, n1527, n1528, n1529, n1530, n1531, n1532, n1533,
         n1534, n1535, n1536, n1537, n1538, n1539, n1540, n1541, n1542, n1543,
         n1544, n1545, n1546, n1547, n1548, n1549, n1550, n1551, n1552, n1553,
         n1554, n1555, n1556, n1557, n1558, n1559, n1560, n1561, n1562, n1563,
         n1564, n1565, n1566, n1567, n1568, n1569, n1570, n1571, n1573, n1574,
         n1575, n1576, n1577, n1578, n1579, n1580, n1581, n1582, n1583, n1584,
         n1585, n1586, n1587, n1588, n1589, n1590, n1591, n1592, n1593, n1594,
         n1595, n1596, n1597, n1598, n1599, n1600, n1601, n1602, n1603, n1604,
         n1605, n1606, n1607, n1608, n1609, n1610, n1611, n1612, n1613, n1614,
         n1615, n1616, n1617, n1618, n1619, n1620, n1621, n1622, n1623, n1624,
         n1625, n1626, n1627, n1628, n1629, n1630, n1631, n1632, n1633, n1634,
         n1635, n1636, n1637, n1638, n1639, n1640, n1641, n1642, n1643, n1644,
         n1645, n1646, n1647, n1648, n1649, n1650, n1651, n1652, n1653, n1654,
         n1655, n1656, n1657, n1658, n1659, n1660, n1661, n1662, n1663, n1664,
         n1665, n1666, n1667, n1668, n1669, n1670, n1671, n1672, n1673, n1674,
         n1675, n1676, n1677, n1678, n1679, n1680, n1681, n1682, n1683, n1684,
         n1685, n1686, n1687, n1688, n1689, n1690, n1691, n1692, n1693, n1694,
         n1695, n1696, n1697, n1698, n1699, n1700, n1701, n1702, n1703, n1704,
         n1705, n1706, n1707, n1708, n1709, n1710, n1711, n1712, n1713, n1714,
         n1715, n1716, n1717, n1718, n1719, n1720, n1721, n1722, n1723, n1724,
         n1725, n1726, n1727, n1728, n1729, n1730, n1731, n1732, n1733, n1734,
         n1735, n1736, n1737, n1738, n1739, n1740, n1742, n1743, n1744, n1745,
         n1746, n1747, n1748, n1749, n1750, n1751, n1752, n1753, n1754, n1755,
         n1756, n1757, n1758, n1759, n1760, n1761, n1762, n1763, n1764, n1765,
         n1766, n1767, n1768, n1770, n1771, n1772, n1773, n1774, n1775, n1776,
         n1777, n1778, n1779, n1780, n1781, n1782, n1783, n1784, n1785, n1786,
         n1787, n1788, n1789, n1790, n1791, n1792, n1793, n1794, n1795, n1796,
         n1797, n1798, n1799, n1800, n1801, n1802, n1803, n1804, n1805, n1806,
         n1807, n1808, n1809, n1810, n1811, n1812, n1813, n1814, n1815, n1816,
         n1817, n1818, n1819, n1820, n1821;
  wire   [5:0] s1_ea_sub_eb_abs;
  wire   [21:0] s1_mmux_lhs;
  wire   [21:0] s1_mmux_rhs;
  wire   [71:60] s1_br4_pp;
  wire   [3:0] s1_br4_s;
  wire   [1:0] s2_opcode_r;
  wire   [5:0] s2_ea_r;
  wire   [5:0] s2_eb_r;
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
  wire   [5:0] s3_ea_r;
  wire   [5:0] s3_eb_r;
  wire   [21:0] s3_lhs_r;
  wire   [22:0] s3_rhs_r;
  wire   [18:0] s3_ps0_r;
  wire   [15:0] s3_ps1_r;
  wire   [22:0] s3_mmux_y;
  wire   [22:0] s4_many_r;
  wire   [22:0] s4_lzdi_r;
  wire   [1:0] s4_opcode_r;
  wire   [5:0] s4_ea_r;
  wire   [5:0] s4_eb_r;
  wire   [1:0] s5_opcode_r;
  wire   [22:0] s5_many_r;
  wire   [4:0] s5_lzd_r;
  wire   [21:0] s5_many_skip_r;
  wire   [5:0] s5_ea_r;
  wire   [5:0] s5_eb_r;

  DFFQX1TS s2_ea_r_reg_5_ ( .D(n595), .CK(clk), .Q(s2_ea_r[5]) );
  DFFQX1TS s2_opcode_r_reg_1_ ( .D(opcode[1]), .CK(clk), .Q(s2_opcode_r[1]) );
  DFFQX1TS s2_opcode_r_reg_0_ ( .D(opcode[0]), .CK(clk), .Q(s2_opcode_r[0]) );
  DFFQX1TS s2_sa_r_reg ( .D(din_uni_a_sgn), .CK(clk), .Q(s2_sa_r) );
  DFFQX1TS s2_sb_r_reg ( .D(din_uni_b_sgn), .CK(clk), .Q(s2_sb_r) );
  DFFQX1TS s2_eb_r_reg_5_ ( .D(n593), .CK(clk), .Q(s2_eb_r[5]) );
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
  DFFQX1TS s2_ea_gte_eb_r_reg ( .D(n1786), .CK(clk), .Q(s2_ea_gte_eb_r) );
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
  DFFQX1TS s2_addsubn_r_reg ( .D(n703), .CK(clk), .Q(s2_addsubn_r) );
  DFFQX1TS s3_sb_r_reg ( .D(s2_sb_r), .CK(clk), .Q(s3_sb_r) );
  DFFQX1TS s3_opcode_r_reg_1_ ( .D(N114), .CK(clk), .Q(s3_opcode_r[1]) );
  DFFQX1TS s3_opcode_r_reg_0_ ( .D(s2_opcode_r[0]), .CK(clk), .Q(
        s3_opcode_r[0]) );
  DFFQX1TS s3_ea_r_reg_5_ ( .D(s2_ea_r[5]), .CK(clk), .Q(s3_ea_r[5]) );
  DFFQX1TS s3_ea_r_reg_4_ ( .D(s2_ea_r[4]), .CK(clk), .Q(s3_ea_r[4]) );
  DFFQX1TS s3_ea_r_reg_3_ ( .D(s2_ea_r[3]), .CK(clk), .Q(s3_ea_r[3]) );
  DFFQX1TS s3_ea_r_reg_2_ ( .D(s2_ea_r[2]), .CK(clk), .Q(s3_ea_r[2]) );
  DFFQX1TS s3_ea_r_reg_1_ ( .D(s2_ea_r[1]), .CK(clk), .Q(s3_ea_r[1]) );
  DFFQX1TS s3_ea_r_reg_0_ ( .D(s2_ea_r[0]), .CK(clk), .Q(s3_ea_r[0]) );
  DFFQX1TS s3_eb_r_reg_5_ ( .D(s2_eb_r[5]), .CK(clk), .Q(s3_eb_r[5]) );
  DFFQX1TS s3_eb_r_reg_4_ ( .D(s2_eb_r[4]), .CK(clk), .Q(s3_eb_r[4]) );
  DFFQX1TS s3_eb_r_reg_3_ ( .D(s2_eb_r[3]), .CK(clk), .Q(s3_eb_r[3]) );
  DFFQX1TS s3_eb_r_reg_2_ ( .D(s2_eb_r[2]), .CK(clk), .Q(s3_eb_r[2]) );
  DFFQX1TS s3_eb_r_reg_1_ ( .D(s2_eb_r[1]), .CK(clk), .Q(s3_eb_r[1]) );
  DFFQX1TS s3_eb_r_reg_0_ ( .D(s2_eb_r[0]), .CK(clk), .Q(s3_eb_r[0]) );
  DFFQX1TS s3_sa_r_reg ( .D(s2_sa_r), .CK(clk), .Q(s3_sa_r) );
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
  DFFQX1TS s3_rhs_r_reg_22_ ( .D(n1815), .CK(clk), .Q(s3_rhs_r[22]) );
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
  DFFQX1TS s3_addsubn_r_reg ( .D(n1814), .CK(clk), .Q(s3_addsubn_r) );
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
  DFFQX1TS s4_sb_r_reg ( .D(s3_sb_r), .CK(clk), .Q(s4_sb_r) );
  DFFQX1TS s4_sa_r_reg ( .D(s3_sa_r), .CK(clk), .Q(s4_sa_r) );
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
  DFFQX1TS s4_opcode_r_reg_0_ ( .D(n814), .CK(clk), .Q(s4_opcode_r[0]) );
  DFFQX1TS s4_ea_r_reg_5_ ( .D(s3_ea_r[5]), .CK(clk), .Q(s4_ea_r[5]) );
  DFFQX1TS s4_ea_r_reg_4_ ( .D(s3_ea_r[4]), .CK(clk), .Q(s4_ea_r[4]) );
  DFFQX1TS s4_ea_r_reg_3_ ( .D(s3_ea_r[3]), .CK(clk), .Q(s4_ea_r[3]) );
  DFFQX1TS s4_ea_r_reg_2_ ( .D(s3_ea_r[2]), .CK(clk), .Q(s4_ea_r[2]) );
  DFFQX1TS s4_ea_r_reg_1_ ( .D(s3_ea_r[1]), .CK(clk), .Q(s4_ea_r[1]) );
  DFFQX1TS s4_ea_r_reg_0_ ( .D(s3_ea_r[0]), .CK(clk), .Q(s4_ea_r[0]) );
  DFFQX1TS s4_eb_r_reg_5_ ( .D(s3_eb_r[5]), .CK(clk), .Q(s4_eb_r[5]) );
  DFFQX1TS s4_eb_r_reg_4_ ( .D(s3_eb_r[4]), .CK(clk), .Q(s4_eb_r[4]) );
  DFFQX1TS s4_eb_r_reg_3_ ( .D(s3_eb_r[3]), .CK(clk), .Q(s4_eb_r[3]) );
  DFFQX1TS s4_eb_r_reg_2_ ( .D(s3_eb_r[2]), .CK(clk), .Q(s4_eb_r[2]) );
  DFFQX1TS s4_eb_r_reg_1_ ( .D(s3_eb_r[1]), .CK(clk), .Q(s4_eb_r[1]) );
  DFFQX1TS s4_eb_r_reg_0_ ( .D(s3_eb_r[0]), .CK(clk), .Q(s4_eb_r[0]) );
  DFFQX1TS s4_ea_gte_eb_r_reg ( .D(s3_ea_gte_eb_r), .CK(clk), .Q(
        s4_ea_gte_eb_r) );
  DFFQX1TS s4_addsubn_r_reg ( .D(s3_addsubn_r), .CK(clk), .Q(s4_addsubn_r) );
  DFFQX1TS s5_sb_r_reg ( .D(s4_sb_r), .CK(clk), .Q(s5_sb_r) );
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
  DFFQX1TS s5_lzd_r_reg_4_ ( .D(n1079), .CK(clk), .Q(s5_lzd_r[4]) );
  DFFQX1TS s5_lzd_r_reg_3_ ( .D(n1816), .CK(clk), .Q(s5_lzd_r[3]) );
  DFFQX1TS s5_ea_r_reg_5_ ( .D(s4_ea_r[5]), .CK(clk), .Q(s5_ea_r[5]) );
  DFFQX1TS s5_ea_r_reg_4_ ( .D(s4_ea_r[4]), .CK(clk), .Q(s5_ea_r[4]) );
  DFFQX1TS s5_ea_r_reg_3_ ( .D(s4_ea_r[3]), .CK(clk), .Q(s5_ea_r[3]) );
  DFFQX1TS s5_ea_r_reg_2_ ( .D(s4_ea_r[2]), .CK(clk), .Q(s5_ea_r[2]) );
  DFFQX1TS s5_eb_r_reg_5_ ( .D(s4_eb_r[5]), .CK(clk), .Q(s5_eb_r[5]) );
  DFFQX1TS s5_eb_r_reg_4_ ( .D(s4_eb_r[4]), .CK(clk), .Q(s5_eb_r[4]) );
  DFFQX1TS s5_eb_r_reg_3_ ( .D(s4_eb_r[3]), .CK(clk), .Q(s5_eb_r[3]) );
  DFFQX1TS s5_eb_r_reg_2_ ( .D(s4_eb_r[2]), .CK(clk), .Q(s5_eb_r[2]) );
  EDFFX1TS s2_ea_r_reg_4_ ( .D(din_uni_a_exp[4]), .E(n1075), .CK(clk), .Q(
        s2_ea_r[4]) );
  EDFFX1TS s2_ea_r_reg_3_ ( .D(din_uni_a_exp[3]), .E(n1076), .CK(clk), .Q(
        s2_ea_r[3]) );
  EDFFX1TS s2_ea_r_reg_2_ ( .D(din_uni_a_exp[2]), .E(n1074), .CK(clk), .Q(
        s2_ea_r[2]) );
  EDFFX1TS s2_ea_r_reg_1_ ( .D(din_uni_a_exp[1]), .E(n1075), .CK(clk), .Q(
        s2_ea_r[1]) );
  EDFFX1TS s2_ea_r_reg_0_ ( .D(n1034), .E(n1076), .CK(clk), .Q(s2_ea_r[0]) );
  EDFFX1TS s2_eb_r_reg_4_ ( .D(n1042), .E(n1075), .CK(clk), .Q(s2_eb_r[4]) );
  EDFFX1TS s2_eb_r_reg_3_ ( .D(n1038), .E(n1074), .CK(clk), .Q(s2_eb_r[3]) );
  EDFFX1TS s2_eb_r_reg_2_ ( .D(n1040), .E(n1075), .CK(clk), .Q(s2_eb_r[2]) );
  EDFFX1TS s2_eb_r_reg_1_ ( .D(n1036), .E(n1076), .CK(clk), .Q(s2_eb_r[1]) );
  EDFFX1TS s2_eb_r_reg_0_ ( .D(n1022), .E(n1074), .CK(clk), .Q(s2_eb_r[0]) );
  EDFFX1TS s2_br4_s_r_reg_4_ ( .D(n727), .E(n1806), .CK(clk), .Q(s2_br4_s_r[4]) );
  EDFFX1TS s2_br4_s_r_reg_3_ ( .D(s1_br4_s[3]), .E(n1804), .CK(clk), .Q(
        s2_br4_s_r[3]), .QN(n1780) );
  EDFFX1TS s2_br4_s_r_reg_2_ ( .D(s1_br4_s[2]), .E(n1806), .CK(clk), .Q(
        s2_br4_s_r[2]), .QN(n1783) );
  EDFFX1TS s2_br4_s_r_reg_1_ ( .D(s1_br4_s[1]), .E(n1806), .CK(clk), .Q(
        s2_br4_s_r[1]) );
  EDFFX1TS s2_br4_s_r_reg_0_ ( .D(s1_br4_s[0]), .E(n1804), .CK(clk), .Q(
        s2_br4_s_r[0]), .QN(n1077) );
  EDFFX1TS s2_br4_pp_r_reg_71_ ( .D(s1_br4_pp[71]), .E(n1803), .CK(clk), .Q(
        s2_br4_pp_r[71]) );
  EDFFX1TS s2_br4_pp_r_reg_70_ ( .D(n633), .E(n1803), .CK(clk), .Q(
        s2_br4_pp_r[70]) );
  EDFFX1TS s2_br4_pp_r_reg_69_ ( .D(n644), .E(n1803), .CK(clk), .Q(
        s2_br4_pp_r[69]) );
  EDFFX1TS s2_br4_pp_r_reg_68_ ( .D(n650), .E(n1803), .CK(clk), .Q(
        s2_br4_pp_r[68]) );
  EDFFX1TS s2_br4_pp_r_reg_67_ ( .D(n656), .E(n1802), .CK(clk), .Q(
        s2_br4_pp_r[67]) );
  EDFFX1TS s2_br4_pp_r_reg_66_ ( .D(n662), .E(n1802), .CK(clk), .Q(
        s2_br4_pp_r[66]) );
  EDFFX1TS s2_br4_pp_r_reg_65_ ( .D(n668), .E(n1802), .CK(clk), .Q(
        s2_br4_pp_r[65]) );
  EDFFX1TS s2_br4_pp_r_reg_64_ ( .D(n674), .E(n1802), .CK(clk), .Q(
        s2_br4_pp_r[64]) );
  EDFFX1TS s2_br4_pp_r_reg_63_ ( .D(n680), .E(n1801), .CK(clk), .Q(
        s2_br4_pp_r[63]) );
  EDFFX1TS s2_br4_pp_r_reg_62_ ( .D(n686), .E(n1801), .CK(clk), .Q(
        s2_br4_pp_r[62]) );
  EDFFX1TS s2_br4_pp_r_reg_61_ ( .D(n692), .E(n1801), .CK(clk), .Q(
        s2_br4_pp_r[61]) );
  EDFFX1TS s2_br4_pp_r_reg_60_ ( .D(s1_br4_pp[60]), .E(n1801), .CK(clk), .Q(
        s2_br4_pp_r[60]) );
  EDFFX1TS s2_br4_pp_r_reg_59_ ( .D(n641), .E(n1800), .CK(clk), .Q(
        s2_br4_pp_r[59]) );
  EDFFX1TS s2_br4_pp_r_reg_58_ ( .D(n640), .E(n1800), .CK(clk), .Q(
        s2_br4_pp_r[58]) );
  EDFFX1TS s2_br4_pp_r_reg_57_ ( .D(n648), .E(n1800), .CK(clk), .Q(
        s2_br4_pp_r[57]) );
  EDFFX1TS s2_br4_pp_r_reg_56_ ( .D(n654), .E(n1800), .CK(clk), .Q(
        s2_br4_pp_r[56]) );
  EDFFX1TS s2_br4_pp_r_reg_55_ ( .D(n660), .E(n1799), .CK(clk), .Q(
        s2_br4_pp_r[55]) );
  EDFFX1TS s2_br4_pp_r_reg_54_ ( .D(n666), .E(n1799), .CK(clk), .Q(
        s2_br4_pp_r[54]) );
  EDFFX1TS s2_br4_pp_r_reg_53_ ( .D(n672), .E(n1799), .CK(clk), .Q(
        s2_br4_pp_r[53]) );
  EDFFX1TS s2_br4_pp_r_reg_52_ ( .D(n678), .E(n1799), .CK(clk), .Q(
        s2_br4_pp_r[52]) );
  EDFFX1TS s2_br4_pp_r_reg_51_ ( .D(n684), .E(n1798), .CK(clk), .Q(
        s2_br4_pp_r[51]) );
  EDFFX1TS s2_br4_pp_r_reg_50_ ( .D(n690), .E(n1798), .CK(clk), .Q(
        s2_br4_pp_r[50]) );
  EDFFX1TS s2_br4_pp_r_reg_49_ ( .D(n696), .E(n1798), .CK(clk), .Q(
        s2_br4_pp_r[49]) );
  EDFFX1TS s2_br4_pp_r_reg_48_ ( .D(n701), .E(n1798), .CK(clk), .Q(
        s2_br4_pp_r[48]) );
  EDFFX1TS s2_br4_pp_r_reg_47_ ( .D(n639), .E(n1797), .CK(clk), .Q(
        s2_br4_pp_r[47]) );
  EDFFX1TS s2_br4_pp_r_reg_46_ ( .D(n638), .E(n1797), .CK(clk), .Q(
        s2_br4_pp_r[46]) );
  EDFFX1TS s2_br4_pp_r_reg_45_ ( .D(n647), .E(n1797), .CK(clk), .Q(
        s2_br4_pp_r[45]) );
  EDFFX1TS s2_br4_pp_r_reg_44_ ( .D(n653), .E(n1797), .CK(clk), .Q(
        s2_br4_pp_r[44]) );
  EDFFX1TS s2_br4_pp_r_reg_43_ ( .D(n659), .E(n1796), .CK(clk), .Q(
        s2_br4_pp_r[43]) );
  EDFFX1TS s2_br4_pp_r_reg_42_ ( .D(n665), .E(n1796), .CK(clk), .Q(
        s2_br4_pp_r[42]) );
  EDFFX1TS s2_br4_pp_r_reg_41_ ( .D(n671), .E(n1796), .CK(clk), .Q(
        s2_br4_pp_r[41]) );
  EDFFX1TS s2_br4_pp_r_reg_40_ ( .D(n677), .E(n1796), .CK(clk), .Q(
        s2_br4_pp_r[40]) );
  EDFFX1TS s2_br4_pp_r_reg_39_ ( .D(n683), .E(n1795), .CK(clk), .Q(
        s2_br4_pp_r[39]) );
  EDFFX1TS s2_br4_pp_r_reg_38_ ( .D(n689), .E(n1795), .CK(clk), .Q(
        s2_br4_pp_r[38]) );
  EDFFX1TS s2_br4_pp_r_reg_37_ ( .D(n695), .E(n1795), .CK(clk), .Q(
        s2_br4_pp_r[37]) );
  EDFFX1TS s2_br4_pp_r_reg_36_ ( .D(n700), .E(n1795), .CK(clk), .Q(
        s2_br4_pp_r[36]) );
  EDFFX1TS s2_br4_pp_r_reg_35_ ( .D(n637), .E(n1794), .CK(clk), .Q(
        s2_br4_pp_r[35]), .QN(n1782) );
  EDFFX1TS s2_br4_pp_r_reg_34_ ( .D(n636), .E(n1794), .CK(clk), .QN(n1781) );
  EDFFX1TS s2_br4_pp_r_reg_33_ ( .D(n646), .E(n1794), .CK(clk), .Q(
        s2_br4_pp_r[33]) );
  EDFFX1TS s2_br4_pp_r_reg_32_ ( .D(n652), .E(n1794), .CK(clk), .Q(
        s2_br4_pp_r[32]) );
  EDFFX1TS s2_br4_pp_r_reg_31_ ( .D(n658), .E(n1793), .CK(clk), .Q(
        s2_br4_pp_r[31]) );
  EDFFX1TS s2_br4_pp_r_reg_30_ ( .D(n664), .E(n1793), .CK(clk), .Q(
        s2_br4_pp_r[30]) );
  EDFFX1TS s2_br4_pp_r_reg_29_ ( .D(n670), .E(n1793), .CK(clk), .Q(
        s2_br4_pp_r[29]) );
  EDFFX1TS s2_br4_pp_r_reg_28_ ( .D(n676), .E(n1793), .CK(clk), .Q(
        s2_br4_pp_r[28]) );
  EDFFX1TS s2_br4_pp_r_reg_27_ ( .D(n682), .E(n1792), .CK(clk), .Q(
        s2_br4_pp_r[27]) );
  EDFFX1TS s2_br4_pp_r_reg_26_ ( .D(n688), .E(n1792), .CK(clk), .Q(
        s2_br4_pp_r[26]) );
  EDFFX1TS s2_br4_pp_r_reg_25_ ( .D(n694), .E(n1792), .CK(clk), .Q(
        s2_br4_pp_r[25]) );
  EDFFX1TS s2_br4_pp_r_reg_24_ ( .D(n699), .E(n1792), .CK(clk), .Q(
        s2_br4_pp_r[24]) );
  EDFFX1TS s2_br4_pp_r_reg_23_ ( .D(n635), .E(n1791), .CK(clk), .Q(
        s2_br4_pp_r[23]) );
  EDFFX1TS s2_br4_pp_r_reg_22_ ( .D(n634), .E(n1791), .CK(clk), .Q(
        s2_br4_pp_r[22]) );
  EDFFX1TS s2_br4_pp_r_reg_21_ ( .D(n645), .E(n1791), .CK(clk), .Q(
        s2_br4_pp_r[21]) );
  EDFFX1TS s2_br4_pp_r_reg_20_ ( .D(n651), .E(n1791), .CK(clk), .Q(
        s2_br4_pp_r[20]) );
  EDFFX1TS s2_br4_pp_r_reg_19_ ( .D(n657), .E(n1790), .CK(clk), .Q(
        s2_br4_pp_r[19]) );
  EDFFX1TS s2_br4_pp_r_reg_18_ ( .D(n663), .E(n1790), .CK(clk), .Q(
        s2_br4_pp_r[18]) );
  EDFFX1TS s2_br4_pp_r_reg_17_ ( .D(n669), .E(n1790), .CK(clk), .Q(
        s2_br4_pp_r[17]) );
  EDFFX1TS s2_br4_pp_r_reg_16_ ( .D(n675), .E(n1790), .CK(clk), .Q(
        s2_br4_pp_r[16]) );
  EDFFX1TS s2_br4_pp_r_reg_15_ ( .D(n681), .E(n1805), .CK(clk), .Q(
        s2_br4_pp_r[15]) );
  EDFFX1TS s2_br4_pp_r_reg_14_ ( .D(n687), .E(n1807), .CK(clk), .Q(
        s2_br4_pp_r[14]) );
  EDFFX1TS s2_br4_pp_r_reg_13_ ( .D(n693), .E(n1804), .CK(clk), .Q(
        s2_br4_pp_r[13]) );
  EDFFX1TS s2_br4_pp_r_reg_12_ ( .D(n698), .E(n702), .CK(clk), .Q(
        s2_br4_pp_r[12]) );
  EDFFX1TS s2_br4_pp_r_reg_11_ ( .D(n642), .E(n1789), .CK(clk), .Q(
        s2_br4_pp_r[11]) );
  EDFFX1TS s2_br4_pp_r_reg_10_ ( .D(n632), .E(n1789), .CK(clk), .Q(
        s2_br4_pp_r[10]) );
  EDFFX1TS s2_br4_pp_r_reg_9_ ( .D(n643), .E(n1789), .CK(clk), .Q(
        s2_br4_pp_r[9]) );
  EDFFX1TS s2_br4_pp_r_reg_8_ ( .D(n649), .E(n1789), .CK(clk), .Q(
        s2_br4_pp_r[8]) );
  EDFFX1TS s2_br4_pp_r_reg_7_ ( .D(n655), .E(n1788), .CK(clk), .Q(
        s2_br4_pp_r[7]) );
  EDFFX1TS s2_br4_pp_r_reg_6_ ( .D(n661), .E(n1788), .CK(clk), .Q(
        s2_br4_pp_r[6]) );
  EDFFX1TS s2_br4_pp_r_reg_5_ ( .D(n667), .E(n1788), .CK(clk), .Q(
        s2_br4_pp_r[5]) );
  EDFFX1TS s2_br4_pp_r_reg_4_ ( .D(n673), .E(n1788), .CK(clk), .Q(
        s2_br4_pp_r[4]) );
  EDFFX1TS s2_br4_pp_r_reg_3_ ( .D(n679), .E(n1787), .CK(clk), .Q(
        s2_br4_pp_r[3]) );
  EDFFX1TS s2_br4_pp_r_reg_2_ ( .D(n685), .E(n1787), .CK(clk), .Q(
        s2_br4_pp_r[2]) );
  EDFFX1TS s2_br4_pp_r_reg_1_ ( .D(n691), .E(n1787), .CK(clk), .Q(
        s2_br4_pp_r[1]) );
  EDFFX1TS s2_br4_pp_r_reg_0_ ( .D(n697), .E(n1787), .CK(clk), .Q(
        s2_br4_pp_r[0]) );
  EDFFX1TS s4_lzdi_r_reg_22_ ( .D(s3_mmux_y[22]), .E(n1813), .CK(clk), .Q(
        s4_lzdi_r[22]) );
  EDFFX1TS s4_lzdi_r_reg_21_ ( .D(s3_mmux_y[21]), .E(n1813), .CK(clk), .Q(
        s4_lzdi_r[21]) );
  EDFFX1TS s4_lzdi_r_reg_20_ ( .D(s3_mmux_y[20]), .E(n1813), .CK(clk), .Q(
        s4_lzdi_r[20]) );
  EDFFX1TS s4_lzdi_r_reg_19_ ( .D(s3_mmux_y[19]), .E(n1812), .CK(clk), .Q(
        s4_lzdi_r[19]) );
  EDFFX1TS s4_lzdi_r_reg_18_ ( .D(s3_mmux_y[18]), .E(n1812), .CK(clk), .Q(
        s4_lzdi_r[18]), .QN(n1784) );
  EDFFX1TS s4_lzdi_r_reg_17_ ( .D(s3_mmux_y[17]), .E(n1812), .CK(clk), .Q(
        s4_lzdi_r[17]) );
  EDFFX1TS s4_lzdi_r_reg_16_ ( .D(s3_mmux_y[16]), .E(n1812), .CK(clk), .Q(
        s4_lzdi_r[16]) );
  EDFFX1TS s4_lzdi_r_reg_15_ ( .D(s3_mmux_y[15]), .E(n1811), .CK(clk), .Q(
        s4_lzdi_r[15]) );
  EDFFX1TS s4_lzdi_r_reg_14_ ( .D(s3_mmux_y[14]), .E(n1811), .CK(clk), .Q(
        s4_lzdi_r[14]) );
  EDFFX1TS s4_lzdi_r_reg_13_ ( .D(s3_mmux_y[13]), .E(n1811), .CK(clk), .Q(
        s4_lzdi_r[13]) );
  EDFFX1TS s4_lzdi_r_reg_12_ ( .D(s3_mmux_y[12]), .E(n1811), .CK(clk), .Q(
        s4_lzdi_r[12]) );
  EDFFX1TS s4_lzdi_r_reg_11_ ( .D(s3_mmux_y[11]), .E(n1810), .CK(clk), .Q(
        s4_lzdi_r[11]) );
  EDFFX1TS s4_lzdi_r_reg_10_ ( .D(s3_mmux_y[10]), .E(n1810), .CK(clk), .Q(
        s4_lzdi_r[10]) );
  EDFFX1TS s4_lzdi_r_reg_9_ ( .D(s3_mmux_y[9]), .E(n1810), .CK(clk), .Q(
        s4_lzdi_r[9]) );
  EDFFX1TS s4_lzdi_r_reg_8_ ( .D(s3_mmux_y[8]), .E(n1810), .CK(clk), .Q(
        s4_lzdi_r[8]) );
  EDFFX1TS s4_lzdi_r_reg_7_ ( .D(s3_mmux_y[7]), .E(n1809), .CK(clk), .Q(
        s4_lzdi_r[7]) );
  EDFFX1TS s4_lzdi_r_reg_6_ ( .D(s3_mmux_y[6]), .E(n1809), .CK(clk), .Q(
        s4_lzdi_r[6]) );
  EDFFX1TS s4_lzdi_r_reg_5_ ( .D(s3_mmux_y[5]), .E(n1809), .CK(clk), .Q(
        s4_lzdi_r[5]) );
  EDFFX1TS s4_lzdi_r_reg_4_ ( .D(s3_mmux_y[4]), .E(n1809), .CK(clk), .Q(
        s4_lzdi_r[4]) );
  EDFFX1TS s4_lzdi_r_reg_3_ ( .D(s3_mmux_y[3]), .E(n1808), .CK(clk), .Q(
        s4_lzdi_r[3]) );
  EDFFX1TS s4_lzdi_r_reg_2_ ( .D(s3_mmux_y[2]), .E(n1808), .CK(clk), .Q(
        s4_lzdi_r[2]) );
  EDFFX1TS s4_lzdi_r_reg_1_ ( .D(s3_mmux_y[1]), .E(n1808), .CK(clk), .Q(
        s4_lzdi_r[1]) );
  EDFFX1TS s4_lzdi_r_reg_0_ ( .D(s3_mmux_y[0]), .E(n1808), .CK(clk), .Q(
        s4_lzdi_r[0]) );
  EDFFX1TS s5_many_skip_r_reg_21_ ( .D(s4_many_r[21]), .E(n1108), .CK(clk), 
        .Q(s5_many_skip_r[21]) );
  EDFFX1TS s5_many_skip_r_reg_20_ ( .D(s4_many_r[20]), .E(n1106), .CK(clk), 
        .Q(s5_many_skip_r[20]) );
  EDFFX1TS s5_many_skip_r_reg_19_ ( .D(s4_many_r[19]), .E(n1105), .CK(clk), 
        .Q(s5_many_skip_r[19]) );
  EDFFX1TS s5_many_skip_r_reg_18_ ( .D(s4_many_r[18]), .E(n1106), .CK(clk), 
        .Q(s5_many_skip_r[18]) );
  EDFFX1TS s5_many_skip_r_reg_17_ ( .D(s4_many_r[17]), .E(n822), .CK(clk), .Q(
        s5_many_skip_r[17]) );
  EDFFX1TS s5_many_skip_r_reg_16_ ( .D(s4_many_r[16]), .E(n1105), .CK(clk), 
        .Q(s5_many_skip_r[16]) );
  EDFFX1TS s5_many_skip_r_reg_15_ ( .D(s4_many_r[15]), .E(n1108), .CK(clk), 
        .Q(s5_many_skip_r[15]) );
  EDFFX1TS s5_many_skip_r_reg_14_ ( .D(s4_many_r[14]), .E(n1107), .CK(clk), 
        .Q(s5_many_skip_r[14]) );
  EDFFX1TS s5_many_skip_r_reg_13_ ( .D(s4_many_r[13]), .E(n1106), .CK(clk), 
        .Q(s5_many_skip_r[13]) );
  EDFFX1TS s5_many_skip_r_reg_12_ ( .D(s4_many_r[12]), .E(n1107), .CK(clk), 
        .Q(s5_many_skip_r[12]) );
  EDFFX1TS s5_many_skip_r_reg_11_ ( .D(s4_many_r[11]), .E(n1105), .CK(clk), 
        .Q(s5_many_skip_r[11]) );
  EDFFX1TS s5_many_skip_r_reg_10_ ( .D(s4_many_r[10]), .E(n1106), .CK(clk), 
        .Q(s5_many_skip_r[10]) );
  EDFFX1TS s5_many_skip_r_reg_9_ ( .D(s4_many_r[9]), .E(n1105), .CK(clk), .Q(
        s5_many_skip_r[9]) );
  EDFFX1TS s5_many_skip_r_reg_8_ ( .D(s4_many_r[8]), .E(n1108), .CK(clk), .Q(
        s5_many_skip_r[8]) );
  EDFFX1TS s5_many_skip_r_reg_7_ ( .D(s4_many_r[7]), .E(n1785), .CK(clk), .Q(
        s5_many_skip_r[7]) );
  EDFFX1TS s5_many_skip_r_reg_6_ ( .D(s4_many_r[6]), .E(n1107), .CK(clk), .Q(
        s5_many_skip_r[6]) );
  EDFFX1TS s5_many_skip_r_reg_5_ ( .D(s4_many_r[5]), .E(n822), .CK(clk), .Q(
        s5_many_skip_r[5]) );
  EDFFX1TS s5_many_skip_r_reg_4_ ( .D(s4_many_r[4]), .E(n1108), .CK(clk), .Q(
        s5_many_skip_r[4]) );
  EDFFX1TS s5_many_skip_r_reg_3_ ( .D(s4_many_r[3]), .E(n822), .CK(clk), .Q(
        s5_many_skip_r[3]) );
  EDFFX1TS s5_many_skip_r_reg_2_ ( .D(s4_many_r[2]), .E(n1107), .CK(clk), .Q(
        s5_many_skip_r[2]) );
  EDFFX1TS s5_many_skip_r_reg_1_ ( .D(s4_many_r[1]), .E(n1785), .CK(clk), .Q(
        s5_many_skip_r[1]) );
  EDFFX1TS s5_many_skip_r_reg_0_ ( .D(s4_many_r[0]), .E(n822), .CK(clk), .Q(
        s5_many_skip_r[0]) );
  ADDHXLTS DP_OP_167J1_125_280_U32 ( .A(s5_eb_r[0]), .B(s5_ea_r[0]), .CO(
        DP_OP_167J1_125_280_n28), .S(DP_OP_167J1_125_280_n39) );
  CMPR32X2TS DP_OP_167J1_125_280_U31 ( .A(s5_ea_r[1]), .B(s5_eb_r[1]), .C(
        DP_OP_167J1_125_280_n28), .CO(DP_OP_167J1_125_280_n27), .S(
        DP_OP_167J1_125_280_n40) );
  CMPR32X2TS DP_OP_167J1_125_280_U30 ( .A(s5_ea_r[2]), .B(s5_eb_r[2]), .C(
        DP_OP_167J1_125_280_n27), .CO(DP_OP_167J1_125_280_n26), .S(
        DP_OP_167J1_125_280_n41) );
  CMPR32X2TS DP_OP_167J1_125_280_U29 ( .A(s5_ea_r[3]), .B(s5_eb_r[3]), .C(
        DP_OP_167J1_125_280_n26), .CO(DP_OP_167J1_125_280_n25), .S(
        DP_OP_167J1_125_280_n42) );
  CMPR32X2TS DP_OP_167J1_125_280_U28 ( .A(s5_ea_r[4]), .B(s5_eb_r[4]), .C(
        DP_OP_167J1_125_280_n25), .CO(DP_OP_167J1_125_280_n24), .S(
        DP_OP_167J1_125_280_n43) );
  CMPR32X2TS DP_OP_167J1_125_280_U14 ( .A(DP_OP_167J1_125_280_n21), .B(
        U2_RSOP_146_C1_Z_1), .C(n811), .CO(DP_OP_167J1_125_280_n16), .S(
        DP_OP_167J1_125_280_n17) );
  CMPR32X2TS DP_OP_167J1_125_280_U13 ( .A(DP_OP_167J1_125_280_n20), .B(
        U2_RSOP_146_C1_Z_2), .C(DP_OP_167J1_125_280_n16), .CO(
        DP_OP_167J1_125_280_n14), .S(DP_OP_167J1_125_280_n15) );
  CMPR32X2TS DP_OP_167J1_125_280_U12 ( .A(n1229), .B(U2_RSOP_146_C1_Z_3), .C(
        DP_OP_167J1_125_280_n14), .CO(DP_OP_167J1_125_280_n12), .S(
        DP_OP_167J1_125_280_n13) );
  CMPR32X2TS DP_OP_167J1_125_280_U11 ( .A(DP_OP_167J1_125_280_n18), .B(
        U2_RSOP_146_C1_Z_4), .C(DP_OP_167J1_125_280_n12), .CO(
        DP_OP_167J1_125_280_n10), .S(DP_OP_167J1_125_280_n11) );
  CMPR32X2TS DP_OP_167J1_125_280_U7 ( .A(U2_RSOP_146_C1_Z_0), .B(n812), .C(
        DP_OP_167J1_125_280_n33), .CO(DP_OP_167J1_125_280_n6), .S(C46_DATA2_0)
         );
  CMPR32X2TS DP_OP_167J1_125_280_U6 ( .A(DP_OP_167J1_125_280_n34), .B(
        DP_OP_167J1_125_280_n17), .C(DP_OP_167J1_125_280_n6), .CO(
        DP_OP_167J1_125_280_n5), .S(C46_DATA2_1) );
  CMPR32X2TS DP_OP_167J1_125_280_U5 ( .A(DP_OP_167J1_125_280_n35), .B(
        DP_OP_167J1_125_280_n15), .C(DP_OP_167J1_125_280_n5), .CO(
        DP_OP_167J1_125_280_n4), .S(C46_DATA2_2) );
  CMPR32X2TS DP_OP_167J1_125_280_U4 ( .A(DP_OP_167J1_125_280_n36), .B(
        DP_OP_167J1_125_280_n13), .C(DP_OP_167J1_125_280_n4), .CO(
        DP_OP_167J1_125_280_n3), .S(C46_DATA2_3) );
  CMPR32X2TS DP_OP_167J1_125_280_U3 ( .A(DP_OP_167J1_125_280_n37), .B(
        DP_OP_167J1_125_280_n11), .C(DP_OP_167J1_125_280_n3), .CO(
        DP_OP_167J1_125_280_n2), .S(C46_DATA2_4) );
  TLATXLTS s3_mmux_y_reg_22_ ( .G(n828), .D(n705), .Q(s3_mmux_y[22]) );
  TLATXLTS s3_mmux_y_reg_21_ ( .G(n829), .D(n623), .Q(s3_mmux_y[21]) );
  TLATXLTS s3_mmux_y_reg_20_ ( .G(n1122), .D(n622), .Q(s3_mmux_y[20]) );
  TLATXLTS s3_mmux_y_reg_19_ ( .G(n1125), .D(n621), .Q(s3_mmux_y[19]) );
  TLATXLTS s3_mmux_y_reg_18_ ( .G(n828), .D(n620), .Q(s3_mmux_y[18]) );
  TLATXLTS s3_mmux_y_reg_17_ ( .G(n1124), .D(n619), .Q(s3_mmux_y[17]) );
  TLATXLTS s3_mmux_y_reg_16_ ( .G(n1123), .D(n618), .Q(s3_mmux_y[16]) );
  TLATXLTS s3_mmux_y_reg_15_ ( .G(n1124), .D(n617), .Q(s3_mmux_y[15]) );
  TLATXLTS s3_mmux_y_reg_14_ ( .G(n828), .D(n616), .Q(s3_mmux_y[14]) );
  TLATXLTS s3_mmux_y_reg_13_ ( .G(n1122), .D(n615), .Q(s3_mmux_y[13]) );
  TLATXLTS s3_mmux_y_reg_12_ ( .G(n1125), .D(n614), .Q(s3_mmux_y[12]) );
  TLATXLTS s3_mmux_y_reg_11_ ( .G(n1122), .D(n613), .Q(s3_mmux_y[11]) );
  TLATXLTS s3_mmux_y_reg_10_ ( .G(n829), .D(n612), .Q(s3_mmux_y[10]) );
  TLATXLTS s3_mmux_y_reg_9_ ( .G(n1123), .D(n611), .Q(s3_mmux_y[9]) );
  TLATXLTS s3_mmux_y_reg_8_ ( .G(n1124), .D(n610), .Q(s3_mmux_y[8]) );
  TLATXLTS s3_mmux_y_reg_7_ ( .G(n828), .D(n609), .Q(s3_mmux_y[7]) );
  TLATXLTS s3_mmux_y_reg_6_ ( .G(n829), .D(n608), .Q(s3_mmux_y[6]) );
  TLATXLTS s3_mmux_y_reg_5_ ( .G(n1125), .D(n607), .Q(s3_mmux_y[5]) );
  TLATXLTS s3_mmux_y_reg_4_ ( .G(n1122), .D(n606), .Q(s3_mmux_y[4]) );
  TLATXLTS s3_mmux_y_reg_3_ ( .G(n1125), .D(n605), .Q(s3_mmux_y[3]) );
  TLATXLTS s3_mmux_y_reg_2_ ( .G(n829), .D(n604), .Q(s3_mmux_y[2]) );
  TLATXLTS s3_mmux_y_reg_1_ ( .G(n1124), .D(n603), .Q(s3_mmux_y[1]) );
  TLATXLTS s3_mmux_y_reg_0_ ( .G(n1123), .D(n602), .Q(s3_mmux_y[0]) );
  DFFQX1TS s5_addsubn_r_reg ( .D(s4_addsubn_r), .CK(clk), .Q(s5_addsubn_r) );
  DFFQX1TS s5_sa_r_reg ( .D(s4_sa_r), .CK(clk), .Q(s5_sa_r) );
  DFFQX1TS s5_lzd_r_reg_2_ ( .D(n1817), .CK(clk), .Q(s5_lzd_r[2]) );
  DFFQX1TS s5_eb_r_reg_0_ ( .D(s4_eb_r[0]), .CK(clk), .Q(s5_eb_r[0]) );
  DFFQX1TS s5_opcode_r_reg_1_ ( .D(s4_opcode_r[1]), .CK(clk), .Q(
        s5_opcode_r[1]) );
  DFFQX1TS s5_lzd_r_reg_1_ ( .D(n626), .CK(clk), .Q(s5_lzd_r[1]) );
  DFFQX1TS s5_opcode_r_reg_0_ ( .D(s4_opcode_r[0]), .CK(clk), .Q(
        s5_opcode_r[0]) );
  DFFQX1TS s5_ea_gte_eb_r_reg ( .D(s4_ea_gte_eb_r), .CK(clk), .Q(
        s5_ea_gte_eb_r) );
  DFFQX1TS s5_ea_r_reg_0_ ( .D(s4_ea_r[0]), .CK(clk), .Q(s5_ea_r[0]) );
  DFFQX1TS s5_ea_r_reg_1_ ( .D(s4_ea_r[1]), .CK(clk), .Q(s5_ea_r[1]) );
  DFFQX1TS s5_eb_r_reg_1_ ( .D(s4_eb_r[1]), .CK(clk), .Q(s5_eb_r[1]) );
  DFFQX1TS s5_lzd_r_reg_0_ ( .D(n625), .CK(clk), .Q(s5_lzd_r[0]) );
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
  CMPR32X2TS intadd_3_U2 ( .A(n1042), .B(intadd_3_B_3_), .C(intadd_3_n2), .CO(
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
  CMPR32X2TS intadd_0_U3 ( .A(n1782), .B(intadd_0_B_13_), .C(intadd_0_n3), 
        .CO(intadd_0_n2), .S(s2_ps0[15]) );
  CMPR32X2TS intadd_0_U2 ( .A(n1783), .B(s2_br4_pp_r[35]), .C(intadd_0_n2), 
        .CO(intadd_0_n1), .S(s2_ps0[16]) );
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
  CMPR32X2TS intadd_3_U5 ( .A(n1036), .B(intadd_3_B_0_), .C(intadd_3_CI), .CO(
        intadd_3_n4), .S(intadd_3_SUM_0_) );
  CMPR32X2TS intadd_3_U4 ( .A(n1040), .B(intadd_3_B_1_), .C(intadd_3_n4), .CO(
        intadd_3_n3), .S(intadd_3_SUM_1_) );
  CMPR32X2TS intadd_3_U3 ( .A(n1038), .B(intadd_3_B_2_), .C(intadd_3_n3), .CO(
        intadd_3_n2), .S(intadd_3_SUM_2_) );
  CMPR32X2TS U830 ( .A(s2_br4_pp_r[23]), .B(s2_br4_pp_r[33]), .C(s2_br4_s_r[0]), .CO(intadd_0_A_12_), .S(intadd_0_B_11_) );
  CMPR32X2TS U831 ( .A(n1781), .B(s2_br4_s_r[0]), .C(s2_br4_s_r[1]), .CO(n1417), .S(n1416) );
  CMPR32X2TS U832 ( .A(s2_br4_pp_r[22]), .B(s2_br4_pp_r[32]), .C(s2_br4_s_r[0]), .CO(intadd_0_A_11_), .S(intadd_0_B_10_) );
  INVX2TS U833 ( .A(n1583), .Y(n1010) );
  NOR3XLTS U836 ( .A(n840), .B(n842), .C(n1648), .Y(n1672) );
  INVX2TS U837 ( .A(n1117), .Y(n1767) );
  AO21XLTS U838 ( .A0(n1093), .A1(n1615), .B0(n1364), .Y(n722) );
  INVX2TS U840 ( .A(n1028), .Y(n1610) );
  INVX2TS U841 ( .A(n1074), .Y(n1777) );
  OA21XLTS U842 ( .A0(n815), .A1(n1389), .B0(n1342), .Y(n706) );
  NOR2XLTS U847 ( .A(n796), .B(n1371), .Y(n1761) );
  NOR2XLTS U850 ( .A(n949), .B(s5_opcode_r[0]), .Y(n1548) );
  AOI222XLTS U851 ( .A0(n1110), .A1(s5_many_r[2]), .B0(n1014), .B1(
        s5_many_r[1]), .C0(n1002), .C1(s5_many_r[0]), .Y(n1505) );
  OR2X1TS U853 ( .A(s2_ea_sub_eb_abs_r[1]), .B(s2_ea_sub_eb_abs_r[0]), .Y(n717) );
  NOR2XLTS U858 ( .A(n1040), .B(n1131), .Y(n1193) );
  INVX2TS U859 ( .A(n1119), .Y(n1175) );
  NOR2XLTS U860 ( .A(n796), .B(n1194), .Y(n1757) );
  NOR2XLTS U861 ( .A(n722), .B(n1374), .Y(n1754) );
  NOR2XLTS U862 ( .A(n792), .B(n1367), .Y(n1764) );
  NOR2XLTS U863 ( .A(n796), .B(n1373), .Y(n1760) );
  NOR2XLTS U864 ( .A(n1610), .B(n1399), .Y(n1752) );
  INVX2TS U865 ( .A(n1505), .Y(n723) );
  INVX2TS U866 ( .A(n723), .Y(n724) );
  INVX2TS U867 ( .A(n1472), .Y(n725) );
  INVX2TS U868 ( .A(n725), .Y(n726) );
  INVX2TS U869 ( .A(n722), .Y(n727) );
  INVX2TS U871 ( .A(n715), .Y(n729) );
  INVX2TS U872 ( .A(n706), .Y(n730) );
  INVX2TS U873 ( .A(n1672), .Y(n731) );
  INVX2TS U874 ( .A(n731), .Y(n732) );
  INVX2TS U875 ( .A(n1713), .Y(n733) );
  INVX2TS U876 ( .A(n733), .Y(n734) );
  INVX2TS U878 ( .A(n735), .Y(n736) );
  INVX2TS U879 ( .A(n1490), .Y(n737) );
  INVX2TS U880 ( .A(n737), .Y(n738) );
  INVX2TS U881 ( .A(n1722), .Y(n739) );
  INVX2TS U882 ( .A(n739), .Y(n740) );
  INVX2TS U883 ( .A(s2_mmux_rhs_r[3]), .Y(n741) );
  INVX2TS U884 ( .A(n741), .Y(n742) );
  INVX2TS U885 ( .A(s2_mmux_rhs_r[4]), .Y(n743) );
  INVX2TS U886 ( .A(n743), .Y(n744) );
  INVX2TS U887 ( .A(s2_mmux_rhs_r[5]), .Y(n745) );
  INVX2TS U888 ( .A(n745), .Y(n746) );
  INVX2TS U889 ( .A(s2_mmux_rhs_r[6]), .Y(n747) );
  INVX2TS U890 ( .A(n747), .Y(n748) );
  INVX2TS U891 ( .A(s2_mmux_rhs_r[7]), .Y(n749) );
  INVX2TS U892 ( .A(n749), .Y(n750) );
  INVX2TS U893 ( .A(s2_mmux_rhs_r[8]), .Y(n751) );
  INVX2TS U894 ( .A(n751), .Y(n752) );
  INVX2TS U895 ( .A(s2_mmux_rhs_r[9]), .Y(n753) );
  INVX2TS U896 ( .A(n753), .Y(n754) );
  INVX2TS U897 ( .A(s2_mmux_rhs_r[10]), .Y(n755) );
  INVX2TS U898 ( .A(n755), .Y(n756) );
  INVX2TS U899 ( .A(s2_mmux_rhs_r[12]), .Y(n757) );
  INVX2TS U900 ( .A(n757), .Y(n758) );
  INVX2TS U901 ( .A(s2_mmux_rhs_r[13]), .Y(n759) );
  INVX2TS U902 ( .A(n759), .Y(n760) );
  INVX2TS U903 ( .A(s2_mmux_rhs_r[14]), .Y(n761) );
  INVX2TS U904 ( .A(n761), .Y(n762) );
  INVX2TS U905 ( .A(s2_mmux_rhs_r[15]), .Y(n763) );
  INVX2TS U906 ( .A(n763), .Y(n764) );
  INVX2TS U907 ( .A(s2_mmux_rhs_r[16]), .Y(n765) );
  INVX2TS U908 ( .A(n765), .Y(n766) );
  INVX2TS U909 ( .A(s2_mmux_rhs_r[17]), .Y(n767) );
  INVX2TS U910 ( .A(n767), .Y(n768) );
  INVX2TS U911 ( .A(s2_mmux_rhs_r[18]), .Y(n769) );
  INVX2TS U912 ( .A(n769), .Y(n770) );
  INVX2TS U913 ( .A(s2_mmux_rhs_r[20]), .Y(n771) );
  INVX2TS U914 ( .A(n771), .Y(n772) );
  INVX2TS U915 ( .A(s2_mmux_rhs_r[21]), .Y(n773) );
  INVX2TS U916 ( .A(n773), .Y(n774) );
  INVX2TS U917 ( .A(n1003), .Y(n775) );
  INVX2TS U918 ( .A(n1009), .Y(n776) );
  INVX2TS U919 ( .A(n776), .Y(n777) );
  INVX2TS U920 ( .A(n1010), .Y(n1013) );
  INVX2TS U921 ( .A(n1010), .Y(n1014) );
  INVX2TS U922 ( .A(n1010), .Y(n1012) );
  INVX2TS U923 ( .A(n1010), .Y(n1011) );
  INVX2TS U924 ( .A(n1243), .Y(n778) );
  INVX2TS U925 ( .A(n717), .Y(n1018) );
  INVX2TS U926 ( .A(n717), .Y(n1017) );
  INVX2TS U927 ( .A(n717), .Y(n1016) );
  INVX2TS U928 ( .A(n717), .Y(n1015) );
  INVX2TS U929 ( .A(n1114), .Y(n779) );
  INVX2TS U930 ( .A(n779), .Y(n780) );
  INVX2TS U931 ( .A(n779), .Y(n781) );
  INVX2TS U933 ( .A(n1771), .Y(n783) );
  INVX2TS U935 ( .A(n1569), .Y(n785) );
  INVX2TS U937 ( .A(n786), .Y(n787) );
  INVX2TS U938 ( .A(n1750), .Y(n788) );
  INVX2TS U939 ( .A(n788), .Y(n789) );
  INVX2TS U940 ( .A(n844), .Y(n790) );
  INVX2TS U941 ( .A(n1191), .Y(n791) );
  INVX2TS U942 ( .A(n791), .Y(n792) );
  INVX2TS U943 ( .A(n1196), .Y(n793) );
  INVX2TS U944 ( .A(n793), .Y(n794) );
  INVX2TS U945 ( .A(n1195), .Y(n795) );
  INVX2TS U946 ( .A(n795), .Y(n796) );
  INVX2TS U947 ( .A(n1690), .Y(n797) );
  INVX2TS U948 ( .A(n797), .Y(n798) );
  INVX2TS U950 ( .A(n714), .Y(n800) );
  INVX2TS U951 ( .A(n1709), .Y(n801) );
  INVX2TS U952 ( .A(n801), .Y(n802) );
  INVX2TS U953 ( .A(n1574), .Y(n803) );
  INVX2TS U954 ( .A(n803), .Y(n804) );
  INVX2TS U955 ( .A(n1585), .Y(n805) );
  INVX2TS U956 ( .A(n805), .Y(n806) );
  INVX2TS U957 ( .A(n716), .Y(n807) );
  INVX2TS U960 ( .A(n809), .Y(n810) );
  INVX2TS U961 ( .A(s5_lzd_r[0]), .Y(n811) );
  INVX2TS U962 ( .A(n811), .Y(n812) );
  INVX2TS U964 ( .A(n813), .Y(n814) );
  INVX2TS U965 ( .A(n1015), .Y(n815) );
  INVX2TS U966 ( .A(n815), .Y(n816) );
  INVX2TS U967 ( .A(n815), .Y(n817) );
  INVX2TS U968 ( .A(n1100), .Y(n818) );
  INVX2TS U969 ( .A(n818), .Y(n819) );
  INVX2TS U970 ( .A(n818), .Y(n820) );
  NOR2BX1TS U971 ( .AN(s4_opcode_r[0]), .B(s4_opcode_r[1]), .Y(n1785) );
  INVX2TS U972 ( .A(n1785), .Y(n821) );
  INVX2TS U973 ( .A(n821), .Y(n822) );
  INVX2TS U974 ( .A(n1270), .Y(n823) );
  INVX2TS U975 ( .A(n1270), .Y(n824) );
  INVX2TS U976 ( .A(n779), .Y(n825) );
  INVX2TS U977 ( .A(n779), .Y(n826) );
  INVX2TS U978 ( .A(n1123), .Y(n827) );
  INVX2TS U979 ( .A(n827), .Y(n828) );
  INVX2TS U980 ( .A(n827), .Y(n829) );
  INVX2TS U982 ( .A(n1549), .Y(n831) );
  INVX2TS U983 ( .A(n1154), .Y(n832) );
  INVX2TS U984 ( .A(n1483), .Y(n833) );
  INVX2TS U985 ( .A(n833), .Y(n834) );
  INVX2TS U986 ( .A(n1710), .Y(n835) );
  INVX2TS U987 ( .A(n835), .Y(n836) );
  INVX2TS U988 ( .A(n1579), .Y(n837) );
  INVX2TS U989 ( .A(n837), .Y(n838) );
  INVX2TS U990 ( .A(s2_ea_sub_eb_abs_r[3]), .Y(n839) );
  INVX2TS U991 ( .A(n839), .Y(n840) );
  INVX2TS U992 ( .A(s2_ea_sub_eb_abs_r[4]), .Y(n841) );
  INVX2TS U993 ( .A(n841), .Y(n842) );
  INVX2TS U994 ( .A(s2_ea_sub_eb_abs_r[5]), .Y(n843) );
  INVX2TS U995 ( .A(n843), .Y(n844) );
  INVX2TS U996 ( .A(n1648), .Y(n845) );
  INVX2TS U997 ( .A(n845), .Y(n846) );
  INVX2TS U1000 ( .A(n847), .Y(n849) );
  INVX2TS U1001 ( .A(n956), .Y(n850) );
  INVX2TS U1002 ( .A(n956), .Y(n851) );
  INVX2TS U1003 ( .A(n1161), .Y(n852) );
  INVX2TS U1004 ( .A(n1161), .Y(n853) );
  INVX2TS U1005 ( .A(n1163), .Y(n854) );
  INVX2TS U1006 ( .A(n1163), .Y(n855) );
  INVX2TS U1007 ( .A(n1165), .Y(n856) );
  INVX2TS U1008 ( .A(n1165), .Y(n857) );
  INVX2TS U1009 ( .A(n1166), .Y(n858) );
  INVX2TS U1010 ( .A(n973), .Y(n859) );
  INVX2TS U1011 ( .A(n1168), .Y(n860) );
  INVX2TS U1012 ( .A(n1168), .Y(n861) );
  INVX2TS U1013 ( .A(n1170), .Y(n862) );
  INVX2TS U1014 ( .A(n1170), .Y(n863) );
  INVX2TS U1015 ( .A(n1172), .Y(n864) );
  INVX2TS U1016 ( .A(n1172), .Y(n865) );
  INVX2TS U1017 ( .A(n1177), .Y(n866) );
  INVX2TS U1018 ( .A(n1177), .Y(n867) );
  INVX2TS U1019 ( .A(n1193), .Y(n868) );
  INVX2TS U1020 ( .A(n868), .Y(n869) );
  INVX2TS U1021 ( .A(n868), .Y(n870) );
  INVX2TS U1022 ( .A(n1766), .Y(n871) );
  INVX2TS U1023 ( .A(n871), .Y(n872) );
  INVX2TS U1024 ( .A(n871), .Y(n873) );
  INVX2TS U1025 ( .A(n1756), .Y(n874) );
  INVX2TS U1026 ( .A(n874), .Y(n875) );
  INVX2TS U1027 ( .A(n874), .Y(n876) );
  INVX2TS U1028 ( .A(n1763), .Y(n877) );
  INVX2TS U1029 ( .A(n877), .Y(n878) );
  INVX2TS U1030 ( .A(n877), .Y(n879) );
  INVX2TS U1031 ( .A(n1759), .Y(n880) );
  INVX2TS U1032 ( .A(n880), .Y(n881) );
  INVX2TS U1033 ( .A(n880), .Y(n882) );
  INVX2TS U1034 ( .A(s5_opcode_r[1]), .Y(n883) );
  INVX2TS U1035 ( .A(s5_opcode_r[1]), .Y(n884) );
  INVX2TS U1036 ( .A(n1747), .Y(n885) );
  INVX2TS U1037 ( .A(n1747), .Y(n886) );
  INVX2TS U1038 ( .A(n1747), .Y(n887) );
  INVX2TS U1039 ( .A(n1768), .Y(n888) );
  INVX2TS U1040 ( .A(n888), .Y(n889) );
  INVX2TS U1041 ( .A(n888), .Y(n890) );
  INVX2TS U1042 ( .A(n718), .Y(n891) );
  INVX2TS U1044 ( .A(n718), .Y(n893) );
  INVX2TS U1045 ( .A(n713), .Y(n894) );
  INVX2TS U1046 ( .A(n713), .Y(n895) );
  INVX2TS U1048 ( .A(n707), .Y(n897) );
  INVX2TS U1049 ( .A(n707), .Y(n898) );
  INVX2TS U1051 ( .A(n1770), .Y(n900) );
  INVX2TS U1052 ( .A(n900), .Y(n901) );
  INVX2TS U1053 ( .A(n900), .Y(n902) );
  INVX2TS U1054 ( .A(n1748), .Y(n903) );
  INVX2TS U1055 ( .A(n903), .Y(n904) );
  INVX2TS U1056 ( .A(n903), .Y(n905) );
  INVX2TS U1058 ( .A(n721), .Y(n907) );
  INVX2TS U1059 ( .A(n721), .Y(n908) );
  INVX2TS U1061 ( .A(n710), .Y(n910) );
  INVX2TS U1062 ( .A(n710), .Y(n911) );
  INVX2TS U1063 ( .A(n1764), .Y(n912) );
  INVX2TS U1064 ( .A(n912), .Y(n913) );
  INVX2TS U1065 ( .A(n912), .Y(n914) );
  INVX2TS U1067 ( .A(n719), .Y(n916) );
  INVX2TS U1068 ( .A(n719), .Y(n917) );
  INVX2TS U1069 ( .A(n1754), .Y(n918) );
  INVX2TS U1070 ( .A(n918), .Y(n919) );
  INVX2TS U1071 ( .A(n918), .Y(n920) );
  INVX2TS U1073 ( .A(n720), .Y(n922) );
  INVX2TS U1074 ( .A(n720), .Y(n923) );
  INVX2TS U1075 ( .A(n1761), .Y(n924) );
  INVX2TS U1076 ( .A(n924), .Y(n925) );
  INVX2TS U1077 ( .A(n924), .Y(n926) );
  INVX2TS U1078 ( .A(n1760), .Y(n927) );
  INVX2TS U1079 ( .A(n927), .Y(n928) );
  INVX2TS U1080 ( .A(n927), .Y(n929) );
  INVX2TS U1081 ( .A(n1757), .Y(n930) );
  INVX2TS U1082 ( .A(n930), .Y(n931) );
  INVX2TS U1083 ( .A(n930), .Y(n932) );
  INVX2TS U1085 ( .A(n709), .Y(n934) );
  INVX2TS U1086 ( .A(n709), .Y(n935) );
  INVX2TS U1087 ( .A(n708), .Y(n936) );
  INVX2TS U1089 ( .A(n708), .Y(n938) );
  INVX2TS U1090 ( .A(n1752), .Y(n939) );
  INVX2TS U1091 ( .A(n939), .Y(n940) );
  INVX2TS U1092 ( .A(n939), .Y(n941) );
  INVX2TS U1093 ( .A(n1121), .Y(n942) );
  INVX2TS U1094 ( .A(n1120), .Y(n943) );
  INVX2TS U1096 ( .A(n944), .Y(n945) );
  INVX2TS U1097 ( .A(n944), .Y(n946) );
  INVX2TS U1098 ( .A(n944), .Y(n947) );
  INVX2TS U1099 ( .A(s5_opcode_r[1]), .Y(n948) );
  INVX2TS U1100 ( .A(n948), .Y(n949) );
  INVX2TS U1101 ( .A(n948), .Y(n950) );
  INVX2TS U1102 ( .A(n948), .Y(n951) );
  INVX2TS U1103 ( .A(n1548), .Y(n952) );
  INVX2TS U1104 ( .A(n952), .Y(n953) );
  INVX2TS U1105 ( .A(n952), .Y(n954) );
  INVX2TS U1106 ( .A(n952), .Y(n955) );
  INVX2TS U1108 ( .A(n712), .Y(n957) );
  INVX2TS U1109 ( .A(n712), .Y(n958) );
  INVX2TS U1110 ( .A(n712), .Y(n959) );
  INVX2TS U1111 ( .A(n1161), .Y(n960) );
  INVX2TS U1112 ( .A(n960), .Y(n961) );
  INVX2TS U1113 ( .A(n960), .Y(n962) );
  INVX2TS U1114 ( .A(n960), .Y(n963) );
  INVX2TS U1115 ( .A(n1163), .Y(n964) );
  INVX2TS U1116 ( .A(n964), .Y(n965) );
  INVX2TS U1117 ( .A(n964), .Y(n966) );
  INVX2TS U1118 ( .A(n964), .Y(n967) );
  INVX2TS U1119 ( .A(n1165), .Y(n968) );
  INVX2TS U1120 ( .A(n968), .Y(n969) );
  INVX2TS U1121 ( .A(n968), .Y(n970) );
  INVX2TS U1122 ( .A(n968), .Y(n971) );
  INVX2TS U1123 ( .A(n1166), .Y(n972) );
  INVX2TS U1124 ( .A(n972), .Y(n973) );
  INVX2TS U1125 ( .A(n972), .Y(n974) );
  INVX2TS U1126 ( .A(n972), .Y(n975) );
  INVX2TS U1127 ( .A(n1168), .Y(n976) );
  INVX2TS U1128 ( .A(n976), .Y(n977) );
  INVX2TS U1129 ( .A(n976), .Y(n978) );
  INVX2TS U1130 ( .A(n976), .Y(n979) );
  INVX2TS U1131 ( .A(n1170), .Y(n980) );
  INVX2TS U1132 ( .A(n980), .Y(n981) );
  INVX2TS U1133 ( .A(n980), .Y(n982) );
  INVX2TS U1134 ( .A(n980), .Y(n983) );
  INVX2TS U1135 ( .A(n1172), .Y(n984) );
  INVX2TS U1136 ( .A(n984), .Y(n985) );
  INVX2TS U1137 ( .A(n984), .Y(n986) );
  INVX2TS U1138 ( .A(n984), .Y(n987) );
  INVX2TS U1139 ( .A(n1177), .Y(n988) );
  INVX2TS U1140 ( .A(n988), .Y(n989) );
  INVX2TS U1141 ( .A(n988), .Y(n990) );
  INVX2TS U1142 ( .A(n988), .Y(n991) );
  INVX2TS U1143 ( .A(n1751), .Y(n992) );
  INVX2TS U1144 ( .A(n992), .Y(n993) );
  INVX2TS U1145 ( .A(n992), .Y(n994) );
  INVX2TS U1146 ( .A(n992), .Y(n995) );
  INVX2TS U1147 ( .A(n1667), .Y(n996) );
  INVX2TS U1148 ( .A(n996), .Y(n997) );
  INVX2TS U1149 ( .A(n996), .Y(n998) );
  INVX2TS U1150 ( .A(n996), .Y(n999) );
  INVX2TS U1151 ( .A(n996), .Y(n1000) );
  INVX2TS U1152 ( .A(n1570), .Y(n1001) );
  INVX2TS U1153 ( .A(n1001), .Y(n1002) );
  INVX2TS U1154 ( .A(n1001), .Y(n1003) );
  INVX2TS U1155 ( .A(n1001), .Y(n1004) );
  INVX2TS U1156 ( .A(n1001), .Y(n1005) );
  INVX2TS U1157 ( .A(n711), .Y(n1006) );
  INVX2TS U1158 ( .A(n711), .Y(n1007) );
  INVX2TS U1159 ( .A(n711), .Y(n1008) );
  INVX2TS U1160 ( .A(n711), .Y(n1009) );
  INVX2TS U1163 ( .A(din_uni_b_exp[0]), .Y(n1021) );
  INVX2TS U1164 ( .A(n1021), .Y(n1022) );
  INVX2TS U1165 ( .A(din_uni_a_man_dn[9]), .Y(n1023) );
  INVX2TS U1166 ( .A(n1023), .Y(n1024) );
  INVX2TS U1167 ( .A(din_uni_b_exp[5]), .Y(n1025) );
  INVX2TS U1168 ( .A(n1025), .Y(n1026) );
  INVX2TS U1169 ( .A(din_uni_b_man_dn[1]), .Y(n1027) );
  INVX2TS U1170 ( .A(n1027), .Y(n1028) );
  INVX2TS U1171 ( .A(din_uni_a_man_dn[1]), .Y(n1029) );
  INVX2TS U1172 ( .A(n1029), .Y(n1030) );
  INVX2TS U1173 ( .A(din_uni_b_man_dn[8]), .Y(n1031) );
  INVX2TS U1174 ( .A(n1031), .Y(n1032) );
  INVX2TS U1175 ( .A(din_uni_a_exp[0]), .Y(n1033) );
  INVX2TS U1176 ( .A(n1033), .Y(n1034) );
  INVX2TS U1177 ( .A(din_uni_b_exp[1]), .Y(n1035) );
  INVX2TS U1178 ( .A(n1035), .Y(n1036) );
  INVX2TS U1179 ( .A(din_uni_b_exp[3]), .Y(n1037) );
  INVX2TS U1180 ( .A(n1037), .Y(n1038) );
  INVX2TS U1181 ( .A(din_uni_b_exp[2]), .Y(n1039) );
  INVX2TS U1182 ( .A(n1039), .Y(n1040) );
  INVX2TS U1183 ( .A(din_uni_b_exp[4]), .Y(n1041) );
  INVX2TS U1184 ( .A(n1041), .Y(n1042) );
  INVX2TS U1185 ( .A(din_uni_a_man_dn[0]), .Y(n1043) );
  INVX2TS U1186 ( .A(n1043), .Y(n1044) );
  INVX2TS U1187 ( .A(din_uni_b_man_dn[2]), .Y(n1045) );
  INVX2TS U1188 ( .A(n1045), .Y(n1046) );
  INVX2TS U1189 ( .A(din_uni_b_man_dn[3]), .Y(n1047) );
  INVX2TS U1190 ( .A(n1047), .Y(n1048) );
  INVX2TS U1191 ( .A(din_uni_b_man_dn[4]), .Y(n1049) );
  INVX2TS U1192 ( .A(n1049), .Y(n1050) );
  INVX2TS U1193 ( .A(din_uni_b_man_dn[5]), .Y(n1051) );
  INVX2TS U1194 ( .A(n1051), .Y(n1052) );
  INVX2TS U1195 ( .A(din_uni_b_man_dn[6]), .Y(n1053) );
  INVX2TS U1196 ( .A(n1053), .Y(n1054) );
  INVX2TS U1197 ( .A(din_uni_b_man_dn[7]), .Y(n1055) );
  INVX2TS U1198 ( .A(n1055), .Y(n1056) );
  INVX2TS U1199 ( .A(din_uni_a_man_dn[2]), .Y(n1057) );
  INVX2TS U1200 ( .A(n1057), .Y(n1058) );
  INVX2TS U1201 ( .A(din_uni_a_man_dn[3]), .Y(n1059) );
  INVX2TS U1202 ( .A(n1059), .Y(n1060) );
  INVX2TS U1203 ( .A(din_uni_a_man_dn[4]), .Y(n1061) );
  INVX2TS U1204 ( .A(n1061), .Y(n1062) );
  INVX2TS U1205 ( .A(din_uni_a_man_dn[5]), .Y(n1063) );
  INVX2TS U1206 ( .A(n1063), .Y(n1064) );
  INVX2TS U1207 ( .A(din_uni_a_man_dn[6]), .Y(n1065) );
  INVX2TS U1208 ( .A(n1065), .Y(n1066) );
  INVX2TS U1209 ( .A(din_uni_a_man_dn[7]), .Y(n1067) );
  INVX2TS U1210 ( .A(n1067), .Y(n1068) );
  INVX2TS U1211 ( .A(din_uni_a_man_dn[8]), .Y(n1069) );
  INVX2TS U1212 ( .A(n1069), .Y(n1070) );
  INVX2TS U1213 ( .A(din_uni_b_man_dn[0]), .Y(n1071) );
  INVX2TS U1214 ( .A(n1071), .Y(n1072) );
  INVX2TS U1215 ( .A(opcode[1]), .Y(n1073) );
  INVX2TS U1216 ( .A(n1073), .Y(n1074) );
  INVX2TS U1217 ( .A(n1073), .Y(n1075) );
  INVX2TS U1218 ( .A(n1073), .Y(n1076) );
  INVX2TS U1219 ( .A(n1077), .Y(n1078) );
  NAND2X1TS U1220 ( .A(n1155), .B(n832), .Y(n1779) );
  INVX2TS U1221 ( .A(n1779), .Y(n1079) );
  INVX2TS U1222 ( .A(n1779), .Y(n1080) );
  NOR2XLTS U1223 ( .A(n804), .B(n1495), .Y(n1576) );
  INVX2TS U1224 ( .A(n1525), .Y(n1081) );
  INVX2TS U1227 ( .A(n1708), .Y(n1083) );
  INVX2TS U1228 ( .A(n1708), .Y(n1084) );
  CLKBUFX2TS U1229 ( .A(n1274), .Y(n1503) );
  INVX2TS U1230 ( .A(n1503), .Y(n1085) );
  INVX2TS U1231 ( .A(n1503), .Y(n1086) );
  INVX2TS U1232 ( .A(n1503), .Y(n1087) );
  INVX2TS U1234 ( .A(n1718), .Y(n1088) );
  INVX2TS U1235 ( .A(n1718), .Y(n1089) );
  INVX2TS U1237 ( .A(n1753), .Y(n1090) );
  INVX2TS U1238 ( .A(n1753), .Y(n1091) );
  INVX2TS U1240 ( .A(n1193), .Y(n1093) );
  INVX2TS U1241 ( .A(n1193), .Y(n1094) );
  INVX2TS U1242 ( .A(n869), .Y(n1095) );
  INVX2TS U1243 ( .A(s5_ea_gte_eb_r), .Y(n1096) );
  INVX2TS U1244 ( .A(n1096), .Y(n1097) );
  INVX2TS U1245 ( .A(n1096), .Y(n1098) );
  INVX2TS U1246 ( .A(n1096), .Y(n1099) );
  INVX2TS U1248 ( .A(n1666), .Y(n1100) );
  INVX2TS U1249 ( .A(n1666), .Y(n1101) );
  INVX2TS U1250 ( .A(n1666), .Y(n1102) );
  INVX2TS U1251 ( .A(n1666), .Y(n1103) );
  INVX2TS U1252 ( .A(n1785), .Y(n1104) );
  INVX2TS U1253 ( .A(n1104), .Y(n1105) );
  INVX2TS U1254 ( .A(n1104), .Y(n1106) );
  INVX2TS U1255 ( .A(n1104), .Y(n1107) );
  INVX2TS U1256 ( .A(n1104), .Y(n1108) );
  OR2X1TS U1257 ( .A(n1220), .B(n1221), .Y(n1584) );
  INVX2TS U1258 ( .A(n1584), .Y(n1109) );
  INVX2TS U1259 ( .A(n1584), .Y(n1110) );
  INVX2TS U1260 ( .A(n1584), .Y(n1111) );
  INVX2TS U1261 ( .A(n1584), .Y(n1112) );
  NAND4XLTS U1262 ( .A(n1632), .B(n1631), .C(n1630), .D(n1629), .Y(n1634) );
  INVX2TS U1263 ( .A(n1634), .Y(n1113) );
  INVX2TS U1264 ( .A(n1634), .Y(n1114) );
  INVX2TS U1267 ( .A(n1771), .Y(n1116) );
  INVX2TS U1268 ( .A(n1771), .Y(n1117) );
  INVX2TS U1269 ( .A(n1771), .Y(n1118) );
  OR3X1TS U1270 ( .A(n1034), .B(din_uni_a_exp[2]), .C(n1130), .Y(n1176) );
  INVX2TS U1271 ( .A(n1176), .Y(n1119) );
  INVX2TS U1272 ( .A(n1176), .Y(n1120) );
  INVX2TS U1273 ( .A(n1176), .Y(n1121) );
  CLKAND2X2TS U1274 ( .A(n1527), .B(n813), .Y(n624) );
  INVX2TS U1275 ( .A(n624), .Y(n1122) );
  INVX2TS U1276 ( .A(n624), .Y(n1123) );
  INVX2TS U1277 ( .A(n624), .Y(n1124) );
  INVX2TS U1278 ( .A(n624), .Y(n1125) );
  INVX2TS U1281 ( .A(n1569), .Y(n1127) );
  INVX2TS U1282 ( .A(n1569), .Y(n1128) );
  INVX2TS U1283 ( .A(n1569), .Y(n1129) );
  INVX2TS U1284 ( .A(s5_lzd_r[3]), .Y(n1229) );
  OAI21XLTS U1285 ( .A0(n1243), .A1(n1266), .B0(n1242), .Y(n1244) );
  OAI21XLTS U1286 ( .A0(n1270), .A1(n1266), .B0(n1265), .Y(n1267) );
  NOR2XLTS U1287 ( .A(n1303), .B(n1302), .Y(n1304) );
  OAI21XLTS U1288 ( .A0(n1320), .A1(intadd_1_n1), .B0(n1319), .Y(n1321) );
  OAI21XLTS U1289 ( .A0(n776), .A1(n1392), .B0(n1381), .Y(n1382) );
  OAI21XLTS U1290 ( .A0(n775), .A1(n1250), .B0(n1234), .Y(n1235) );
  OAI21XLTS U1291 ( .A0(n1255), .A1(n1266), .B0(n1252), .Y(n1253) );
  NOR2XLTS U1292 ( .A(n1276), .B(s3_addsubn_r), .Y(n1292) );
  AOI31XLTS U1293 ( .A0(n1323), .A1(s3_rhs_r[2]), .A2(n1299), .B0(n1298), .Y(
        n1303) );
  INVX2TS U1294 ( .A(s2_mmux_rhs_r[19]), .Y(n1389) );
  OAI21XLTS U1295 ( .A0(n1454), .A1(n1087), .B0(n1453), .Y(n1456) );
  NOR2XLTS U1296 ( .A(s5_lzd_r[4]), .B(n884), .Y(n1497) );
  NOR2XLTS U1297 ( .A(n1437), .B(n1087), .Y(n1246) );
  AOI211XLTS U1298 ( .A0(n1461), .A1(n1441), .B0(n1440), .C0(n1439), .Y(n1442)
         );
  INVX2TS U1299 ( .A(n1098), .Y(n1424) );
  OAI21XLTS U1300 ( .A0(s3_rhs_r[22]), .A1(n1597), .B0(n1595), .Y(n1596) );
  AOI221XLTS U1301 ( .A0(n909), .A1(n987), .B0(n906), .B1(n864), .C0(n913), 
        .Y(n1179) );
  AOI221XLTS U1302 ( .A0(n925), .A1(n986), .B0(n921), .B1(n864), .C0(n928), 
        .Y(n1200) );
  AOI221XLTS U1303 ( .A0(n933), .A1(n971), .B0(n931), .B1(n856), .C0(n936), 
        .Y(n1207) );
  AOI221XLTS U1304 ( .A0(n916), .A1(n858), .B0(n919), .B1(n973), .C0(n1092), 
        .Y(n1185) );
  AOI221XLTS U1305 ( .A0(n919), .A1(n1170), .B0(n915), .B1(n862), .C0(n1090), 
        .Y(n1755) );
  AOI211XLTS U1306 ( .A0(n1677), .A1(n1717), .B0(n1676), .C0(n1675), .Y(n1678)
         );
  OAI21XLTS U1307 ( .A0(n1385), .A1(n1384), .B0(n1712), .Y(n1383) );
  INVX2TS U1308 ( .A(s2_addsubn_r), .Y(n1694) );
  OAI21XLTS U1309 ( .A0(n726), .A1(n849), .B0(n1450), .Y(n1562) );
  OAI21XLTS U1310 ( .A0(n1484), .A1(n1483), .B0(n1482), .Y(n1568) );
  NOR2XLTS U1311 ( .A(n1551), .B(n1557), .Y(n626) );
  OAI21XLTS U1312 ( .A0(n1166), .A1(n904), .B0(n1410), .Y(n691) );
  OAI21XLTS U1313 ( .A0(n981), .A1(n904), .B0(n1407), .Y(n643) );
  OAI21XLTS U1314 ( .A0(n1116), .A1(n1367), .B0(n1366), .Y(n635) );
  OAI21XLTS U1315 ( .A0(n783), .A1(n1373), .B0(n1372), .Y(n637) );
  OAI21XLTS U1316 ( .A0(n1117), .A1(n1370), .B0(n1369), .Y(n639) );
  OAI21XLTS U1317 ( .A0(n1118), .A1(n1376), .B0(n1375), .Y(n641) );
  NOR2XLTS U1318 ( .A(n783), .B(n946), .Y(s1_br4_pp[71]) );
  OAI21XLTS U1319 ( .A0(n1472), .A1(n1585), .B0(n1457), .Y(
        dout_uni_y_man_dn[0]) );
  OAI211XLTS U1320 ( .A0(n1472), .A1(n1489), .B0(n1471), .C0(n1470), .Y(
        dout_uni_y_man_dn[8]) );
  OAI211XLTS U1321 ( .A0(s5_addsubn_r), .A1(n1423), .B0(n1422), .C0(n1421), 
        .Y(dout_uni_y_sgn) );
  INVX1TS U1322 ( .A(din_uni_a_exp[1]), .Y(intadd_3_B_0_) );
  INVX1TS U1323 ( .A(din_uni_a_exp[3]), .Y(intadd_3_B_2_) );
  INVX1TS U1324 ( .A(din_uni_a_exp[4]), .Y(intadd_3_B_3_) );
  NAND3XLTS U1325 ( .A(intadd_3_B_0_), .B(intadd_3_B_2_), .C(intadd_3_B_3_), 
        .Y(n1130) );
  OR4X2TS U1326 ( .A(n1042), .B(n1022), .C(n1038), .D(n1036), .Y(n1131) );
  NOR2XLTS U1327 ( .A(n1032), .B(n1095), .Y(n1364) );
  INVX2TS U1329 ( .A(s5_ea_r[2]), .Y(n1133) );
  INVX2TS U1330 ( .A(n949), .Y(n1431) );
  INVX2TS U1331 ( .A(s5_opcode_r[0]), .Y(n1214) );
  NOR2XLTS U1332 ( .A(n883), .B(n1214), .Y(n1419) );
  NOR2XLTS U1334 ( .A(n1099), .B(s5_eb_r[2]), .Y(n1132) );
  AOI211XLTS U1335 ( .A0(n1099), .A1(n1133), .B0(n830), .C0(n1132), .Y(
        U2_RSOP_146_C1_Z_2) );
  INVX2TS U1336 ( .A(s5_ea_r[3]), .Y(n1135) );
  NOR2XLTS U1337 ( .A(n1097), .B(s5_eb_r[3]), .Y(n1134) );
  AOI211XLTS U1338 ( .A0(n1098), .A1(n1135), .B0(n831), .C0(n1134), .Y(
        U2_RSOP_146_C1_Z_3) );
  INVX2TS U1339 ( .A(s5_ea_r[4]), .Y(n1137) );
  NOR2XLTS U1340 ( .A(n1098), .B(s5_eb_r[4]), .Y(n1136) );
  AOI211XLTS U1341 ( .A0(n1099), .A1(n1137), .B0(n831), .C0(n1136), .Y(
        U2_RSOP_146_C1_Z_4) );
  CLKAND2X2TS U1343 ( .A(n814), .B(n1527), .Y(n1776) );
  CLKBUFX2TS U1344 ( .A(n1776), .Y(n1138) );
  CLKBUFX2TS U1345 ( .A(n1138), .Y(n1336) );
  AO21XLTS U1346 ( .A0(s3_lhs_r[6]), .A1(n1336), .B0(intadd_1_SUM_0_), .Y(n608) );
  CLKBUFX2TS U1347 ( .A(n1776), .Y(n1294) );
  CLKBUFX2TS U1348 ( .A(n1294), .Y(n1332) );
  AO21XLTS U1349 ( .A0(s3_lhs_r[13]), .A1(n1332), .B0(intadd_1_SUM_7_), .Y(
        n615) );
  AO21XLTS U1350 ( .A0(s3_lhs_r[7]), .A1(n1336), .B0(intadd_1_SUM_1_), .Y(n609) );
  AO21XLTS U1351 ( .A0(s3_lhs_r[11]), .A1(n1332), .B0(intadd_1_SUM_5_), .Y(
        n613) );
  AO21XLTS U1352 ( .A0(s3_lhs_r[12]), .A1(n1332), .B0(intadd_1_SUM_6_), .Y(
        n614) );
  CLKBUFX2TS U1353 ( .A(n1138), .Y(n1334) );
  AO21XLTS U1354 ( .A0(s3_lhs_r[8]), .A1(n1334), .B0(intadd_1_SUM_2_), .Y(n610) );
  CLKBUFX2TS U1355 ( .A(n1138), .Y(n1335) );
  AO21XLTS U1356 ( .A0(s3_lhs_r[16]), .A1(n1335), .B0(intadd_1_SUM_10_), .Y(
        n618) );
  AO21XLTS U1357 ( .A0(s3_lhs_r[9]), .A1(n1334), .B0(intadd_1_SUM_3_), .Y(n611) );
  AO21XLTS U1358 ( .A0(s3_lhs_r[17]), .A1(n1138), .B0(intadd_1_SUM_11_), .Y(
        n619) );
  AO21XLTS U1359 ( .A0(s3_lhs_r[10]), .A1(n1334), .B0(intadd_1_SUM_4_), .Y(
        n612) );
  AO21XLTS U1360 ( .A0(s3_lhs_r[14]), .A1(n1336), .B0(intadd_1_SUM_8_), .Y(
        n616) );
  AO21XLTS U1361 ( .A0(s3_lhs_r[15]), .A1(n1335), .B0(intadd_1_SUM_9_), .Y(
        n617) );
  AO21XLTS U1362 ( .A0(s3_lhs_r[18]), .A1(n1335), .B0(intadd_1_SUM_12_), .Y(
        n620) );
  CLKBUFX2TS U1364 ( .A(n1288), .Y(n1528) );
  INVX2TS U1365 ( .A(n1528), .Y(n1547) );
  NOR2XLTS U1366 ( .A(s3_opcode_r[0]), .B(n1527), .Y(n1536) );
  CLKBUFX2TS U1367 ( .A(n1536), .Y(n1538) );
  CLKBUFX2TS U1368 ( .A(n1538), .Y(n1530) );
  CLKBUFX2TS U1369 ( .A(n1530), .Y(n1546) );
  AO22XLTS U1370 ( .A0(n1547), .A1(s3_rhs_r[18]), .B0(n1546), .B1(s3_ps1_r[12]), .Y(intadd_1_A_12_) );
  NOR2XLTS U1371 ( .A(n1034), .B(n1021), .Y(intadd_3_CI) );
  AOI21X1TS U1372 ( .A0(n1034), .A1(n1021), .B0(intadd_3_CI), .Y(n1734) );
  INVX2TS U1373 ( .A(n1734), .Y(s1_ea_sub_eb_abs[0]) );
  AND3X1TS U1374 ( .A(s2_br4_s_r[3]), .B(s2_br4_pp_r[36]), .C(s2_br4_pp_r[37]), 
        .Y(intadd_2_CI) );
  CLKAND2X2TS U1375 ( .A(s2_br4_pp_r[36]), .B(s2_br4_s_r[3]), .Y(n1561) );
  AOI2BB1XLTS U1376 ( .A0N(n1561), .A1N(s2_br4_pp_r[37]), .B0(intadd_2_CI), 
        .Y(s2_ps1[1]) );
  AND3X1TS U1377 ( .A(s2_br4_pp_r[0]), .B(s2_br4_s_r[0]), .C(s2_br4_pp_r[1]), 
        .Y(intadd_0_CI) );
  CLKAND2X2TS U1378 ( .A(s2_br4_pp_r[0]), .B(n1078), .Y(n1560) );
  AOI2BB1XLTS U1379 ( .A0N(n1560), .A1N(s2_br4_pp_r[1]), .B0(intadd_0_CI), .Y(
        s2_ps0[1]) );
  NOR2XLTS U1380 ( .A(opcode[0]), .B(n1777), .Y(n702) );
  CLKBUFX2TS U1381 ( .A(n702), .Y(n1807) );
  CLKBUFX2TS U1382 ( .A(n1807), .Y(n1139) );
  CLKBUFX2TS U1383 ( .A(n1139), .Y(n1789) );
  CLKBUFX2TS U1384 ( .A(n1807), .Y(n1142) );
  CLKBUFX2TS U1385 ( .A(n1142), .Y(n1794) );
  CLKBUFX2TS U1386 ( .A(n1142), .Y(n1795) );
  CLKBUFX2TS U1387 ( .A(n1139), .Y(n1787) );
  CLKBUFX2TS U1388 ( .A(n1139), .Y(n1788) );
  CLKBUFX2TS U1389 ( .A(n1139), .Y(n1141) );
  CLKBUFX2TS U1390 ( .A(n1141), .Y(n1793) );
  CLKBUFX2TS U1391 ( .A(n1141), .Y(n1792) );
  CLKBUFX2TS U1392 ( .A(n1142), .Y(n1140) );
  CLKBUFX2TS U1393 ( .A(n1140), .Y(n1796) );
  CLKBUFX2TS U1394 ( .A(n1141), .Y(n1791) );
  CLKBUFX2TS U1395 ( .A(n1140), .Y(n1800) );
  CLKBUFX2TS U1396 ( .A(n1140), .Y(n1802) );
  CLKBUFX2TS U1397 ( .A(n1140), .Y(n1801) );
  CLKBUFX2TS U1398 ( .A(n1141), .Y(n1790) );
  CLKBUFX2TS U1399 ( .A(n1142), .Y(n1805) );
  CLKBUFX2TS U1400 ( .A(n1805), .Y(n1798) );
  CLKBUFX2TS U1401 ( .A(n1805), .Y(n1797) );
  CLKBUFX2TS U1402 ( .A(n1805), .Y(n1799) );
  CLKBUFX2TS U1403 ( .A(n1807), .Y(n1806) );
  CLKBUFX2TS U1404 ( .A(n1806), .Y(n1804) );
  CLKBUFX2TS U1405 ( .A(n1804), .Y(n1803) );
  AOI22X1TS U1406 ( .A0(n869), .A1(n1046), .B0(n1093), .B1(n1048), .Y(n1191)
         );
  INVX2TS U1407 ( .A(n1191), .Y(s1_br4_s[1]) );
  CLKBUFX2TS U1408 ( .A(n1694), .Y(n1815) );
  AOI22X1TS U1410 ( .A0(n1016), .A1(n770), .B0(n1100), .B1(s2_mmux_rhs_r[19]), 
        .Y(n1146) );
  NAND2X1TS U1412 ( .A(s2_ea_sub_eb_abs_r[1]), .B(s2_ea_sub_eb_abs_r[0]), .Y(
        n1393) );
  INVX2TS U1413 ( .A(n1393), .Y(n1667) );
  AOI22X1TS U1414 ( .A0(n1006), .A1(n772), .B0(n997), .B1(s2_mmux_rhs_r[21]), 
        .Y(n1145) );
  NAND2X1TS U1415 ( .A(n1146), .B(n1145), .Y(n1713) );
  CLKBUFX2TS U1416 ( .A(n1694), .Y(n1723) );
  INVX2TS U1417 ( .A(n1723), .Y(n1643) );
  INVX2TS U1418 ( .A(s2_ea_sub_eb_abs_r[2]), .Y(n1648) );
  NAND2X1TS U1419 ( .A(n839), .B(n846), .Y(n1659) );
  NAND2X1TS U1421 ( .A(n1643), .B(n1089), .Y(n1731) );
  NAND2X1TS U1422 ( .A(n1815), .B(n1718), .Y(n1730) );
  OAI221XLTS U1423 ( .A0(n733), .A1(n1731), .B0(n1713), .B1(s2_addsubn_r), 
        .C0(n1730), .Y(s2_mmux3_rhs_addsub[18]) );
  NAND2X1TS U1424 ( .A(n1015), .B(n774), .Y(n1709) );
  OAI221XLTS U1425 ( .A0(n801), .A1(s2_addsubn_r), .B0(n1709), .B1(n1731), 
        .C0(n1730), .Y(s2_mmux3_rhs_addsub[21]) );
  NOR4XLTS U1426 ( .A(s4_lzdi_r[11]), .B(s4_lzdi_r[9]), .C(s4_lzdi_r[10]), .D(
        s4_lzdi_r[8]), .Y(n1148) );
  NOR4XLTS U1427 ( .A(s4_lzdi_r[13]), .B(s4_lzdi_r[7]), .C(s4_lzdi_r[14]), .D(
        s4_lzdi_r[12]), .Y(n1147) );
  CLKAND2X2TS U1428 ( .A(n1148), .B(n1147), .Y(n1155) );
  NOR4XLTS U1432 ( .A(s4_lzdi_r[19]), .B(s4_lzdi_r[18]), .C(s4_lzdi_r[16]), 
        .D(s4_lzdi_r[17]), .Y(n1152) );
  NOR4XLTS U1433 ( .A(s4_lzdi_r[20]), .B(s4_lzdi_r[15]), .C(s4_lzdi_r[22]), 
        .D(s4_lzdi_r[21]), .Y(n1151) );
  NAND2X1TS U1434 ( .A(n1152), .B(n1151), .Y(n1154) );
  AOI21X1TS U1435 ( .A0(n1155), .A1(n1153), .B0(n1154), .Y(n1816) );
  INVX2TS U1436 ( .A(n1154), .Y(n1552) );
  AOI22X1TS U1437 ( .A0(s4_lzdi_r[4]), .A1(n1080), .B0(n1552), .B1(
        s4_lzdi_r[12]), .Y(n1156) );
  NOR2BX1TS U1438 ( .AN(n1156), .B(s4_lzdi_r[20]), .Y(n1554) );
  AO22XLTS U1439 ( .A0(n832), .A1(s4_lzdi_r[13]), .B0(n1079), .B1(s4_lzdi_r[5]), .Y(n1157) );
  NOR2XLTS U1440 ( .A(s4_lzdi_r[21]), .B(n1157), .Y(n1357) );
  AO22XLTS U1441 ( .A0(n832), .A1(s4_lzdi_r[14]), .B0(n1080), .B1(s4_lzdi_r[6]), .Y(n1158) );
  NOR2XLTS U1442 ( .A(s4_lzdi_r[22]), .B(n1158), .Y(n1363) );
  AOI22X1TS U1443 ( .A0(n1552), .A1(s4_lzdi_r[11]), .B0(n1079), .B1(
        s4_lzdi_r[3]), .Y(n1159) );
  NAND4BXLTS U1444 ( .AN(s4_lzdi_r[19]), .B(n1357), .C(n1363), .D(n1159), .Y(
        n1556) );
  NOR2BX1TS U1445 ( .AN(n1554), .B(n1556), .Y(n1817) );
  AOI22X1TS U1446 ( .A0(n870), .A1(n1054), .B0(n1095), .B1(n1056), .Y(n1196)
         );
  INVX2TS U1447 ( .A(n1196), .Y(s1_br4_s[3]) );
  AOI22X1TS U1448 ( .A0(n870), .A1(n1050), .B0(n1094), .B1(n1052), .Y(n1195)
         );
  INVX2TS U1449 ( .A(n1195), .Y(s1_br4_s[2]) );
  INVX1TS U1450 ( .A(din_uni_b_man_dn[9]), .Y(n1615) );
  AOI22X1TS U1451 ( .A0(n869), .A1(n1072), .B0(n1093), .B1(n1028), .Y(n1749)
         );
  INVX2TS U1452 ( .A(n1749), .Y(s1_br4_s[0]) );
  AOI22X1TS U1453 ( .A0(n869), .A1(n1028), .B0(n1094), .B1(n1046), .Y(n1160)
         );
  INVX2TS U1454 ( .A(n906), .Y(n1367) );
  NAND2X1TS U1455 ( .A(n1749), .B(n1160), .Y(n1365) );
  NAND3XLTS U1456 ( .A(n1191), .B(n1367), .C(n1365), .Y(n1768) );
  NAND2X1TS U1457 ( .A(s1_br4_s[1]), .B(n1365), .Y(n1766) );
  AOI22X1TS U1458 ( .A0(n1121), .A1(n1066), .B0(n1068), .B1(n1176), .Y(n1161)
         );
  AOI221XLTS U1459 ( .A0(n909), .A1(n963), .B0(n906), .B1(n852), .C0(n913), 
        .Y(n1162) );
  OAI221XLTS U1460 ( .A0(n958), .A1(n889), .B0(n851), .B1(n872), .C0(n1162), 
        .Y(n651) );
  AOI22X1TS U1461 ( .A0(n1119), .A1(n1064), .B0(n1066), .B1(n1175), .Y(n1163)
         );
  AOI221XLTS U1462 ( .A0(n910), .A1(n967), .B0(n907), .B1(n854), .C0(n913), 
        .Y(n1164) );
  OAI221XLTS U1463 ( .A0(n962), .A1(n889), .B0(n853), .B1(n872), .C0(n1164), 
        .Y(n657) );
  AOI22X1TS U1464 ( .A0(n1120), .A1(n1030), .B0(n1058), .B1(n942), .Y(n1165)
         );
  AOI22X1TS U1465 ( .A0(n1121), .A1(n1044), .B0(n1030), .B1(n943), .Y(n1166)
         );
  AOI221XLTS U1466 ( .A0(n911), .A1(n974), .B0(n908), .B1(n858), .C0(n914), 
        .Y(n1167) );
  OAI221XLTS U1467 ( .A0(n970), .A1(n889), .B0(n857), .B1(n872), .C0(n1167), 
        .Y(n687) );
  AOI22X1TS U1468 ( .A0(n1121), .A1(n1058), .B0(n1060), .B1(n943), .Y(n1168)
         );
  AOI221XLTS U1469 ( .A0(n910), .A1(n970), .B0(n907), .B1(n856), .C0(n1764), 
        .Y(n1169) );
  OAI221XLTS U1470 ( .A0(n978), .A1(n889), .B0(n861), .B1(n872), .C0(n1169), 
        .Y(n681) );
  AOI22X1TS U1471 ( .A0(n1120), .A1(n1070), .B0(n1024), .B1(n942), .Y(n1170)
         );
  AOI221XLTS U1472 ( .A0(n911), .A1(n959), .B0(n908), .B1(n850), .C0(n914), 
        .Y(n1171) );
  OAI221XLTS U1473 ( .A0(n982), .A1(n890), .B0(n863), .B1(n1766), .C0(n1171), 
        .Y(n645) );
  AOI22X1TS U1474 ( .A0(n1119), .A1(n1060), .B0(n1062), .B1(n943), .Y(n1172)
         );
  AOI221XLTS U1475 ( .A0(n910), .A1(n979), .B0(n907), .B1(n860), .C0(n1764), 
        .Y(n1173) );
  OAI221XLTS U1476 ( .A0(n986), .A1(n1768), .B0(n865), .B1(n873), .C0(n1173), 
        .Y(n675) );
  NAND2X1TS U1477 ( .A(n1044), .B(n942), .Y(n1751) );
  INVX2TS U1478 ( .A(n993), .Y(n1750) );
  AOI221XLTS U1479 ( .A0(n907), .A1(n789), .B0(n909), .B1(n993), .C0(n913), 
        .Y(n1174) );
  OAI221XLTS U1480 ( .A0(n974), .A1(n890), .B0(n859), .B1(n873), .C0(n1174), 
        .Y(n693) );
  AOI22X1TS U1481 ( .A0(n1119), .A1(n1062), .B0(n1064), .B1(n942), .Y(n1177)
         );
  AOI221XLTS U1482 ( .A0(n911), .A1(n991), .B0(n908), .B1(n866), .C0(n914), 
        .Y(n1178) );
  OAI221XLTS U1483 ( .A0(n966), .A1(n1768), .B0(n855), .B1(n873), .C0(n1178), 
        .Y(n663) );
  OAI221XLTS U1484 ( .A0(n990), .A1(n890), .B0(n867), .B1(n1766), .C0(n1179), 
        .Y(n669) );
  AOI22X1TS U1485 ( .A0(n870), .A1(n1056), .B0(n1094), .B1(n1032), .Y(n1180)
         );
  INVX2TS U1486 ( .A(n915), .Y(n1376) );
  NAND2X1TS U1487 ( .A(n794), .B(n1180), .Y(n1374) );
  NAND2X1TS U1488 ( .A(n727), .B(n1374), .Y(n1756) );
  AOI221XLTS U1489 ( .A0(n920), .A1(n1165), .B0(n916), .B1(n856), .C0(n1090), 
        .Y(n1181) );
  OAI221XLTS U1490 ( .A0(n977), .A1(n891), .B0(n861), .B1(n875), .C0(n1181), 
        .Y(n684) );
  AOI221XLTS U1491 ( .A0(n919), .A1(n1161), .B0(n917), .B1(n852), .C0(n1091), 
        .Y(n1182) );
  OAI221XLTS U1492 ( .A0(n957), .A1(n891), .B0(n851), .B1(n875), .C0(n1182), 
        .Y(n654) );
  AOI221XLTS U1493 ( .A0(n919), .A1(n994), .B0(n915), .B1(n789), .C0(n1091), 
        .Y(n1183) );
  OAI221XLTS U1494 ( .A0(n1166), .A1(n891), .B0(n859), .B1(n875), .C0(n1183), 
        .Y(n696) );
  AOI221XLTS U1495 ( .A0(n920), .A1(n1172), .B0(n916), .B1(n864), .C0(n1092), 
        .Y(n1184) );
  OAI221XLTS U1496 ( .A0(n989), .A1(n891), .B0(n867), .B1(n875), .C0(n1184), 
        .Y(n672) );
  OAI221XLTS U1497 ( .A0(n969), .A1(n893), .B0(n857), .B1(n1756), .C0(n1185), 
        .Y(n690) );
  AOI221XLTS U1498 ( .A0(n1754), .A1(n956), .B0(n917), .B1(n850), .C0(n1090), 
        .Y(n1186) );
  OAI221XLTS U1499 ( .A0(n981), .A1(n892), .B0(n863), .B1(n876), .C0(n1186), 
        .Y(n648) );
  AOI221XLTS U1500 ( .A0(n920), .A1(n1177), .B0(n916), .B1(n866), .C0(n1091), 
        .Y(n1187) );
  OAI221XLTS U1501 ( .A0(n965), .A1(n893), .B0(n855), .B1(n876), .C0(n1187), 
        .Y(n666) );
  AOI221XLTS U1502 ( .A0(n1754), .A1(n1163), .B0(n917), .B1(n854), .C0(n1092), 
        .Y(n1188) );
  OAI221XLTS U1503 ( .A0(n961), .A1(n892), .B0(n853), .B1(n876), .C0(n1188), 
        .Y(n660) );
  AOI221XLTS U1504 ( .A0(n920), .A1(n1168), .B0(n917), .B1(n860), .C0(n1090), 
        .Y(n1189) );
  OAI221XLTS U1505 ( .A0(n985), .A1(n893), .B0(n865), .B1(n1756), .C0(n1189), 
        .Y(n678) );
  AOI22X1TS U1506 ( .A0(n1193), .A1(n1048), .B0(n1095), .B1(n1050), .Y(n1190)
         );
  INVX2TS U1507 ( .A(n921), .Y(n1373) );
  NAND2X1TS U1508 ( .A(n792), .B(n1190), .Y(n1371) );
  NAND2X1TS U1509 ( .A(s1_br4_s[2]), .B(n1371), .Y(n1763) );
  AOI221XLTS U1510 ( .A0(n925), .A1(n978), .B0(n921), .B1(n860), .C0(n928), 
        .Y(n1192) );
  OAI221XLTS U1511 ( .A0(n987), .A1(n894), .B0(n865), .B1(n878), .C0(n1192), 
        .Y(n676) );
  AOI22X1TS U1512 ( .A0(n870), .A1(n1052), .B0(n1093), .B1(n1054), .Y(n1194)
         );
  INVX2TS U1513 ( .A(n931), .Y(n1370) );
  NAND2X1TS U1514 ( .A(n796), .B(n1194), .Y(n1368) );
  NAND2X1TS U1515 ( .A(s1_br4_s[3]), .B(n1368), .Y(n1759) );
  AOI221XLTS U1516 ( .A0(n933), .A1(n962), .B0(n931), .B1(n852), .C0(n936), 
        .Y(n1197) );
  OAI221XLTS U1517 ( .A0(n959), .A1(n897), .B0(n851), .B1(n881), .C0(n1197), 
        .Y(n653) );
  AOI221XLTS U1518 ( .A0(n934), .A1(n966), .B0(n932), .B1(n854), .C0(n936), 
        .Y(n1198) );
  OAI221XLTS U1519 ( .A0(n963), .A1(n897), .B0(n853), .B1(n881), .C0(n1198), 
        .Y(n659) );
  AOI221XLTS U1520 ( .A0(n932), .A1(n789), .B0(n933), .B1(n993), .C0(n936), 
        .Y(n1199) );
  OAI221XLTS U1521 ( .A0(n975), .A1(n897), .B0(n859), .B1(n881), .C0(n1199), 
        .Y(n695) );
  OAI221XLTS U1522 ( .A0(n991), .A1(n894), .B0(n867), .B1(n878), .C0(n1200), 
        .Y(n670) );
  AOI221XLTS U1523 ( .A0(n926), .A1(n990), .B0(n922), .B1(n866), .C0(n928), 
        .Y(n1201) );
  OAI221XLTS U1524 ( .A0(n967), .A1(n894), .B0(n855), .B1(n878), .C0(n1201), 
        .Y(n664) );
  AOI221XLTS U1525 ( .A0(n935), .A1(n958), .B0(n931), .B1(n850), .C0(n938), 
        .Y(n1202) );
  OAI221XLTS U1526 ( .A0(n983), .A1(n897), .B0(n863), .B1(n881), .C0(n1202), 
        .Y(n647) );
  AOI221XLTS U1527 ( .A0(n925), .A1(n969), .B0(n923), .B1(n856), .C0(n929), 
        .Y(n1203) );
  OAI221XLTS U1528 ( .A0(n979), .A1(n894), .B0(n861), .B1(n878), .C0(n1203), 
        .Y(n682) );
  AOI221XLTS U1529 ( .A0(n922), .A1(n1750), .B0(n925), .B1(n993), .C0(n928), 
        .Y(n1204) );
  OAI221XLTS U1530 ( .A0(n973), .A1(n895), .B0(n859), .B1(n1763), .C0(n1204), 
        .Y(n694) );
  AOI221XLTS U1531 ( .A0(n934), .A1(n977), .B0(n932), .B1(n860), .C0(n937), 
        .Y(n1205) );
  OAI221XLTS U1532 ( .A0(n985), .A1(n898), .B0(n865), .B1(n1759), .C0(n1205), 
        .Y(n677) );
  AOI221XLTS U1533 ( .A0(n926), .A1(n957), .B0(n922), .B1(n850), .C0(n1760), 
        .Y(n1206) );
  OAI221XLTS U1534 ( .A0(n981), .A1(n896), .B0(n863), .B1(n879), .C0(n1206), 
        .Y(n646) );
  OAI221XLTS U1535 ( .A0(n977), .A1(n899), .B0(n861), .B1(n882), .C0(n1207), 
        .Y(n683) );
  AOI221XLTS U1536 ( .A0(n935), .A1(n975), .B0(n1757), .B1(n858), .C0(n938), 
        .Y(n1208) );
  OAI221XLTS U1537 ( .A0(n971), .A1(n898), .B0(n857), .B1(n882), .C0(n1208), 
        .Y(n689) );
  AOI221XLTS U1538 ( .A0(n934), .A1(n989), .B0(n932), .B1(n866), .C0(n937), 
        .Y(n1209) );
  OAI221XLTS U1539 ( .A0(n965), .A1(n899), .B0(n855), .B1(n882), .C0(n1209), 
        .Y(n665) );
  AOI221XLTS U1540 ( .A0(n935), .A1(n985), .B0(n1757), .B1(n864), .C0(n938), 
        .Y(n1210) );
  OAI221XLTS U1541 ( .A0(n989), .A1(n898), .B0(n867), .B1(n1759), .C0(n1210), 
        .Y(n671) );
  AOI221XLTS U1542 ( .A0(n1761), .A1(n965), .B0(n923), .B1(n854), .C0(n929), 
        .Y(n1211) );
  OAI221XLTS U1543 ( .A0(n961), .A1(n895), .B0(n853), .B1(n879), .C0(n1211), 
        .Y(n658) );
  AOI221XLTS U1544 ( .A0(n926), .A1(n961), .B0(n922), .B1(n852), .C0(n1760), 
        .Y(n1212) );
  OAI221XLTS U1545 ( .A0(n957), .A1(n896), .B0(n851), .B1(n879), .C0(n1212), 
        .Y(n652) );
  AOI221XLTS U1546 ( .A0(n1761), .A1(n973), .B0(n923), .B1(n858), .C0(n929), 
        .Y(n1213) );
  OAI221XLTS U1547 ( .A0(n969), .A1(n895), .B0(n857), .B1(n1763), .C0(n1213), 
        .Y(n688) );
  CMPR32X2TS U1548 ( .A(s2_br4_pp_r[40]), .B(s2_br4_pp_r[50]), .C(
        s2_br4_pp_r[60]), .CO(intadd_2_A_3_), .S(intadd_2_B_2_) );
  CMPR32X2TS U1549 ( .A(s2_br4_pp_r[41]), .B(s2_br4_pp_r[51]), .C(
        s2_br4_pp_r[61]), .CO(intadd_2_A_4_), .S(intadd_2_B_3_) );
  CMPR32X2TS U1550 ( .A(s2_br4_pp_r[42]), .B(s2_br4_pp_r[52]), .C(
        s2_br4_pp_r[62]), .CO(intadd_2_A_5_), .S(intadd_2_B_4_) );
  CMPR32X2TS U1551 ( .A(s2_br4_pp_r[43]), .B(s2_br4_pp_r[53]), .C(
        s2_br4_pp_r[63]), .CO(intadd_2_A_6_), .S(intadd_2_B_5_) );
  CMPR32X2TS U1552 ( .A(s2_br4_pp_r[44]), .B(s2_br4_pp_r[54]), .C(
        s2_br4_pp_r[64]), .CO(intadd_2_A_7_), .S(intadd_2_B_6_) );
  CMPR32X2TS U1553 ( .A(s2_br4_pp_r[45]), .B(s2_br4_pp_r[55]), .C(
        s2_br4_pp_r[65]), .CO(intadd_2_A_8_), .S(intadd_2_B_7_) );
  CMPR32X2TS U1554 ( .A(s2_br4_pp_r[46]), .B(s2_br4_pp_r[56]), .C(
        s2_br4_pp_r[66]), .CO(intadd_2_A_9_), .S(intadd_2_B_8_) );
  CMPR32X2TS U1555 ( .A(s2_br4_pp_r[47]), .B(s2_br4_pp_r[57]), .C(
        s2_br4_pp_r[67]), .CO(intadd_2_B_10_), .S(intadd_2_B_9_) );
  CMPR32X2TS U1556 ( .A(s2_br4_pp_r[58]), .B(s2_br4_pp_r[68]), .C(n1780), .CO(
        intadd_2_A_11_), .S(intadd_2_A_10_) );
  OR2X1TS U1557 ( .A(s2_br4_pp_r[69]), .B(s2_br4_pp_r[59]), .Y(intadd_2_B_12_)
         );
  INVX2TS U1558 ( .A(intadd_0_n1), .Y(s2_ps0[17]) );
  CMPR32X2TS U1559 ( .A(s2_br4_pp_r[4]), .B(s2_br4_pp_r[14]), .C(
        s2_br4_pp_r[24]), .CO(intadd_0_A_3_), .S(intadd_0_B_2_) );
  CMPR32X2TS U1560 ( .A(s2_br4_pp_r[5]), .B(s2_br4_pp_r[15]), .C(
        s2_br4_pp_r[25]), .CO(intadd_0_A_4_), .S(intadd_0_B_3_) );
  CMPR32X2TS U1561 ( .A(s2_br4_pp_r[6]), .B(s2_br4_pp_r[16]), .C(
        s2_br4_pp_r[26]), .CO(intadd_0_A_5_), .S(intadd_0_B_4_) );
  CMPR32X2TS U1562 ( .A(s2_br4_pp_r[7]), .B(s2_br4_pp_r[17]), .C(
        s2_br4_pp_r[27]), .CO(intadd_0_A_6_), .S(intadd_0_B_5_) );
  CMPR32X2TS U1563 ( .A(s2_br4_pp_r[8]), .B(s2_br4_pp_r[18]), .C(
        s2_br4_pp_r[28]), .CO(intadd_0_A_7_), .S(intadd_0_B_6_) );
  CMPR32X2TS U1564 ( .A(s2_br4_pp_r[9]), .B(s2_br4_pp_r[19]), .C(
        s2_br4_pp_r[29]), .CO(intadd_0_A_8_), .S(intadd_0_B_7_) );
  CMPR32X2TS U1565 ( .A(s2_br4_pp_r[10]), .B(s2_br4_pp_r[20]), .C(
        s2_br4_pp_r[30]), .CO(intadd_0_A_9_), .S(intadd_0_B_8_) );
  CMPR32X2TS U1566 ( .A(s2_br4_pp_r[11]), .B(s2_br4_pp_r[21]), .C(
        s2_br4_pp_r[31]), .CO(intadd_0_A_10_), .S(intadd_0_B_9_) );
  OR2X1TS U1567 ( .A(n1214), .B(n950), .Y(n1522) );
  CLKBUFX2TS U1568 ( .A(n1522), .Y(n1455) );
  INVX2TS U1569 ( .A(n1455), .Y(n1451) );
  NAND3XLTS U1570 ( .A(n954), .B(s5_lzd_r[1]), .C(n812), .Y(n1216) );
  NOR2BX1TS U1571 ( .AN(s5_lzd_r[2]), .B(n1216), .Y(n1217) );
  NAND2X1TS U1572 ( .A(n1217), .B(s5_lzd_r[3]), .Y(n1215) );
  XNOR2X1TS U1573 ( .A(s5_lzd_r[4]), .B(n1215), .Y(n1574) );
  OAI21XLTS U1574 ( .A0(n1217), .A1(s5_lzd_r[3]), .B0(n1215), .Y(n1465) );
  INVX2TS U1575 ( .A(n1216), .Y(n1218) );
  AOI2BB1XLTS U1576 ( .A0N(s5_lzd_r[2]), .A1N(n1218), .B0(n1217), .Y(n1427) );
  INVX2TS U1577 ( .A(n1427), .Y(n1426) );
  NAND2X1TS U1578 ( .A(n1465), .B(n1426), .Y(n1496) );
  NOR2XLTS U1579 ( .A(n804), .B(n1496), .Y(n1274) );
  NAND2X1TS U1580 ( .A(n951), .B(n1274), .Y(n1585) );
  INVX2TS U1581 ( .A(n1585), .Y(n1486) );
  AOI21X1TS U1582 ( .A0(n953), .A1(s5_lzd_r[0]), .B0(s5_lzd_r[1]), .Y(n1222)
         );
  NOR2XLTS U1583 ( .A(n1218), .B(n1222), .Y(n1220) );
  NAND2X1TS U1585 ( .A(n1220), .B(n1219), .Y(n1262) );
  INVX2TS U1586 ( .A(n1262), .Y(n1570) );
  AOI22X1TS U1587 ( .A0(n1004), .A1(s5_many_r[9]), .B0(n1128), .B1(
        s5_many_r[8]), .Y(n1224) );
  INVX2TS U1588 ( .A(n1219), .Y(n1221) );
  NAND2X1TS U1589 ( .A(n1222), .B(n1221), .Y(n1243) );
  INVX2TS U1590 ( .A(n1243), .Y(n1583) );
  AOI22X1TS U1591 ( .A0(n824), .A1(s5_many_r[11]), .B0(n1012), .B1(
        s5_many_r[10]), .Y(n1223) );
  NAND2X1TS U1592 ( .A(n1224), .B(n1223), .Y(n1441) );
  AOI22X1TS U1593 ( .A0(n1451), .A1(s5_many_skip_r[10]), .B0(n805), .B1(n1441), 
        .Y(n1231) );
  INVX2TS U1594 ( .A(s5_many_r[2]), .Y(n1250) );
  AOI22X1TS U1595 ( .A0(n1002), .A1(s5_many_r[1]), .B0(n785), .B1(s5_many_r[0]), .Y(n1225) );
  OAI21XLTS U1596 ( .A0(n1243), .A1(n1250), .B0(n1225), .Y(n1226) );
  NOR2XLTS U1597 ( .A(s5_lzd_r[4]), .B(n1465), .Y(n1428) );
  NAND2X1TS U1598 ( .A(n1428), .B(n1426), .Y(n1579) );
  INVX2TS U1599 ( .A(n838), .Y(n1461) );
  NAND2X1TS U1600 ( .A(n950), .B(n1461), .Y(n1489) );
  INVX2TS U1601 ( .A(s5_many_r[4]), .Y(n1263) );
  INVX2TS U1602 ( .A(n1128), .Y(n1255) );
  AOI22X1TS U1603 ( .A0(n1014), .A1(s5_many_r[6]), .B0(n1005), .B1(
        s5_many_r[5]), .Y(n1227) );
  OAI21XLTS U1604 ( .A0(n1263), .A1(n1255), .B0(n1227), .Y(n1228) );
  AOI21X1TS U1605 ( .A0(n1110), .A1(s5_many_r[7]), .B0(n1228), .Y(n1491) );
  NAND2X1TS U1606 ( .A(n1229), .B(n1427), .Y(n1495) );
  NAND2X1TS U1607 ( .A(n949), .B(n1576), .Y(n1490) );
  OA22X1TS U1608 ( .A0(n729), .A1(n1489), .B0(n1491), .B1(n738), .Y(n1230) );
  NAND2X1TS U1609 ( .A(n1231), .B(n1230), .Y(dout_uni_y_man_dn[10]) );
  AOI22X1TS U1610 ( .A0(n1005), .A1(s5_many_r[6]), .B0(n1129), .B1(
        s5_many_r[5]), .Y(n1233) );
  AOI22X1TS U1611 ( .A0(n1110), .A1(s5_many_r[8]), .B0(n1011), .B1(
        s5_many_r[7]), .Y(n1232) );
  NAND2X1TS U1612 ( .A(n1233), .B(n1232), .Y(n1459) );
  AOI22X1TS U1613 ( .A0(n1013), .A1(s5_many_r[3]), .B0(n1127), .B1(
        s5_many_r[1]), .Y(n1234) );
  AOI21X1TS U1614 ( .A0(n1109), .A1(s5_many_r[4]), .B0(n1235), .Y(n1434) );
  NAND2BXLTS U1616 ( .AN(n1496), .B(n804), .Y(n1438) );
  NAND2X1TS U1617 ( .A(n1111), .B(s5_many_r[0]), .Y(n1445) );
  OAI22X1TS U1618 ( .A0(n1434), .A1(n849), .B0(n1438), .B1(n1445), .Y(n1241)
         );
  INVX2TS U1619 ( .A(s5_many_r[10]), .Y(n1269) );
  AOI22X1TS U1620 ( .A0(n778), .A1(s5_many_r[11]), .B0(n1128), .B1(
        s5_many_r[9]), .Y(n1236) );
  OAI21XLTS U1621 ( .A0(n1262), .A1(n1269), .B0(n1236), .Y(n1237) );
  AOI21X1TS U1622 ( .A0(n1111), .A1(s5_many_r[12]), .B0(n1237), .Y(n1454) );
  INVX2TS U1623 ( .A(n1576), .Y(n1483) );
  INVX2TS U1624 ( .A(s5_many_r[14]), .Y(n1266) );
  AOI22X1TS U1625 ( .A0(n1012), .A1(s5_many_r[15]), .B0(n1127), .B1(
        s5_many_r[13]), .Y(n1238) );
  OAI21XLTS U1626 ( .A0(n1262), .A1(n1266), .B0(n1238), .Y(n1239) );
  AOI21X1TS U1627 ( .A0(n1111), .A1(s5_many_r[16]), .B0(n1239), .Y(n1469) );
  OAI22X1TS U1628 ( .A0(n1454), .A1(n1483), .B0(n1469), .B1(n1085), .Y(n1240)
         );
  AOI211XLTS U1629 ( .A0(n1461), .A1(n1459), .B0(n1241), .C0(n1240), .Y(n1433)
         );
  CLKBUFX2TS U1630 ( .A(n1522), .Y(n1474) );
  INVX2TS U1631 ( .A(n1474), .Y(n1275) );
  OAI2BB2XLTS U1632 ( .B0(n1433), .B1(n1431), .A0N(n1275), .A1N(
        s5_many_skip_r[15]), .Y(dout_uni_y_man_dn[15]) );
  AOI22X1TS U1633 ( .A0(n1004), .A1(s5_many_r[13]), .B0(n785), .B1(
        s5_many_r[12]), .Y(n1242) );
  AOI21X1TS U1634 ( .A0(n1109), .A1(s5_many_r[15]), .B0(n1244), .Y(n1437) );
  OAI22X1TS U1635 ( .A0(n1491), .A1(n1579), .B0(n729), .B1(n848), .Y(n1245) );
  AOI211XLTS U1636 ( .A0(n1576), .A1(n1441), .B0(n1246), .C0(n1245), .Y(n1448)
         );
  INVX2TS U1637 ( .A(n1474), .Y(n1567) );
  OAI2BB2XLTS U1638 ( .B0(n1448), .B1(n1431), .A0N(n1567), .A1N(
        s5_many_skip_r[14]), .Y(dout_uni_y_man_dn[14]) );
  AOI22X1TS U1639 ( .A0(n1570), .A1(s5_many_r[7]), .B0(n1129), .B1(
        s5_many_r[6]), .Y(n1248) );
  AOI22X1TS U1640 ( .A0(n1112), .A1(s5_many_r[9]), .B0(n1013), .B1(
        s5_many_r[8]), .Y(n1247) );
  NAND2X1TS U1641 ( .A(n1248), .B(n1247), .Y(n1477) );
  AOI22X1TS U1642 ( .A0(n1111), .A1(s5_many_r[1]), .B0(n1012), .B1(
        s5_many_r[0]), .Y(n1472) );
  AOI22X1TS U1643 ( .A0(s5_many_r[4]), .A1(n1013), .B0(s5_many_r[3]), .B1(
        n1002), .Y(n1249) );
  OAI21XLTS U1644 ( .A0(n1250), .A1(n1255), .B0(n1249), .Y(n1251) );
  AOI21X1TS U1645 ( .A0(n823), .A1(s5_many_r[5]), .B0(n1251), .Y(n1458) );
  OAI22X1TS U1646 ( .A0(n726), .A1(n1438), .B0(n1458), .B1(n848), .Y(n1258) );
  AOI22X1TS U1647 ( .A0(n778), .A1(s5_many_r[16]), .B0(n1003), .B1(
        s5_many_r[15]), .Y(n1252) );
  AOI21X1TS U1648 ( .A0(n1109), .A1(s5_many_r[17]), .B0(n1253), .Y(n1484) );
  AOI22X1TS U1649 ( .A0(n778), .A1(s5_many_r[12]), .B0(n1002), .B1(
        s5_many_r[11]), .Y(n1254) );
  OAI21XLTS U1650 ( .A0(n1255), .A1(n1269), .B0(n1254), .Y(n1256) );
  AOI21X1TS U1651 ( .A0(n1110), .A1(s5_many_r[13]), .B0(n1256), .Y(n1478) );
  OAI22X1TS U1652 ( .A0(n1484), .A1(n1086), .B0(n1478), .B1(n834), .Y(n1257)
         );
  AOI211XLTS U1653 ( .A0(n837), .A1(n1477), .B0(n1258), .C0(n1257), .Y(n1501)
         );
  OAI2BB2XLTS U1654 ( .B0(n1501), .B1(n1431), .A0N(n1275), .A1N(
        s5_many_skip_r[16]), .Y(dout_uni_y_man_dn[16]) );
  AOI22X1TS U1655 ( .A0(n1004), .A1(s5_many_r[16]), .B0(n1129), .B1(
        s5_many_r[15]), .Y(n1260) );
  AOI22X1TS U1656 ( .A0(n824), .A1(s5_many_r[18]), .B0(n1014), .B1(
        s5_many_r[17]), .Y(n1259) );
  NAND2X1TS U1657 ( .A(n1260), .B(n1259), .Y(n1575) );
  AOI22X1TS U1658 ( .A0(n1011), .A1(s5_many_r[5]), .B0(s5_many_r[3]), .B1(
        n1127), .Y(n1261) );
  OAI21XLTS U1659 ( .A0(n1263), .A1(n775), .B0(n1261), .Y(n1264) );
  AOI21X1TS U1660 ( .A0(n1112), .A1(s5_many_r[6]), .B0(n1264), .Y(n1508) );
  OAI22X1TS U1661 ( .A0(n1508), .A1(n849), .B0(n724), .B1(n1438), .Y(n1273) );
  INVX2TS U1662 ( .A(n1112), .Y(n1270) );
  AOI22X1TS U1663 ( .A0(n1570), .A1(s5_many_r[12]), .B0(n1126), .B1(
        s5_many_r[11]), .Y(n1265) );
  AOI21X1TS U1664 ( .A0(n1012), .A1(s5_many_r[13]), .B0(n1267), .Y(n1580) );
  AOI22X1TS U1665 ( .A0(n1005), .A1(s5_many_r[8]), .B0(n1129), .B1(
        s5_many_r[7]), .Y(n1268) );
  OAI21XLTS U1666 ( .A0(n1270), .A1(n1269), .B0(n1268), .Y(n1271) );
  AOI21X1TS U1667 ( .A0(n1011), .A1(s5_many_r[9]), .B0(n1271), .Y(n1485) );
  OAI22X1TS U1668 ( .A0(n1580), .A1(n834), .B0(n1485), .B1(n1579), .Y(n1272)
         );
  AOI211XLTS U1669 ( .A0(n1274), .A1(n1575), .B0(n1273), .C0(n1272), .Y(n1494)
         );
  OAI2BB2XLTS U1670 ( .B0(n1494), .B1(n883), .A0N(n1275), .A1N(
        s5_many_skip_r[17]), .Y(dout_uni_y_man_dn[17]) );
  INVX2TS U1671 ( .A(s5_lzd_r[1]), .Y(DP_OP_167J1_125_280_n21) );
  INVX2TS U1672 ( .A(s5_lzd_r[4]), .Y(DP_OP_167J1_125_280_n18) );
  CLKBUFX2TS U1673 ( .A(n1288), .Y(n1283) );
  INVX2TS U1674 ( .A(n1283), .Y(n1318) );
  CLKBUFX2TS U1675 ( .A(n1530), .Y(n1317) );
  AOI22X1TS U1676 ( .A0(n1318), .A1(s3_lhs_r[1]), .B0(n1317), .B1(s3_ps0_r[1]), 
        .Y(n1279) );
  INVX2TS U1677 ( .A(s3_rhs_r[0]), .Y(n1276) );
  INVX2TS U1678 ( .A(n1283), .Y(n1307) );
  CLKBUFX2TS U1679 ( .A(n1530), .Y(n1306) );
  AOI22X1TS U1680 ( .A0(n1307), .A1(s3_lhs_r[0]), .B0(n1306), .B1(s3_ps0_r[0]), 
        .Y(n1296) );
  INVX2TS U1681 ( .A(n1296), .Y(n1277) );
  AOI21X1TS U1682 ( .A0(s3_addsubn_r), .A1(n1276), .B0(n1283), .Y(n1293) );
  OAI21XLTS U1683 ( .A0(n1292), .A1(n1277), .B0(n1293), .Y(n1278) );
  NOR2XLTS U1684 ( .A(n1279), .B(n1278), .Y(n1284) );
  NAND2X1TS U1685 ( .A(n1279), .B(n1278), .Y(n1285) );
  NAND2BXLTS U1686 ( .AN(n1284), .B(n1285), .Y(n1282) );
  CLKBUFX2TS U1687 ( .A(n1288), .Y(n1533) );
  NOR2BX1TS U1688 ( .AN(s3_rhs_r[1]), .B(n1533), .Y(n1281) );
  CLKBUFX2TS U1689 ( .A(n1294), .Y(n1333) );
  AOI22X1TS U1690 ( .A0(s3_lhs_r[1]), .A1(n1333), .B0(n1282), .B1(n1281), .Y(
        n1280) );
  OAI21XLTS U1691 ( .A0(n1282), .A1(n1281), .B0(n1280), .Y(n603) );
  AOI22X1TS U1692 ( .A0(n1318), .A1(s3_lhs_r[2]), .B0(n1317), .B1(s3_ps0_r[2]), 
        .Y(n1287) );
  INVX2TS U1693 ( .A(n1283), .Y(n1323) );
  AOI31XLTS U1694 ( .A0(n1323), .A1(s3_rhs_r[1]), .A2(n1285), .B0(n1284), .Y(
        n1286) );
  NOR2XLTS U1695 ( .A(n1287), .B(n1286), .Y(n1298) );
  NAND2X1TS U1696 ( .A(n1287), .B(n1286), .Y(n1299) );
  NAND2BXLTS U1697 ( .AN(n1298), .B(n1299), .Y(n1291) );
  CLKBUFX2TS U1698 ( .A(n1288), .Y(n1542) );
  NOR2BX1TS U1699 ( .AN(s3_rhs_r[2]), .B(n1542), .Y(n1290) );
  AOI22X1TS U1700 ( .A0(s3_lhs_r[2]), .A1(n1333), .B0(n1291), .B1(n1290), .Y(
        n1289) );
  OAI21XLTS U1701 ( .A0(n1291), .A1(n1290), .B0(n1289), .Y(n604) );
  NOR2BX1TS U1702 ( .AN(n1293), .B(n1292), .Y(n1297) );
  CLKBUFX2TS U1703 ( .A(n1294), .Y(n1337) );
  AOI22X1TS U1704 ( .A0(s3_lhs_r[0]), .A1(n1337), .B0(n1297), .B1(n1296), .Y(
        n1295) );
  OAI21XLTS U1705 ( .A0(n1297), .A1(n1296), .B0(n1295), .Y(n602) );
  AOI22X1TS U1706 ( .A0(s3_lhs_r[3]), .A1(n1323), .B0(n1306), .B1(s3_ps0_r[3]), 
        .Y(n1302) );
  XNOR2X1TS U1707 ( .A(n1302), .B(n1303), .Y(n1301) );
  NOR2BX1TS U1708 ( .AN(s3_rhs_r[3]), .B(n1528), .Y(n1305) );
  AOI22X1TS U1709 ( .A0(s3_lhs_r[3]), .A1(n1337), .B0(n1301), .B1(n1305), .Y(
        n1300) );
  OAI21XLTS U1710 ( .A0(n1301), .A1(n1305), .B0(n1300), .Y(n605) );
  OAI2BB2XLTS U1711 ( .B0(n1305), .B1(n1304), .A0N(n1303), .A1N(n1302), .Y(
        n1774) );
  AOI22X1TS U1712 ( .A0(n1307), .A1(s3_rhs_r[4]), .B0(n1306), .B1(s3_s2_r), 
        .Y(n1773) );
  AOI22X1TS U1713 ( .A0(n1307), .A1(s3_lhs_r[4]), .B0(n1306), .B1(s3_ps0_r[4]), 
        .Y(n1772) );
  AOI22X1TS U1714 ( .A0(n1307), .A1(s3_lhs_r[5]), .B0(n1546), .B1(s3_ps0_r[5]), 
        .Y(n1309) );
  INVX2TS U1715 ( .A(n1528), .Y(n1595) );
  NAND2X1TS U1716 ( .A(n1595), .B(s3_rhs_r[5]), .Y(n1308) );
  NOR2XLTS U1717 ( .A(n1309), .B(n1308), .Y(n1589) );
  INVX2TS U1718 ( .A(n1309), .Y(n1310) );
  AOI21X1TS U1719 ( .A0(n1595), .A1(s3_rhs_r[5]), .B0(n1310), .Y(n1590) );
  NOR2XLTS U1720 ( .A(n1589), .B(n1590), .Y(n1312) );
  AOI22X1TS U1721 ( .A0(s3_lhs_r[5]), .A1(n1337), .B0(n1592), .B1(n1312), .Y(
        n1311) );
  OAI21XLTS U1722 ( .A0(n1592), .A1(n1312), .B0(n1311), .Y(n607) );
  AOI22X1TS U1723 ( .A0(n1318), .A1(s3_rhs_r[19]), .B0(n1317), .B1(
        s3_ps1_r[13]), .Y(n1314) );
  NAND2X1TS U1724 ( .A(n1547), .B(s3_lhs_r[19]), .Y(n1313) );
  NOR2XLTS U1725 ( .A(n1314), .B(n1313), .Y(n1320) );
  NAND2X1TS U1726 ( .A(n1314), .B(n1313), .Y(n1319) );
  NAND2BXLTS U1727 ( .AN(n1320), .B(n1319), .Y(n1316) );
  AOI22X1TS U1728 ( .A0(s3_lhs_r[19]), .A1(n1333), .B0(n1316), .B1(intadd_1_n1), .Y(n1315) );
  OAI21XLTS U1729 ( .A0(n1316), .A1(intadd_1_n1), .B0(n1315), .Y(n621) );
  AOI22X1TS U1730 ( .A0(n1318), .A1(s3_rhs_r[20]), .B0(n1317), .B1(
        s3_ps1_r[14]), .Y(n1322) );
  NAND2X1TS U1731 ( .A(n1322), .B(n1321), .Y(n1328) );
  NOR2XLTS U1732 ( .A(n1322), .B(n1321), .Y(n1329) );
  AOI31XLTS U1733 ( .A0(n1595), .A1(s3_lhs_r[20]), .A2(n1328), .B0(n1329), .Y(
        n1325) );
  AOI22X1TS U1734 ( .A0(n1323), .A1(s3_rhs_r[21]), .B0(n1546), .B1(
        s3_ps1_r[15]), .Y(n1324) );
  NOR2XLTS U1735 ( .A(n1325), .B(n1324), .Y(n1593) );
  NAND2X1TS U1736 ( .A(n1325), .B(n1324), .Y(n1594) );
  NAND2BXLTS U1737 ( .AN(n1593), .B(n1594), .Y(n1327) );
  NAND2X1TS U1738 ( .A(s3_lhs_r[21]), .B(n814), .Y(n1326) );
  XOR2XLTS U1739 ( .A(n1327), .B(n1326), .Y(n623) );
  NAND2BXLTS U1740 ( .AN(n1329), .B(n1328), .Y(n1331) );
  NAND2X1TS U1741 ( .A(s3_lhs_r[20]), .B(s3_opcode_r[0]), .Y(n1330) );
  XOR2XLTS U1742 ( .A(n1331), .B(n1330), .Y(n622) );
  INVX2TS U1743 ( .A(n1332), .Y(n1811) );
  INVX2TS U1744 ( .A(n1333), .Y(n1813) );
  INVX2TS U1745 ( .A(n1334), .Y(n1810) );
  INVX2TS U1746 ( .A(n1335), .Y(n1808) );
  INVX2TS U1747 ( .A(n1336), .Y(n1809) );
  INVX2TS U1748 ( .A(n1337), .Y(n1812) );
  INVX2TS U1749 ( .A(n842), .Y(n1721) );
  NAND4XLTS U1750 ( .A(s2_ea_sub_eb_abs_r[3]), .B(n790), .C(n1721), .D(n1648), 
        .Y(n1710) );
  INVX2TS U1751 ( .A(n836), .Y(n1700) );
  AOI22X1TS U1752 ( .A0(n817), .A1(n764), .B0(n1103), .B1(n766), .Y(n1339) );
  AOI22X1TS U1753 ( .A0(n1008), .A1(n768), .B0(n1000), .B1(s2_mmux_rhs_r[18]), 
        .Y(n1338) );
  NAND2X1TS U1754 ( .A(n1339), .B(n1338), .Y(n1717) );
  AOI22X1TS U1755 ( .A0(s2_mmux_rhs_r[7]), .A1(n1016), .B0(n820), .B1(n752), 
        .Y(n1341) );
  AOI22X1TS U1756 ( .A0(n1009), .A1(s2_mmux_rhs_r[9]), .B0(n999), .B1(
        s2_mmux_rhs_r[10]), .Y(n1340) );
  NAND2X1TS U1757 ( .A(n1341), .B(n1340), .Y(n1671) );
  AO22XLTS U1758 ( .A0(n1700), .A1(n1717), .B0(n1088), .B1(n1671), .Y(n1347)
         );
  CLKBUFX2TS U1759 ( .A(n1694), .Y(n1686) );
  INVX2TS U1760 ( .A(n1686), .Y(n1397) );
  AOI22X1TS U1761 ( .A0(n1007), .A1(s2_mmux_rhs_r[21]), .B0(n1102), .B1(n772), 
        .Y(n1342) );
  NAND4XLTS U1762 ( .A(n840), .B(s2_ea_sub_eb_abs_r[2]), .C(n790), .D(n1721), 
        .Y(n1690) );
  INVX2TS U1763 ( .A(s2_mmux_rhs_r[11]), .Y(n1392) );
  AOI22X1TS U1764 ( .A0(n997), .A1(n762), .B0(n819), .B1(n758), .Y(n1343) );
  OAI21XLTS U1765 ( .A0(n815), .A1(n1392), .B0(n1343), .Y(n1344) );
  AOI21X1TS U1766 ( .A0(n1007), .A1(n760), .B0(n1344), .Y(n1699) );
  OAI22X1TS U1767 ( .A0(n706), .A1(n1690), .B0(n1699), .B1(n1082), .Y(n1346)
         );
  OAI21XLTS U1768 ( .A0(n1347), .A1(n1346), .B0(n1643), .Y(n1345) );
  OAI31X1TS U1769 ( .A0(n1347), .A1(n1397), .A2(n1346), .B0(n1345), .Y(
        s2_mmux3_rhs_addsub[7]) );
  AOI22X1TS U1770 ( .A0(n1017), .A1(n762), .B0(n1102), .B1(n764), .Y(n1349) );
  AOI22X1TS U1771 ( .A0(n1006), .A1(n766), .B0(n999), .B1(n768), .Y(n1348) );
  NAND2X1TS U1772 ( .A(n1349), .B(n1348), .Y(n1714) );
  AOI22X1TS U1773 ( .A0(n748), .A1(n1018), .B0(s2_mmux_rhs_r[7]), .B1(n1101), 
        .Y(n1351) );
  AOI22X1TS U1774 ( .A0(n777), .A1(s2_mmux_rhs_r[8]), .B0(n1667), .B1(
        s2_mmux_rhs_r[9]), .Y(n1350) );
  NAND2X1TS U1775 ( .A(n1351), .B(n1350), .Y(n1660) );
  AO22XLTS U1776 ( .A0(n1700), .A1(n1714), .B0(n1089), .B1(n1660), .Y(n1356)
         );
  AOI22X1TS U1777 ( .A0(n997), .A1(n760), .B0(n1017), .B1(n756), .Y(n1352) );
  OAI2BB1X1TS U1778 ( .A0N(n1101), .A1N(s2_mmux_rhs_r[11]), .B0(n1352), .Y(
        n1353) );
  AOI21X1TS U1779 ( .A0(n777), .A1(n758), .B0(n1353), .Y(n1696) );
  OAI22X1TS U1780 ( .A0(n733), .A1(n1690), .B0(n1696), .B1(n1083), .Y(n1355)
         );
  OAI21XLTS U1781 ( .A0(n1356), .A1(n1355), .B0(n1643), .Y(n1354) );
  OAI31X1TS U1782 ( .A0(n1356), .A1(n1397), .A2(n1355), .B0(n1354), .Y(
        s2_mmux3_rhs_addsub[6]) );
  AO22XLTS U1784 ( .A0(s4_lzdi_r[9]), .A1(n1816), .B0(n1079), .B1(s4_lzdi_r[1]), .Y(n1358) );
  OAI21XLTS U1785 ( .A0(s4_lzdi_r[17]), .A1(n1358), .B0(n1817), .Y(n1359) );
  AOI22X1TS U1787 ( .A0(s4_lzdi_r[10]), .A1(n1816), .B0(n1080), .B1(
        s4_lzdi_r[2]), .Y(n1361) );
  OAI2BB1X1TS U1788 ( .A0N(n1784), .A1N(n1361), .B0(n1817), .Y(n1362) );
  NAND2X1TS U1789 ( .A(n1363), .B(n1362), .Y(n1557) );
  OAI2BB1X1TS U1790 ( .A0N(n1364), .A1N(n1615), .B0(n945), .Y(n1770) );
  NOR2XLTS U1791 ( .A(n994), .B(n902), .Y(s1_br4_pp[60]) );
  OAI21XLTS U1792 ( .A0(n1118), .A1(n1365), .B0(s1_br4_s[1]), .Y(n1366) );
  INVX2TS U1793 ( .A(n1723), .Y(n1814) );
  OAI21XLTS U1794 ( .A0(n1115), .A1(n1368), .B0(s1_br4_s[3]), .Y(n1369) );
  OAI21XLTS U1795 ( .A0(n1117), .A1(n1371), .B0(s1_br4_s[2]), .Y(n1372) );
  OAI21XLTS U1796 ( .A0(n1118), .A1(n1374), .B0(n727), .Y(n1375) );
  AOI22X1TS U1797 ( .A0(n817), .A1(s2_mmux_rhs_r[13]), .B0(n820), .B1(
        s2_mmux_rhs_r[14]), .Y(n1378) );
  AOI22X1TS U1798 ( .A0(n777), .A1(s2_mmux_rhs_r[15]), .B0(n1000), .B1(
        s2_mmux_rhs_r[16]), .Y(n1377) );
  NAND2X1TS U1799 ( .A(n1378), .B(n1377), .Y(n1654) );
  INVX2TS U1800 ( .A(n1654), .Y(n1706) );
  AOI22X1TS U1801 ( .A0(n1015), .A1(n768), .B0(n1101), .B1(n770), .Y(n1379) );
  OAI21XLTS U1802 ( .A0(n776), .A1(n1389), .B0(n1379), .Y(n1380) );
  AOI21X1TS U1803 ( .A0(n997), .A1(n772), .B0(n1380), .Y(n1707) );
  OAI22X1TS U1804 ( .A0(n1706), .A1(n1084), .B0(n1707), .B1(n836), .Y(n1385)
         );
  AOI22X1TS U1805 ( .A0(n817), .A1(n754), .B0(n820), .B1(n756), .Y(n1381) );
  AOI21X1TS U1806 ( .A0(n999), .A1(s2_mmux_rhs_r[12]), .B0(n1382), .Y(n1689)
         );
  OAI22X1TS U1807 ( .A0(n1689), .A1(n787), .B0(n798), .B1(n802), .Y(n1384) );
  INVX2TS U1808 ( .A(n1686), .Y(n1712) );
  OAI31X1TS U1809 ( .A0(n1385), .A1(n1397), .A2(n1384), .B0(n1383), .Y(
        s2_mmux3_rhs_addsub[9]) );
  AOI22X1TS U1810 ( .A0(n1016), .A1(s2_mmux_rhs_r[12]), .B0(n1100), .B1(
        s2_mmux_rhs_r[13]), .Y(n1387) );
  AOI22X1TS U1811 ( .A0(n1009), .A1(s2_mmux_rhs_r[14]), .B0(n998), .B1(
        s2_mmux_rhs_r[15]), .Y(n1386) );
  NAND2X1TS U1812 ( .A(n1387), .B(n1386), .Y(n1642) );
  INVX2TS U1813 ( .A(n1642), .Y(n1703) );
  AOI22X1TS U1814 ( .A0(n816), .A1(n766), .B0(n819), .B1(n768), .Y(n1388) );
  OAI21XLTS U1815 ( .A0(n1393), .A1(n1389), .B0(n1388), .Y(n1390) );
  AOI21X1TS U1816 ( .A0(n1008), .A1(n770), .B0(n1390), .Y(n1704) );
  OAI22X1TS U1817 ( .A0(n1703), .A1(n1082), .B0(n1704), .B1(n1710), .Y(n1398)
         );
  AOI22X1TS U1818 ( .A0(n1008), .A1(s2_mmux_rhs_r[10]), .B0(n1103), .B1(n754), 
        .Y(n1391) );
  OAI21XLTS U1819 ( .A0(n1393), .A1(n1392), .B0(n1391), .Y(n1394) );
  AOI21X1TS U1820 ( .A0(n1018), .A1(s2_mmux_rhs_r[8]), .B0(n1394), .Y(n1682)
         );
  OAI22X1TS U1821 ( .A0(n800), .A1(n798), .B0(n1682), .B1(n787), .Y(n1396) );
  OAI21XLTS U1822 ( .A0(n1398), .A1(n1396), .B0(n1712), .Y(n1395) );
  OAI31X1TS U1823 ( .A0(n1398), .A1(n1397), .A2(n1396), .B0(n1395), .Y(
        s2_mmux3_rhs_addsub[8]) );
  NAND3XLTS U1824 ( .A(n1072), .B(n1094), .C(n1610), .Y(n1748) );
  NAND2X1TS U1825 ( .A(n1072), .B(n1095), .Y(n1399) );
  NAND2X1TS U1826 ( .A(s1_br4_s[0]), .B(n1399), .Y(n1747) );
  AOI22X1TS U1827 ( .A0(n963), .A1(n885), .B0(n958), .B1(n940), .Y(n1400) );
  OAI21XLTS U1828 ( .A0(n957), .A1(n905), .B0(n1400), .Y(n649) );
  AOI22X1TS U1829 ( .A0(n967), .A1(n887), .B0(n962), .B1(n941), .Y(n1401) );
  OAI21XLTS U1830 ( .A0(n961), .A1(n1748), .B0(n1401), .Y(n655) );
  AOI22X1TS U1831 ( .A0(n983), .A1(n886), .B0(n1116), .B1(n1752), .Y(n1402) );
  OAI21XLTS U1832 ( .A0(n1115), .A1(n905), .B0(n1402), .Y(n632) );
  AOI211XLTS U1833 ( .A0(n995), .A1(s1_br4_s[1]), .B0(n1764), .C0(n911), .Y(
        n1403) );
  OAI21XLTS U1834 ( .A0(n994), .A1(n890), .B0(n1403), .Y(n698) );
  AOI22X1TS U1835 ( .A0(n975), .A1(n887), .B0(n970), .B1(n940), .Y(n1404) );
  OAI21XLTS U1836 ( .A0(n969), .A1(n1748), .B0(n1404), .Y(n685) );
  AOI22X1TS U1837 ( .A0(n979), .A1(n886), .B0(n986), .B1(n941), .Y(n1405) );
  OAI21XLTS U1838 ( .A0(n985), .A1(n905), .B0(n1405), .Y(n673) );
  AOI22X1TS U1839 ( .A0(n987), .A1(n887), .B0(n990), .B1(n1752), .Y(n1406) );
  OAI21XLTS U1840 ( .A0(n989), .A1(n904), .B0(n1406), .Y(n667) );
  AOI22X1TS U1841 ( .A0(n959), .A1(n886), .B0(n982), .B1(n940), .Y(n1407) );
  AOI22X1TS U1842 ( .A0(n991), .A1(n887), .B0(n966), .B1(n941), .Y(n1408) );
  OAI21XLTS U1843 ( .A0(n965), .A1(n905), .B0(n1408), .Y(n661) );
  AOI22X1TS U1844 ( .A0(n971), .A1(n886), .B0(n978), .B1(n1752), .Y(n1409) );
  OAI21XLTS U1845 ( .A0(n977), .A1(n1748), .B0(n1409), .Y(n679) );
  AOI22X1TS U1846 ( .A0(n974), .A1(n941), .B0(n885), .B1(n1751), .Y(n1410) );
  AOI211XLTS U1847 ( .A0(n788), .A1(s1_br4_s[2]), .B0(n1760), .C0(n1761), .Y(
        n1411) );
  OAI21XLTS U1848 ( .A0(n995), .A1(n895), .B0(n1411), .Y(n699) );
  AOI211XLTS U1849 ( .A0(s1_br4_s[3]), .A1(n788), .B0(n937), .C0(n935), .Y(
        n1412) );
  OAI21XLTS U1850 ( .A0(n1751), .A1(n898), .B0(n1412), .Y(n700) );
  AOI211XLTS U1851 ( .A0(n727), .A1(n995), .B0(n1754), .C0(n1091), .Y(n1413)
         );
  OAI21XLTS U1852 ( .A0(n893), .A1(n1751), .B0(n1413), .Y(n701) );
  OA22X1TS U1854 ( .A0(n1744), .A1(intadd_3_n1), .B0(n1026), .B1(n1019), .Y(
        n1598) );
  CLKBUFX2TS U1855 ( .A(n1598), .Y(n1606) );
  INVX2TS U1856 ( .A(n1606), .Y(n1786) );
  INVX1TS U1857 ( .A(din_uni_a_exp[2]), .Y(intadd_3_B_1_) );
  NAND2BXLTS U1858 ( .AN(s2_br4_s_r[4]), .B(s2_br4_pp_r[70]), .Y(n1415) );
  XOR2XLTS U1859 ( .A(s2_br4_pp_r[71]), .B(intadd_2_n1), .Y(n1414) );
  XOR2XLTS U1860 ( .A(n1415), .B(n1414), .Y(s2_ps1[15]) );
  INVX2TS U1861 ( .A(n1416), .Y(intadd_0_B_12_) );
  INVX2TS U1862 ( .A(n1417), .Y(intadd_0_B_13_) );
  INVX2TS U1863 ( .A(s5_sa_r), .Y(n1418) );
  NOR2XLTS U1864 ( .A(n883), .B(s5_opcode_r[0]), .Y(n1550) );
  AOI31XLTS U1865 ( .A0(n951), .A1(n1424), .A2(n1418), .B0(n1081), .Y(n1423)
         );
  NAND3XLTS U1866 ( .A(n1097), .B(s5_sb_r), .C(n884), .Y(n1422) );
  OA21XLTS U1867 ( .A0(n1099), .A1(s5_addsubn_r), .B0(n1419), .Y(n1420) );
  AOI32X1TS U1868 ( .A0(n884), .A1(s5_sa_r), .A2(n1424), .B0(n1420), .B1(
        s5_sa_r), .Y(n1421) );
  CLKBUFX2TS U1869 ( .A(n1522), .Y(n1510) );
  INVX2TS U1870 ( .A(n1455), .Y(n1498) );
  AOI222XLTS U1872 ( .A0(n1474), .A1(C46_DATA2_0), .B0(n807), .B1(s5_eb_r[0]), 
        .C0(s5_ea_r[0]), .C1(n1520), .Y(n1425) );
  INVX2TS U1873 ( .A(n1425), .Y(dout_uni_y_exp[0]) );
  AOI22X1TS U1874 ( .A0(n1427), .A1(n1445), .B0(n1434), .B1(n1426), .Y(n1466)
         );
  AOI22X1TS U1875 ( .A0(n1428), .A1(n1466), .B0(n833), .B1(n1459), .Y(n1453)
         );
  INVX2TS U1876 ( .A(n1454), .Y(n1460) );
  AOI22X1TS U1877 ( .A0(s5_many_skip_r[11]), .A1(n1451), .B0(n1486), .B1(n1460), .Y(n1429) );
  OAI21XLTS U1878 ( .A0(n1453), .A1(n884), .B0(n1429), .Y(
        dout_uni_y_man_dn[11]) );
  AOI222XLTS U1879 ( .A0(n1455), .A1(C46_DATA2_1), .B0(n807), .B1(s5_eb_r[1]), 
        .C0(s5_ea_r[1]), .C1(n1520), .Y(n1430) );
  INVX2TS U1880 ( .A(n1430), .Y(dout_uni_y_exp[1]) );
  INVX2TS U1881 ( .A(n954), .Y(n1500) );
  OAI22X1TS U1882 ( .A0(n726), .A1(n1495), .B0(n1458), .B1(n1496), .Y(n1481)
         );
  AOI22X1TS U1883 ( .A0(n1498), .A1(s5_many_skip_r[4]), .B0(n1497), .B1(n1481), 
        .Y(n1432) );
  OAI21XLTS U1884 ( .A0(n1433), .A1(n1500), .B0(n1432), .Y(
        dout_uni_y_man_dn[4]) );
  AOI2BB2XLTS U1885 ( .B0(s5_many_skip_r[7]), .B1(n1451), .A0N(n1434), .A1N(
        n738), .Y(n1444) );
  AOI22X1TS U1886 ( .A0(n1003), .A1(s5_many_r[17]), .B0(n1127), .B1(
        s5_many_r[16]), .Y(n1436) );
  AOI22X1TS U1887 ( .A0(n1112), .A1(s5_many_r[19]), .B0(n1014), .B1(
        s5_many_r[18]), .Y(n1435) );
  AOI21X1TS U1888 ( .A0(n1436), .A1(n1435), .B0(n1086), .Y(n1440) );
  OAI22X1TS U1889 ( .A0(n728), .A1(n1438), .B0(n1437), .B1(n834), .Y(n1439) );
  OAI21XLTS U1890 ( .A0(n1491), .A1(n849), .B0(n1442), .Y(n1565) );
  AOI22X1TS U1891 ( .A0(n955), .A1(n1565), .B0(n1486), .B1(n1459), .Y(n1443)
         );
  OAI211XLTS U1892 ( .A0(n1445), .A1(n1489), .B0(n1444), .C0(n1443), .Y(
        dout_uni_y_man_dn[7]) );
  CLKAND2X2TS U1893 ( .A(n1466), .B(n1465), .Y(n1446) );
  AOI22X1TS U1894 ( .A0(n1498), .A1(s5_many_skip_r[3]), .B0(n1497), .B1(n1446), 
        .Y(n1447) );
  OAI21XLTS U1895 ( .A0(n1448), .A1(n1500), .B0(n1447), .Y(
        dout_uni_y_man_dn[3]) );
  OAI22X1TS U1896 ( .A0(n1458), .A1(n838), .B0(n1478), .B1(n1086), .Y(n1449)
         );
  AOI21X1TS U1897 ( .A0(n833), .A1(n1477), .B0(n1449), .Y(n1450) );
  AOI22X1TS U1898 ( .A0(n955), .A1(n1562), .B0(n1451), .B1(s5_many_skip_r[1]), 
        .Y(n1452) );
  OAI21XLTS U1899 ( .A0(n1505), .A1(n806), .B0(n1452), .Y(dout_uni_y_man_dn[1]) );
  INVX2TS U1900 ( .A(n1455), .Y(n1581) );
  AOI22X1TS U1901 ( .A0(n954), .A1(n1456), .B0(n1581), .B1(s5_many_skip_r[0]), 
        .Y(n1457) );
  AOI2BB2XLTS U1902 ( .B0(n1581), .B1(s5_many_skip_r[8]), .A0N(n1458), .A1N(
        n738), .Y(n1471) );
  AOI22X1TS U1904 ( .A0(n1461), .A1(n1460), .B0(n847), .B1(n1459), .Y(n1468)
         );
  AOI22X1TS U1905 ( .A0(n1004), .A1(s5_many_r[18]), .B0(n1126), .B1(
        s5_many_r[17]), .Y(n1463) );
  AOI22X1TS U1906 ( .A0(n824), .A1(s5_many_r[20]), .B0(n778), .B1(
        s5_many_r[19]), .Y(n1462) );
  AOI21X1TS U1907 ( .A0(n1463), .A1(n1462), .B0(n1085), .Y(n1464) );
  AOI31XLTS U1908 ( .A0(n1466), .A1(n804), .A2(n1465), .B0(n1464), .Y(n1467)
         );
  OAI211XLTS U1909 ( .A0(n1469), .A1(n834), .B0(n1468), .C0(n1467), .Y(n1566)
         );
  AOI22X1TS U1910 ( .A0(n953), .A1(n1566), .B0(n1486), .B1(n1477), .Y(n1470)
         );
  AOI222XLTS U1911 ( .A0(n1510), .A1(C46_DATA2_2), .B0(n808), .B1(s5_eb_r[2]), 
        .C0(s5_ea_r[2]), .C1(n810), .Y(n1473) );
  INVX2TS U1912 ( .A(n1473), .Y(dout_uni_y_exp[2]) );
  INVX2TS U1913 ( .A(n1474), .Y(n1563) );
  AOI2BB2XLTS U1914 ( .B0(n1563), .B1(s5_many_skip_r[9]), .A0N(n1508), .A1N(
        n738), .Y(n1488) );
  AOI22X1TS U1915 ( .A0(n1005), .A1(s5_many_r[19]), .B0(n1128), .B1(
        s5_many_r[18]), .Y(n1476) );
  AOI22X1TS U1916 ( .A0(n1109), .A1(s5_many_r[21]), .B0(n1011), .B1(
        s5_many_r[20]), .Y(n1475) );
  AOI21X1TS U1917 ( .A0(n1476), .A1(n1475), .B0(n1087), .Y(n1480) );
  OAI2BB2XLTS U1918 ( .B0(n1478), .B1(n838), .A0N(n1477), .A1N(n847), .Y(n1479) );
  AOI211XLTS U1919 ( .A0(n1574), .A1(n1481), .B0(n1480), .C0(n1479), .Y(n1482)
         );
  INVX2TS U1920 ( .A(n1485), .Y(n1571) );
  AOI22X1TS U1921 ( .A0(n954), .A1(n1568), .B0(n1486), .B1(n1571), .Y(n1487)
         );
  OAI211XLTS U1922 ( .A0(n1505), .A1(n1489), .B0(n1488), .C0(n1487), .Y(
        dout_uni_y_man_dn[9]) );
  OAI22X1TS U1923 ( .A0(n1491), .A1(n806), .B0(n729), .B1(n1490), .Y(n1492) );
  AOI21X1TS U1924 ( .A0(n1563), .A1(s5_many_skip_r[6]), .B0(n1492), .Y(n1493)
         );
  OAI21XLTS U1925 ( .A0(n1494), .A1(n1500), .B0(n1493), .Y(
        dout_uni_y_man_dn[6]) );
  OAI22X1TS U1926 ( .A0(n1508), .A1(n1496), .B0(n724), .B1(n1495), .Y(n1573)
         );
  AOI22X1TS U1927 ( .A0(n1498), .A1(s5_many_skip_r[5]), .B0(n1497), .B1(n1573), 
        .Y(n1499) );
  OAI21XLTS U1928 ( .A0(n1501), .A1(n1500), .B0(n1499), .Y(
        dout_uni_y_man_dn[5]) );
  AOI222XLTS U1929 ( .A0(n1510), .A1(C46_DATA2_3), .B0(n808), .B1(s5_eb_r[3]), 
        .C0(s5_ea_r[3]), .C1(n810), .Y(n1502) );
  INVX2TS U1930 ( .A(n1502), .Y(dout_uni_y_exp[3]) );
  OAI22X1TS U1931 ( .A0(n724), .A1(n848), .B0(n1580), .B1(n1085), .Y(n1506) );
  AOI21X1TS U1932 ( .A0(n833), .A1(n1571), .B0(n1506), .Y(n1507) );
  OAI21XLTS U1933 ( .A0(n1508), .A1(n1579), .B0(n1507), .Y(n1564) );
  AOI22X1TS U1934 ( .A0(n1548), .A1(n1564), .B0(n1581), .B1(s5_many_skip_r[2]), 
        .Y(n1509) );
  OAI21XLTS U1935 ( .A0(n729), .A1(n806), .B0(n1509), .Y(dout_uni_y_man_dn[2])
         );
  AOI222XLTS U1936 ( .A0(n1510), .A1(C46_DATA2_4), .B0(n808), .B1(s5_eb_r[4]), 
        .C0(s5_ea_r[4]), .C1(n810), .Y(n1511) );
  INVX2TS U1937 ( .A(n1511), .Y(dout_uni_y_exp[4]) );
  XOR2XLTS U1938 ( .A(s5_ea_r[5]), .B(s5_eb_r[5]), .Y(n1512) );
  XOR2XLTS U1939 ( .A(DP_OP_167J1_125_280_n24), .B(n1512), .Y(n1513) );
  INVX2TS U1941 ( .A(s5_ea_r[5]), .Y(n1515) );
  NOR2XLTS U1942 ( .A(n1097), .B(s5_eb_r[5]), .Y(n1514) );
  AOI211XLTS U1943 ( .A0(s5_ea_gte_eb_r), .A1(n1515), .B0(n831), .C0(n1514), 
        .Y(n1516) );
  XOR2XLTS U1946 ( .A(n1519), .B(DP_OP_167J1_125_280_n2), .Y(n1521) );
  AOI222XLTS U1947 ( .A0(n1522), .A1(n1521), .B0(n810), .B1(s5_ea_r[5]), .C0(
        n807), .C1(s5_eb_r[5]), .Y(n1523) );
  INVX2TS U1948 ( .A(n1523), .Y(dout_uni_y_exp[5]) );
  MXI2XLTS U1949 ( .A(s5_eb_r[0]), .B(s5_ea_r[0]), .S0(n1098), .Y(n1524) );
  INVX2TS U1950 ( .A(n1550), .Y(n1525) );
  OAI21XLTS U1951 ( .A0(n831), .A1(n1524), .B0(n1525), .Y(U2_RSOP_146_C1_Z_0)
         );
  MXI2XLTS U1952 ( .A(s5_eb_r[1]), .B(s5_ea_r[1]), .S0(n1097), .Y(n1526) );
  OAI21XLTS U1953 ( .A0(n830), .A1(n1526), .B0(n1525), .Y(U2_RSOP_146_C1_Z_1)
         );
  INVX2TS U1954 ( .A(n1528), .Y(n1529) );
  CLKBUFX2TS U1955 ( .A(n1538), .Y(n1531) );
  AO22XLTS U1956 ( .A0(n1529), .A1(s3_lhs_r[6]), .B0(n1531), .B1(s3_ps0_r[6]), 
        .Y(intadd_1_CI) );
  CLKBUFX2TS U1957 ( .A(n1536), .Y(n1543) );
  AO22XLTS U1958 ( .A0(n1547), .A1(s3_rhs_r[6]), .B0(n1543), .B1(s3_ps1_r[0]), 
        .Y(intadd_1_B_0_) );
  AO22XLTS U1959 ( .A0(n1529), .A1(s3_lhs_r[7]), .B0(n1531), .B1(s3_ps0_r[7]), 
        .Y(intadd_1_B_1_) );
  AO22XLTS U1960 ( .A0(n1529), .A1(s3_rhs_r[7]), .B0(n1531), .B1(s3_ps1_r[1]), 
        .Y(intadd_1_A_1_) );
  INVX2TS U1961 ( .A(n1533), .Y(n1532) );
  CLKBUFX2TS U1962 ( .A(n1530), .Y(n1534) );
  AO22XLTS U1963 ( .A0(n1532), .A1(s3_lhs_r[8]), .B0(n1534), .B1(s3_ps0_r[8]), 
        .Y(intadd_1_B_2_) );
  AO22XLTS U1964 ( .A0(n1532), .A1(s3_rhs_r[8]), .B0(n1531), .B1(s3_ps1_r[2]), 
        .Y(intadd_1_A_2_) );
  AO22XLTS U1965 ( .A0(n1532), .A1(s3_lhs_r[9]), .B0(n1534), .B1(s3_ps0_r[9]), 
        .Y(intadd_1_B_3_) );
  AO22XLTS U1966 ( .A0(n1532), .A1(s3_rhs_r[9]), .B0(n1534), .B1(s3_ps1_r[3]), 
        .Y(intadd_1_A_3_) );
  INVX2TS U1967 ( .A(n1533), .Y(n1535) );
  CLKBUFX2TS U1968 ( .A(n1538), .Y(n1537) );
  AO22XLTS U1969 ( .A0(n1535), .A1(s3_lhs_r[10]), .B0(n1537), .B1(s3_ps0_r[10]), .Y(intadd_1_B_4_) );
  AO22XLTS U1970 ( .A0(n1535), .A1(s3_rhs_r[10]), .B0(n1534), .B1(s3_ps1_r[4]), 
        .Y(intadd_1_A_4_) );
  AO22XLTS U1971 ( .A0(n1535), .A1(s3_lhs_r[11]), .B0(n1537), .B1(s3_ps0_r[11]), .Y(intadd_1_B_5_) );
  AO22XLTS U1972 ( .A0(n1535), .A1(s3_rhs_r[11]), .B0(n1537), .B1(s3_ps1_r[5]), 
        .Y(intadd_1_A_5_) );
  INVX2TS U1973 ( .A(n1542), .Y(n1541) );
  CLKBUFX2TS U1974 ( .A(n1536), .Y(n1540) );
  AO22XLTS U1975 ( .A0(n1541), .A1(s3_lhs_r[12]), .B0(n1540), .B1(s3_ps0_r[12]), .Y(intadd_1_B_6_) );
  AO22XLTS U1976 ( .A0(n1541), .A1(s3_rhs_r[12]), .B0(n1537), .B1(s3_ps1_r[6]), 
        .Y(intadd_1_A_6_) );
  INVX2TS U1977 ( .A(n1542), .Y(n1539) );
  AO22XLTS U1978 ( .A0(n1539), .A1(s3_lhs_r[13]), .B0(n1540), .B1(s3_ps0_r[13]), .Y(intadd_1_B_7_) );
  AO22XLTS U1979 ( .A0(n1541), .A1(s3_rhs_r[13]), .B0(n1540), .B1(s3_ps1_r[7]), 
        .Y(intadd_1_A_7_) );
  CLKBUFX2TS U1980 ( .A(n1538), .Y(n1544) );
  AO22XLTS U1981 ( .A0(n1539), .A1(s3_lhs_r[14]), .B0(n1544), .B1(s3_ps0_r[14]), .Y(intadd_1_B_8_) );
  AO22XLTS U1982 ( .A0(n1539), .A1(s3_rhs_r[14]), .B0(n1544), .B1(s3_ps1_r[8]), 
        .Y(intadd_1_A_8_) );
  AO22XLTS U1983 ( .A0(n1539), .A1(s3_lhs_r[15]), .B0(n1544), .B1(s3_ps0_r[15]), .Y(intadd_1_B_9_) );
  AO22XLTS U1984 ( .A0(n1541), .A1(s3_rhs_r[15]), .B0(n1540), .B1(s3_ps1_r[9]), 
        .Y(intadd_1_A_9_) );
  INVX2TS U1985 ( .A(n1542), .Y(n1545) );
  AO22XLTS U1986 ( .A0(n1545), .A1(s3_lhs_r[16]), .B0(n1543), .B1(s3_ps0_r[16]), .Y(intadd_1_B_10_) );
  AO22XLTS U1987 ( .A0(n1545), .A1(s3_rhs_r[16]), .B0(n1543), .B1(s3_ps1_r[10]), .Y(intadd_1_A_10_) );
  AO22XLTS U1988 ( .A0(n1545), .A1(s3_lhs_r[17]), .B0(n1543), .B1(s3_ps0_r[17]), .Y(intadd_1_B_11_) );
  AO22XLTS U1989 ( .A0(n1545), .A1(s3_rhs_r[17]), .B0(n1544), .B1(s3_ps1_r[11]), .Y(intadd_1_A_11_) );
  AO22XLTS U1990 ( .A0(n1547), .A1(s3_lhs_r[18]), .B0(n1546), .B1(s3_ps0_r[18]), .Y(intadd_1_B_12_) );
  INVX2TS U1991 ( .A(s5_lzd_r[2]), .Y(DP_OP_167J1_125_280_n20) );
  AO21XLTS U1992 ( .A0(DP_OP_167J1_125_280_n43), .A1(n1081), .B0(n955), .Y(
        DP_OP_167J1_125_280_n37) );
  CLKAND2X2TS U1993 ( .A(DP_OP_167J1_125_280_n42), .B(n1081), .Y(
        DP_OP_167J1_125_280_n36) );
  CLKAND2X2TS U1994 ( .A(DP_OP_167J1_125_280_n41), .B(n1550), .Y(
        DP_OP_167J1_125_280_n35) );
  CLKAND2X2TS U1995 ( .A(DP_OP_167J1_125_280_n40), .B(n1550), .Y(
        DP_OP_167J1_125_280_n34) );
  AO21XLTS U1996 ( .A0(DP_OP_167J1_125_280_n39), .A1(n1550), .B0(n1549), .Y(
        DP_OP_167J1_125_280_n33) );
  INVX2TS U1997 ( .A(n1551), .Y(n1559) );
  INVX2TS U1998 ( .A(n1816), .Y(n1553) );
  OAI22X1TS U1999 ( .A0(s4_lzdi_r[8]), .A1(n1553), .B0(s4_lzdi_r[16]), .B1(
        n1552), .Y(n1555) );
  OAI21XLTS U2000 ( .A0(n1556), .A1(n1555), .B0(n1554), .Y(n1558) );
  AOI21X1TS U2001 ( .A0(n1559), .A1(n1558), .B0(n1557), .Y(n625) );
  CLKAND2X2TS U2002 ( .A(s2_br4_pp_r[13]), .B(s2_br4_pp_r[3]), .Y(
        intadd_0_A_2_) );
  AOI2BB1XLTS U2003 ( .A0N(s2_br4_pp_r[13]), .A1N(s2_br4_pp_r[3]), .B0(
        intadd_0_A_2_), .Y(intadd_0_A_1_) );
  CLKAND2X2TS U2004 ( .A(s2_br4_pp_r[12]), .B(s2_br4_pp_r[2]), .Y(
        intadd_0_B_1_) );
  AOI2BB1XLTS U2005 ( .A0N(s2_br4_pp_r[12]), .A1N(s2_br4_pp_r[2]), .B0(
        intadd_0_B_1_), .Y(intadd_0_B_0_) );
  AOI2BB1XLTS U2006 ( .A0N(s2_br4_pp_r[0]), .A1N(n1078), .B0(n1560), .Y(
        s2_ps0[0]) );
  XNOR2X1TS U2007 ( .A(s2_br4_s_r[4]), .B(s2_br4_pp_r[70]), .Y(intadd_2_A_12_)
         );
  OAI2BB1X1TS U2008 ( .A0N(s2_br4_pp_r[59]), .A1N(s2_br4_pp_r[69]), .B0(
        intadd_2_B_12_), .Y(intadd_2_B_11_) );
  CLKAND2X2TS U2009 ( .A(s2_br4_pp_r[49]), .B(s2_br4_pp_r[39]), .Y(
        intadd_2_A_2_) );
  AOI2BB1XLTS U2010 ( .A0N(s2_br4_pp_r[49]), .A1N(s2_br4_pp_r[39]), .B0(
        intadd_2_A_2_), .Y(intadd_2_A_1_) );
  CLKAND2X2TS U2011 ( .A(s2_br4_pp_r[48]), .B(s2_br4_pp_r[38]), .Y(
        intadd_2_B_1_) );
  AOI2BB1XLTS U2012 ( .A0N(s2_br4_pp_r[48]), .A1N(s2_br4_pp_r[38]), .B0(
        intadd_2_B_1_), .Y(intadd_2_B_0_) );
  AOI2BB1XLTS U2013 ( .A0N(s2_br4_s_r[3]), .A1N(s2_br4_pp_r[36]), .B0(n1561), 
        .Y(s2_ps1[0]) );
  AO22XLTS U2014 ( .A0(n950), .A1(n1562), .B0(n1563), .B1(s5_many_skip_r[12]), 
        .Y(dout_uni_y_man_dn[12]) );
  AO22XLTS U2015 ( .A0(n951), .A1(n1564), .B0(n1563), .B1(s5_many_skip_r[13]), 
        .Y(dout_uni_y_man_dn[13]) );
  AO22XLTS U2016 ( .A0(s5_opcode_r[1]), .A1(n1565), .B0(n1567), .B1(
        s5_many_skip_r[18]), .Y(dout_uni_y_man_dn[18]) );
  AO22XLTS U2017 ( .A0(n950), .A1(n1566), .B0(n1567), .B1(s5_many_skip_r[19]), 
        .Y(dout_uni_y_man_dn[19]) );
  AO22XLTS U2018 ( .A0(n951), .A1(n1568), .B0(n1567), .B1(s5_many_skip_r[20]), 
        .Y(dout_uni_y_man_dn[20]) );
  AOI22X1TS U2019 ( .A0(n1003), .A1(s5_many_r[20]), .B0(n1126), .B1(
        s5_many_r[19]), .Y(n1588) );
  AOI22X1TS U2020 ( .A0(n1574), .A1(n1573), .B0(n847), .B1(n1571), .Y(n1578)
         );
  NAND2X1TS U2021 ( .A(n1576), .B(n1575), .Y(n1577) );
  OAI211XLTS U2022 ( .A0(n1580), .A1(n838), .B0(n1578), .C0(n1577), .Y(n1582)
         );
  AOI22X1TS U2023 ( .A0(n949), .A1(n1582), .B0(n1581), .B1(s5_many_skip_r[21]), 
        .Y(n1587) );
  AOI22X1TS U2024 ( .A0(n824), .A1(s5_many_r[22]), .B0(n1583), .B1(
        s5_many_r[21]), .Y(n1586) );
  AOI32X1TS U2025 ( .A0(n1588), .A1(n1587), .A2(n1586), .B0(n806), .B1(n1587), 
        .Y(dout_uni_y_man_dn[21]) );
  INVX2TS U2026 ( .A(n1589), .Y(n1591) );
  AOI21X1TS U2027 ( .A0(n1592), .A1(n1591), .B0(n1590), .Y(intadd_1_A_0_) );
  AO21XLTS U2028 ( .A0(s3_lhs_r[21]), .A1(n1594), .B0(n1593), .Y(n1597) );
  AOI21X1TS U2029 ( .A0(s3_rhs_r[22]), .A1(n1597), .B0(n1596), .Y(n705) );
  CLKBUFX2TS U2030 ( .A(n1598), .Y(n1603) );
  CLKBUFX2TS U2031 ( .A(n1603), .Y(n1600) );
  CLKBUFX2TS U2032 ( .A(n1600), .Y(n1735) );
  CLKBUFX2TS U2033 ( .A(n1603), .Y(n1611) );
  CLKBUFX2TS U2034 ( .A(n1611), .Y(n1607) );
  INVX2TS U2035 ( .A(n1607), .Y(n1625) );
  AO22XLTS U2036 ( .A0(n1735), .A1(n1044), .B0(n1625), .B1(din_uni_b_man_dn[0]), .Y(s1_mmux_rhs[0]) );
  CLKBUFX2TS U2037 ( .A(n1600), .Y(n1740) );
  CLKBUFX2TS U2038 ( .A(n1598), .Y(n1604) );
  INVX2TS U2039 ( .A(n1604), .Y(n1738) );
  AOI22X1TS U2040 ( .A0(n1740), .A1(n1029), .B0(n1610), .B1(n1738), .Y(
        s1_mmux_rhs[1]) );
  INVX2TS U2041 ( .A(n1735), .Y(n1599) );
  AO22XLTS U2042 ( .A0(n1603), .A1(n1058), .B0(n1599), .B1(n1046), .Y(
        s1_mmux_rhs[2]) );
  AO22XLTS U2043 ( .A0(n1600), .A1(n1060), .B0(n1599), .B1(n1048), .Y(
        s1_mmux_rhs[3]) );
  CLKBUFX2TS U2044 ( .A(n1598), .Y(n1601) );
  AO22XLTS U2045 ( .A0(n1601), .A1(n1062), .B0(n1599), .B1(n1050), .Y(
        s1_mmux_rhs[4]) );
  AO22XLTS U2046 ( .A0(n1601), .A1(n1064), .B0(n1599), .B1(n1052), .Y(
        s1_mmux_rhs[5]) );
  CLKBUFX2TS U2047 ( .A(n1600), .Y(n1624) );
  INVX2TS U2048 ( .A(n1624), .Y(n1602) );
  AO22XLTS U2049 ( .A0(n1601), .A1(n1066), .B0(n1602), .B1(n1054), .Y(
        s1_mmux_rhs[6]) );
  AO22XLTS U2050 ( .A0(n1601), .A1(n1068), .B0(n1602), .B1(n1056), .Y(
        s1_mmux_rhs[7]) );
  AO22XLTS U2051 ( .A0(n1604), .A1(n1070), .B0(n1602), .B1(n1032), .Y(
        s1_mmux_rhs[8]) );
  AOI22X1TS U2052 ( .A0(n1740), .A1(n1023), .B0(n1615), .B1(n1738), .Y(
        s1_mmux_rhs[9]) );
  AO22XLTS U2053 ( .A0(n1604), .A1(din_uni_a_man_dn[10]), .B0(n1602), .B1(
        din_uni_b_man_dn[10]), .Y(s1_mmux_rhs[10]) );
  CLKBUFX2TS U2054 ( .A(n1603), .Y(n1612) );
  CLKBUFX2TS U2055 ( .A(n1612), .Y(n1622) );
  INVX2TS U2056 ( .A(n1622), .Y(n1605) );
  AO22XLTS U2057 ( .A0(n1604), .A1(din_uni_a_man_dn[11]), .B0(n1605), .B1(
        din_uni_b_man_dn[11]), .Y(s1_mmux_rhs[11]) );
  AO22XLTS U2058 ( .A0(n1606), .A1(din_uni_a_man_dn[12]), .B0(n1605), .B1(
        din_uni_b_man_dn[12]), .Y(s1_mmux_rhs[12]) );
  AO22XLTS U2059 ( .A0(n1606), .A1(din_uni_a_man_dn[13]), .B0(n1605), .B1(
        din_uni_b_man_dn[13]), .Y(s1_mmux_rhs[13]) );
  AO22XLTS U2060 ( .A0(n1606), .A1(din_uni_a_man_dn[14]), .B0(n1605), .B1(
        din_uni_b_man_dn[14]), .Y(s1_mmux_rhs[14]) );
  CLKBUFX2TS U2061 ( .A(n1612), .Y(n1618) );
  INVX2TS U2062 ( .A(n1618), .Y(n1608) );
  AO22XLTS U2063 ( .A0(n1607), .A1(din_uni_a_man_dn[15]), .B0(n1608), .B1(
        din_uni_b_man_dn[15]), .Y(s1_mmux_rhs[15]) );
  AO22XLTS U2064 ( .A0(n1607), .A1(din_uni_a_man_dn[16]), .B0(n1608), .B1(
        din_uni_b_man_dn[16]), .Y(s1_mmux_rhs[16]) );
  AO22XLTS U2065 ( .A0(n1607), .A1(din_uni_a_man_dn[17]), .B0(n1608), .B1(
        din_uni_b_man_dn[17]), .Y(s1_mmux_rhs[17]) );
  CLKBUFX2TS U2066 ( .A(n1611), .Y(n1620) );
  AO22XLTS U2067 ( .A0(n1620), .A1(din_uni_a_man_dn[18]), .B0(n1608), .B1(
        din_uni_b_man_dn[18]), .Y(s1_mmux_rhs[18]) );
  CLKBUFX2TS U2068 ( .A(n1612), .Y(n1626) );
  INVX2TS U2069 ( .A(n1626), .Y(n1609) );
  AO22XLTS U2070 ( .A0(n1620), .A1(din_uni_a_man_dn[19]), .B0(n1609), .B1(
        din_uni_b_man_dn[19]), .Y(s1_mmux_rhs[19]) );
  AO22XLTS U2071 ( .A0(n1620), .A1(din_uni_a_man_dn[20]), .B0(n1609), .B1(
        din_uni_b_man_dn[20]), .Y(s1_mmux_rhs[20]) );
  CLKBUFX2TS U2072 ( .A(n1611), .Y(n1616) );
  AO22XLTS U2073 ( .A0(n1616), .A1(din_uni_a_man_dn[21]), .B0(n1609), .B1(
        din_uni_b_man_dn[21]), .Y(s1_mmux_rhs[21]) );
  AO22XLTS U2074 ( .A0(n1616), .A1(n1072), .B0(n1609), .B1(n1044), .Y(
        s1_mmux_lhs[0]) );
  AOI22X1TS U2075 ( .A0(n1740), .A1(n1610), .B0(n1029), .B1(n1786), .Y(
        s1_mmux_lhs[1]) );
  CLKBUFX2TS U2076 ( .A(n1611), .Y(n1621) );
  CLKBUFX2TS U2077 ( .A(n1612), .Y(n1613) );
  INVX2TS U2078 ( .A(n1613), .Y(n1619) );
  AO22XLTS U2079 ( .A0(n1621), .A1(n1046), .B0(n1619), .B1(n1058), .Y(
        s1_mmux_lhs[2]) );
  AO22XLTS U2080 ( .A0(n1621), .A1(n1048), .B0(n1619), .B1(n1060), .Y(
        s1_mmux_lhs[3]) );
  AO22XLTS U2081 ( .A0(n1613), .A1(n1050), .B0(n1619), .B1(n1062), .Y(
        s1_mmux_lhs[4]) );
  INVX2TS U2082 ( .A(n1621), .Y(n1614) );
  AO22XLTS U2083 ( .A0(n1613), .A1(n1052), .B0(n1614), .B1(n1064), .Y(
        s1_mmux_lhs[5]) );
  AO22XLTS U2084 ( .A0(n1613), .A1(n1054), .B0(n1614), .B1(n1066), .Y(
        s1_mmux_lhs[6]) );
  AO22XLTS U2085 ( .A0(n1626), .A1(n1056), .B0(n1614), .B1(n1068), .Y(
        s1_mmux_lhs[7]) );
  AO22XLTS U2086 ( .A0(n1616), .A1(n1032), .B0(n1614), .B1(n1070), .Y(
        s1_mmux_lhs[8]) );
  AOI22X1TS U2087 ( .A0(n1735), .A1(n1615), .B0(n1023), .B1(n1786), .Y(
        s1_mmux_lhs[9]) );
  INVX2TS U2088 ( .A(n1616), .Y(n1617) );
  AO22XLTS U2089 ( .A0(n1626), .A1(din_uni_b_man_dn[10]), .B0(n1617), .B1(
        din_uni_a_man_dn[10]), .Y(s1_mmux_lhs[10]) );
  AO22XLTS U2090 ( .A0(n1618), .A1(din_uni_b_man_dn[11]), .B0(n1617), .B1(
        din_uni_a_man_dn[11]), .Y(s1_mmux_lhs[11]) );
  AO22XLTS U2091 ( .A0(n1618), .A1(din_uni_b_man_dn[12]), .B0(n1617), .B1(
        din_uni_a_man_dn[12]), .Y(s1_mmux_lhs[12]) );
  AO22XLTS U2092 ( .A0(n1618), .A1(din_uni_b_man_dn[13]), .B0(n1617), .B1(
        din_uni_a_man_dn[13]), .Y(s1_mmux_lhs[13]) );
  AO22XLTS U2093 ( .A0(n1622), .A1(din_uni_b_man_dn[14]), .B0(n1619), .B1(
        din_uni_a_man_dn[14]), .Y(s1_mmux_lhs[14]) );
  INVX2TS U2094 ( .A(n1620), .Y(n1623) );
  AO22XLTS U2095 ( .A0(n1622), .A1(din_uni_b_man_dn[15]), .B0(n1623), .B1(
        din_uni_a_man_dn[15]), .Y(s1_mmux_lhs[15]) );
  AO22XLTS U2096 ( .A0(n1621), .A1(din_uni_b_man_dn[16]), .B0(n1623), .B1(
        din_uni_a_man_dn[16]), .Y(s1_mmux_lhs[16]) );
  AO22XLTS U2097 ( .A0(n1622), .A1(din_uni_b_man_dn[17]), .B0(n1623), .B1(
        din_uni_a_man_dn[17]), .Y(s1_mmux_lhs[17]) );
  AO22XLTS U2098 ( .A0(n1624), .A1(din_uni_b_man_dn[18]), .B0(n1623), .B1(
        din_uni_a_man_dn[18]), .Y(s1_mmux_lhs[18]) );
  AO22XLTS U2099 ( .A0(n1624), .A1(din_uni_b_man_dn[19]), .B0(n1625), .B1(
        din_uni_a_man_dn[19]), .Y(s1_mmux_lhs[19]) );
  AO22XLTS U2100 ( .A0(n1624), .A1(din_uni_b_man_dn[20]), .B0(n1625), .B1(
        din_uni_a_man_dn[20]), .Y(s1_mmux_lhs[20]) );
  AO22XLTS U2101 ( .A0(n1626), .A1(din_uni_b_man_dn[21]), .B0(n1625), .B1(
        din_uni_a_man_dn[21]), .Y(s1_mmux_lhs[21]) );
  NOR4XLTS U2102 ( .A(s2_mmux_lhs_r[10]), .B(s2_mmux_lhs_r[9]), .C(
        s2_mmux_lhs_r[5]), .D(s2_mmux_lhs_r[7]), .Y(n1632) );
  NOR4XLTS U2103 ( .A(s2_mmux_lhs_r[14]), .B(s2_mmux_lhs_r[12]), .C(
        s2_mmux_lhs_r[11]), .D(s2_mmux_lhs_r[8]), .Y(n1631) );
  NOR4XLTS U2104 ( .A(s2_mmux_lhs_r[18]), .B(s2_mmux_lhs_r[17]), .C(
        s2_mmux_lhs_r[13]), .D(s2_mmux_lhs_r[15]), .Y(n1630) );
  OR4X2TS U2105 ( .A(s2_mmux_lhs_r[6]), .B(s2_mmux_lhs_r[2]), .C(
        s2_mmux_lhs_r[4]), .D(s2_mmux_lhs_r[3]), .Y(n1628) );
  OR4X2TS U2106 ( .A(s2_mmux_lhs_r[21]), .B(s2_mmux_lhs_r[19]), .C(
        s2_mmux_lhs_r[20]), .D(s2_mmux_lhs_r[16]), .Y(n1627) );
  NOR4XLTS U2107 ( .A(s2_mmux_lhs_r[0]), .B(s2_mmux_lhs_r[1]), .C(n1628), .D(
        n1627), .Y(n1629) );
  INVX2TS U2108 ( .A(s2_opcode_r[1]), .Y(n1633) );
  AOI21X1TS U2109 ( .A0(n826), .A1(s2_opcode_r[0]), .B0(n1633), .Y(N114) );
  AO21XLTS U2110 ( .A0(s2_mmux_rhs_r[0]), .A1(n1114), .B0(s2_mmux_lhs_r[0]), 
        .Y(s2_mmux3_lhs_addsub[0]) );
  AO21XLTS U2111 ( .A0(s2_mmux_rhs_r[1]), .A1(n1113), .B0(s2_mmux_lhs_r[1]), 
        .Y(s2_mmux3_lhs_addsub[1]) );
  AO21XLTS U2112 ( .A0(s2_mmux_rhs_r[2]), .A1(n826), .B0(s2_mmux_lhs_r[2]), 
        .Y(s2_mmux3_lhs_addsub[2]) );
  AO21XLTS U2113 ( .A0(s2_mmux_rhs_r[3]), .A1(n780), .B0(s2_mmux_lhs_r[3]), 
        .Y(s2_mmux3_lhs_addsub[3]) );
  AO21XLTS U2114 ( .A0(s2_mmux_rhs_r[4]), .A1(n781), .B0(s2_mmux_lhs_r[4]), 
        .Y(s2_mmux3_lhs_addsub[4]) );
  AO21XLTS U2115 ( .A0(s2_mmux_rhs_r[5]), .A1(n781), .B0(s2_mmux_lhs_r[5]), 
        .Y(s2_mmux3_lhs_addsub[5]) );
  AO21XLTS U2116 ( .A0(s2_mmux_rhs_r[6]), .A1(n825), .B0(s2_mmux_lhs_r[6]), 
        .Y(s2_mmux3_lhs_addsub[6]) );
  AO21XLTS U2117 ( .A0(s2_mmux_rhs_r[7]), .A1(n826), .B0(s2_mmux_lhs_r[7]), 
        .Y(s2_mmux3_lhs_addsub[7]) );
  AO21XLTS U2118 ( .A0(s2_mmux_rhs_r[8]), .A1(n1113), .B0(s2_mmux_lhs_r[8]), 
        .Y(s2_mmux3_lhs_addsub[8]) );
  AO21XLTS U2119 ( .A0(s2_mmux_rhs_r[9]), .A1(n1114), .B0(s2_mmux_lhs_r[9]), 
        .Y(s2_mmux3_lhs_addsub[9]) );
  AO21XLTS U2120 ( .A0(s2_mmux_rhs_r[10]), .A1(n825), .B0(s2_mmux_lhs_r[10]), 
        .Y(s2_mmux3_lhs_addsub[10]) );
  AO21XLTS U2121 ( .A0(s2_mmux_rhs_r[11]), .A1(n826), .B0(s2_mmux_lhs_r[11]), 
        .Y(s2_mmux3_lhs_addsub[11]) );
  AO21XLTS U2122 ( .A0(s2_mmux_rhs_r[12]), .A1(n780), .B0(s2_mmux_lhs_r[12]), 
        .Y(s2_mmux3_lhs_addsub[12]) );
  AO21XLTS U2123 ( .A0(s2_mmux_rhs_r[13]), .A1(n781), .B0(s2_mmux_lhs_r[13]), 
        .Y(s2_mmux3_lhs_addsub[13]) );
  AO21XLTS U2124 ( .A0(s2_mmux_rhs_r[14]), .A1(n825), .B0(s2_mmux_lhs_r[14]), 
        .Y(s2_mmux3_lhs_addsub[14]) );
  AO21XLTS U2125 ( .A0(s2_mmux_rhs_r[15]), .A1(n1113), .B0(s2_mmux_lhs_r[15]), 
        .Y(s2_mmux3_lhs_addsub[15]) );
  AO21XLTS U2126 ( .A0(s2_mmux_rhs_r[16]), .A1(n1114), .B0(s2_mmux_lhs_r[16]), 
        .Y(s2_mmux3_lhs_addsub[16]) );
  AO21XLTS U2127 ( .A0(s2_mmux_rhs_r[17]), .A1(n1113), .B0(s2_mmux_lhs_r[17]), 
        .Y(s2_mmux3_lhs_addsub[17]) );
  AO21XLTS U2128 ( .A0(s2_mmux_rhs_r[18]), .A1(n825), .B0(s2_mmux_lhs_r[18]), 
        .Y(s2_mmux3_lhs_addsub[18]) );
  AO21XLTS U2129 ( .A0(s2_mmux_rhs_r[19]), .A1(n780), .B0(s2_mmux_lhs_r[19]), 
        .Y(s2_mmux3_lhs_addsub[19]) );
  AO21XLTS U2130 ( .A0(s2_mmux_rhs_r[20]), .A1(n780), .B0(s2_mmux_lhs_r[20]), 
        .Y(s2_mmux3_lhs_addsub[20]) );
  AO21XLTS U2131 ( .A0(s2_mmux_rhs_r[21]), .A1(n781), .B0(s2_mmux_lhs_r[21]), 
        .Y(s2_mmux3_lhs_addsub[21]) );
  INVX2TS U2132 ( .A(n1686), .Y(n1680) );
  NOR3XLTS U2133 ( .A(n842), .B(n839), .C(n1648), .Y(n1677) );
  AOI22X1TS U2134 ( .A0(n1017), .A1(s2_mmux_rhs_r[0]), .B0(n1102), .B1(
        s2_mmux_rhs_r[1]), .Y(n1636) );
  AOI22X1TS U2135 ( .A0(n1008), .A1(s2_mmux_rhs_r[2]), .B0(n1000), .B1(n742), 
        .Y(n1635) );
  AOI21X1TS U2136 ( .A0(n1636), .A1(n1635), .B0(n736), .Y(n1641) );
  NAND3XLTS U2137 ( .A(n840), .B(n1721), .C(n846), .Y(n1674) );
  AOI221XLTS U2138 ( .A0(s2_ea_sub_eb_abs_r[2]), .A1(n799), .B0(n846), .B1(
        n1704), .C0(s2_ea_sub_eb_abs_r[3]), .Y(n1724) );
  AOI22X1TS U2139 ( .A0(n1017), .A1(n744), .B0(n1102), .B1(n746), .Y(n1638) );
  AOI22X1TS U2140 ( .A0(n1007), .A1(n748), .B0(n1000), .B1(n750), .Y(n1637) );
  NAND2X1TS U2141 ( .A(n1638), .B(n1637), .Y(n1685) );
  AOI22X1TS U2142 ( .A0(s2_ea_sub_eb_abs_r[4]), .A1(n1724), .B0(n732), .B1(
        n1685), .Y(n1639) );
  OAI21XLTS U2143 ( .A0(n1682), .A1(n1674), .B0(n1639), .Y(n1640) );
  AOI211XLTS U2144 ( .A0(n1677), .A1(n1642), .B0(n1641), .C0(n1640), .Y(n1644)
         );
  NOR2XLTS U2145 ( .A(n1644), .B(s2_ea_sub_eb_abs_r[5]), .Y(n1645) );
  NAND2X1TS U2146 ( .A(n1643), .B(n790), .Y(n1722) );
  OAI22X1TS U2147 ( .A0(n1680), .A1(n1645), .B0(n1644), .B1(n740), .Y(
        s2_mmux3_rhs_addsub[0]) );
  AOI22X1TS U2148 ( .A0(n1016), .A1(s2_mmux_rhs_r[1]), .B0(n1103), .B1(
        s2_mmux_rhs_r[2]), .Y(n1647) );
  AOI22X1TS U2149 ( .A0(n1006), .A1(n742), .B0(n999), .B1(n744), .Y(n1646) );
  AOI21X1TS U2150 ( .A0(n1647), .A1(n1646), .B0(n736), .Y(n1653) );
  AOI221XLTS U2151 ( .A0(s2_ea_sub_eb_abs_r[2]), .A1(n802), .B0(n846), .B1(
        n1707), .C0(n840), .Y(n1727) );
  AOI22X1TS U2152 ( .A0(n748), .A1(n1100), .B0(n1018), .B1(n746), .Y(n1650) );
  AOI22X1TS U2153 ( .A0(n777), .A1(n750), .B0(n998), .B1(n752), .Y(n1649) );
  NAND2X1TS U2154 ( .A(n1650), .B(n1649), .Y(n1693) );
  AOI22X1TS U2155 ( .A0(s2_ea_sub_eb_abs_r[4]), .A1(n1727), .B0(n1672), .B1(
        n1693), .Y(n1651) );
  OAI21XLTS U2156 ( .A0(n1689), .A1(n1674), .B0(n1651), .Y(n1652) );
  AOI211XLTS U2157 ( .A0(n1677), .A1(n1654), .B0(n1653), .C0(n1652), .Y(n1655)
         );
  NOR2XLTS U2158 ( .A(n1655), .B(s2_ea_sub_eb_abs_r[5]), .Y(n1656) );
  OAI22X1TS U2159 ( .A0(n1680), .A1(n1656), .B0(n1655), .B1(n740), .Y(
        s2_mmux3_rhs_addsub[1]) );
  AOI22X1TS U2160 ( .A0(n1018), .A1(s2_mmux_rhs_r[2]), .B0(n820), .B1(n742), 
        .Y(n1658) );
  AOI22X1TS U2161 ( .A0(n1007), .A1(s2_mmux_rhs_r[4]), .B0(n998), .B1(n746), 
        .Y(n1657) );
  AOI21X1TS U2162 ( .A0(n1658), .A1(n1657), .B0(n1668), .Y(n1663) );
  NOR2XLTS U2163 ( .A(n1721), .B(n1659), .Y(n1681) );
  AOI22X1TS U2164 ( .A0(n1672), .A1(n1660), .B0(n1681), .B1(n734), .Y(n1661)
         );
  OAI21XLTS U2165 ( .A0(n1696), .A1(n1674), .B0(n1661), .Y(n1662) );
  AOI211XLTS U2166 ( .A0(n1677), .A1(n1714), .B0(n1663), .C0(n1662), .Y(n1664)
         );
  NOR2XLTS U2167 ( .A(n1664), .B(n844), .Y(n1665) );
  OAI22X1TS U2168 ( .A0(n1680), .A1(n1665), .B0(n1664), .B1(n1722), .Y(
        s2_mmux3_rhs_addsub[2]) );
  AOI22X1TS U2169 ( .A0(n817), .A1(s2_mmux_rhs_r[3]), .B0(s2_mmux_rhs_r[4]), 
        .B1(n1101), .Y(n1670) );
  AOI22X1TS U2170 ( .A0(n1006), .A1(s2_mmux_rhs_r[5]), .B0(s2_mmux_rhs_r[6]), 
        .B1(n998), .Y(n1669) );
  AOI21X1TS U2171 ( .A0(n1670), .A1(n1669), .B0(n1668), .Y(n1676) );
  AOI22X1TS U2172 ( .A0(n1672), .A1(n1671), .B0(n1681), .B1(n730), .Y(n1673)
         );
  OAI21XLTS U2173 ( .A0(n1699), .A1(n1674), .B0(n1673), .Y(n1675) );
  NOR2XLTS U2174 ( .A(n1678), .B(s2_ea_sub_eb_abs_r[5]), .Y(n1679) );
  OAI22X1TS U2175 ( .A0(n1680), .A1(n1679), .B0(n1678), .B1(n1722), .Y(
        s2_mmux3_rhs_addsub[3]) );
  NAND2X1TS U2176 ( .A(n1681), .B(n843), .Y(n1688) );
  OAI22X1TS U2177 ( .A0(n1704), .A1(n798), .B0(n799), .B1(n1688), .Y(n1684) );
  OAI22X1TS U2178 ( .A0(n1703), .A1(n836), .B0(n1682), .B1(n1083), .Y(n1683)
         );
  AOI211XLTS U2179 ( .A0(n786), .A1(n1685), .B0(n1684), .C0(n1683), .Y(n1687)
         );
  XNOR2X1TS U2180 ( .A(n1687), .B(n1686), .Y(s2_mmux3_rhs_addsub[4]) );
  OAI22X1TS U2181 ( .A0(n1706), .A1(n836), .B0(n802), .B1(n1688), .Y(n1692) );
  OAI22X1TS U2182 ( .A0(n1707), .A1(n798), .B0(n1689), .B1(n1084), .Y(n1691)
         );
  AOI211XLTS U2183 ( .A0(n1088), .A1(n1693), .B0(n1692), .C0(n1691), .Y(n1695)
         );
  CLKBUFX2TS U2184 ( .A(n1694), .Y(n1719) );
  XNOR2X1TS U2185 ( .A(n1695), .B(n1719), .Y(s2_mmux3_rhs_addsub[5]) );
  INVX2TS U2186 ( .A(n1082), .Y(n1716) );
  INVX2TS U2187 ( .A(n1696), .Y(n1697) );
  AOI222XLTS U2188 ( .A0(n1714), .A1(n1716), .B0(n1697), .B1(n1088), .C0(n734), 
        .C1(n1700), .Y(n1698) );
  XNOR2X1TS U2189 ( .A(n1698), .B(n1815), .Y(s2_mmux3_rhs_addsub[10]) );
  INVX2TS U2190 ( .A(n1699), .Y(n1701) );
  AOI222XLTS U2191 ( .A0(n1717), .A1(n1716), .B0(n1701), .B1(n1089), .C0(n730), 
        .C1(n1700), .Y(n1702) );
  XNOR2X1TS U2192 ( .A(n1702), .B(n1719), .Y(s2_mmux3_rhs_addsub[11]) );
  OAI222X1TS U2193 ( .A0(n1710), .A1(n800), .B0(n1083), .B1(n1704), .C0(n787), 
        .C1(n1703), .Y(n1705) );
  XNOR2X1TS U2194 ( .A(n1712), .B(n1705), .Y(s2_mmux3_rhs_addsub[12]) );
  OAI222X1TS U2195 ( .A0(n1710), .A1(n802), .B0(n1084), .B1(n1707), .C0(n787), 
        .C1(n1706), .Y(n1711) );
  XNOR2X1TS U2196 ( .A(n1712), .B(n1711), .Y(s2_mmux3_rhs_addsub[13]) );
  AOI22X1TS U2197 ( .A0(n786), .A1(n1714), .B0(n1716), .B1(n734), .Y(n1715) );
  XNOR2X1TS U2198 ( .A(n1715), .B(n1719), .Y(s2_mmux3_rhs_addsub[14]) );
  AOI22X1TS U2199 ( .A0(n1088), .A1(n1717), .B0(n1716), .B1(n730), .Y(n1720)
         );
  XNOR2X1TS U2200 ( .A(n1720), .B(n1719), .Y(s2_mmux3_rhs_addsub[15]) );
  INVX2TS U2201 ( .A(n1724), .Y(n1725) );
  OAI21XLTS U2203 ( .A0(n844), .A1(s2_ea_sub_eb_abs_r[4]), .B0(n1723), .Y(
        n1726) );
  OAI221XLTS U2204 ( .A0(n1725), .A1(n1728), .B0(n1724), .B1(n1814), .C0(n1726), .Y(s2_mmux3_rhs_addsub[16]) );
  INVX2TS U2205 ( .A(n1727), .Y(n1729) );
  OAI221XLTS U2206 ( .A0(n1729), .A1(n1728), .B0(n1727), .B1(n1814), .C0(n1726), .Y(s2_mmux3_rhs_addsub[17]) );
  OAI221XLTS U2207 ( .A0(n706), .A1(n1731), .B0(n730), .B1(n1814), .C0(n1730), 
        .Y(s2_mmux3_rhs_addsub[19]) );
  OAI221XLTS U2208 ( .A0(n800), .A1(n1731), .B0(n714), .B1(s2_addsubn_r), .C0(
        n1730), .Y(s2_mmux3_rhs_addsub[20]) );
  NOR2XLTS U2209 ( .A(n1738), .B(n1734), .Y(n1732) );
  XNOR2X1TS U2210 ( .A(n1732), .B(intadd_3_SUM_0_), .Y(s1_ea_sub_eb_abs[1]) );
  AOI21X1TS U2211 ( .A0(n1734), .A1(intadd_3_SUM_0_), .B0(n1786), .Y(n1733) );
  XNOR2X1TS U2212 ( .A(intadd_3_SUM_1_), .B(n1733), .Y(s1_ea_sub_eb_abs[2]) );
  NAND3XLTS U2213 ( .A(intadd_3_SUM_1_), .B(n1734), .C(intadd_3_SUM_0_), .Y(
        n1737) );
  NAND2X1TS U2214 ( .A(n1737), .B(n1735), .Y(n1736) );
  XOR2XLTS U2215 ( .A(intadd_3_SUM_2_), .B(n1736), .Y(s1_ea_sub_eb_abs[3]) );
  NOR2XLTS U2217 ( .A(n1738), .B(n1742), .Y(n1739) );
  XNOR2X1TS U2218 ( .A(n1739), .B(intadd_3_SUM_3_), .Y(s1_ea_sub_eb_abs[4]) );
  NOR2XLTS U2221 ( .A(n1019), .B(n1026), .Y(n1743) );
  OAI22X1TS U2222 ( .A0(n1744), .A1(n1743), .B0(n1746), .B1(intadd_3_n1), .Y(
        n1745) );
  AOI21X1TS U2223 ( .A0(n1746), .A1(intadd_3_n1), .B0(n1745), .Y(
        s1_ea_sub_eb_abs[5]) );
  XNOR2X1TS U2224 ( .A(din_uni_b_sgn), .B(din_uni_a_sgn), .Y(n703) );
  OAI221XLTS U2225 ( .A0(n1750), .A1(n1749), .B0(n994), .B1(n904), .C0(n1747), 
        .Y(n697) );
  OAI22X1TS U2226 ( .A0(n975), .A1(n901), .B0(n947), .B1(n995), .Y(n692) );
  OAI22X1TS U2227 ( .A0(n971), .A1(n901), .B0(n974), .B1(n945), .Y(n686) );
  OAI22X1TS U2228 ( .A0(n979), .A1(n901), .B0(n970), .B1(n945), .Y(n680) );
  OAI22X1TS U2229 ( .A0(n987), .A1(n901), .B0(n978), .B1(n945), .Y(n674) );
  OAI22X1TS U2230 ( .A0(n991), .A1(n902), .B0(n986), .B1(n947), .Y(n668) );
  OAI22X1TS U2231 ( .A0(n967), .A1(n1770), .B0(n990), .B1(n946), .Y(n662) );
  OAI22X1TS U2232 ( .A0(n963), .A1(n902), .B0(n966), .B1(n947), .Y(n656) );
  OAI22X1TS U2233 ( .A0(n959), .A1(n1770), .B0(n962), .B1(n946), .Y(n650) );
  OAI22X1TS U2234 ( .A0(n983), .A1(n902), .B0(n958), .B1(n947), .Y(n644) );
  AO21XLTS U2235 ( .A0(s1_br4_s[0]), .A1(n1116), .B0(n940), .Y(n642) );
  OAI221XLTS U2236 ( .A0(n1117), .A1(n892), .B0(n1767), .B1(n876), .C0(n1755), 
        .Y(n640) );
  AOI221XLTS U2237 ( .A0(n934), .A1(n983), .B0(n1757), .B1(n862), .C0(n938), 
        .Y(n1758) );
  OAI221XLTS U2238 ( .A0(n1118), .A1(n899), .B0(n1767), .B1(n882), .C0(n1758), 
        .Y(n638) );
  AOI221XLTS U2239 ( .A0(n926), .A1(n982), .B0(n923), .B1(n862), .C0(n929), 
        .Y(n1762) );
  OAI221XLTS U2240 ( .A0(n783), .A1(n896), .B0(n1767), .B1(n879), .C0(n1762), 
        .Y(n636) );
  AOI221XLTS U2241 ( .A0(n910), .A1(n981), .B0(n908), .B1(n862), .C0(n914), 
        .Y(n1765) );
  OAI221XLTS U2242 ( .A0(n1115), .A1(n1768), .B0(n1767), .B1(n873), .C0(n1765), 
        .Y(n634) );
  OAI22X1TS U2243 ( .A0(n1116), .A1(n1770), .B0(n982), .B1(n946), .Y(n633) );
  CMPR32X2TS U2244 ( .A(n1774), .B(n1773), .C(n1772), .CO(n1592), .S(n1775) );
  OAI2BB1X1TS U2245 ( .A0N(n1776), .A1N(s3_lhs_r[4]), .B0(n1775), .Y(n606) );
  CLKAND2X2TS U2246 ( .A(opcode[0]), .B(n1076), .Y(n1778) );
  AO22XLTS U2247 ( .A0(din_uni_a_exp[5]), .A1(n1778), .B0(s2_ea_r[5]), .B1(
        n1777), .Y(n595) );
  AO22XLTS U2248 ( .A0(n1026), .A1(n1778), .B0(s2_eb_r[5]), .B1(n1777), .Y(
        n593) );
  CLKINVX1TS U834 ( .A(n899), .Y(n707) );
  NAND3X1TS U835 ( .A(n1370), .B(n1368), .C(n1196), .Y(n899) );
  CLKINVX1TS U839 ( .A(n892), .Y(n718) );
  NAND3X1TS U843 ( .A(n1376), .B(n1374), .C(n722), .Y(n892) );
  CLKINVX1TS U844 ( .A(n896), .Y(n713) );
  NAND3X1TS U845 ( .A(n1373), .B(n1371), .C(n1195), .Y(n896) );
  NAND2X1TS U846 ( .A(n739), .B(n841), .Y(n1728) );
  CLKINVX1TS U848 ( .A(n1092), .Y(n1753) );
  NOR2X1TS U849 ( .A(n722), .B(n1376), .Y(n1092) );
  CLKINVX1TS U852 ( .A(n933), .Y(n709) );
  NOR2X1TS U854 ( .A(n1368), .B(n794), .Y(n933) );
  CLKINVX1TS U855 ( .A(n909), .Y(n710) );
  NOR2X1TS U856 ( .A(n1365), .B(n792), .Y(n909) );
  CLKINVX1TS U857 ( .A(n937), .Y(n708) );
  NOR2X1TS U870 ( .A(n1370), .B(n794), .Y(n937) );
  OAI2BB1X1TS U877 ( .A0N(n1742), .A1N(intadd_3_SUM_3_), .B0(n1740), .Y(n1746)
         );
  NOR2BX1TS U932 ( .AN(intadd_3_SUM_2_), .B(n1737), .Y(n1742) );
  CLKINVX1TS U934 ( .A(n1115), .Y(n1771) );
  NOR2X1TS U936 ( .A(n943), .B(n1024), .Y(n1115) );
  NAND2XLTS U949 ( .A(n1357), .B(n1359), .Y(n1551) );
  CLKINVX1TS U958 ( .A(n808), .Y(n716) );
  NOR2X1TS U959 ( .A(n1424), .B(n1510), .Y(n808) );
  CLKINVX1TS U963 ( .A(n956), .Y(n712) );
  AOI22X1TS U981 ( .A0(n1175), .A1(n1070), .B0(n1068), .B1(n1120), .Y(n956) );
  CLKINVX1TS U998 ( .A(n1082), .Y(n1708) );
  NAND2X1TS U999 ( .A(n843), .B(n732), .Y(n1082) );
  XOR2X1TS U1043 ( .A(DP_OP_167J1_125_280_n10), .B(n1818), .Y(n1519) );
  XOR2X1TS U1047 ( .A(n1819), .B(n1516), .Y(n1818) );
  AOI21X1TS U1050 ( .A0(n1513), .A1(n1081), .B0(n1548), .Y(n1819) );
  CLKINVX1TS U1057 ( .A(n809), .Y(n1520) );
  NAND2X1TS U1060 ( .A(n1424), .B(n1498), .Y(n809) );
  CLKINVX1TS U1066 ( .A(n786), .Y(n1718) );
  NOR2X1TS U1072 ( .A(n736), .B(n844), .Y(n786) );
  CLKINVX1TS U1084 ( .A(n915), .Y(n719) );
  NOR2X1TS U1088 ( .A(n1180), .B(n794), .Y(n915) );
  CLKINVX1TS U1095 ( .A(n728), .Y(n715) );
  AOI21X1TS U1107 ( .A0(n823), .A1(s5_many_r[3]), .B0(n1226), .Y(n728) );
  CLKINVX1TS U1161 ( .A(n848), .Y(n847) );
  NAND2X1TS U1162 ( .A(n1427), .B(n1428), .Y(n848) );
  OR4X1TS U1225 ( .A(s4_lzdi_r[0]), .B(s4_lzdi_r[4]), .C(s4_lzdi_r[2]), .D(
        n1820), .Y(n1153) );
  OR4X1TS U1226 ( .A(s4_lzdi_r[3]), .B(s4_lzdi_r[1]), .C(s4_lzdi_r[5]), .D(
        s4_lzdi_r[6]), .Y(n1820) );
  CLKINVX1TS U1233 ( .A(n799), .Y(n714) );
  AOI22X1TS U1236 ( .A0(n774), .A1(n1103), .B0(n772), .B1(n1015), .Y(n799) );
  CLKINVX1TS U1239 ( .A(n906), .Y(n721) );
  NOR2X1TS U1247 ( .A(n1160), .B(n1749), .Y(n906) );
  CLKINVX1TS U1265 ( .A(n921), .Y(n720) );
  NOR2X1TS U1266 ( .A(n1190), .B(n792), .Y(n921) );
  INVXLTS U1279 ( .A(din_uni_b_man_dn[9]), .Y(n1821) );
  NOR2X1TS U1280 ( .A(n1364), .B(n1821), .Y(n944) );
  CLKINVX1TS U1328 ( .A(n735), .Y(n1668) );
  NOR2X1TS U1333 ( .A(n842), .B(n1659), .Y(n735) );
  NOR2XLTS U1342 ( .A(n1025), .B(din_uni_a_exp[5]), .Y(n1744) );
  INVXLTS U1363 ( .A(din_uni_a_exp[5]), .Y(n1019) );
  NAND2BX1TS U1409 ( .AN(s2_ea_sub_eb_abs_r[0]), .B(s2_ea_sub_eb_abs_r[1]), 
        .Y(n711) );
  CLKINVX1TS U1411 ( .A(n830), .Y(n1549) );
  NOR2X1TS U1420 ( .A(n1419), .B(n953), .Y(n830) );
  CLKINVX1TS U1429 ( .A(n1126), .Y(n1569) );
  NOR2X1TS U1430 ( .A(n1219), .B(n1222), .Y(n1126) );
  NAND2BX1TS U1431 ( .AN(s2_ea_sub_eb_abs_r[1]), .B(s2_ea_sub_eb_abs_r[0]), 
        .Y(n1666) );
  OAI22X1TS U1584 ( .A0(n812), .A1(n953), .B0(n952), .B1(n811), .Y(n1219) );
  CLKINVX1TS U1615 ( .A(s3_opcode_r[0]), .Y(n813) );
  CLKINVX1TS U1783 ( .A(s3_opcode_r[1]), .Y(n1527) );
  NAND2X1TS U1786 ( .A(s3_opcode_r[0]), .B(s3_opcode_r[1]), .Y(n1288) );
endmodule

