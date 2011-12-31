class CreateProjectFields < ActiveRecord::Migration
  def up
    unless ::Refinery::ProjectField.table_exists?
      create_table ::Refinery::ProjectField.table_name, :force => true do |t|
        t.string :title
        t.string :value
        t.integer :refinery_project_id
        t.integer :position
        t.timestamps
      end

      add_index ::Refinery::ProjectField.table_name, :id
    end
  end

  def down
    drop_table ::Refinery::ProjectField.table_name
  end
end