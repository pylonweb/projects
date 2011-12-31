require 'refinerycms-projects'

module Refinery
  module Projects
    class Engine < Rails::Engine
      include Refinery::Engine

      isolate_namespace Refinery
      engine_name :refinery_projects
      
      config.autoload_paths += %W( #{config.root}/lib )

      initializer "register refinerycms_projects plugin", :after => :set_routes_reloader do |app|
        Refinery::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.name = "refinery_projects"
          plugin.version = %q{2.0.0}
          plugin.url = app.routes.url_helpers.refinery_admin_projects_path #{:controller => '/refinery/projects', :action => 'index'} #app.routes.url_helpers.refinery_admin_projects_path
          plugin.menu_match = /refinery\/project?s/
          plugin.activity = {
            :class_name => :'refinery/projects',
            :title => 'title',
            :url_prefix => nil,
            :url => "refinery_admin_project_path" # temp hack for namespacees
          }
        end
      end

      config.after_initialize do
        Refinery.register_engine(Refinery::Projects)
      end
    end
  end
end

#ActiveRecord::Base.send(:include, Refinery::Projects::Extension)