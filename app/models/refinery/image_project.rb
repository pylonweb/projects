module Refinery
  class ImageProject < ActiveRecord::Base

    belongs_to :image
    belongs_to :project

    translates :caption if self.respond_to?(:translates)

    attr_accessible :image_id, :position, :locale
    self.translation_class.send :attr_accessible, :locale
    
  end
end