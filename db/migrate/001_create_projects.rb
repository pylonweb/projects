class CreateProjects < ActiveRecord::Migration

  def up
    unless ::Refinery::Project.table_exists?
      create_table ::Refinery::Project.table_name, :force => true do |t|
        t.string :title
        t.string :header
        t.string :description
        t.integer :position

        t.timestamps
      end

      add_index ::Refinery::Project.table_name, :id
    end
    
    #load(Rails.root.join('db', 'seeds', 'projects.rb'))
    
    Refinery::Projects::Engine.load_seed
  end

  def down
    drop_table ::Refinery::Project.table_name

    ::Refinery::Page.delete_all({
      :link_url => ("/projects")
    }) if defined?(::Refinery::Page)
  end

end
