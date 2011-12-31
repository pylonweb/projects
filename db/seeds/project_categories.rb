if defined?(::Refinery::Projects)
  ::Refinery::Projects.config.default_categories.each do |default_project_category|
    ::Refinery::ProjectCategory.create(:title => default_project_category)
  end
end