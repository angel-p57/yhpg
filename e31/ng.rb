# !! this code does not produce the valid answers
def solve input
  # implement
  b,x,y=input.split(?,).map{|t| b ? t.chars.map{|c| c.to_i(b) } : b=t.to_i }
  #p [b,x,y]
  f=->dnum,llim,ulim{
 #   p ["called",dnum,llim,ulim]
    llim.push(*[0]*(dnum-llim.size))
    ulim.push(*[b-1]*(dnum-ulim.size))
    return 0 if llim[0]>ulim[0]
    return ulim[0]-llim[0]+1 if dnum==1
    return (ulim[0]-llim[0]-1)*2**(dnum-1) + f[dnum,llim,[llim[0]]] + f[dnum,[ulim[0]],ulim] if llim[0]<ulim[0]
    # llim[0]==ulim[0]
    return [0,1].reduce(0){|s,i|
      top=(llim[0]+i)%b
      s+(llim[1]<top ? f[dnum-1,[top],ulim.drop(1)] : llim[1]>top ? 0 : f[dnum-1,llim.drop(1),ulim.drop(1)])
    }
  }
  (x.size..y.size).reduce(0){|s,d|
    llim=d==x.size ? x : [1]
    ulim=d==y.size ? y : []
    s+f[d,llim,ulim]
  }
end

def test(n,input,expected)
  actual=solve(input).to_s
  puts "#{n}: "+(actual==expected ? "ok":"ng ( #{actual} against #{expected} for #{input} )")
end

# test cases below
test( 0, "4,1313,3012", "12" )
test( 1, "10,100,110", "0" )
test( 2, "36,zoo,zyz", "0" )
test( 3, "4,1300000,2222221", "0" )
test( 4, "2,1,1", "1" )
test( 5, "2,1000,1110", "7" )
test( 6, "4,21,132", "8" )
test( 7, "10,28,79", "10" )
test( 8, "36,q,1r", "12" )
test( 9, "28,bjb,g9a", "16" )
test( 10, "20,2i9d,5id4", "24" )
test( 11, "5,12000,24141", "24" )
test( 12, "6,1245,5145", "28" )
test( 13, "36,1,z", "35" )
test( 14, "14,277,dc1", "42" )
test( 15, "35,9iy,l5p", "44" )
test( 16, "17,7be,19b1", "44" )
test( 17, "18,96f,236g", "52" )
test( 18, "23,b1f,1k81", "56" )
test( 19, "6,143424,353115", "64" )
test( 20, "5,3401,40123", "67" )
test( 21, "4,321,123022", "102" )
test( 22, "13,1b0,8a72", "108" )
test( 23, "20,62,339f", "124" )
test( 24, "24,f8h,bcn0", "124" )
test( 25, "31,do3,78no", "124" )
test( 26, "17,727,ced4", "136" )
test( 27, "5,14,222243", "154" )
test( 28, "16,3c5,100bb", "168" )
test( 29, "9,353,80016", "200" )
test( 30, "21,h7d,34504", "220" )
test( 31, "11,20a,78926", "224" )
test( 32, "12,b0,77996", "238" )
test( 33, "3,212,11112012", "254" )
test( 34, "22,6f2,789hd", "340" )
test( 35, "36,5l6,tvmw", "352" )
test( 36, "25,db8,99b08", "376" )
test( 37, "32,hpi,556a7", "376" )
test( 38, "29,1cl,456d2", "396" )
test( 39, "34,dli,455u7", "404" )
test( 40, "15,ced,3345c1", "424" )
test( 41, "30,601,7780o", "428" )
test( 42, "3,22,22000021", "445" )
test( 43, "5,440,4012303", "446" )
test( 44, "27,hg,aaamk", "480" )
test( 45, "33,suv,defn7", "480" )
test( 46, "2,11,111101110", "492" )
test( 47, "35,60e,9aamd", "528" )
test( 48, "7,33,3445635", "542" )
test( 49, "4,120,22330013", "550" )
test( 50, "23,8fk,lm066", "564" )
test( 51, "6,142,5001252", "568" )
test( 52, "8,111,3344567", "572" )
test( 53, "26,4na,klmib", "600" )
test( 54, "19,32a,6678g3", "672" )
test( 55, "7,605,6011223", "680" )
test( 56, "6,15,11235050", "692" )
test( 57, "9,664,5567833", "746" )
test( 58, "10,909,4556846", "746" )
test( 59, "10,991,5555766", "769" )
test( 60, "8,757,7700001", "812" )
test( 61, "36,6pku,27wr28", "856" )
test( 62, "35,6n89a,j1dlik", "1024" )
test( 63, "34,7gehm,m0anuo", "1088" )
test( 64, "10,3268665,134217728", "1856" )
test( 65, "11,571016a,47352388a", "2624" )
test( 66, "4,10030022033,10203020123103", "21504" )
test( 67, "3,22111101011101,11021122211120221", "100352" )
test( 68, "2,101001011010110000110101,110101110001110110110101", "3240321" )
