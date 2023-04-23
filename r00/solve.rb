# オフラインリアルタイムどう書く問題作成リハビリ #0
require 'json'

# 正方形の位置情報を扱うクラス
Square = Struct.new(:x,:y,:w) do
  # x,y,w → (x,y)が下の頂点、wが一辺の長さ

  # 正方形同士の位置関係の判定
  def pos(sq)
    # -1: intersect, 0: tangent, 1: far 
    rhx = (x<=>sq.x+sq.w)*(x+w<=>sq.x)
    rhy = (y<=>sq.y+sq.w)*(y+w<=>sq.y)
    rhx==-1 ? rhy : rhy==-1 ? rhx : 1
  end
end

# ソルバー本体
def solve(src)
  # src: 正方形の幅のリスト
  # return: 回答の文字列
  #  ※最大の正方形に隣接する正方形の幅の昇順リストをカンマ区切り結合

  # 正方形の頂点のx座標、y座標の候補のリスト
  xvals = [0]
  yvals = [0]
  # 正方形の配置情報リスト
  squares = []

  # 配置する正方形の幅に対してループ
  src.each{|w|
    # 頂点の候補リストを優先度順にソートした状態で作成
    xylist = xvals.product(yvals).sort_by{|(x,y)| (x+y)**2+x }
    # 配置済みの正方形と重ならないように頂点を探索
    x,y = xylist.find{|(x,y)|
      newsq = Square.new(x,y,w)
      squares.all?{|sq| sq.pos(newsq)>=0 }
    }
    # 正方形情報および、次回以降のx,y座標候補を追加
    sq = Square.new(x,y,w)
    squares.push(sq)
    xvals.push(x+w)
    yvals.push(y+w)
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
