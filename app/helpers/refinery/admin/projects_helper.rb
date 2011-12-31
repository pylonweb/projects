module ::Refinery
  module Admin
    module ProjectsHelper
      def link_to_remove_fields(name, f)
        f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)", :id => "remove_image_link")
      end

      def link_to_add_fields(name, f, association)
        new_object = f.object.class.reflect_on_association(association).klass.new
        fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
          render('refinery/admin/projects/tabs/'+association.to_s.singularize, :"#{association.to_s.singularize}_form" => builder)
        end
        link_to_function(name, "add_fields(this, '#{association}', '#{escape_javascript(fields)}')", :id => "add_image_link")
      end
    end
  end
end
