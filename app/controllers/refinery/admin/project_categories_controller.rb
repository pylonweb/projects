module Refinery
  module Admin
    class ProjectCategoriesController < ::Refinery::AdminController
      
      crudify :'refinery/project_category',
              :title_attribute => 'title', :xhr_paging => true
              
    end
  end
end