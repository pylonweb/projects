module Refinery
  module Admin
    class ProjectFieldsController < ::Refinery::AdminController
      
      crudify :'refinery/project_field',
              :title_attribute => 'title', :xhr_paging => true
              
    end
  end
end