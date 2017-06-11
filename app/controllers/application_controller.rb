class ApplicationController < ActionController::API

  def get_best_smile(params)
    # TODO : paramsに応じて類似度などを判定してベストスマイルを返却する
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

  def get_advice()
  end

  def smile_score(image_url)
#    image_url = params[:url]
    uri = URI("#{ENV["FACEAPI_URL"]}")
    # 笑顔度等を取得
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
