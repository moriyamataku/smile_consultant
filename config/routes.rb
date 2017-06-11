Rails.application.routes.draw do
resources :me do
  collection do
    get :smile_score
  end
end

resources :best_smiles, :only => [:create], defaults: { format: "json" }
end
