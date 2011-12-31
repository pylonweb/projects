class AddCaptionToImageProjects < ActiveRecord::Migration
  def change
    add_column Refinery::ImageProject.table_name, :caption, :text
  end
end