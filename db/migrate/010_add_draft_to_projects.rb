class AddDraftToProjects < ActiveRecord::Migration
  def change
    add_column Refinery::Project.table_name, :draft, :boolean
  end
end
