ActiveAdmin.register BiographyType do
  menu parent: 'Controlled Vocabularies'
  
  permit_params :name, :description
  
  preserve_default_filters!
  remove_filter :biographies

  show do
    attributes_table do
      default_attribute_table_rows.each do |field|
        row field
      end
      row :biographies do |x|
        ul do
          x.biographies.each do |biography|
            li link_to biography.title.present? ? biography.title : biography.id, admin_biography_path(biography)
          end
        end
      end
    end
  end
  
end
