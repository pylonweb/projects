module Refinery
  class ProjectField < ActiveRecord::Base
    belongs_to :project
    
    attr_accessible :title, :value, :position
    
  end
end