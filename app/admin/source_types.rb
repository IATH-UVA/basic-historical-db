ActiveAdmin.register SourceType do
  menu parent: 'Controlled Vocabularies'
  
  permit_params :name, :description

  preserve_default_filters!
  remove_filter :sources

  show do
    attributes_table do
      default_attribute_table_rows.each do |field|
        row field
      end
      row :sources do |x|
        ul do
          x.sources.each do |source|
            li link_to source.title.present? ? source.title : source.id, admin_source_path(source)
          end
        end
      end
    end
  end
  
end
