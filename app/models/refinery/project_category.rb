module Refinery
  class ProjectCategory < ActiveRecord::Base
    
    has_many  :projects,
              :class_name => '::Refinery::Project',
              :order => 'position ASC',
              :inverse_of => :project_category   
    #attr_accessible :title, :position, :projects
    
  end
end