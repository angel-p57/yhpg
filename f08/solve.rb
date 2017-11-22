def solve s
  ids=[1,3,5,7,9,8,6,4,2]
  cap=[30]*9
  h={}
  s.each_char{|c|
    if c<?a
      i=(0..8).max_by{|j| cap[j]+(c<?N ? -ids[j] : ids[j]) }
      h[c]=i
      cap[i]-=30
      cap[(i+1)%9]-=10
      cap[(i-1)%9]-=10
    else
      i=h.delete(c.upcase)
      cap[i]+=30
      cap[(i+1)%9]+=10
      cap[(i-1)%9]+=10
    end
  }
  h.each_with_object(?-*9){|(k,v),r| r[v]=k }
end
puts (<<E).split(?\n).map{|s|s=~/..(\d+).*"(.*)", *"(.*)"/;[$1,solve($2)==$3?"ok":"ng"]*?:}
/*0*/ test( "NABETanI", "I-E--T-B-" );
/*1*/ test( "A", "A--------" );
/*2*/ test( "Aa", "---------" );
/*3*/ test( "Z", "----Z----" );
/*4*/ test( "Zz", "---------" );
/*5*/ test( "AaB", "B--------" );
/*6*/ test( "ABa", "-------B-" );
/*7*/ test( "ABCDEFGHI", "AGCEIDHBF" );
/*8*/ test( "OPQRSTUVW", "WSQUOTPVR" );
/*9*/ test( "F", "F--------" );
/*10*/ test( "L", "L--------" );
/*11*/ test( "Mm", "---------" );
/*12*/ test( "JQ", "J---Q----" );
/*13*/ test( "ACP", "A---P--C-" );
/*14*/ test( "GgS", "----S----" );
/*15*/ test( "USLE", "L-E-U-S--" );
/*16*/ test( "XJZY", "J-Y-X-Z--" );
/*17*/ test( "NnJXx", "J--------" );
/*18*/ test( "AJjQa", "----Q----" );
/*19*/ test( "HGThgQ", "----T-Q--" );
/*20*/ test( "NJRErI", "J-E-N--I-" );
/*21*/ test( "ZzWwDYG", "D---Y--G-" );
/*22*/ test( "ZGgKQHM", "K-H-Z-Q-M" );
/*23*/ test( "OZYSAsHP", "A-Y-OPZ-H" );
/*24*/ test( "VNnEISAW", "E-S-VWAI-" );
/*25*/ test( "HhYAKkCOE", "A-O-Y-EC-" );
/*26*/ test( "KAkHJTSWV", "H-JWTSVA-" );
/*27*/ test( "WNTYKHZhMQ", "KMTQWZN-Y" );
/*28*/ test( "YyJHFGfgTh", "J---T----" );
/*29*/ test( "NRWPLBZAOpC", "LBWONZRAC" );
/*30*/ test( "IORiTMXHUCF", "MCTFOURXH" );
/*31*/ test( "AEeHGBEJUNZn", "AZGEUB-HJ" );
/*32*/ test( "GgKGSOsZTLYS", "K-OYZTSGL" );
/*33*/ test( "VZvPOpWPMzHGF", "MGO-W-HFP" );
/*34*/ test( "CMmcUuLTWADFQ", "LFA-TQW-D" );
/*35*/ test( "HUGZMLzlNgTLDd", "H-N-U-MTL" );
/*36*/ test( "CFKEkHeJShUDTf", "C-UTSJ--D" );
/*37*/ test( "QJjGPMAICHKqWcY", "GIMHWKPYA" );
/*38*/ test( "HhIiQCIBiUMZcVv", "--B-QZU-M" );
/*39*/ test( "VMvEmFOPANIBUiVb", "F-PUONAEV" );
/*40*/ test( "EDCJUINdLPVnFpGe", "-VCFUJGLI" );
/*41*/ test( "FGQINTEnLMAlBbPpV", "FMITQAVGE" );
/*42*/ test( "WSVCORUMXsvNBuTtT", "CXBTWRNOM" );
/*43*/ test( "HJTjRVIQAXqDGxCtUh", "-AVCUGRDI" );
/*44*/ test( "ZzHXIEKQYUuBTxLlCq", "HTEYC-KIB" );
/*45*/ test( "RGDCAEBVrgFbTJUePjc", "-T-FUVADP" );
/*46*/ test( "WBIRSALCVvsbwalYBJP", "B-R-YPCIJ" );
/*47*/ test( "HKFZGEPAIphLRarAOaHo", "LHFIZ-GKE" );
/*48*/ test( "WFNwBfbSAXCZzMDJUcKx", "AM-JSUNDK" );
E
