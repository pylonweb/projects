require 'refinerycms-core'

module Refinery
  autoload :ProjectsGenerator, 'generators/refinery/projects_generator'

  module Projects
    require 'refinery/projects/engine' if defined?(Rails)
    require 'refinery/projects/configuration'

    class << self
      attr_writer :root

      def register(tab)
        tab.name = "images"
        tab.partial = "/refinery/admin/pages/tabs/images"
      end
            
      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def factory_paths
        @factory_paths ||= [ root.join("spec/factories").to_s ]
      end
    end
    
    module Extension
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def has_many_project_images
          has_many :image_projects, :as => :project, :order => 'position ASC'
          has_many :images, :through => :image_projects, :order => 'position ASC'
          # accepts_nested_attributes_for MUST come before def images_attributes=
          # this is because images_attributes= overrides accepts_nested_attributes_for.

          accepts_nested_attributes_for :images, :allow_destroy => false
          module_eval do ## need to do it this way because of the way accepts_nested_attributes_for deletes an already defined images_attributes
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

          include Refinery::PageImages::Extension::InstanceMethods

          # this wasn't working for me so I've commented it out for now
          # if ActiveModel::MassAssignmentSecurity::WhiteList === active_authorizer
          #   attr_accessible :images_attributes
          # else
          #   # to prevent a future call to attr_accessible
          #   self._accessible_attributes = accessible_attributes + [:images_attributes]
          # end
          attr_accessible :images_attributes
        end
      end

      module InstanceMethods

        def caption_for_image_index(index)
          self.image_projects[index].try(:caption).presence || ""
        end

        def image_project_id_for_image_index(index)
          self.image_projects[index].try(:id)
        end
      end
    end
  end
end