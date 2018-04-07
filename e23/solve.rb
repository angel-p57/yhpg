def solve input
  # implement
  n,s=input.split(?,)
  a,n=0,n.to_i-1
  s.reverse.chars{|c|
    b=c.ord-93
    n,r=n.divmod(b)
    r=(r+1)%(b-1)-1
    a+=r if r.abs==1
  }
  n>0 ? ?x : "0+-"[a%3]
end

def test(n,input,expected)
  actual=solve(input).to_s
  puts "#{n}: "+(actual==expected ? "ok":"ng ( #{actual} against #{expected} for #{input} )")
end

# test cases below
test( 0, "120,aabb", "0" )
test( 1, "100,a", "x" )
test( 2, "3,a", "-" )
test( 3, "3,b", "0" )
test( 4, "9,aa", "-" )
test( 5, "10,bb", "+" )
test( 6, "11,ab", "-" )
test( 7, "12,ba", "0" )
test( 8, "7,aaa", "0" )
test( 9, "17,baa", "+" )
test( 10, "28,bba", "-" )
test( 11, "82,bba", "+" )
test( 12, "35,baa", "-" )
test( 13, "254,babb", "+" )
test( 14, "462,abba", "x" )
test( 15, "226,bbba", "0" )
test( 16, "345,bbba", "0" )
test( 17, "256,aaaa", "0" )
test( 18, "11,aaab", "-" )
test( 19, "241,abaab", "-" )
test( 20, "490,aabaa", "0" )
test( 21, "1305,bbbaa", "0" )
test( 22, "1102,ababa", "-" )
test( 23, "1077,abbab", "-" )
test( 24, "281,aabaa", "-" )
test( 25, "2218,abbaaa", "+" )
test( 26, "4095,bbabbb", "+" )
test( 27, "2750,abbaab", "+" )
test( 28, "5573,bbaaba", "+" )
test( 29, "6644,aaabba", "x" )
test( 30, "8109,bbbbba", "+" )
test( 31, "3860,aaaabbb", "+" )
test( 32, "59222,bbbbbba", "0" )
test( 33, "14956,baabbab", "-" )
test( 34, "14894,ababbba", "+" )
test( 35, "3163,aaaaaab", "-" )
test( 36, "21917,babaaaa", "+" )
test( 37, "178620,aabbbaab", "x" )
test( 38, "96709,babbaaaa", "0" )
test( 39, "74116,abababaa", "-" )
test( 40, "22025,abbbbabb", "0" )
test( 41, "8612,aaaabbaa", "-" )
test( 42, "153868,bbbabbab", "-" )
test( 43, "747769,abbabaaba", "x" )
test( 44, "541589,baabbbbab", "-" )
test( 45, "787443,ababbbbab", "-" )
test( 46, "129549,ababaaaaa", "0" )
test( 47, "837323,aabbbabab", "x" )
test( 48, "140592,bbbbabbab", "+" )
test( 49, "219669,ababbabbab", "-" )
test( 50, "500261,bbababaabb", "-" )
test( 51, "966503,aaabababbb", "0" )
test( 52, "443603,baabaababb", "+" )
test( 53, "3912,aabbababaa", "0" )
test( 54, "2926358,bbabbbbaba", "0" )
test( 55, "18104279,bbbaababbab", "-" )
test( 56, "3849980,aaabaaaaaba", "0" )
test( 57, "9276072,baabaabaaab", "0" )
test( 58, "11202113,baaaaabbbba", "0" )
test( 59, "5432578,abaabbaaaaa", "-" )
test( 60, "17363025,bbaabababbb", "0" )
test( 61, "24147656,baabaabbbbab", "0" )
test( 62, "1078733,bbbaaaabbbbb", "+" )
test( 63, "38623426,abaabababbaa", "-" )
test( 64, "19312285,bbaababbaaba", "+" )
test( 65, "11485959,baaaaababaaa", "-" )
test( 66, "36831104,babbbbbbabab", "+" )
