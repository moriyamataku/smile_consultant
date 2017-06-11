class ApplicationController < ActionController::API

  def get_best_smile(params)
    # TODO : params�ɉ����ėގ��x�Ȃǂ𔻒肵�ăx�X�g�X�}�C����ԋp����
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

end
