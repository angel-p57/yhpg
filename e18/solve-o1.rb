def s_tri n
  n*(n+1)/2
end
def s_tri2 n
  (n+1)**2/4
end
def s_fwd base,x,y,h
  x,h=0,h+x if x<0
  y,h=0,h+y if y<0
  h=[h,base-x-y].min
  h<0 ? 0 : s_tri(h)
end
def s_rev base,x,y,h
  y,h=base-1,h-y+base-1 if y>=base
  h=[h,x+y+1].min
  return 0 if x<0||h<=0
  a=s_tri(h)
  a-=s_tri(h-x-1) if h>x+1
  a-=s_tri(h-y-1) if h>y+1
  a-=s_tri(x+y-base+1) if x+y>=base
  a
end
def s_crs base,x,y,h
  y,h=0,h+y if y<0
  d=x+y-base
  x,h=x-d-1,h-d-1 if d>=0
  h=x-y+base if y+h>x+base
  return 0 if x<0||h<=0
  a=s_tri(h)
  a-=s_tri(h-x-1) if h>x+1
  a-=s_tri2(x+y+h-base) if x+y+h>base
  a
end
def solve input
  # implement
  tris=input.split(?/).map{|tok|
    tok=~/(\d+),(\d+)([RLTB])(\d+)/
    [Complex($1,$2),1i**"LTRB".index($3),$4.to_i]
  }.sort_by(&:last)
  h_base=tris[1][2]
  top=(tris[0][0]-tris[1][0])*tris[1][1].conj
  dir=tris[0][1]*tris[1][1].conj
  h=tris[0][2]
  x=top.real
  case dir
  when  1
    y=top.imag.abs
    (x-y).even? ?
      s_fwd(h_base,(x-y)/2,(x+y)/2,h)+s_fwd(h_base-1,(x-y)/2,(x+y)/2,h-1) :
      s_fwd(h_base,(x-y+1)/2,(x+y+1)/2,h-1)+s_fwd(h_base-1,(x-y-1)/2,(x+y-1)/2,h)
  when -1
    y=top.imag.abs
    (x-y).even? ?
      s_rev(h_base,(x-y)/2,(x+y)/2,h)+s_rev(h_base-1,(x-y)/2-1,(x+y)/2-1,h-1) :
      s_rev(h_base,(x-y-1)/2,(x+y-1)/2,h-1)+s_rev(h_base-1,(x-y-1)/2,(x+y-1)/2,h)
  else
    y=(top.imag*dir).imag
    (x-y).even? ?
      s_crs(h_base,(x-y)/2,(x+y)/2,h)+s_crs(h_base-1,(x-y)/2-1,(x+y)/2,h-1) :
      s_crs(h_base,(x-y-1)/2,(x+y+1)/2,h-1)+s_crs(h_base-1,(x-y-1)/2,(x+y-1)/2,h)
  end
end

def test(n,input,expected)
  actual=solve(input).to_s
  puts "#{n}: "+(actual==expected ? "ok":"ng ( #{actual} against #{expected} for #{input} )")
end

# test cases below
test( 0, "7,0R6/3,1B5", "15" )
test( 1, "1,6L4/4,9R9", "4" )
test( 2, "0,2R4/1,3B4", "3" )
test( 3, "1,2L4/1,2L5", "16" )
test( 4, "3,2L5/5,6B4", "8" )
test( 5, "4,1B3/6,3B4", "4" )
test( 6, "4,4R7/4,3R5", "20" )
test( 7, "4,5R9/0,7T3", "7" )
test( 8, "4,7T9/1,6T3", "1" )
test( 9, "4,8B7/3,7L4", "10" )
test( 10, "5,3L3/9,8L4", "0" )
test( 11, "5,6B4/4,4R2", "3" )
test( 12, "5,6B4/8,5R4", "8" )
test( 13, "5,8B9/5,2L2", "4" )
test( 14, "6,1L5/7,1T2", "3" )
test( 15, "7,2B4/7,2T4", "1" )
test( 16, "7,3T9/9,6L6", "11" )
test( 17, "8,0R6/8,1R7", "30" )
test( 18, "0,4R7/4,6R10", "36" )
test( 19, "10,4L4/9,1T6", "9" )
test( 20, "2,2T7/6,7T10", "4" )
test( 21, "2,7R4/1,6L8 ", "2" )
test( 22, "3,0R10/1,2T7", "7" )
test( 23, "3,5T2/3,6B10", "2" )
test( 24, "4,7R10/8,2T8", "6" )
test( 25, "6,8B10/4,5B6", "36" )
test( 26, "9,2B7/1,1B10", "6" )
test( 27, "9,3R14/2,4R1", "1" )
test( 28, "3,0R10/0,6B10", "54" )
test( 29, "4,10T8/4,10T8", "64" )
test( 30, "1,5T10/1,20B10", "56" )
test( 31, "15,16L4/5,12L12", "4" )
test( 32, "12,11T18/7,18R18", "34" )
test( 33, "15,16T14/5,12L15", "44" )
test( 34, "5,10L40/22,22B10", "100" )
test( 35, "46,34T34/34,29T14", "30" )
test( 36, "52,75L12/88,69T54", "0" )
test( 37, "67,83B70/99,48T14", "52" )
test( 38, "291,11T120/258,54B130", "424" )
test( 39, "62,170L139/133,172R21", "441" )
test( 40, "98,189B116/183,127R27", "240" )
test( 41, "646,684B96/435,690R772", "0" )
test( 42, "113,668L866/581,859L852", "158404" )
test( 43, "309,321B162/137,420B423", "15750" )
test( 44, "5474,6459R9089/8177,150R5120", "376996" )
test( 45, "2399,1640B2451/1718,2100L1623", "221334" )
test( 46, "5621,8460T7612/2715,5697L8851", "861192" )
