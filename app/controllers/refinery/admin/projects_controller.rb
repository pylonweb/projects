module Refinery
  module Admin
    class ProjectsController < ::Refinery::AdminController
      
      crudify :'refinery/project',
              :title_attribute => 'title', :xhr_paging => true
              
      def new
        @project = Project.new
        ::Refinery::Projects.config.default_fields.each do |default_project_field|
          @project.fields.new(:title => default_project_field)
        end
      end
      
      def update
        if @project.update_attributes(params[:project])
          (request.xhr? ? flash.now : flash).notice = t(
            'refinery.crudify.updated',
            :what => "'#{@project.title}'"
          )

          unless from_dialog?
            unless params[:continue_editing] =~ /true|on|1/
              redirect_back_or_default(main_app.refinery_admin_projects_path)
            else
              unless request.xhr?
                redirect_to :back
              else
                render :partial => "/refinery/message"
              end
            end
          else
            render :text => "<script>parent.window.location = #{main_app.refinery_admin_projects_path};</script>"
          end
        else
          unless request.xhr?
            render :action => 'edit'
          else
            render :partial => "/refinery/admin/error_messages",
                   :locals => {
                     :object => @project,
                     :include_object_name => true
                   }
          end
        end
      end
      
      
    end
  end
end
