class ChangeProjectToPolymorphic < ActiveRecord::Migration
  def change
    add_column Refinery::ImageProject.table_name, :project_type, :string, :default => "project"
  end
end
