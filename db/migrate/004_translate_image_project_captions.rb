class TranslateImageProjectCaptions < ActiveRecord::Migration
  def up
    add_column Refinery::ImageProject.table_name, :id, :primary_key

    Refinery::ImageProject.reset_column_information
    unless defined?(Refinery::ImageProject::Translation) && Refinery::ImageProject::Translation.table_exists?
      Refinery::ImageProject.create_translation_table!({
        :caption => :text
      }, {
        :migrate_data => true
      })
    end
  end

  def down
    Refinery::ImageProject.reset_column_information

    Refinery::ImageProject.drop_translation_table! :migrate_data => true

    remove_column Refinery::ImageProject.table_name, :id
  end
end
