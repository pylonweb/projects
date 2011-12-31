class RemoveFieldsFromProjects < ActiveRecord::Migration
  def change
    remove_column Refinery::Project.table_name, :header
  end
end
