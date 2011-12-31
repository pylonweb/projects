class AddCategoriesAndCompletedToProjects < ActiveRecord::Migration
  def change
    add_column Refinery::Project.table_name, :completed, :boolean
    add_column Refinery::Project.table_name, :refinery_categorie_id, :integer
  end
end
