
`timescale 1ns/1fs

module data_dmem_fp16(
    input [8:0]         a,
    output reg [15:0]   q   
);
always @* begin
	case(a) 
	9'd000: q = 16'h4601;
	9'd001: q = 16'h38B4;
	9'd002: q = 16'h3C9D;
	9'd003: q = 16'h3B9C;
	9'd004: q = 16'h8000;
	9'd005: q = 16'h3B9C;
	9'd006: q = 16'hB4CB;
	9'd007: q = 16'h38B4;
	9'd008: q = 16'hB0D2;
	9'd009: q = 16'h8000;
	9'd010: q = 16'h30D2;
	9'd011: q = 16'hB8B4;
	9'd012: q = 16'h34CB;
	9'd013: q = 16'hBB9C;
	9'd014: q = 16'h8000;
	9'd015: q = 16'hBB9C;
	9'd016: q = 16'hBC9D;
	9'd017: q = 16'hB8B4;
	9'd018: q = 16'hC601;
	9'd019: q = 16'h8000;
	9'd020: q = 16'h4601;
	9'd021: q = 16'h38B4;
	9'd022: q = 16'h3C9D;
	9'd023: q = 16'h3B9C;
	9'd024: q = 16'h8000;
	9'd025: q = 16'h3B9C;
	9'd026: q = 16'hB4CB;
	9'd027: q = 16'h38B4;
	9'd028: q = 16'hB0D2;
	9'd029: q = 16'h8000;
	9'd030: q = 16'h30D2;
	9'd031: q = 16'hB8B4;
	9'd032: q = 16'h34CB;
	9'd033: q = 16'hBB9C;
	9'd034: q = 16'h8000;
	9'd035: q = 16'hBB9C;
	9'd036: q = 16'hBC9D;
	9'd037: q = 16'hB8B4;
	9'd038: q = 16'hC601;
	9'd039: q = 16'h8000;
	9'd040: q = 16'h4601;
	9'd041: q = 16'h38B4;
	9'd042: q = 16'h3C9D;
	9'd043: q = 16'h3B9C;
	9'd044: q = 16'h8000;
	9'd045: q = 16'h3B9C;
	9'd046: q = 16'hB4CB;
	9'd047: q = 16'h38B4;
	9'd048: q = 16'hB0D2;
	9'd049: q = 16'h0000;
	9'd050: q = 16'h30D2;
	9'd051: q = 16'hB8B4;
	9'd052: q = 16'h34CB;
	9'd053: q = 16'hBB9C;
	9'd054: q = 16'h0000;
	9'd055: q = 16'hBB9C;
	9'd056: q = 16'hBC9D;
	9'd057: q = 16'hB8B4;
	9'd058: q = 16'hC601;
	9'd059: q = 16'h8000;
	9'd060: q = 16'h4601;
	9'd061: q = 16'h38B4;
	9'd062: q = 16'h3C9D;
	9'd063: q = 16'h3B9C;
	9'd064: q = 16'h0000;
	9'd065: q = 16'h3B9C;
	9'd066: q = 16'hB4CB;
	9'd067: q = 16'h38B4;
	9'd068: q = 16'hB0D2;
	9'd069: q = 16'h0000;
	9'd070: q = 16'h30D2;
	9'd071: q = 16'hB8B4;
	9'd072: q = 16'h34CB;
	9'd073: q = 16'hBB9C;
	9'd074: q = 16'h0000;
	9'd075: q = 16'hBB9C;
	9'd076: q = 16'hBC9D;
	9'd077: q = 16'hB8B4;
	9'd078: q = 16'hC601;
	9'd079: q = 16'h8000;
	9'd080: q = 16'h4601;
	9'd081: q = 16'h38B4;
	9'd082: q = 16'h3C9D;
	9'd083: q = 16'h3B9C;
	9'd084: q = 16'h0000;
	9'd085: q = 16'h3B9C;
	9'd086: q = 16'hB4CB;
	9'd087: q = 16'h38B4;
	9'd088: q = 16'hB0D2;
	9'd089: q = 16'h8000;
	9'd090: q = 16'h30D2;
	9'd091: q = 16'hB8B4;
	9'd092: q = 16'h34CB;
	9'd093: q = 16'hBB9C;
	9'd094: q = 16'h8000;
	9'd095: q = 16'hBB9C;
	9'd096: q = 16'hBC9D;
	9'd097: q = 16'hB8B4;
	9'd098: q = 16'hC601;
	9'd099: q = 16'h8000;
	9'd100: q = 16'h4601;
	9'd101: q = 16'h38B4;
	9'd102: q = 16'h3C9D;
	9'd103: q = 16'h3B9C;
	9'd104: q = 16'h0000;
	9'd105: q = 16'h3B9C;
	9'd106: q = 16'hB4CB;
	9'd107: q = 16'h38B4;
	9'd108: q = 16'hB0D2;
	9'd109: q = 16'h0000;
	9'd110: q = 16'h30D2;
	9'd111: q = 16'hB8B4;
	9'd112: q = 16'h34CB;
	9'd113: q = 16'hBB9C;
	9'd114: q = 16'h8000;
	9'd115: q = 16'hBB9C;
	9'd116: q = 16'hBC9D;
	9'd117: q = 16'hB8B4;
	9'd118: q = 16'hC601;
	9'd119: q = 16'h8000;
	9'd120: q = 16'h4601;
	9'd121: q = 16'h38B4;
	9'd122: q = 16'h3C9D;
	9'd123: q = 16'h3B9C;
	9'd124: q = 16'h0000;
	9'd125: q = 16'h3B9C;
	9'd126: q = 16'hB4CB;
	9'd127: q = 16'h38B4;
	9'd128: q = 16'hB0D2;
	9'd129: q = 16'h0000;
	9'd130: q = 16'h30D2;
	9'd131: q = 16'hB8B4;
	9'd132: q = 16'h34CB;
	9'd133: q = 16'hBB9C;
	9'd134: q = 16'h8000;
	9'd135: q = 16'hBB9C;
	9'd136: q = 16'hBC9D;
	9'd137: q = 16'hB8B4;
	9'd138: q = 16'hC601;
	9'd139: q = 16'h8000;
	9'd140: q = 16'h4601;
	9'd141: q = 16'h38B4;
	9'd142: q = 16'h3C9D;
	9'd143: q = 16'h3B9C;
	9'd144: q = 16'h0000;
	9'd145: q = 16'h3B9C;
	9'd146: q = 16'hB4CB;
	9'd147: q = 16'h38B4;
	9'd148: q = 16'hB0D2;
	9'd149: q = 16'h8000;
	9'd150: q = 16'h30D2;
	9'd151: q = 16'hB8B4;
	9'd152: q = 16'h34CB;
	9'd153: q = 16'hBB9C;
	9'd154: q = 16'h8000;
	9'd155: q = 16'hBB9C;
	9'd156: q = 16'hBC9D;
	9'd157: q = 16'hB8B4;
	9'd158: q = 16'hC601;
	9'd159: q = 16'h8000;
	9'd160: q = 16'h4601;
	9'd161: q = 16'h38B4;
	9'd162: q = 16'h3C9D;
	9'd163: q = 16'h3B9C;
	9'd164: q = 16'h8000;
	9'd165: q = 16'h3B9C;
	9'd166: q = 16'hB4CB;
	9'd167: q = 16'h38B4;
	9'd168: q = 16'hB0D2;
	9'd169: q = 16'h8000;
	9'd170: q = 16'h30D2;
	9'd171: q = 16'hB8B4;
	9'd172: q = 16'h34CB;
	9'd173: q = 16'hBB9C;
	9'd174: q = 16'h8000;
	9'd175: q = 16'hBB9C;
	9'd176: q = 16'hBC9D;
	9'd177: q = 16'hB8B4;
	9'd178: q = 16'hC601;
	9'd179: q = 16'h0000;
	9'd180: q = 16'h4601;
	9'd181: q = 16'h38B4;
	9'd182: q = 16'h3C9D;
	9'd183: q = 16'h3B9C;
	9'd184: q = 16'h8000;
	9'd185: q = 16'h3B9C;
	9'd186: q = 16'hB4CB;
	9'd187: q = 16'h38B4;
	9'd188: q = 16'hB0D2;
	9'd189: q = 16'h8000;
	9'd190: q = 16'h30D2;
	9'd191: q = 16'hB8B4;
	9'd192: q = 16'h34CB;
	9'd193: q = 16'hBB9C;
	9'd194: q = 16'h8000;
	9'd195: q = 16'hBB9C;
	9'd196: q = 16'hBC9D;
	9'd197: q = 16'hB8B4;
	9'd198: q = 16'hC601;
	9'd199: q = 16'h8000;
	9'd200: q = 16'h4601;
	9'd201: q = 16'h38B4;
	9'd202: q = 16'h3C9D;
	9'd203: q = 16'h3B9C;
	9'd204: q = 16'h8000;
	9'd205: q = 16'h3B9C;
	9'd206: q = 16'hB4CB;
	9'd207: q = 16'h38B4;
	9'd208: q = 16'hB0D2;
	9'd209: q = 16'h0000;
	9'd210: q = 16'h30D2;
	9'd211: q = 16'hB8B4;
	9'd212: q = 16'h34CB;
	9'd213: q = 16'hBB9C;
	9'd214: q = 16'h8000;
	9'd215: q = 16'hBB9C;
	9'd216: q = 16'hBC9D;
	9'd217: q = 16'hB8B4;
	9'd218: q = 16'hC601;
	9'd219: q = 16'h0000;
	9'd220: q = 16'h4601;
	9'd221: q = 16'h38B4;
	9'd222: q = 16'h3C9D;
	9'd223: q = 16'h3B9C;
	9'd224: q = 16'h8000;
	9'd225: q = 16'h3B9C;
	9'd226: q = 16'hB4CB;
	9'd227: q = 16'h38B4;
	9'd228: q = 16'hB0D2;
	9'd229: q = 16'h8000;
	9'd230: q = 16'h30D2;
	9'd231: q = 16'hB8B4;
	9'd232: q = 16'h34CB;
	9'd233: q = 16'hBB9C;
	9'd234: q = 16'h8000;
	9'd235: q = 16'hBB9C;
	9'd236: q = 16'hBC9D;
	9'd237: q = 16'hB8B4;
	9'd238: q = 16'hC601;
	9'd239: q = 16'h8000;
	9'd240: q = 16'h4601;
	9'd241: q = 16'h38B4;
	9'd242: q = 16'h3C9D;
	9'd243: q = 16'h3B9C;
	9'd244: q = 16'h8000;
	9'd245: q = 16'h3B9C;
	9'd246: q = 16'hB4CB;
	9'd247: q = 16'h38B4;
	9'd248: q = 16'hB0D2;
	9'd249: q = 16'h0000;
	9'd250: q = 16'h30D2;
	9'd251: q = 16'hB8B4;
	9'd252: q = 16'h34CB;
	9'd253: q = 16'hBB9C;
	9'd254: q = 16'h8000;
	9'd255: q = 16'hBB9C;
	9'd256: q = 16'hBC9D;
	9'd257: q = 16'hB8B4;
	9'd258: q = 16'hC601;
	9'd259: q = 16'h0000;
	9'd260: q = 16'h4601;
	9'd261: q = 16'h38B4;
	9'd262: q = 16'h3C9D;
	9'd263: q = 16'h3B9C;
	9'd264: q = 16'h8000;
	9'd265: q = 16'h3B9C;
	9'd266: q = 16'hB4CB;
	9'd267: q = 16'h38B4;
	9'd268: q = 16'hB0D2;
	9'd269: q = 16'h0000;
	9'd270: q = 16'h30D2;
	9'd271: q = 16'hB8B4;
	9'd272: q = 16'h34CB;
	9'd273: q = 16'hBB9C;
	9'd274: q = 16'h8000;
	9'd275: q = 16'hBB9C;
	9'd276: q = 16'hBC9D;
	9'd277: q = 16'hB8B4;
	9'd278: q = 16'hC601;
	9'd279: q = 16'h8000;
	9'd280: q = 16'h4601;
	9'd281: q = 16'h38B4;
	9'd282: q = 16'h3C9D;
	9'd283: q = 16'h3B9C;
	9'd284: q = 16'h8000;
	9'd285: q = 16'h3B9C;
	9'd286: q = 16'hB4CB;
	9'd287: q = 16'h38B4;
	9'd288: q = 16'hB0D2;
	9'd289: q = 16'h8000;
	9'd290: q = 16'h30D2;
	9'd291: q = 16'hB8B4;
	9'd292: q = 16'h34CB;
	9'd293: q = 16'hBB9C;
	9'd294: q = 16'h8000;
	9'd295: q = 16'hBB9C;
	9'd296: q = 16'hBC9D;
	9'd297: q = 16'hB8B4;
	9'd298: q = 16'hC601;
	9'd299: q = 16'h0000;
	9'd300: q = 16'h4601;
	9'd301: q = 16'h38B4;
	9'd302: q = 16'h3C9D;
	9'd303: q = 16'h3B9C;
	9'd304: q = 16'h8000;
	9'd305: q = 16'h3B9C;
	9'd306: q = 16'hB4CB;
	9'd307: q = 16'h38B4;
	9'd308: q = 16'hB0D2;
	9'd309: q = 16'h8000;
	9'd310: q = 16'h30D2;
	9'd311: q = 16'hB8B4;
	9'd312: q = 16'h34CB;
	9'd313: q = 16'hBB9C;
	9'd314: q = 16'h8000;
	9'd315: q = 16'hBB9C;
	9'd316: q = 16'hBC9D;
	9'd317: q = 16'hB8B4;
	9'd318: q = 16'hC601;
	9'd319: q = 16'h8000;
	9'd320: q = 16'h4601;
	9'd321: q = 16'h38B4;
	9'd322: q = 16'h3C9D;
	9'd323: q = 16'h3B9C;
	9'd324: q = 16'h8000;
	9'd325: q = 16'h3B9C;
	9'd326: q = 16'hB4CB;
	9'd327: q = 16'h38B4;
	9'd328: q = 16'hB0D2;
	9'd329: q = 16'h8000;
	9'd330: q = 16'h30D2;
	9'd331: q = 16'hB8B4;
	9'd332: q = 16'h34CB;
	9'd333: q = 16'hBB9C;
	9'd334: q = 16'h8000;
	9'd335: q = 16'hBB9C;
	9'd336: q = 16'hBC9D;
	9'd337: q = 16'hB8B4;
	9'd338: q = 16'hC601;
	9'd339: q = 16'h0000;
	9'd340: q = 16'h4601;
	9'd341: q = 16'h38B4;
	9'd342: q = 16'h3C9D;
	9'd343: q = 16'h3B9C;
	9'd344: q = 16'h8000;
	9'd345: q = 16'h3B9C;
	9'd346: q = 16'hB4CB;
	9'd347: q = 16'h38B4;
	9'd348: q = 16'hB0D2;
	9'd349: q = 16'h8000;
	9'd350: q = 16'h30D2;
	9'd351: q = 16'hB8B4;
	9'd352: q = 16'h34CB;
	9'd353: q = 16'hBB9C;
	9'd354: q = 16'h8000;
	9'd355: q = 16'hBB9C;
	9'd356: q = 16'hBC9D;
	9'd357: q = 16'hB8B4;
	9'd358: q = 16'hC601;
	9'd359: q = 16'h0000;
	9'd360: q = 16'h4601;
	9'd361: q = 16'h38B4;
	9'd362: q = 16'h3C9D;
	9'd363: q = 16'h3B9C;
	9'd364: q = 16'h0000;
	9'd365: q = 16'h3B9C;
	9'd366: q = 16'hB4CB;
	9'd367: q = 16'h38B4;
	9'd368: q = 16'hB0D2;
	9'd369: q = 16'h8000;
	9'd370: q = 16'h30D2;
	9'd371: q = 16'hB8B4;
	9'd372: q = 16'h34CB;
	9'd373: q = 16'hBB9C;
	9'd374: q = 16'h8000;
	9'd375: q = 16'hBB9C;
	9'd376: q = 16'hBC9D;
	9'd377: q = 16'hB8B4;
	9'd378: q = 16'hC601;
	9'd379: q = 16'h8000;
	9'd380: q = 16'h4601;
	9'd381: q = 16'h38B4;
	9'd382: q = 16'h3C9D;
	9'd383: q = 16'h3B9C;
	9'd384: q = 16'h8000;
	9'd385: q = 16'h3B9C;
	9'd386: q = 16'hB4CB;
	9'd387: q = 16'h38B4;
	9'd388: q = 16'hB0D2;
	9'd389: q = 16'h0000;
	9'd390: q = 16'h30D2;
	9'd391: q = 16'hB8B4;
	9'd392: q = 16'h34CB;
	9'd393: q = 16'hBB9C;
	9'd394: q = 16'h8000;
	9'd395: q = 16'hBB9C;
	9'd396: q = 16'hBC9D;
	9'd397: q = 16'hB8B4;
	9'd398: q = 16'hC601;
	9'd399: q = 16'h8000;
	9'd400: q = 16'h4601;
	9'd401: q = 16'h38B4;
	9'd402: q = 16'h3C9D;
	9'd403: q = 16'h3B9C;
	9'd404: q = 16'h8000;
	9'd405: q = 16'h3B9C;
	9'd406: q = 16'hB4CB;
	9'd407: q = 16'h38B4;
	9'd408: q = 16'hB0D2;
	9'd409: q = 16'h8000;
	9'd410: q = 16'h30D2;
	9'd411: q = 16'hB8B4;
	9'd412: q = 16'h34CB;
	9'd413: q = 16'hBB9C;
	9'd414: q = 16'h0000;
	9'd415: q = 16'hBB9C;
	9'd416: q = 16'hBC9D;
	9'd417: q = 16'hB8B4;
	9'd418: q = 16'hC601;
	9'd419: q = 16'h0000;
	9'd420: q = 16'h4601;
	9'd421: q = 16'h38B4;
	9'd422: q = 16'h3C9D;
	9'd423: q = 16'h3B9C;
	9'd424: q = 16'h8000;
	9'd425: q = 16'h3B9C;
	9'd426: q = 16'hB4CB;
	9'd427: q = 16'h38B4;
	9'd428: q = 16'hB0D2;
	9'd429: q = 16'h8000;
	9'd430: q = 16'h30D2;
	9'd431: q = 16'hB8B4;
	9'd432: q = 16'h34CB;
	9'd433: q = 16'hBB9C;
	9'd434: q = 16'h8000;
	9'd435: q = 16'hBB9C;
	9'd436: q = 16'hBC9D;
	9'd437: q = 16'hB8B4;
	9'd438: q = 16'hC601;
	9'd439: q = 16'h0000;
	9'd440: q = 16'h4601;
	9'd441: q = 16'h38B4;
	9'd442: q = 16'h3C9D;
	9'd443: q = 16'h3B9C;
	9'd444: q = 16'h8000;
	9'd445: q = 16'h3B9C;
	9'd446: q = 16'hB4CB;
	9'd447: q = 16'h38B4;
	9'd448: q = 16'hB0D2;
	9'd449: q = 16'h8000;
	9'd450: q = 16'h30D2;
	9'd451: q = 16'hB8B4;
	9'd452: q = 16'h34CB;
	9'd453: q = 16'hBB9C;
	9'd454: q = 16'h0000;
	9'd455: q = 16'hBB9C;
	9'd456: q = 16'hBC9D;
	9'd457: q = 16'hB8B4;
	9'd458: q = 16'hC601;
	9'd459: q = 16'h8000;
	9'd460: q = 16'h4601;
	9'd461: q = 16'h38B4;
	9'd462: q = 16'h3C9D;
	9'd463: q = 16'h3B9C;
	9'd464: q = 16'h8000;
	9'd465: q = 16'h3B9C;
	9'd466: q = 16'hB4CB;
	9'd467: q = 16'h38B4;
	9'd468: q = 16'hB0D2;
	9'd469: q = 16'h8000;
	9'd470: q = 16'h30D2;
	9'd471: q = 16'hB8B4;
	9'd472: q = 16'h34CB;
	9'd473: q = 16'hBB9C;
	9'd474: q = 16'h8000;
	9'd475: q = 16'hBB9C;
	9'd476: q = 16'hBC9D;
	9'd477: q = 16'hB8B4;
	9'd478: q = 16'hC601;
	9'd479: q = 16'h8000;
	9'd480: q = 16'h4601;
	9'd481: q = 16'h38B4;
	9'd482: q = 16'h3C9D;
	9'd483: q = 16'h3B9C;
	9'd484: q = 16'h8000;
	9'd485: q = 16'h3B9C;
	9'd486: q = 16'hB4CB;
	9'd487: q = 16'h38B4;
	9'd488: q = 16'hB0D2;
	9'd489: q = 16'h8000;
	9'd490: q = 16'h30D2;
	9'd491: q = 16'hB8B4;
	9'd492: q = 16'h34CB;
	9'd493: q = 16'hBB9C;
	9'd494: q = 16'h8000;
	9'd495: q = 16'hBB9C;
	9'd496: q = 16'hBC9D;
	9'd497: q = 16'hB8B4;
	9'd498: q = 16'hC601;
	9'd499: q = 16'h8000;
	9'd500: q = 16'h4601;
	9'd501: q = 16'h38B4;
	9'd502: q = 16'h3C9D;
	9'd503: q = 16'h3B9C;
	9'd504: q = 16'h8000;
	9'd505: q = 16'h3B9C;
	9'd506: q = 16'hB4CB;
	9'd507: q = 16'h38B4;
	9'd508: q = 16'hB0D2;
	9'd509: q = 16'h8000;
	9'd510: q = 16'h30D2;
	9'd511: q = 16'hB8B4;
    endcase
end

endmodule /* data_dmem_fp16 */
/* vim: set ts=4 sw=4 noet */