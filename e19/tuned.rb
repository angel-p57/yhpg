def solve input
  # implement
  n=input.size/2
  masks=input.split(?,).map{|s|s.reverse.tr("xo","01").to_i(2)}
  a,b1,b2=[],[],[]
  (f=->i=0,m=1,full=true{
    if i==n
      b2s=b2.size
      m.upto(n){|k|
        if full||k!=m
          b2.push(k,k)
        else
          b2.push(k)
        end
      }
      a.push((b1+b2)*?,) if b2.each_with_index.all?{|e,k| b2[k]&1==masks[1][k] }
      b2.pop(b2.size-b2s)
    else
      m.upto(n){|j|
        next unless j&1==masks[0][i]
        b2s=b2.size
        m.upto(j-1){|k|
          if full||k!=m
            b2.push(k,k)
          else
            b2.push(k)
          end
        }
        if b2.each_with_index.all?{|e,k| b2[k]&1==masks[1][k] }
          b1.push(j)
          if full||j!=m
            f[i+1,j,false]
          else
            f[i+1,j+1,true]
          end
          b1.pop
        end
        b2.pop(b2.size-b2s)
      }
    end
  })[]
  a*?|
end

def test(n,input,expected)
  actual=solve(input).to_s
  puts "#{n}: "+(actual==expected ? "ok":"ng ( #{actual} against #{expected} for #{input} )")
end

# test cases below
test( 0, "xxoxo,oooxo", "2,2,3,4,5,1,1,3,4,5")
test( 1, "ooxxo,ooxxo", "1,1,2,2,5,3,3,4,4,5|3,3,4,4,5,1,1,2,2,5")
test( 2, "oxoxo,oxoxo", "1,2,3,4,5,1,2,3,4,5")
test( 3, "ooxoxx,oxxoxo", "1,3,4,5,6,6,1,2,2,3,4,5")
test( 4, "ooxxxx,ooxxoo", "1,1,2,2,6,6,3,3,4,4,5,5|3,3,4,4,6,6,1,1,2,2,5,5")
test( 5, "oxoxox,oxoxox", "1,2,3,4,5,6,1,2,3,4,5,6")
test( 6, "oxoxxxo,oxoxooo", "1,2,3,4,6,6,7,1,2,3,4,5,5,7")
test( 7, "oxooxxx,oxxoooo", "1,2,3,3,4,6,6,1,2,4,5,5,7,7")
test( 8, "oxoxxxo,oxoooxo", "1,2,3,4,4,6,7,1,2,3,5,5,6,7")
test( 9, "oxoxooox,oxoxoxxx", "1,2,3,4,5,7,7,8,1,2,3,4,5,6,6,8")
test( 10, "ooxoxxox,ooxxxoox", "3,3,4,5,6,6,7,8,1,1,2,2,4,5,7,8")
test( 11, "oxoxxxxx,oxoxoooo", "1,2,3,4,6,6,8,8,1,2,3,4,5,5,7,7")
test( 12, "oxoxooxxo,oxooxxoxo", "1,2,5,6,7,7,8,8,9,1,2,3,3,4,4,5,6,9")
test( 13, "oxoooooxo,oxxxoxxxo", "1,2,3,3,5,7,7,8,9,1,2,4,4,5,6,6,8,9")
test( 14, "oxoxoxxox,oxoxooxoo", "1,2,3,4,5,6,6,7,8,1,2,3,4,5,7,8,9,9")
test( 15, "oooxxxxoxo,xxooooxoxx", "1,1,3,4,4,6,6,7,8,9,2,2,3,5,5,7,8,9,10,10")
test( 16, "ooooxxxoxx,xxooxxxooo", "1,1,5,5,6,8,8,9,10,10,2,2,3,3,4,4,6,7,7,9")
test( 17, "xoxxoxxoxo,ooxoooxoxx", "2,3,4,4,5,6,6,7,8,9,1,1,2,3,5,7,8,9,10,10")
test( 18, "oxooxxoooxo,oxxxoxooxxo", "1,2,3,3,4,4,5,5,7,8,11,1,2,6,6,7,8,9,9,10,10,11")
test( 19, "oooxxxxoxoo,xxooooxooxx", "1,1,3,4,4,6,6,7,8,11,11,2,2,3,5,5,7,8,9,9,10,10")
test( 20, "ooooxxoxoxo,oxxxxooxoxo", "1,3,3,5,6,6,7,8,9,10,11,1,2,2,4,4,5,7,8,9,10,11")
test( 21, "ooooxoxooxox,xxoxxoxoxxox", "1,1,3,5,6,7,8,9,9,10,11,12,2,2,3,4,4,5,6,7,8,10,11,12")
test( 22, "ooxxoooooxox,ooxxoxxxxxox", "1,1,2,2,5,7,7,9,9,10,11,12,3,3,4,4,5,6,6,8,8,10,11,12|3,3,4,4,5,7,7,9,9,10,11,12,1,1,2,2,5,6,6,8,8,10,11,12")
test( 23, "xoxoxxooxoxx,ooxoxoxooxxo", "2,3,4,5,6,6,7,7,8,11,12,12,1,1,2,3,4,5,8,9,9,10,10,11|2,3,4,5,6,8,9,9,10,11,12,12,1,1,2,3,4,5,6,7,7,8,10,11")
test( 24, "oooooooooooo,xxxxxxxxxxxx", "1,1,3,3,5,5,7,7,9,9,11,11,2,2,4,4,6,6,8,8,10,10,12,12")
