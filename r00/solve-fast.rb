# オフラインリアルタイムどう書く問題作成リハビリ #0
# see: https://qiita.com/Nabetani/items/03f983f0835b928a9524
#      https://nabetani.github.io/q/pages/r0/
require 'json'

# xy平面上の点を扱うクラス
# x: 右上方向、y: 左上方向
Vertex = Struct.new(:x,:y)
  

# x/y軸に平行な線分を表すクラス
# x=5,1≦y≦3 あるいは 1≦x≦3,y=5 をともに (p=5,s=1,e=3) として扱う
Line = Struct.new(:p, :s, :e)

# 正方形の位置情報を扱うクラス
Square = Struct.new(:v,:w) do
  # v: 下の頂点を表すVertex、w: 一辺の長さ
  
  include Comparable
  # 問題の優先順位 ( 下→左の順に優先 ) に合わせた頂点の比較
  def <=>(sq)
    c = v.x+v.y <=> sq.v.x+sq.v.y
    c==0 ? v.x <=> sq.v.x : c
  end

  # 正方形同士の位置関係の判定
  def pos(sq)
    # -1: intersect, 0: tangent, 1: far 
    rhx = (v.x<=>sq.v.x+sq.w)*(v.x+w<=>sq.v.x)
    rhy = (v.y<=>sq.v.y+sq.w)*(v.y+w<=>sq.v.y)
    rhx==-1 ? rhy : rhy==-1 ? rhx : 1
  end

  # 幅ゼロかどうかの判定
  def zero?
    w==0
  end

  # 既存の正方形に被らないように作れる正方形の辺の長さの上限
  # 正方形が作れない場合は 0、無制限の場合は Infinity
  def wlimit(vn)
    xlim,ylim = *[[vn.x,v.x],[vn.y,v.y]].map{|(t,b)|
      t<b ? b-t : t<b+w ? 0 : Float::INFINITY
    }
    [xlim,ylim].max
  end
end

# ソート済みの2配列のマージ 
def merge(sa1,sa2)
  i1=i2=0
  x1,x2=sa1[0],sa2[0]
  ma=[]
  until x1.nil? && x2.nil?
    if x1.nil? || !x2.nil? && x2<x1
      ma.push(x2)
      x2=sa2[i2+=1]
    else
      ma.push(x1)
      x1=sa1[i1+=1]
    end
  end
  ma
end

# ソルバー本体
def solve(src)
  # 頂点候補を作るための線分のリスト
  # vlsがy軸方向の線分用 ( p:x座標の降順にソート )
  # hlsがx軸方向の線分用 ( p:y座標の降順にソート )
  vls = [ Line.new(0,0,Float::INFINITY) ]
  hls = [ Line.new(0,0,Float::INFINITY) ]
  # 頂点候補毎に配置できる最大サイズの正方形のリスト
  # 「頂点の優先順位」の昇順にソート
  caps = [ Square.new(Vertex.new(0,0),Float::INFINITY) ]
  # 配置済み正方形のリスト
  squares = []
 
  src.each{|w|
    # 配置できる正方形のうち、サイズに収まる最優先のものを選出
    vn = caps.find{|c| c.w>=w }.v
    # 新たに配置する正方形をfix
    sq_a = Square.new(vn,w)
    # 新たに配置した正方形により、配置できる正方形のサイズをそれぞれ修正
    # ※サイズ0=配置できなくなったものは削除
    caps_upd = caps.map{|c|
      Square.new(c.v,[c.w,sq_a.wlimit(c.v)].min)
    }.reject(&:zero?)

    # 新たに配置した正方形の「屋根」にあたる辺に沿って、新たに配置可能となった
    # 情報を整理する
    
    # まずは頂点候補の選出
    vs_add = []
    # 鉛直、水平でxy座標の順が違うだけなので同じループで処理
    [ [vls,true], [hls,false] ].each{|(ls,xy_order)|
      # 屋根にあたる部分のLine(新規追加用)のパラメータ
      pn,sn = *xy_order ? [vn.x+w,vn.y] : [vn.y+w,vn.x]
      en = sn+w
      # vls/hls にLineを追加する場合のインデクス
      l_i=nil
      ls.each_with_index{|l,i|
        # 後ろ(無限遠方向)にある線分は無関係なので飛ばす
        next if l.p>pn
        # Lineのリストの降順を保つようにインデクスを決定
        l_i=i unless l_i
        # 頂点候補ができないケースは飛ばす
        next if l.e<=en
        # 頂点候補の追加
        vs_add.push(xy_order ? Vertex.new(l.p,en) : Vertex.new(en,l.p))
        # 屋根の射線が遮られる場合、これ以上候補ができないので終了
        break if l.s<=en
      }
      ls.insert(l_i,Line.new(pn,sn,en))
    }

    # 頂点候補を元に、配置済みの正方形と照らし合わせて
    # 追加分の「配置できる正方形」を決定
    caps_add = vs_add.map{|v|
      # 正方形の最大サイズは、配置済み正方形全てと突き合わせて最小値を採用
      wlim_min = squares.map{|sq_e| sq_e.wlimit(v) }.min || Float::INFINITY
      Square.new(v,wlim_min)
    }.reject(&:zero?)

    # 配置可能な正方形のリストと、配置済み正方形のリストを更新
    caps = merge(caps_upd,caps_add.sort)
    squares.push(sq_a)
  }
  # 最大の正方形および隣接する正方形情報を探索し、解を生成
  biggest = squares.max_by(&:w)
  squares.select{|sq| sq.pos(biggest)==0 }.map(&:w).sort*?,
end

# JSONを元に解答チェックする処理
# ※JSONはサイトで提供されている形式を前提とする
def main(jsonfile)
  dataset = JSON.load(File.open(jsonfile).read)
  c_all = c_ok = 0
  dataset['test_data'].each{|h|
    id = h['number']
    src = h['src'].split(?,).map(&:to_i)
    exp = h['expected']
    act = solve(src)
    puts "#{id}: #{act==exp ? 'ok' : 'ng'}"
    puts "  in:  #{src*?,}"
    puts "  out: #{act}"
    puts "  exp: #{exp}"
    puts ""
    c_ok+=1 if act==exp
    c_all+=1
  }
  puts "ok: #{c_ok} / #{c_all}"
end

# カレントディレクトリに data.json を置いて、"ruby solve.rb" で実行
# ※別のJSONを使う場合は "ruby solve.rb JSONファイル" とする
main(ARGV[0] || 'data.json')
