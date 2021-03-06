def solve s
  r,g=s.split(?,).map &:to_i
  return 1 if r==g
  w=[[r,1]]
  a=0
  until w.empty?
    k,v=*w.pop
    [k*2/3,k/2-10].each{|x|
      next if x<g
      next a+=v if x==g
      i=(0...w.size).bsearch{|j|w[j][0]>=x}
      if !i
        w.push([x,v])
      elsif w[i][0]==x
        w[i][1]+=v
      else
        w.insert(i,[x,v])
      end
    }
  end
  a
end

def test(n,input,expected)
  actual=solve(input).to_s
  puts "#{n}: "+(actual==expected ? "ok":"ng ( #{actual} against #{expected} for #{input} )")
end

# test cases below
test( 0, "123,4", "5" )
test( 1, "1,1", "1" )
test( 2, "2,1", "1" )
test( 3, "3,3", "1" )
test( 4, "19,5", "1" )
test( 5, "69,5", "3" )
test( 6, "88,9", "2" )
test( 7, "1,100", "0" )
test( 8, "100,4", "4" )
test( 9, "101,9", "0" )
test( 10, "456,7", "7" )
test( 11, "567,8", "12" )
test( 12, "756,10", "10" )
test( 13, "789,10", "12" )
test( 14, "896,29", "2" )
test( 15, "7764,6", "664" )
test( 16, "1234,56", "3" )
test( 17, "8563,29", "35" )
test( 18, "12345,67", "10" )
test( 19, "72927,51", "263" )
test( 20, "71441,145", "22" )
test( 21, "123456,78", "397" )
test( 22, "123456,789", "1" )
test( 23, "592741,216", "55" )
test( 24, "913826,584", "81" )
test( 25, "1234567,89", "2293" )
test( 26, "10000000,1", "19383507" )
test( 27, "12345678,9", "3567354" )
test( 28, "6215879,358", "2907" )
test( 29, "12345678,90", "79419" )
test( 30, "5745432,1032", "1287" )
