::Refinery::User.all.each do |user|
  if user.plugins.where(:name => 'refinery_projects').blank?
    user.plugins.create(:name => "refinery_projects",
                        :position => (user.plugins.maximum(:position) || -1) +1)
  end
end if defined?(::Refinery::User)

if defined?(::Refinery::Page)
  page_position = (::Refinery::Page.maximum(:position, :conditions => {:parent_id => nil}) || -1)

  projects_page = ::Refinery::Page.create({
    :title => "Projects",
    :link_url => "/projects",
    :menu_match => "^/(projects).*$",
    :deletable => false,
    :position => (page_position += 1),
    :skip_to_first_childre => true
  })
  
  categories_page = ::Refinery::Page.create({
    :title => "Categories",
    :link_url => "/categories",
    :menu_match => "^/(categories).*$",
    :deletable => false,
    :position => (page_position += 1),
    :parent_id => projects_page.id
  })
  
  completed_page = ::Refinery::Page.create({
    :title => "Completed",
    :link_url => "/completed",
    :menu_match => "^/(completed).*$",
    :deletable => false,
    :position => (page_position += 1),
    :parent_id => projects_page.id
  })
  
end

