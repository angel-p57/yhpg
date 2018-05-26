def solve input
  # implement
  b,n=input.split(?,).map &:to_i
  t=1
  1.upto(b-1){|d|
    t=t*(b-d)/d
    next n-=t if n>t
    return (f=->s,d,n{
      return (s+n-1).to_s(b) if d<2
      w=(1...d).reduce(1){|c,i| c*(b-s-i)/i }
      s.upto(b-1){|m|
        return m.to_s(b)+f[m+1,d-1,n] if n<=w
        n-=w
        w=w*(b-m-d)/(b-m-1)
      }
    })[1,d,n]
  }
  ?-
end

def test(n,input,expected)
  actual=solve(input).to_s
  puts "#{n}: "+(actual==expected ? "ok":"ng ( #{actual} against #{expected} for #{input} )")
end

# test cases below
test( 0, "16,333", "38e" )
test( 1, "2,100", "-" )
test( 2, "2,1", "1" )
test( 3, "2,2", "-" )
test( 4, "11,8", "8" )
test( 5, "14,9", "9" )
test( 6, "11,12", "13" )
test( 7, "7,16", "34" )
test( 8, "20,16", "g" )
test( 9, "2,17", "-" )
test( 10, "8,26", "56" )
test( 11, "16,51", "3c" )
test( 12, "3,77", "-" )
test( 13, "2,100", "-" )
test( 14, "9,110", "1347" )
test( 15, "22,127", "78" )
test( 16, "24,142", "79" )
test( 17, "30,158", "5s" )
test( 18, "20,213", "139" )
test( 19, "6,216", "-" )
test( 20, "9,244", "235678" )
test( 21, "13,253", "57c" )
test( 22, "19,265", "19c" )
test( 23, "24,314", "13k" )
test( 24, "16,333", "38e" )
test( 25, "32,353", "eo" )
test( 26, "25,490", "1dg" )
test( 27, "26,498", "1bd" )
test( 28, "10,500", "2456789" )
test( 29, "10,543", "-" )
test( 30, "3,897", "-" )
test( 31, "11,1000", "1345789a" )
test( 32, "9,1307", "-" )
test( 33, "9,1412", "-" )
test( 34, "26,1678", "79e" )
test( 35, "8,1942", "-" )
test( 36, "12,1950", "234589ab" )
test( 37, "2,2245", "-" )
test( 38, "18,2670", "5ace" )
test( 39, "5,3013", "-" )
test( 40, "5,3048", "-" )
test( 41, "14,3099", "157acd" )
test( 42, "27,3440", "13hm" )
test( 43, "13,3698", "235689ab" )
test( 44, "36,5592", "dqs" )
test( 45, "10,9505", "-" )
test( 46, "27,9833", "49ej" )
test( 47, "16,10000", "123467e" )
test( 48, "24,14090", "14bfk" )
test( 49, "29,15270", "5mnq" )
test( 50, "17,20000", "23458cg" )
test( 51, "36,20000", "37bc" )
test( 52, "25,24346", "256bk" )
test( 53, "21,27815", "146adi" )
test( 54, "25,28030", "2aflm" )
test( 55, "25,34448", "3cefi" )
test( 56, "36,44811", "abpu" )
