def solve input
  (?0+(input.to_i+1).to_s(2)).sub(/(.*?)(0111|1000)(.*)/){n=$3.size;$1+"1001"+"001"*(n/3)+?0*(n%3)}.to_i(2)
end

def test(n,input,expected)
  actual=solve(input).to_s
  puts "#{n}: "+(actual==expected ? "ok":"ng ( #{actual} against #{expected} for #{input} )")
end

# test cases below
test( 0, "1441", "1444" )
test( 1, "1", "2" )
test( 2, "2", "3" )
test( 3, "3", "4" )
test( 4, "7", "9" )
test( 5, "43690", "43691" )
test( 6, "349525", "349526" )
test( 7, "209715", "209716" )
test( 8, "209919", "210066" )
test( 9, "209664", "209700" )
test( 10, "65536", "74898" )
test( 11, "1048575", "1198372" )
test( 12, "14", "18" )
test( 13, "13", "18" )
test( 14, "27", "36" )
test( 15, "44", "45" )
test( 16, "136", "146" )
test( 17, "383", "402" )
test( 18, "649", "658" )
test( 19, "1227", "1228" )
test( 20, "2693", "2706" )
test( 21, "4943", "4946" )
test( 22, "9152", "9362" )
test( 23, "8336", "9362" )
test( 24, "36993", "37449" )
test( 25, "81868", "84260" )
test( 26, "73287", "74898" )
test( 27, "305901", "305956" )
test( 28, "555516", "599186" )
test( 29, "691590", "692809" )
test( 30, "3112217", "3295524" )
test( 31, "5235890", "5392676" )
test( 32, "6804756", "6890642" )
test( 33, "13653246", "13781284" )
test( 34, "20099429", "20099657" )
test( 35, "107304545", "107304548" )
test( 36, "227978622", "227978642" )
test( 37, "380810157", "380810386" )
test( 38, "268435455", "306783378" )
test( 39, "536870912", "613566756" )
test( 40, "1072693248", "1227133513" )
