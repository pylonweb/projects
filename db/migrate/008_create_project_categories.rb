class CreateProjectCategories < ActiveRecord::Migration

  def up
    create_table ::Refinery::ProjectCategory.table_name do |t|
      t.string :title
      t.integer :position

      t.timestamps
    end
    
    add_index ::Refinery::ProjectCategory.table_name, :id
    load(Rails.root.join('db', 'seeds', 'project_categories.rb'))
  end
  
  def down
    drop_table ::Refinery::ProjectCategory.table_name
  end

end
