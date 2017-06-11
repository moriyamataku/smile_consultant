class BestSmilesController < ApplicationController
  ADVISES = [
    { point: "口角が下がっています。", advises:
      [
        "鏡の前で、「自分の笑顔のイメージより150％の笑顔」を作り、「イ―――」と声を出して、そのまま10秒キープ。",
        "上下の前歯でわりばしを横に挟んで、軽く噛みます。口角がわりばしよりも上がるようにします。\nそのまま口角を上げて、上の歯が10本見えるようにします。その状態を30秒キープして、わりばしを抜きます。"
      ]
    },
    { point: "目が笑っていません。", advises:
      [
        "目を閉じます。指で目尻を外側に優しく伸ばします。\nそのまま寄り目にして10秒キープ！目尻を元に戻してから思いっきり目をカッと見開こう！",
        "眉頭を摘んで上に押し上げる。そのまま、10秒キープ！\nその状態で左右に動かす。これを眉頭から眉尾までやる。"
      ]
    }
  ]

  def create

    personal = {'name' => 'Yamada', 'old' => 28}
    render :json => personal
  end


  private

  def advise(smile_score)
    case smile_score
    when 0 < smile_score && smile_score <= 20 then
      [
        ADVISES[0][:point], ADVISES[0][:advises][0], ADVISES[0][:advises][1],
        ADVISES[1][:point], ADVISES[1][:advises][0], ADVISES[1][:advises][1]
      ]
    when 20 < smile_score && smile_score <= 40 then
      [
        ADVISES[0][:point], ADVISES[0][:advises][0],
        ADVISES[1][:point], ADVISES[1][:advises][0], ADVISES[1][:advises][1]
      ]
    when 40 < smile_score && smile_score <= 60 then
      [ADVISES[1][:point], ADVISES[1][:advises][0], ADVISES[1][:advises][1]]
    when 60 < smile_score && smile_score <= 80 then
      [ADVISES[1][:point], ADVISES[1][:advises][1]]
    else
      [""]
    end
  end
end
