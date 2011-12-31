Rails.application.routes.draw do
  match "/refinery/projects/add_image" => "refinery/admin/projects#add_image", :as => "add_image_refinery_admin_projects"
  scope(:module => 'refinery', :as => 'refinery') do    
    resources :projects, :only => [:index, :show] do
      collection do
        get :categories
        get :completed
      end
    end

    scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
      resources :projects, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end
end
