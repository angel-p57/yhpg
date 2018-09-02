module Flinear
  N=4
  class Vector
    def initialize(r)
      @r=r.map{|e|e%N}
    end

    def self.[](*r)
      new(r)
    end

    def to_a
      @r
    end

    def size
      @r.size
    end

    def [](i)
      @r[i]
    end

    def -@
      self.class.new(@r.map(&:-@))
    end

    def +(v)
      raise "vector size mismatch" if size!=v.size
      self.class.new(size.times.map{|i|self[i]+v[i]})
    end

    def -(v)
      raise "vector size mismatch" if size!=v.size
      self.class.new(size.times.map{|i|self[i]-v[i]})
    end

    def *(c)
      self.class.new(size.times.map{|i|self[i]*c})
    end
  end

  class Matrix
    def initialize(row,col,r)
      raise "argument mismatch" if r.size!=row*col
      @row,@col,@r=row,col,r.map{|e|e%N}
    end

    def self.[](*rr)
      row=rr.size
      col=rr[0].size
      new(row,col,rr.flatten)
    end

    def self.e(n)
      new(n,n,(n*n).times.map{|i| i%(n+1)==0 ? 1 : 0 })
    end

    def size
      row*col
    end

    def at(i)
      @r[i]
    end

    def [](r,c)
      at(r*col+c)
    end

    def to_a
      @r
    end

    def -@
      self.class.new(@row,@col,(-Vector[*@r]).to_a)
    end

    def +(m)
      raise "matirx size mismatch" if @row!=m.row||@col!=m.col
      self.class.new(@row,@col,(Vector[*@r]+Vector[*m.to_a]).to_a)
    end

    def -(m)
      raise "matirx size mismatch" if @row!=m.row||@col!=m.col
      self.class.new(@row,@col,(Vector[*@r]-Vector[*m.to_a]).to_a)
    end

    def muls(c)
      self.class.new(@row,@col,(Vector[*@r]*c).to_a)
    end

    def mulv(v)
      raise "matrix-vector size mismatch" if @col!=v.size
      Vector[*@row.times.map{|i|@col.times.reduce(0){|s,j|s+self[i,j]*v[j]}}]
    end

    def mulm(m)
      raise "matrix-matrix size mismatch" if @col!=m.row
      self.class.new(@row,m.col,@row.times.flat_map{|i|m.col.times.map{|j|@col.times.reduce(0){|s,k|s+self[i,k]*m[k,j]}}})
    end

    def *(arg)
      case arg
      when Flinear::Vector; mulv(arg)
      when Flinear::Matrix; mulm(arg)
      else;                 muls(arg)
      end
    end

    def rowvec(r)
      Vector[*@r[r*@col,@col]]
    end

    def exrow(r1,r2)
      r1==r2 ?
        self :
        self.class.new(@row,@col,@row.times.flat_map{|i|
          s = i==r1 ? r2 : i==r2 ? r1 : i
          @r[s*@col,@col]
        })
    end

    def subrow(r,cs)
      base=rowvec(r)
      self.class.new(@row,@col,@row.times.flat_map{|i|
        c=cs[i]
        ( i==r ?  base*c : rowvec(i)-base*c ).to_a
      })
    end
    attr_reader :row,:col
  end
end

def gauss(n)
  a=Flinear::Matrix[*n.times.map{|i|
    n.times.map{|j| ( (i-j).abs<=>1 )%3-1 }
  }]
  t0=e=Flinear::Matrix.e(n)
  t1=a
  (n-1).times{t0,t1=t1,t1*a-t0}
  m1,m2=t1,e
  n.times{|i|
    if rbase=(i...n).find{|j| m1[j,i].odd? }
      m1,m2=m1.exrow(i,rbase),m2.exrow(i,rbase)
      c=m1[i,i]
      cs=n.times.map{|j| i==j ? c : m1[j,i]*c }
      m1,m2=m1.subrow(i,cs),m2.subrow(i,cs)
    elsif rbase=(i...n).find{|j| m1[j,i]==2 } 
      m1,m2=m1.exrow(i,rbase),m2.exrow(i,rbase)
      cs=n.times.map{|j| m1[j,i]/2 }
      m1,m2=m1.subrow(i,cs),m2.subrow(i,cs)
    end
  }
  [a,m1,m2]
end

$mats=[]
def test(n,r)
  p xs
end

def solve input
  # implement
  n,*r=input.split /\W/
  n=n.to_i

  a,m1,m2=$mats[n]||=gauss(n)
  vs=r.map{|s| Flinear::Vector[*s.chars.map{|c|5-c.to_i}] }
  u0,u1=Flinear::Vector[*[0]*n],vs[0]
  us=[*(1...n).map{|i| u0,u1=u1,a*u1-u0+vs[i]; u0 }]
  t=(m2*u1).to_a
  (n-1).downto(0){|i|
    c=m1[i,i]
    if c==0
      t[i]=0
      next
    end
    if c==2
      raise if t[i].odd?
      t[i]/=2
    end
    z=t[i]
    (0...i).each{|j|
      t[j]-=m1[j,i]*z
    }
  }
  x0=Flinear::Vector[*t]
  counts=[x0.to_a,(x1=a*x0-vs[0]).to_a,*(1..n-2).map{|i|x0,x1=x1,a*x1-x0-vs[i];x1.to_a}].flatten

  (0...n*n).flat_map{|i|
    next [] if counts[i]==0
    y,x=i.divmod(n)
    ["#{x+1},#{y+1}"]*counts[i]
  }*?|
end

def test(n,input)
  actual=solve(input).to_s
  puts "#{n} #{actual}"
end

$<.each{|s|
  m=s.match(/(\d+).*"(.*)"/) or next
  n,arg=m[1].to_i,m[2]
  test(n,arg)
}
