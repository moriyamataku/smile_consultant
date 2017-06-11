class MeController < ApplicationController

=begin

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

=end

end
