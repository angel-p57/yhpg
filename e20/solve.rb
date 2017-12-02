Walls=->hnodes,vnodes{
  masks=[0]*36
  (hnodes.map{|s|s.to_i(36)}+(0..6).map{|i|i*6-1}).each{|i|
    masks[i]|=1 if i>=0
    masks[i+1]|=4 if i+1<36
  }
  (vnodes.map{|s|s.to_i(36)}+[*-6..-1,*30..35]).each{|i|
    masks[i]|=2 if i>=0
    masks[i+6]|=8 if i+6<36
  }
  masks
}[%W(1 6 A D E G I M O R W X),%W(2 4 7 8 A B D F K L O Q T)]
def solve input
  # implement
  s,g=input.chars.map{|s|s.to_i(36)}
  q=[[s,0,nil]]
  c=0
  until q.empty?
    v,x,b=q.shift
    return x if v==g
    4.times{|d|
      next if b&&(d-b).abs==2||Walls[v][d]>0
      q.push([v+[1,6,-1,-6][d],x+1,d])
    }
  end
end

def test(n,input,expected)
  actual=solve(input).to_s
  puts "#{n}: "+(actual==expected ? "ok":"ng ( #{actual} against #{expected} for #{input} )")
end

# test cases below
test( 0, "DE", "13" )
test( 1, "EK", "1" )
test( 2, "01", "1" )
test( 3, "LG", "2" )
test( 4, "A1", "4" )
test( 5, "GJ", "4" )
test( 6, "FK", "4" )
test( 7, "LV", "4" )
test( 8, "27", "4" )
test( 9, "0O", "4" )
test( 10, "G1", "5" )
test( 11, "ZH", "5" )
test( 12, "AB", "5" )
test( 13, "KX", "5" )
test( 14, "1G", "5" )
test( 15, "WX", "5" )
test( 16, "3L", "5" )
test( 17, "9Y", "5" )
test( 18, "EX", "6" )
test( 19, "BG", "6" )
test( 20, "7K", "7" )
test( 21, "E3", "7" )
test( 22, "SW", "7" )
test( 23, "BM", "7" )
test( 24, "3C", "7" )
test( 25, "H9", "7" )
test( 26, "J3", "7" )
test( 27, "GX", "8" )
test( 28, "2Z", "8" )
test( 29, "8H", "8" )
test( 30, "Z7", "8" )
test( 31, "0B", "8" )
test( 32, "U9", "9" )
test( 33, "Z0", "10" )
test( 34, "0N", "10" )
test( 35, "U8", "10" )
test( 36, "XZ", "10" )
test( 37, "H0", "11" )
test( 38, "CH", "13" )
test( 39, "WB", "13" )
test( 40, "0R", "13" )
test( 41, "DZ", "13" )
test( 42, "NI", "13" )
test( 43, "QC", "14" )
test( 44, "6U", "14" )
test( 45, "PO", "15" )
test( 46, "RI", "16" )
test( 47, "UO", "17" )
test( 48, "WO", "17" )
test( 49, "OX", "18" )
