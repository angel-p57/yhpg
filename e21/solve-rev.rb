def solve input
  # implement
  w=input.scan(/\[(\d)\]|(\d)|\/(\d+)/)
  n=w.pop[2].to_i
  x=w.map{|r| [(r[0]||r[1]).to_i,!r[1]] }
  b=x.count(&:last)
  u=n*x.size
  [*0...n].combination(b).select{|c|
    a=c.each_with_object([0]*n){|i,obj| obj[i]=1 }
    xw=x.dup
    bw=b
    i=z=0
    while bw>0
      break if z>u
      r=xw.shift
      if a[i]==1
        break if !r[1]
        bw-=1
        a[i]=0
        z=0
      else
        i=(i+r[0])%n
        xw.push(r)
        z+=1
      end
    end
    bw==0
  }.map{|c| c.each_with_object([0]*n){|i,a| a[i]=1 }*"" }
end

def test(n,input,expected)
  actual=solve(input).to_s
  puts "#{n}: "+(actual.include?(expected) ? "ok ( #{actual} )":"ng ( #{actual} does not include #{expected} for #{input} )")
end

# test cases below
test( 0, "3[2]3/6", "000100")
test( 1, "21[3]/6", "000100")
test( 2, "12[3]/6", "000100")
test( 3, "3[2]1/6", "000100")
test( 4, "3[2]3/6", "000100")
test( 5, "1[1]3/6", "010000")
test( 6, "[3]4[4]3/7", "1000100")
test( 7, "4[4]24/7", "0000100")
test( 8, "[4]41[1]/7", "1000010")
test( 9, "1[1]33[1]/8", "01000001")
test( 10, "[1]12[4][3]/8", "10100001")
test( 11, "2[2][1]12/8", "01001000")
test( 12, "1[2][2][1]34/9", "011100000")
test( 13, "[4]1141[2]/9", "100000010")
test( 14, "[3]33[3][2]2/9", "100000110")
test( 15, "[5]1[3]44[2][3]/10", "0100101001")
test( 16, "3[1][2]23[3][1]/10", "0110110000")
test( 17, "33[5]12[5][2]/10", "0000010011")
test( 18, "13[3]1[4][4][4][1]/11", "00101100110")
test( 19, "[5]3[2]35[1]1[4]/11", "10001010001")
test( 20, "4[1]4[5]342[5]/11", "00001010100")
test( 21, "[5][4]55[2][2][4]33/12", "001111100000")
test( 22, "3[2]415[1][4][4]3/12", "010101000100")
test( 23, "3[2][4][2][4]4[5]4[1]/12", "011001110010")
test( 24, "3555[6]33[6]4[1]/13", "0010010000010")
test( 25, "4[1]32[6]3[3]4[3]4/13", "0001100001001")
test( 26, "2[2]14[3][1][6][4]63/13", "0010011001010")
test( 27, "2[9][9][9]8[2]3[4][8]2[1]8/15", "011010100001110")
test( 28, "[1][2][6]64[1][3]68[3][8]8/15", "111001000011010")
test( 29, "[7][6][5]54[5]8[5]53[8]1/15", "010001110010001")
