class BestSmilesController < ApplicationController
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
