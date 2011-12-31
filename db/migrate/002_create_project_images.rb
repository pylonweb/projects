class CreateProjectImages < ActiveRecord::Migration
  def change
    create_table Refinery::ImageProject.table_name, :id => false do |t|
      t.integer :image_id
      t.integer :project_id
      t.integer :position
    end

    add_index Refinery::ImageProject.table_name, :image_id
    add_index Refinery::ImageProject.table_name, :project_id
  end
end
