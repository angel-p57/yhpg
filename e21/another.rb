def solve input
  # implement
  # dlist: 人毎の弾倉移動数
  # ssize: リボルバーの弾倉数
  # pnum: 参加人数
  ssize,*dlist=nil
  dead=[]
  input.scan(/\[(\d)\]|(\d)|\/(\d+)/).each_with_index{|m,i|
    break ssize=m[2].to_i if m[2]
    dlist.push((m[0]||m[1]).to_i)
    dead.push(i) if m[0]
  }
  pnum=dlist.size
  ans=[]
  # 動的計画法に用いる相互再帰関数
  proceed,detail=
    ->rem0,alive,sp,ss,proved0,revolver,cap0{
      # rem0: 残り死亡予定者
      # alive: 現生存者bit-set
      # sp,ss: 開始者・弾倉位置
      # proved0: 弾倉確定位置bit-set
      # revolver: 弾倉状況bit-set ( 未確定位置も 0 )
      # cap0: 未確定弾倉数の余裕
      if rem0.empty?
        ans.push(("%0*b"%[ssize,revolver]).reverse)
      else
        # 次の死亡者を公平に当番で決める
        rem0.each_with_index{|e,i|
          rem,cap,proved,slot=rem0.dup,cap0,proved0,ss
          rem.delete_at(i)
          # 死亡者の番まで空砲を進める
          (sp>e ? [sp...pnum,0...e]:[sp...e]).each{|r|
            r.each{|j|
              next if alive[j]==0
              # 空砲として決定
              (proved|=1<<slot;cap-=1) if proved[slot]==0
              slot=(slot+dlist[j])%ssize
            }
          }
          detail[e,rem,alive,slot,proved,revolver,cap]
        }
      end
    },
    ->dt,rem,alive,ss,proved,revolver,cap{
      # dt: 死亡当番者
      # 他は proceed と同様
      slot=ss
      # 未確定の弾倉の余裕がなくなったら探索終了
      while cap>=0
        # 弾倉が未確定なら、そこで死亡のケースを探索
        proceed[rem,alive&~(1<<dt),(dt+1)%pnum,slot,proved|1<<slot,revolver|1<<slot,cap] if proved[slot]==0
        # 1周空砲で回す
        [dt...pnum,0...dt].each{|r|
          r.each{|j|
            next if alive[j]==0
            # 空砲として決定
            (proved|=1<<slot;cap-=1) if proved[slot]==0
            slot=(slot+dlist[j])%ssize
          }
        }
        return if slot==ss # 無限ループ検知
      end
    }
  proceed[dead,(1<<pnum)-1,0,0,0,0,ssize-dead.size]
  ans
end

def test(n,input,expected)
  actual=solve(input).to_s
  puts "#{n}: "+(actual.include?(expected) ? "ok ( #{actual} )":"ng ( #{actual} does not include #{expected} for #{input} )")
end

# test cases below
test( 0, "3[2]3/6", "000100")
test( 1, "21[3]/6", "000100")
test( 2, "12[3]/6", "000100")
test( 3, "3[2]1/6", "000100")
test( 4, "3[2]3/6", "000100")
test( 5, "1[1]3/6", "010000")
test( 6, "[3]4[4]3/7", "1000100")
test( 7, "4[4]24/7", "0000100")
test( 8, "[4]41[1]/7", "1000010")
test( 9, "1[1]33[1]/8", "01000001")
test( 10, "[1]12[4][3]/8", "10100001")
test( 11, "2[2][1]12/8", "01001000")
test( 12, "1[2][2][1]34/9", "011100000")
test( 13, "[4]1141[2]/9", "100000010")
test( 14, "[3]33[3][2]2/9", "100000110")
test( 15, "[5]1[3]44[2][3]/10", "0100101001")
test( 16, "3[1][2]23[3][1]/10", "0110110000")
test( 17, "33[5]12[5][2]/10", "0000010011")
test( 18, "13[3]1[4][4][4][1]/11", "00101100110")
test( 19, "[5]3[2]35[1]1[4]/11", "10001010001")
test( 20, "4[1]4[5]342[5]/11", "00001010100")
test( 21, "[5][4]55[2][2][4]33/12", "001111100000")
test( 22, "3[2]415[1][4][4]3/12", "010101000100")
test( 23, "3[2][4][2][4]4[5]4[1]/12", "011001110010")
test( 24, "3555[6]33[6]4[1]/13", "0010010000010")
test( 25, "4[1]32[6]3[3]4[3]4/13", "0001100001001")
test( 26, "2[2]14[3][1][6][4]63/13", "0010011001010")
test( 27, "2[9][9][9]8[2]3[4][8]2[1]8/15", "011010100001110")
test( 28, "[1][2][6]64[1][3]68[3][8]8/15", "111001000011010")
test( 29, "[7][6][5]54[5]8[5]53[8]1/15", "010001110010001")
