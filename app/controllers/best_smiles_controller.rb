class BestSmilesController < ApplicationController

 after_filter :cors_set_access_control_headers

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = '*'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  def create

    image_url = params[:url]
    smile_score = smile_score(image_url)

    hash = {
        "me" => {
             "image_url" => image_url,
             "score" => smile_score
         },
        "best_smile" =>  get_best_smile({}),
        "advice" => get_advice(smile_score)
    }
    render :json => hash

#    personal = {'name' => 'Yamada', 'old' => 28}
#    render :json => personal
  end
end
