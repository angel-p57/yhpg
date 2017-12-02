NODES=[
  "11000", # 0
  "1100", # 1
  "121", # 2
  "12", # 3
  "120", # 4
  "1200", # 5
  "110000", # 6
  "110", # 7
  "11", # 8
  "1", # 9
  "10", # A
  "12000", # B
  "1100000", # C
  "11000000", # D
  "00101", # E
  "", # F
  "0", # G
  "000000", # H
  "11000001", # I
  "00100", # J
  "0010", # K
  "001", # L
  "00", # M
  "00000", # N
  "110000010", # O
  "001000", # P
  "0010000", # Q
  "00100000", # R
  "000", # S
  "0000", # T
  "00100011", # U
  "0010001", # V
  "00100010", # W
  "001000000", # X
  "0001", # Y
  "00010", # Z
]
def solve input
  # implement
  s,g=input.chars.map{|s|NODES[s.to_i(36)]}
  s.size+g.size-(0..36).find{|i|s[i]!=g[i]}*2
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
