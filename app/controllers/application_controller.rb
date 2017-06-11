class ApplicationController < ActionController::API
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

  def get_best_smile(params)
    # TODO : params�ɉ����ėގ��x�Ȃǂ𔻒肵�ăx�X�g�X�}�C�����ԋp����
    best_smiles = [
      {
        "id" => "1",
        "image_url" => "https://s3-ap-northeast-1.amazonaws.com/takeuchi.test.jp/smile/smile1.jpg",
        "score" => "90"
      },
      {
        "id" => "2",
        "image_url" => "https://s3-ap-northeast-1.amazonaws.com/takeuchi.test.jp/smile/smile2.jpg",
        "score" => "92"
      },
      {
        "id" => "3",
        "image_url" => "https://s3-ap-northeast-1.amazonaws.com/takeuchi.test.jp/smile/smile3.jpg",
        "score" => "80"
      }
    ]
    return best_smiles.sample(1)
  end

  def get_advice(smile_score)
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

  def smile_score(image_url)
#    image_url = params[:url]
    uri = URI("#{ENV["FACEAPI_URL"]}")
    # �Ί��x�����擾
    uri.query = URI.encode_www_form({
      'returnFaceId' => 'true',
      'returnFaceLandmarks' => 'false',
      'returnFaceAttributes' => 'age,gender,smile,facialHair,glasses'
    })
    request = Net::HTTP::Post.new(uri.request_uri)
    # Request headers
    request['Content-Type'] = 'application/json'
    request['Ocp-Apim-Subscription-Key'] = "#{ENV['API_KEY']}"
    request.body = "{\"url\":\"#{image_url}\"}"
    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request(request)
    end
    data = JSON.parse(response.body)
    smile_rate = data[0]["faceAttributes"]["smile"] * 100
    return smile_rate
#    render json: { smile_rate: smile_rate }.to_json
  end

end
