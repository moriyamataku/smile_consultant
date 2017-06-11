Rails.application.routes.draw do
  resources :best_smiles, :only => [:create], defaults: { format: "json" }
end
