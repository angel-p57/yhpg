def solve input
  # implement
  input.scan(/(['"])((.*?)\1)?|(\w+)|(\/)(\/)?/).each_with_object([""]){|m,r|
    return ?- if m[0]&&!m[1]
    if m[4]&&!m[5]
      return ?- if r[-1].empty?
      r.push("")
    else
      r[-1]+=m[2]||m[3]||m[4]
    end
  }.tap{|e| return ?- if e[-1].empty? }*?,
end

def test(n,input,expected)
  actual=solve(input).to_s
  puts "#{n}: "+(actual==expected ? "ok":"ng ( #{actual} against #{expected} for #{input} )")
end

# test cases below
test( 0, "foo/bar/baz", "foo,bar,baz" )
test( 1, "/foo/bar/baz'/", "-" )
test( 2, "\"", "-" )
test( 3, "'", "-" )
test( 4, "/", "-" )
test( 5, "\"\"", "-" )
test( 6, "''", "-" )
test( 7, "//", "/" )
test( 8, "\"/'", "-" )
test( 9, "'/\"", "-" )
test( 10, "Qux", "Qux" )
test( 11, "Foo/Bar", "Foo,Bar" )
test( 12, "foo\"bar", "-" )
test( 13, "foo'bar", "-" )
test( 14, "/foo/bar", "-" )
test( 15, "Foo//Bar", "Foo/Bar" )
test( 16, "foo/bar/", "-" )
test( 17, "'\"'a'\"'/b", "\"a\",b" )
test( 18, "Foo\"/\"Bar", "Foo/Bar" )
test( 19, "foo\"'\"bar", "foo'bar" )
test( 20, "foo'\"'bar", "foo\"bar" )
test( 21, "foo///bar", "foo/,bar" )
test( 22, "\"Z\"\"tO\"uFM", "ZtOuFM" )
test( 23, "''/foo/bar", "-" )
test( 24, "////'/\"//'", "///\"//" )
test( 25, "File/'I/O'", "File,I/O" )
test( 26, "Foo'//'Bar", "Foo//Bar" )
test( 27, "foo/''/bar", "-" )
test( 28, "foo/bar/\"\"", "-" )
test( 29, "'/////'////", "///////" )
test( 30, "'foo\"\"\"bar'", "foo\"\"\"bar" )
test( 31, "//'int'/V/c", "/int,V,c" )
test( 32, "foo/bar/baz", "foo,bar,baz" )
test( 33, "'H//Sg//zN'/", "-" )
test( 34, "//'//\"/'/'\"'", "///\"/,\"" )
test( 35, "foo//bar/baz", "foo/bar,baz" )
test( 36, "\"\"\"///\"/'/'//", "///,//" )
test( 37, "58\"\"N\"//nIk'd", "-" )
test( 38, "foo\"/\"bar/baz", "foo/bar,baz" )
test( 39, "/////'\"/'/'\"/'", "//,\"/,\"/" )
test( 40, "f\"//J\"/O9o\"//'", "-" )
test( 41, "foo\"//\"bar/baz", "foo//bar,baz" )
test( 42, "foo/bar////baz", "foo,bar//baz" )
test( 43, "\"\"\"'/'//'''/\"//", "'/'//'''//" )
test( 44, "8//'/k///\"3da\"'", "8//k///\"3da\"" )
test( 45, "foo/'/bar/'/baz", "foo,/bar/,baz" )
test( 46, "///''\"//\"\"///\"\"\"", "/,/////" )
test( 47, "//wUJ8KNAk'n0//\"", "-" )
test( 48, "What/is/'\"real\"'", "What,is,\"real\"" )
test( 49, "\"//'/////\"''/'//'", "//'/////,//" )
test( 50, "\"8hKE\"3Fx/4//Hk/J", "8hKE3Fx,4/Hk,J" )
test( 51, "'////''\"'//'/\"///'", "////\"//\"///" )
test( 52, "Ro\"/j''/2u/f/r/\"3n", "Ro/j''/2u/f/r/3n" )
test( 53, "hoge\"//\"fuga//piyo", "hoge//fuga/piyo" )
test( 54, "'foo//bar'//baz/qux", "foo//bar/baz,qux" )
test( 55, "//'//\"'/\"///'\"/''//", "///\",///',/" )
test( 56, "2/L'3'A8p/7//wP49Jb", "2,L3A8p,7/wP49Jb" )
test( 57, "\"foo'\"/\"bar'\"/\"baz'\"", "foo',bar',baz'" )
test( 58, "'//'\"//'///'///''\"//", "////'///'///''/" )
test( 59, "F6vX/q/Zu//5/'/H\"/'w", "F6vX,q,Zu/5,/H\"/w" )
test( 60, "\"foo'bar\"/'hoge\"fuga'", "foo'bar,hoge\"fuga" )
test( 61, "/\"/'//'/\"\"\"''//'/\"'''", "-" )
test( 62, "0gK\"koYUb\"\"S/p''z/\"Et", "0gKkoYUbS/p''z/Et" )
test( 63, "Foo/Bar/\"Hoge'/'Fuga\"", "Foo,Bar,Hoge'/'Fuga" )
