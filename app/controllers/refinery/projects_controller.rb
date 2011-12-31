module Refinery
  class ProjectsController < ::ApplicationController

    before_filter :find_all_projects, :find_page, :find_models

    def index
      # you can use meta fields from your model instead (e.g. browser_title)
      # by swapping @page for @project in the line below:
      present(@page)
    end

    def show
      @project = Project.find(params[:id])
      @model = @project

      # you can use meta fields from your model instead (e.g. browser_title)
      # by swapping @page for @project in the line below:
      present(@page)
    end
    
    def completed
      @projects = ::Refinery::Project.where(:completed => true).order(:year)
      present(@page)
    end
    
    def categories
      @categories = ::Refinery::ProjectCategory.order('position ASC')
      present(@page)
    end

  protected
  
    def find_models
      @url = "/projects/"
      @models = @projects
    end

    def find_all_projects
      @projects = Project.order('position ASC')
    end

    def find_page
      @page = ::Refinery::Page.where(:link_url => "/projects").first
    end

  end
end
