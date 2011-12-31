class AddYearToProjects < ActiveRecord::Migration
  def change
    add_column Refinery::Project.table_name, :year, :integer
  end
end
