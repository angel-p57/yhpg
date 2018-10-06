def solve input
  # implement
  Enumerator.new{|y|
    (f=->c,s=0{
      [1,10].each{|d|
        c.each{|b|
          b.step(by:d).with_index.with_object(c.dup){|(t,i),c2|
            c2.delete(t) or break
            c2.empty? ? y<<s+i*i : f[c2,s+i*i] if i>0
          }
        }
      }
    })[input.split(?,).map{|s|s.tr("A-G","0-6").to_i}]
  }.max || ?-
end

def test(n,input,expected)
  actual=solve(input).to_s
  puts "#{n}: "+(actual==expected ? "ok":"ng ( #{actual} against #{expected} for #{input} )")
end

# test cases below
test( 0, "A1,A2,A3,A4,B3,C3,D5,E5", "11" )
test( 1, "A1,B2,C3,D4,E5,F6,G7,A8", "-" )
test( 2, "A3,A5,A4,A6,A7,A1,A2,A8", "49" )
test( 3, "G2,G1,A1,F1,C1,E1,B1,D1", "26" )
test( 4, "E3,G3,D4,F3,D3,C3,B3,A3", "9" )
test( 5, "A1,C1,C2,E3,B1,B2,A2,D3", "9" )
test( 6, "D2,E2,C1,B2,C2,B1,A2,A1", "20" )
test( 7, "C2,B3,B4,A1,A2,B2,B1,C1", "11" )
test( 8, "D1,B1,D3,C3,D2,B2,C1,B3", "4" )
test( 9, "C1,F5,F6,B2,C2,D2,F4,C3", "-" )
test( 10, "D2,A2,C2,E2,F2,B2,C3,C1", "9" )
test( 11, "D6,E7,D8,F7,C7,G7,D7,D5", "-" )
test( 12, "B2,B3,B4,D5,D2,D4,D3,C3", "-" )
test( 13, "C3,D3,B2,B1,E4,E5,D4,C2", "4" )
test( 14, "D3,E4,E2,C1,F4,D2,E3,C2", "4" )
test( 15, "B4,C3,D5,C4,A4,C5,B5,B6", "4" )
test( 16, "E9,D8,D9,D7,F8,F9,E8,E7", "9" )
test( 17, "F9,C9,D7,D9,D8,E7,E9,F8", "-" )
test( 18, "D4,C5,B5,B6,D3,D2,D5,B7", "11" )
test( 19, "B8,D8,D7,A7,A8,D9,C8,A9", "9" )
test( 20, "F3,E3,F7,E5,E6,E4,E7,F6", "11" )
test( 21, "A9,G9,B8,A7,G7,C8,A8,G8", "9" )
test( 22, "G8,G2,G3,G9,G6,G4,G5,G7", "49" )
test( 23, "E9,E1,B9,D1,C9,G9,D9,F9", "26" )
test( 24, "B9,B7,G3,A7,G4,B1,B8,B2", "4" )
test( 25, "A1,B4,B3,A4,A2,B5,A3,A5", "20" )
test( 26, "B3,D3,F3,G2,C3,A3,E3,G3", "26" )
test( 27, "E8,D8,E7,D7,G8,G7,F7,F8", "18" )
test( 28, "D4,B3,E4,A3,C4,E3,D3,C3", "20" )
test( 29, "B7,B5,E4,B6,D4,A4,B4,C4", "20" )
test( 30, "B2,B1,B7,C8,F2,B9,B8,F1", "-" )
test( 31, "C4,C3,C5,E3,E1,E2,E4,C2", "18" )
test( 32, "G1,E1,D1,A1,F1,A2,B1,C1", "26" )
test( 33, "E4,C5,C4,B4,D4,D5,E5,F5", "18" )
test( 34, "D4,G4,A4,F4,C4,A3,E4,B4", "26" )
test( 35, "B3,A9,G4,F4,A8,B4,G8,A3", "-" )
test( 36, "B4,E3,F4,E4,G3,A4,G4,F3", "9" )
test( 37, "E4,B3,E3,C3,A3,G3,F3,A2", "4" )
test( 38, "C5,C4,C6,C8,C1,C2,C7,C3", "49" )
test( 39, "C4,D4,E4,F3,E3,F4,D3,G4", "20" )
test( 40, "F2,F6,F9,F7,F5,F3,F8,F4", "49" )
test( 41, "A9,A3,A8,A2,B9,B8,A7,A1", "9" )
test( 42, "G9,A8,G8,A6,A9,G6,G7,A7", "18" )
test( 43, "B8,C4,D5,D4,C8,D8,E8,B4", "11" )
test( 44, "B1,B2,F6,E4,C1,C2,F4,F5", "4" )
test( 45, "B4,B3,B5,B1,B7,B8,B6,B2", "49" )
test( 46, "G8,A8,G7,A7,F7,G6,A6,F8", "9" )
test( 47, "B7,E7,D7,G7,C7,A7,F7,E8", "11" )
test( 48, "F3,D7,B7,D3,C3,G3,E3,D9", "-" )
test( 49, "B3,A6,C5,A3,A4,A2,B5,A5", "-" )
test( 50, "A8,D6,B8,C8,D7,C7,D8,E8", "4" )
test( 51, "B4,D9,C4,E9,E2,G9,F9,D2", "11" )
test( 52, "B3,G9,A9,G1,A1,F1,F9,A3", "-" )
test( 53, "G1,B1,A2,G2,B2,A1,A4,A3", "11" )
test( 54, "A7,A6,C7,B7,B5,G5,A5,F5", "4" )
test( 55, "D1,D9,D4,E4,E8,B4,F8,F4", "-" )
test( 56, "B4,A8,C8,G8,B7,A3,B3,C7", "-" )
test( 57, "D3,G3,D7,F3,D9,B7,E3,C3", "-" )
test( 58, "B9,B1,F2,B7,B2,C8,F1,B8", "-" )
test( 59, "F6,E4,F4,F5,B1,B2,C1,C2", "4" )
test( 60, "A5,G5,B5,B4,G6,C4,G7,A6", "-" )
test( 61, "C4,G3,F4,B7,A1,G4,D4,D5", "-" )
test( 62, "D7,G2,A4,A3,A7,A5,A6,F7", "-" )
test( 63, "F7,E5,E4,E3,E7,F3,F6,E6", "11" )
test( 64, "C1,E9,D4,G5,A5,C5,C6,B5", "-" )
test( 65, "E4,B6,A4,B4,B7,B5,C4,D4", "20" )
test( 66, "G9,B4,D9,D2,E2,C4,F9,E9", "11" )
test( 67, "B9,B2,B7,B1,G3,A7,B8,G4", "4" )
test( 68, "B2,C1,E7,E6,A2,D2,C2,A1", "-" )
test( 69, "A4,B4,F4,G4,E3,G3,E4,F3", "9" )
test( 70, "A8,D8,D6,D7,C8,B8,E8,C7", "4" )
