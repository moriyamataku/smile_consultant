class BestSmilesController < ApplicationController
  def create

    personal = {'name' => 'Yamada', 'old' => 28}
    render :json => personal
  end
end
