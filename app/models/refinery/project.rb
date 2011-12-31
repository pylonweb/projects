module Refinery
  class Project < ActiveRecord::Base

    has_many :image_projects, :as => :project, :order => 'position ASC'
    has_many :images, :through => :image_projects, :order => 'position ASC'
    belongs_to :project_category,
               :class_name => "::Refinery::ProjectCategory"
    
    has_many :fields,
             :foreign_key => :refinery_project_id,
             :class_name => '::Refinery::ProjectField',
             :order => 'position ASC',
             :inverse_of => :project,
             :dependent => :destroy
             #:include => ((:translations) if ::Refinery::PagePart.respond_to?(:translation_class))
    
    
             
    # accepts_nested_attributes_for MUST come before def images_attributes=
    # this is because images_attributes= overrides accepts_nested_attributes_for
    
    attr_accessible :title, :description, :completed, :project_category_id, :draft, :year, :position
    attr_accessible :fields_attributes, :images_attributes
    accepts_nested_attributes_for :fields, :reject_if => lambda { |a| a[:value].blank? }, :allow_destroy => true
    accepts_nested_attributes_for :images, :allow_destroy => false
    
    
    acts_as_indexed :fields => [:title]

    validates :title, :uniqueness => true
    validates :title, :description, :presence => true
    
    self.class_eval do
      def images_attributes=(data)
        ids_to_delete = data.map{|i, d| d['image_project_id']}.compact
        self.image_projects.each do |image_project|
          if ids_to_delete.index(image_project.id.to_s).nil?
            # Image has been removed, we must delete it
            self.image_projects.delete(image_project)
            image_project.destroy
          end
        end

        (0..(data.length-1)).each do |i|
          unless (image_data = data[i.to_s]).nil? or image_data['id'].blank?
            image_project = if image_data['image_project_id'].present?
              self.image_projects.find(image_data['image_project_id'])
            else
              self.image_projects.new(:image_id => image_data['id'].to_i)
            end
            image_project.position = i
            # Add caption if supported
            if Refinery::Setting.find_or_set(:project_images_captions, false)
              image_project.caption = image_data['caption']
            end

            self.image_projects << image_project if image_data['image_project_id'].blank?
            image_project.save
          end
        end
      end
    end
  end
end